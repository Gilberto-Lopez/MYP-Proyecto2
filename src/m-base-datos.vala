using Sqlite;

public class M.BaseDatos : GLib.Object {

	//Administrador de la base de datos.
	private Database db;
	private string errmsg;

	/**
	 * Abre una conexión a la base de datos.
	 *
	 * Abre una conexión a la base de datos, la base de datos usa restricciones
	 * de llaves foráneas y cuenta con un tiempo de espera para las operaciones
	 * de 30 segundos. Regresa un entero representando si la operación se
	 * realizó con éxito o no. Para más información sobre el valor de retorno
	 * véase [[https://www.sqlite.org/capi3ref.html#SQLITE_ABORT|Result Codes]].
	 *
	 * @return Un entero representando si la operación se realizó con éxito
	 *         (Sqlite.OK) o no.
	 */
	public int abre_conexion ()
	{
		int ec = Database.open ("Database.db", out db);
		if (ec != Sqlite.OK) {
			return db.errcode ();
		}
		//Neciesitamos claves foráneas.
		ec = db.exec ("PRAGMA foreign_keys = ON;", null, out errmsg);
		if (ec != Sqlite.OK) {
			return ec;
		}
		//30 segundos para tiempo de espera.
		ec = db.busy_timeout (30000);
		return ec;
	}

	/**
	 * Ejecuta una consulta no SELECT sobre la base de datos con la conexión
	 * actual.
	 *
	 * Ejectua una consulta no SELECT sobre la base de datos, regresa un entero
	 * representando si la operación se realizó con éxito o no.
	 *
	 * @param consulta La consulta SQL no SELECT.
	 *
	 * @return Un entero representando si la operación se realizó con éxito
	 *         (Sqlite.OK) o no.
	 */
	public int realiza_consulta (string consulta)
	{
		return db.exec (consulta, null, out errmsg);
	}

	/**
	 * Ejecuta una consulta SELECT sobre la base de datos con la conexión
	 * actual.
	 *
	 * Ejecuta una consulta SELECT sobre la base de datos, regresando un entero
	 * representando si la operación se realizó con éxito o no, y ejecutando un
	 * Callback sobre el conjunto de resultados.
	 *
	 * @param consulta La consulta SQL SELECT.
	 *
	 * @param callback El callback que se ejecuta sobre el conjunto de
	 *        de resultados que regresa la consulta SELECT.
	 *
	 * @return Un entero representando si la operación se realizó con éxito
	 *         (Sqlite.OK) o no.
	 */
	public int realiza_consulta_select (string consulta,
										Sqlite.Callback? callback)
	{
		return db.exec (consulta, callback, out errmsg);
	}
	
}