using M;
using V;
using C;
using Gtk;

int main (string[] args)
{
	//args[1] base de datos
	//args[2] interfaz
	Interfaz interfaz = new Interfaz ();
	Modelo modelo = new Modelo (args[1]);
	Controlador controlador = new Controlador (interfaz, modelo);
	Gtk.init (ref args);
	int i = interfaz.inicia (args[2], controlador);
	if (i != 0) {
		return 1;
	}
	return 0;
}