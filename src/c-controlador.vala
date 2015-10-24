using Gtk;
using M;
using V;

/**
 * Clase Controlador representando el Controlador del programa.
 *
 * Los objectos de esta clase sirven para proporcionar sus métodos
 * como handlers a eventos de la interfaz gráfica.
 */
public class C.Controlador : GLib.Object {

	private const string consolas_default = "consola1, consola2, ...";
	private const string fecha_default = "YYYY-MM-DD";
	private Interfaz interfaz;
	private Modelo modelo;

	/**
	 * Constructor
	 *
	 * Los objetos están asociados a la interfaz gráfica y
	 * al modelo de la base de datos.
	 *
	 * @param interfaz El objeto que representa la interfaz gráfica.
	 *
	 * @param modelo El objeto que representa el modelo de la base
	 *        de datos.
	 */
	public Controlador (Interfaz interfaz, Modelo modelo)
	{
		this.interfaz = interfaz;
		this.modelo = modelo;
	}
	
	//Handlers

	//Add game dialog-----------------------------------------------------------

	[CCode (instance_pos = -1)]
	public void on_add_vg_cancel_clicked (Button source)
	{
		interfaz.dialog_vg_add.hide ();
		interfaz.text_vg_nombre.set_text ("");
		interfaz.text_vg_dev.set_text ("");
		interfaz.text_vg_pub.set_text ("");
		interfaz.text_vg_motor.set_text ("");
		interfaz.text_vg_consolas.set_text (consolas_default);
	}
	
	[CCode (instance_pos = -1)]
	public void on_add_vg_accept_clicked (Button source)
	{
		if (interfaz.text_vg_nombre.get_text () == "" ||
			interfaz.text_vg_dev.get_text () == "" ||
			interfaz.text_vg_pub.get_text () == "" ||
			interfaz.text_vg_consolas.get_text () == "") {
			return;
		}
		int s;
		string nombre = interfaz.text_vg_nombre.get_text ().replace ("\"", "'");
		string motor = interfaz.text_vg_motor.get_text ().replace ("\"", "'");
		string dev = interfaz.text_vg_dev.get_text ().replace ("\"", "'");
		string pub = interfaz.text_vg_pub.get_text ().replace ("\"", "'");
		string[] consolas = interfaz.text_vg_consolas.get_text ().replace ("\"", "'").split (", ");
		bool e = modelo.consultas_select.existe_vj (nombre, out s);		
		if (s != Sqlite.OK) {
			interfaz.label_state.set_text (@"No ha sido posible agregar $nombre.");
		} else if (e) {
			int update;
			interfaz.label_update_elemento.set_text (nombre);
			update = interfaz.dialog_update.run ();
			if (update == 1) {
				existen_en_base (dev, pub, consolas);
				modelo.base_datos.realiza_consulta (modelo.consultas_no_select.eliminar_vj (nombre));
				modelo.base_datos.realiza_consulta (modelo.consultas_no_select.agrega_vj (nombre, motor, dev, pub));
				foreach (string consola in consolas) {
					modelo.base_datos.realiza_consulta (modelo.consultas_no_select.relaciona_vj (nombre, consola));
				}
			}
		} else {
			existen_en_base (dev, pub, consolas);
			string? vg = modelo.consultas_no_select.agrega_vj (nombre, motor, dev, pub);
			s = modelo.base_datos.realiza_consulta (vg);
			if (s != Sqlite.OK) {
				interfaz.label_state.set_text (@"No ha sido posible agregar $nombre.");
			}
			foreach (string consola in consolas) {
				modelo.base_datos.realiza_consulta (modelo.consultas_no_select.relaciona_vj (nombre, consola));
			}
		}
		on_add_vg_cancel_clicked (source);
	}

	//Developer add dialog------------------------------------------------------

	[CCode (instance_pos = -1)]
	public void on_add_dev_cancel_clicked (Button source)
	{
		interfaz.dialog_dev_add.hide ();
		interfaz.text_dev_nombre.set_text ("");
		interfaz.text_dev_sede.set_text ("");
		interfaz.text_dev_fundacion.set_text (fecha_default);
	}

