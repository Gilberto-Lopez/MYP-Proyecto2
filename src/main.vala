using M;
using V;
using C;
using Gtk;

int main (string[] args)
{
	//args[0] ./main
	//args[1] lib/DataBase.db - base de datos
	//args[2] lib/DataBaseUI.glade - interfaz
	Interfaz interfaz = new Interfaz ();
	Modelo modelo = new Modelo (args[1]);
	Controlador controlador = new Controlador (interfaz, modelo);
	Gtk.init (ref args);
	return interfaz.inicia (args[2], controlador);
}