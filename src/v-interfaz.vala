using Gtk;
using C;

public class V.Interfaz {

	//dialog_delete
	public Dialog dialog_delete;
	public Label label_del_elemento;
	//dialog update
	public Dialog dialog_update;
	public Label label_update_elemento;
	//dialog_vg_add
	public Dialog dialog_vg_add;
	public Entry text_vg_nombre;
	public Entry text_vg_dev;
	public Entry text_vg_pub;
	public Entry text_vg_motor;
	public Entry text_vg_consolas;
	//dialog_dev_add
	public Dialog dialog_dev_add;
	public Entry text_dev_nombre;
	public Entry text_dev_sede;
	public Entry text_dev_fundacion;
	public RadioButton radio_dev_activo_y;
	//dialog_pub_add
	public Dialog dialog_pub_add;
	public Entry text_pub_nombre;
	public Entry text_pub_sede;
	public Entry text_pub_fundacion;
	public RadioButton radio_pub_activo_y;
	//dialog_con_add
	public Dialog dialog_con_add;
	public Entry text_con_nombre;
	public Entry text_con_fabricante;
	public Entry text_con_cpu;
	public Entry text_con_lanzamiento;
	public SpinButton spinbutton_con_generacion;
	//window
	public Window main_window;
	public Label label_state;
	public Spinner spinner_search_active;
	public Button button_search;
	public TreeView treeview_tables_area;

	public int inicia (string archivo, Controlador controlador)
	{
		Builder builder = new Builder ();
		try {
			builder.add_from_file (archivo);
		} catch (Error e) {
			return -1;
		}
		builder.connect_signals (controlador);

		//Main window
		main_window = builder.get_object ("main_window") as Window;
		spinner_search_active = builder.get_object ("spinner_search_active") as Spinner;
		button_search = builder.get_object ("button_search") as Button;
		treeview_tables_area = builder.get_object ("treeview_tables_area") as TreeView;
		label_state = builder.get_object ("label_state") as Label;
		
		//Delete dialog
		dialog_delete = builder.get_object ("dialog_delete") as Dialog;
		label_del_elemento = builder.get_object ("label_del_elemento") as Label;

		//Update dialog
		dialog_update = builder.get_object ("dialog_update") as Dialog;
		label_update_elemento = builder.get_object ("label_update_elemento") as Label;

		//Add vg dialog
		dialog_vg_add = builder.get_object ("dialog_vg_add") as Dialog;
		text_vg_nombre = builder.get_object ("text_vg_nombre") as Entry;
		text_vg_dev = builder.get_object ("text_vg_dev") as Entry;
		text_vg_pub = builder.get_object ("text_vg_pub") as Entry;
		text_vg_motor = builder.get_object ("text_vg_motor") as Entry;
		text_vg_consolas = builder.get_object ("text_vg_consolas") as Entry;

		//Add dev dialog
		dialog_dev_add = builder.get_object ("dialog_dev_add") as Dialog;
		text_dev_nombre = builder.get_object ("text_dev_nombre") as Entry;
		text_dev_sede = builder.get_object ("text_dev_sede") as Entry;
		text_dev_fundacion = builder.get_object ("text_dev_fundacion") as Entry;
		radio_dev_activo_y = builder.get_object ("radio_dev_activo_y") as RadioButton;

		//Add pub dialog
		dialog_pub_add = builder.get_object ("dialog_pub_add") as Dialog;
		text_pub_nombre = builder.get_object ("text_pub_nombre") as Entry;
		text_pub_sede = builder.get_object ("text_pub_sede") as Entry;
		text_pub_fundacion = builder.get_object ("text_pub_fundacion") as Entry;
		radio_pub_activo_y = builder.get_object ("radio_pub_activo_y") as RadioButton;

		//Add con dialog
		dialog_con_add = builder.get_object ("dialog_con_add") as Dialog;
		text_con_nombre = builder.get_object ("text_con_nombre") as Entry;
		text_con_fabricante = builder.get_object ("text_con_fabricante") as Entry;
		text_con_cpu = builder.get_object ("text_con_cpu") as Entry;
		text_con_lanzamiento = builder.get_object ("text_con_lanzamiento") as Entry;
		spinbutton_con_generacion = builder.get_object ("spinbutton_con_generacion") as SpinButton;			

		main_window.show_all ();
		Gtk.main ();
		return 0;
	}
	
}