	[CCode (instance_pos = -1)]
	public void on_add_dev_accept_clicked (Button source)
	{
		if (interfaz.text_dev_nombre.get_text () == "") {
			return;
		}
		int s;
		string nombre = interfaz.text_dev_nombre.get_text ().replace ("\"", "'");
		string sede = interfaz.text_dev_sede.get_text ().replace ("\"", "'");
		string fundacion = interfaz.text_dev_fundacion.get_text ().replace ("\"", "'");
		int activo = (interfaz.radio_dev_activo_y.get_active ()) ? 1 : 0;
		bool e = modelo.consultas_select.existe_dev (nombre, out s);
		if (s != Sqlite.OK) {
			interfaz.label_state.set_text (@"No ha sido posible agregar $nombre.");
		} else if (e) {
			int update;
			interfaz.label_update_elemento.set_text (nombre);
			update = interfaz.dialog_update.run ();
			if (update == 1) {
				string? _sede = modelo.consultas_no_select.actualizar_dev (nombre, Tablas.Desarrolladoras.SEDE, sede);
				string? _fundacion = modelo.consultas_no_select.actualizar_dev (nombre, Tablas.Desarrolladoras.FUNDACION, fundacion);
				string? _activo = modelo.consultas_no_select.actualizar_dev (nombre, Tablas.Desarrolladoras.ACTIVO, activo.to_string ());
				modelo.base_datos.realiza_consulta (_sede);
				modelo.base_datos.realiza_consulta (_fundacion);
				modelo.base_datos.realiza_consulta (_activo);
			}
		} else {
			string? dev = modelo.consultas_no_select.agrega_dev (nombre, sede, activo, fundacion);
			s = modelo.base_datos.realiza_consulta (dev);
			if (s != Sqlite.OK) {
				interfaz.label_state.set_text (@"No ha sido posible agregar $nombre.");
			}
		}
		on_add_dev_cancel_clicked (source);
	}

	//Publisher add dialog------------------------------------------------------

	[CCode (instance_pos = -1)]
	public void on_add_pub_cancel_clicked (Button source)
	{
		interfaz.dialog_pub_add.hide ();
		interfaz.text_pub_nombre.set_text ("");
		interfaz.text_pub_sede.set_text ("");
		interfaz.text_pub_fundacion.set_text (fecha_default);
	}

	[CCode (instance_pos = -1)]
	public void on_add_pub_accept_clicked (Button source)
	{
		if (interfaz.text_pub_nombre.get_text () == "") {
			return;
		}
		int s;
		string nombre = interfaz.text_pub_nombre.get_text ().replace ("\"", "'");
		string sede = interfaz.text_pub_sede.get_text ().replace ("\"", "'");
		string fundacion = interfaz.text_pub_fundacion.get_text ().replace ("\"", "'");
		int activo = (interfaz.radio_pub_activo_y.get_active ()) ? 1 : 0;
		bool e = modelo.consultas_select.existe_pub (nombre, out s);
		if (s != Sqlite.OK) {
			interfaz.label_state.set_text (@"No ha sido posible agregar $nombre.");
		} else if (e) {
			int update;
			interfaz.label_update_elemento.set_text (nombre);
			update = interfaz.dialog_update.run ();
			if (update == 1) {
				string? _sede = modelo.consultas_no_select.actualizar_pub (nombre, Tablas.Publicadoras.SEDE, sede);
				string? _fundacion = modelo.consultas_no_select.actualizar_pub (nombre, Tablas.Publicadoras.FUNDACION, fundacion);
				string? _activo = modelo.consultas_no_select.actualizar_pub (nombre, Tablas.Publicadoras.ACTIVO, activo.to_string ());
				modelo.base_datos.realiza_consulta (_sede);
				modelo.base_datos.realiza_consulta (_fundacion);
				modelo.base_datos.realiza_consulta (_activo);
			}
		} else {
			string? pub = modelo.consultas_no_select.agrega_pub (nombre, sede, activo, fundacion);
			s = modelo.base_datos.realiza_consulta (pub);
			if (s != Sqlite.OK) {
				interfaz.label_state.set_text (@"No ha sido posible agregar $nombre.");
			}
		}
		on_add_pub_cancel_clicked (source);
	}

	//Console add dialog--------------------------------------------------------

