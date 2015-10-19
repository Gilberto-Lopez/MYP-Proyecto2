public class M.Modelo : GLib.Object {

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
	
	public Modelo (string base_datos) {
		this.base_datos = BaseDatos.get_instancia ();
		int ec = this.base_datos.abre_conexion (base_datos);
		assert (ec == Sqlite.OK);
		consultas_no_select = new Consultas ();
		consultas_select = new ConsultasSelect (this.base_datos);
	}
	
}