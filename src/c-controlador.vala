using Gtk;
using M;
using V;

public class C.Controlador : GLib.Object {

	private const string consolas_default = "consola1, consola2, ...";
	private const string fecha_default = "YYYY-MM-DD";
	private Interfaz interfaz;
	private Modelo modelo;
	
	public Controlador (Interfaz interfaz, Modelo modelo)
	{
		this.interfaz = interfaz;
		this.modelo = modelo;
	}
	
	//Callbacks

	//Delete dialog-------------------------------------------------------------

	[CCode (instance_pos = -1)]
	public void on_delete_cancel_clicked (Button source)
	{
		interfaz.dialog_delete.hide ();
		interfaz.label_del_elemento.set_label ("");
	}

	[CCode (instance_pos = -1)]
	public void on_delete_accept_clicked (Button source)
	{
		//eliminamos de la base de datos
		on_delete_cancel_clicked (source);
	}

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
		bool e = modelo.consultas_select.existe_vg (nombre, out s);
		if (s != Sqlite.OK) {
			interfaz.label_state.set_text (@"No ha sido posible agregar $nombre.");
		} else if (e) {
			int update;
			interfaz.label_update_elemento.set_text (nombre);
			update = interfaz.dialog_update.run ();
			if (update == 1) {
				
			}
		} else {

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

	//Main window---------------------------------------------------------------

	[CCode (instance_pos = -1)]
	public void on_search_clicked (Button source)
	{
		return;
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
	
}