	[CCode (instance_pos = -1)]
	public void on_add_con_cancel_clicked (Button source)
	{
		interfaz.dialog_con_add.hide ();
		interfaz.text_con_nombre.set_text ("");
		interfaz.text_con_fabricante.set_text ("");
		interfaz.text_con_cpu.set_text ("");
		interfaz.text_con_lanzamiento.set_text ("");
		interfaz.spinbutton_con_generacion.set_value (0);
	}

	[CCode (instance_pos = -1)]
	public void on_add_con_accept_clicked (Button source)
	{
		if (interfaz.text_con_nombre.get_text () == "" ||
			interfaz.text_con_fabricante.get_text () == "") {
			return;
		}
		int s;
		string nombre = interfaz.text_con_nombre.get_text ().replace ("\"", "'");
		string fabricante = interfaz.text_con_fabricante.get_text ().replace ("\"", "'");
		string cpu = interfaz.text_con_cpu.get_text ().replace ("\"", "'");
		string lanzamiento = interfaz.text_con_lanzamiento.get_text ().replace ("\"", "'");
		int gen = interfaz.spinbutton_con_generacion.get_value_as_int ();
		bool e = modelo.consultas_select.existe_con (nombre, out s);
		if (s != Sqlite.OK) {
			interfaz.label_state.set_text (@"No ha sido posible agregar $nombre.");
		} else if (e) {
			int update;
			interfaz.label_update_elemento.set_text (nombre);
			update = interfaz.dialog_update.run ();
			if (update == 1) {
				string? _fabricante = modelo.consultas_no_select.actualizar_con (nombre, Tablas.Consolas.FABRICANTE, fabricante);
				string? _cpu = modelo.consultas_no_select.actualizar_con (nombre, Tablas.Consolas.CPU, cpu);
				string? _lanzamiento = modelo.consultas_no_select.actualizar_con (nombre, Tablas.Consolas.LANZAMIENTO, lanzamiento);
				string? _gen = modelo.consultas_no_select.actualizar_con (nombre, Tablas.Consolas.GENERACION, gen.to_string ());
				modelo.base_datos.realiza_consulta (_fabricante);
				modelo.base_datos.realiza_consulta (_cpu);
				modelo.base_datos.realiza_consulta (_lanzamiento);
				modelo.base_datos.realiza_consulta (_gen);
			}
		} else {
			string? con = modelo.consultas_no_select.agrega_con (nombre, fabricante, gen, cpu, lanzamiento);
			s = modelo.base_datos.realiza_consulta (con);
			if (s != Sqlite.OK) {
				interfaz.label_state.set_text (@"No ha sido posible agregar $nombre.");
			}
		}
		on_add_con_cancel_clicked (source);
	}

	//Info dialog---------------------------------------------------------------

	[CCode (instance_pos = -1)]
	public void on_info_close (Button source)
	{
		interfaz.label_info_vg.set_label ("");
		interfaz.label_info_dev.set_label ("");
		interfaz.label_info_pub.set_label ("");
		interfaz.label_info_engine.set_label ("");
		var child = interfaz.viewport_consoles.get_child ();
		if (child != null) {
			interfaz.viewport_consoles.remove (child);
		}
		interfaz.dialog_info.hide ();
	}

	//Update dialog-------------------------------------------------------------
	
	[CCode (instance_pos = -1)]
	public void on_update_cancel_clicked (Button source)
	{
		interfaz.dialog_update.response (0);
		interfaz.dialog_update.hide ();
		interfaz.label_update_elemento.set_text ("");
	}

	[CCode (instance_pos = -1)]
	public void on_update_accept_clicked (Button source)
	{
		interfaz.dialog_update.response (1);
		interfaz.dialog_update.hide ();
		interfaz.label_update_elemento.set_text ("");
	}

	//Main window---------------------------------------------------------------
	
	[CCode (instance_pos = -1)]
	public void on_clean_clicked (Button source)
	{
		interfaz.viewport.remove (interfaz.viewport.get_child ());
		source.set_sensitive (false);
	}
	
