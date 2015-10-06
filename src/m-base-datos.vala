using Gda;

public class M.BaseDatos : GLib.Object {

	public string proveedor { private set; get; default = "SQLite"; }
	public string constr { private set; get; default = "SQLite://DB_DIR=.;DB_NAME=DataBase.db"; }
	public Connection conn { private set; get; }

	/**
	 * Abre una conexión a la base de datos.
	 *
	 * @throws Error Este método puede fallar con dominio de error
	 *         GDA_CONNECTION_ERROR o ConfigError.
	 */
	public void abre_conexion ()
	throws Error
	{
		conn = Connection.open_from_string(null, constr, null, ConnectionOptions.NONE);
		//Necesitamos claves foráneas.
		conn.execute_non_select_command ("PRAGMA foreign_keys = ON;");
	}

	/**
	 * Ejecuta una operación no SELECT sobre la base de datos con la conexión
	 * actual. <<BR>>
	 *
	 * Regresa el número de renglones afectados por la ejecución de
	 * <code>consulta</code>, -1 si ocurre un error, -2 en caso de que el
	 * proveedor no regrese el número de renglones afectados.
	 *
	 * @param consulta Una operación no SELECT sobre la base de datos.
	 *
	 * @return El número de renglones afectados (>= 0), -1, ó -2.
	 */
	public int realiza_consulta (string consulta)
	throws Error
	requires (conn.is_opened ())
	{
		return conn.execute_non_select_command (consulta);
	}

	/**
	 * Ejecuta una operación SELECT sobre la base de datos con la conexión
	 * actual. <<BR>>
	 *
	 * Regresa un DataModel representando el conjunto resultado de la consulta
	 * SELECT si la consulta se realizó con éxito, null en otro caso.
	 *
	 * @param consulta Una operación SELECT sobre la base de datos.
	 *
	 * @return Un DataModel representando el conjunto resultado de la consulta.
	 */
	public DataModel realiza_consulta_select (string consulta)
	throws Error
	requires (conn.is_opened ())
	{
		return conn.execute_select_command (consulta);
	}

	/**
	 * Cierra la actual conexión.
	 *
	 * Cierra la actual conexión a la base de datos.
	 */
	public void cierra_conexion ()
	requires (conn.is_opened ())
	{
		conn.close();
	}
	
}