using Gtk;
using V;

public class C.Controlador {

	private const string consolas_default = "consola1, consola2, ...";
	private const string fecha_default = "YYYY-MM-DD";
	private Interfaz interfaz;
	
	public Controlador (Interfaz interfaz)
	{
		this.interfaz = interfaz;
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
		interfaz.dialog_delete.hide ();
		interfaz.label_del_elemento.set_label ("");
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
		//agregamos el videojuego
		interfaz.dialog_vg_add.hide ();
		interfaz.text_vg_nombre.set_text ("");
		interfaz.text_vg_dev.set_text ("");
		interfaz.text_vg_pub.set_text ("");
		interfaz.text_vg_motor.set_text ("");
		interfaz.text_vg_consolas.set_text (consolas_default);
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
		//agregamos la desarrolladora
		interfaz.dialog_dev_add.hide ();
		interfaz.text_dev_nombre.set_text ("");
		interfaz.text_dev_sede.set_text ("");
		interfaz.text_dev_fundacion.set_text (fecha_default);
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
		//agregamos la publicadora
		interfaz.dialog_pub_add.hide ();
		interfaz.text_pub_nombre.set_text ("");
		interfaz.text_pub_sede.set_text ("");
		interfaz.text_pub_fundacion.set_text (fecha_default);
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
		//agregamos la consola
		interfaz.dialog_con_add.hide ();
		interfaz.text_con_nombre.set_text ("");
		interfaz.text_con_fabricante.set_text ("");
		interfaz.text_con_cpu.set_text ("");
		interfaz.text_con_lanzamiento.set_text ("");
		interfaz.spinbutton_con_generacion.set_value (0);
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
}