	[CCode (instance_pos = -1)]
	public void show_all (Button source)
	{
		if (interfaz.viewport.get_child () != null) {
			interfaz.viewport.remove (interfaz.viewport.get_child ());
		}
		var listbox = new ListBox ();
		listbox.selection_mode = SelectionMode.SINGLE;
		interfaz.viewport.add (listbox);
		modelo.base_datos.realiza_consulta_select (
			"SELECT nombre FROM videojuegos;",
			(n_columns, values, column_names) => {
				var row = new ListBoxRow ();
				row.set_activatable (true);
				var label = new Label (values[0]);
				row.add (label);
				listbox.add (row);
				return 0;
			}
		);
		interfaz.viewport.show_all ();
		listbox.row_activated.connect (
			(row) => {
				var listbox_con = new ListBox ();
				string vj = (row.get_child () as Label).get_label ();
				modelo.base_datos.realiza_consulta_select (@"SELECT * FROM videojuegos INNER JOIN dis_to ON dis_to.vj_n = videojuegos.nombre WHERE videojuegos.nombre = '$vj'", (n_columns, values, column_names) => {
						interfaz.label_info_vg.set_label (vj);
						int dev = 0;
						int pub = 0;
						int engine = 0;
						int con = 0;
						for (int i = 0; i < n_columns; i++) {
							if (column_names[i] == "dev"){
								dev = i;
							} else if (column_names[i] == "pub") {
								pub = i;
							} else if (column_names[i] == "motor") {
								engine = i;
							} else if (column_names[i] == "con_n") {
								con = i;
							}
						}
						interfaz.label_info_dev.set_label (values[dev]);
						interfaz.label_info_pub.set_label (values[pub]);
						interfaz.label_info_engine.set_label (values[engine]);
						var label = new Label(values[con]);
						var vrow = new ListBoxRow ();
						vrow.add (label);
						listbox_con.add (vrow);
						return 0;
					}
				);
				if (interfaz.viewport_consoles.get_child () != null) {
					interfaz.viewport_consoles.remove(interfaz.viewport_consoles.get_child ());
				}
				interfaz.viewport_consoles.add (listbox_con);
				interfaz.viewport_consoles.show_all ();
				interfaz.dialog_info.show_all ();
			}
		);
		interfaz.button_clean.set_sensitive (true);
	}
	
	[CCode (instance_pos = -1)]
	public void show_developers (Button source)
	{
		if (interfaz.viewport.get_child () != null) {
			interfaz.viewport.remove (interfaz.viewport.get_child ());
		}
		var listbox = new ListBox ();
		listbox.selection_mode = SelectionMode.SINGLE;
		interfaz.viewport.add (listbox);
		modelo.base_datos.realiza_consulta_select (
			"SELECT nombre FROM desarrolladoras;",
			(n_columns, values, column_names) => {
				var row = new ListBoxRow ();
				row.set_activatable (true);
				var label = new Label (values[0]);
				row.add (label);
				listbox.add (row);
				return 0;
			}
		);
		interfaz.viewport.show_all ();
		listbox.row_activated.connect (
			(row) => {
				var label = row.get_child () as Label;
				var dev = label.get_label ();
				interfaz.viewport.remove (interfaz.viewport.get_child ());
				listbox = new ListBox ();
				listbox.selection_mode = SelectionMode.SINGLE;
				interfaz.viewport.add (listbox);
				modelo.base_datos.realiza_consulta_select (
					@"SELECT nombre FROM videojuegos WHERE dev = '$dev';",
					(n_columns, values, column_names) => {
						var vrow = new ListBoxRow ();
						vrow.set_activatable (true);
						var vlabel = new Label (values[0]);
						vrow.add (vlabel);
						listbox.add (vrow);
						return 0;
					});
				interfaz.viewport.show_all ();
			}
		);
		interfaz.button_clean.set_sensitive (true);
	}
	
