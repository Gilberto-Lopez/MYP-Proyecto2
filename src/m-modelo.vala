/**
 * Clase Modelo correspondiente al modelo del programa.
 *
 * Los objetos de esta clase encapsulan a la base de datos y las operaciones
 * que se pueden realizar sobre ella.
 */
public class M.Modelo : GLib.Object {

	/**
	 * La base de datos a la cual se realiza la conexión.
	 */
	public BaseDatos base_datos { get; private set; }

	/**
	 * Una instancia de Consultas para realizar consultas no SELECT sobre la 
	 * base de datos.
	 */
	public Consultas consultas_no_select { get; private set; }
	/**
	 * Una instancia de ConsultasSelect para realizar consultas SELECT sobre la
	 * base de datos.
	 */
	public ConsultasSelect consultas_select { get; private set; }

	/**
	 * Constructor de Modelo. Crea un objeto Modelo que abre una conexión a la
	 * base de datos especificada como parámetro e inicializando los objetos
	 * necesarios para hacer consultas sobre dicha base.
	 *
	 * @param base_datos El path al archvio de la base de datos de SQLite.
	 */
	public Modelo (string base_datos) {
		this.base_datos = BaseDatos.get_instancia ();
		int ec = this.base_datos.abre_conexion (base_datos);
		assert (ec == Sqlite.OK);
		consultas_no_select = new Consultas ();
		consultas_select = new ConsultasSelect (this.base_datos);
	}
	
}