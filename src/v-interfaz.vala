using Gtk;

public class V.Interfaz : GLib.Object {

	//dialog_delete
	public Label label_del_elemento;
	public Button button_del_aceptar;
	public Button button_del_cancelar;
	//dialog_vg_add
	public Button button_vg_add_aceptar;
	public Button button_vg_add_cancelar;
	public Entry text_vg_nombre;
	public Entry text_vg_dev;
	public Entry text_vg_pub;
	public Entry text_vg_motor;
	public Entry text_vg_consolas;
	//dialog_dev_add
	public Button button_dev_add_aceptar;
	public Button button_dev_add_cancelar;
	public Entry text_dev_nombre;
	public Entry text_dev_sede;
	public Entry text_dev_fundacion;
	public RadioButton radio_dev_activo_y;
	public RadioButton radio_dev_activo_n;
	//dialog_pub_add
	public Button button_pub_add_aceptar;
	public Button button_pub_add_cancelar;
	public Entry text_pub_nombre;
	public Entry text_pub_sede;
	public Entry text_pub_fundacion;
	public RadioButton radio_pub_activo_y;
	public RadioButton radio_pub_activo_n;
	//dialog_con_add
	public Button button_con_add_aceptar;
	public Button button_con_add_cancelar;
	public Entry text_con_nombre;
	public Entry text_con_fabricante;
	public Entry text_con_cpu;
	public Entry text_con_lanzamiento;
	public SpinButton spinbutton_con_generacion;
	//window
	public Spinner spinner_search_active;
	public Button button_search;
	public ComboBox combox_add;
	public TreeView treeview_tables_area;
	public ListStore liststore_tables;
	
}