	[CCode (instance_pos = -1)]
	public void show_publishers (Button source)
	{
		if (interfaz.viewport.get_child () != null) {
			interfaz.viewport.remove (interfaz.viewport.get_child ());
		}
		var listbox = new ListBox ();
		listbox.selection_mode = SelectionMode.SINGLE;
		interfaz.viewport.add (listbox);
		modelo.base_datos.realiza_consulta_select (
			"SELECT nombre FROM publicadoras;",
			(n_columns, values, column_names) => {
				var row = new ListBoxRow ();
				row.set_activatable (true);
				var label = new Label (values[0]);
				row.add (label);
				listbox.add (row);
				return 0;
			}
		);
		interfaz.viewport.show_all ();
		listbox.row_activated.connect (
			(row) => {
				var label = row.get_child () as Label;
				var pub = label.get_label ();
				interfaz.viewport.remove (interfaz.viewport.get_child ());
				listbox = new ListBox ();
				listbox.selection_mode = SelectionMode.SINGLE;
				interfaz.viewport.add (listbox);
				modelo.base_datos.realiza_consulta_select (
					@"SELECT nombre FROM videojuegos WHERE pub = '$pub';",
					(n_columns, values, column_names) => {
						var vrow = new ListBoxRow ();
						vrow.set_activatable (true);
						var vlabel = new Label (values[0]);
						vrow.add (vlabel);
						listbox.add (vrow);
						return 0;
					});
				interfaz.viewport.show_all ();
			}
		);
		interfaz.button_clean.set_sensitive (true);
	}

	[CCode (instance_pos = -1)]
	public void show_consoles (Button source)
	{
		if (interfaz.viewport.get_child () != null) {
			interfaz.viewport.remove (interfaz.viewport.get_child ());
		}
		var listbox = new ListBox ();
		listbox.selection_mode = SelectionMode.SINGLE;
		interfaz.viewport.add (listbox);
		modelo.base_datos.realiza_consulta_select (
			"SELECT nombre FROM consolas;",
			(n_columns, values, column_names) => {
				var row = new ListBoxRow ();
				row.set_activatable (true);
				var label = new Label (values[0]);
				row.add (label);
				listbox.add (row);
				return 0;
			}
		);
		interfaz.viewport.show_all ();
				listbox.row_activated.connect (
			(row) => {
				var label = row.get_child () as Label;
				var con = label.get_label ();
				interfaz.viewport.remove (interfaz.viewport.get_child ());
				listbox = new ListBox ();
				listbox.selection_mode = SelectionMode.SINGLE;
				interfaz.viewport.add (listbox);
				modelo.base_datos.realiza_consulta_select (
					@"SELECT vj_n FROM dis_to WHERE con_n = '$con';",
					(n_columns, values, column_names) => {
						var vrow = new ListBoxRow ();
						vrow.set_activatable (true);
						var vlabel = new Label (values[0]);
						vrow.add (vlabel);
						listbox.add (vrow);
						return 0;
					});
				interfaz.viewport.show_all ();
			}
		);
		interfaz.button_clean.set_sensitive (true);
	}

	[CCode (instance_pos = -1)]
	public void on_add_changed (ComboBox source)
	{
		switch (source.get_active_id ()) {
		case "vg" :
		interfaz.dialog_vg_add.show_all ();
		break;
		case "dev" :
		interfaz.dialog_dev_add.show_all ();
		break;
		case "pub" :
		interfaz.dialog_pub_add.show_all ();
		break;
		case "con" :
		interfaz.dialog_con_add.show_all ();
		break;
		}
		source.set_active_id ("add");
	}

	//--------------------------------------------------------------------------

	/* Crea la desarrolladora, publicadora y consolas si no existen. */
	private int existen_en_base (string dev, string pub, string[] con)
	{
		int r;
		if (!modelo.consultas_select.existe_dev (dev, out r)) {
			modelo.base_datos.realiza_consulta (modelo.consultas_no_select.agrega_dev (dev, null, 0, null));
		}
		if (!modelo.consultas_select.existe_pub (pub, out r)) {
			modelo.base_datos.realiza_consulta (modelo.consultas_no_select.agrega_pub (pub, null, 0, null));
		}
		foreach (string consola in con) {
			if (!modelo.consultas_select.existe_con (consola, out r)) {
				modelo.base_datos.realiza_consulta (modelo.consultas_no_select.agrega_con (consola, "desconocido", 0, null, null));
			}
		}
		foreach (string consola in con) {
			if (!modelo.consultas_select.desarrolla_para (dev, consola, out r)) {
				modelo.base_datos.realiza_consulta (modelo.consultas_no_select.relaciona_dev (dev, consola));
			}
		}
		foreach (string consola in con) {
			if (!modelo.consultas_select.publica_para (pub, consola, out r)) {
				modelo.base_datos.realiza_consulta (modelo.consultas_no_select.relaciona_pub (pub, consola));
			}
		}
		return r;
	}
	
}
