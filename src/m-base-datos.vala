using Sqlite;

/**
 * Clase para administrar la conexión a una base de datos.
 *
 * La conexión se realiza a una base de datos "DataBase.db" por defecto con el
 * método {@link abre_conexion}. La conexión tiene por defecto activas las 
 * restricciones de [[https://www.sqlite.org/foreignkeys.html|claves foráneas]],
 * y establece el tiempo de espera
 * ([[https://www.sqlite.org/pragma.html#pragma_busy_timeout|busy timeout]])
 * de 30 segundos.
 *
 * Pueden realizarse consultas no SELECT sobre la base de datos dado un
 * enunciado SQL válido, y consultas SELECT sobre la base de datos dado un 
 * enunciado SQL válido y un {@link Sqlite.Callback} para realizar operaciones
 * sobre el conjunto de resultados.
 *
 * Importante: la conexión es única, no pueden existir varias conexiones a la
 * base de datos, si quiere obtener la única conexión (instancia) véase
 * {@link get_instancia}.
 */
public class M.BaseDatos : GLib.Object {

	//Administrador de la base de datos.
	private static BaseDatos bd = null;
	private Database db;
	private string errmsg;

	//Constructor vacío, privado para evitar que esta clase pueda ser
	//instanciada
	private BaseDatos ()
	{
	}

	//Crea una instancia de la clase si es que no existe una actualmente.
	private static void crea_instancia ()
	{
		if (bd == null) {
			bd = new BaseDatos ();
		}
	}

	/**
	 * Regresa un administrador para trabajar sobre una base de datos, pues
	 * la conexión a la base de datos debe ser única.
	 *
	 * @return Un administrador de la base de datos.
	 */
	public static BaseDatos get_instancia ()
	{
		if (bd == null) {
			crea_instancia ();
		}
		return bd;
	}
	
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
		int ec = Database.open ("DataBase.db", out db);
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
	 * @param callback El callback que se ejecuta sobre el conjunto
	 *        de resultados que regresa la consulta SELECT.
	 *
	 * @return Un entero representando si la operación se realizó con éxito
	 *         (Sqlite.OK) o no.
	 */
	public int realiza_consulta_select (string consulta,
										Sqlite.Callback? callback = null)
	{
		return db.exec (consulta, callback, out errmsg);
	}

	/**
	 * Convierte una consulta en un Prepared Statement.
	 *
	 * Crea un [[https://www.sqlite.org/c3ref/stmt.html|Prepared Statement]],
	 * que es una consulta SQL que ha sido compilada a forma binaria y está
	 * lista para ser evaluada.
	 *
	 * @param consulta La consulta SQL a compilar.
	 *
	 * @param statement Una variable statement que contendrá el Prepared
	 *        Statement.
	 *
	 * @return Un entero representando si la operación se realizó con éxito
	 *         (Sqlite.OK) o no.
	 */
	public int crea_statement (string consulta, out Statement statement)
	{
		return db.prepare_v2 (consulta, consulta.length, out statement);
	}
	
}