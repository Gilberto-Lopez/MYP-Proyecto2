using M.BaseDatos;
using M.Tablas;

public class M.OperacionesBD : GLib.Object {

	//La base de datos a la cual nos conectamos
	private BaseDatos db;

	/**
	 * Constructor vacío, abre una conexión a una base de datos y realiza
	 * operaciones sobre ella.
	 *
	 * Para el error lanzado
	 * @see M.BaseDatos.abre_conexion ()
	 */
	public OperacionesBD ()
	throws Error
	{
		db = new BaseDatos ();
		db.abre_conexion ();
	}

	/**
	 * Agrega un nuevo videojuego a la base de datos.
	 *
	 * Agrega un nuevo videojuego a la base de datos con los datos
	 * especificados. Para el valor de retorno o el error lanzado 
	 * @see M.BaseDatos.realiza_consulta ()
	 *
	 * @param nombre El nombre del videojuego (distinto de la cadena vacía).
	 *
	 * @param motor El motor usado para desarrollar el videojuego, o null.
	 *
	 * @param desarrolladora La desarrolladora del videojuego, o null.
	 *
	 * @param publicadora La publicadora del videojuego, o null.
	 */
	public int agrega_vj (string nombre, string? motor,
						  string? desarrolladora, string? publicadora)
	throws Error
	{
		assert(nombre != "");
		motor = (motor == null || motor == "") ? "NULL" : @"'$motor'";
		desarrolladora = (desarrolladora == null || motor == "") ?
			"NULL" : @"'$desarrolladora'";
		publicadora = (publicadora == null || publicadora == "") ?
			"NULL" : @"'$publicadora'";
		string stmt = @"INSERT INTO videojuegos (nombre, motor, dev, pub) VALUES ('$nombre', $motor, $desarrolladora, $publicadora);"
		return db.realiza_consulta(stmt);
	}

	/**
	 * Agrega una nueva desarrolladora a la base de datos.
	 *
	 * Agrega un nueva desarrolladora a la base de datos con los datos
	 * especificados. Para el valor de retorno o el error lanzado 
	 * @see M.BaseDatos.realiza_consulta ()
	 *
	 * @param nombre El nombre de la desarrolladora (distinto de la cadena
	 *        vacía).
	 *
	 * @param sede La sede actual de la desarrolladora, o null.
	 *
	 * @param activo 0 si la desarrolladora no sigue activa, 1 si aún está
	 *        activa.
	 *
	 * @param fundacion La fecha de fundación de la desarrolladora, en formato
	 *        YYYY-MM-DD, o null.
	 */
	public int agrega_dev (string nombre, string? sede,
						   int activo, string? fundacion)
		throws Error
		requires (activo == 0 || activo == 1)
	{
		assert(nombre != "");
		sede = (sede == null || sede == "") ? "NULL" : @"'$sede'";
		fundacion = (fundacion == null || fundacion == "") ?
			"NULL" : @"'$fundacion'";
		string stmt = @"INSERT INTO desarrolladoras (nombre, sede, activo, fundacion) VALUES ('$nombre', $sede, $activo, $fundacion);";
		return db.realiza_consulta(stmt);
	}

	/**
	 * Agrega una nueva publicadora a la base de datos.
	 *
	 * Agrega una nueva publicadora a la base de datos con los datos
	 * especificados. Para el valor de retorno o el error lanzado 
	 * @see M.BaseDatos.realiza_consulta ()
	 *
	 * @param nombre El nombre de la publicadora (distinto de la cadena vacía).
	 *
	 * @param sede La sede actual de la publicadora, o null.
	 *
	 * @param activo 0 si la publicadora no sigue activa, 1 si aún está activa.
	 *
	 * @param fundacion La fecha de fundación de la publicadora, en formato
	 *        YYYY-MM-DD, o null.
	 */
	public int agrega_pub (string nombre, string? sede,
						   int activo, string? fundacion)
		throws Error
		requires (activo == 0 || activo == 1)
	{
		assert (nombre != "");
		sede = (sede == null || sede == "") ? "NULL" : @"'$sede'";
		fundacion = (fundacion == null || fundacion == "") ?
			"NULL" : @"'$fundacion'";
		string stmt = @"INSERT INTO publicadoras (nombre, sede, activo, fundacion) VALUES ('$nombre', $sede, $activo, $fundacion);";
		return db.realiza_consulta(stmt);
	}

	/**
	 * Agrega una nueva consola a la base de datos.
	 *
	 * Agrega un nueva consola a la base de datos con los datos
	 * especificados. Para el valor de retorno o el error lanzado 
	 * @see M.BaseDatos.realiza_consulta ()
	 *
	 * @param nombre El nombre de la consola (distinto de la cadena vacía).
	 *
	 * @param fabricante El fabricante de la consola, o null.
	 *
	 * @param gen La generación a la que pertenece la consola (>= 1 o 0 si se
	 *        desconoce).
	 *
	 * @param cpu El CPU principal usado por la consola, o null.
	 *
	 * @param lannzamiento La fecha de lanzamiento de la consola, en formato
	 *        YYYY-MM-DD, o null.
	 */
	public int agrega_consola (string nombre, string? fabricante,
							   int gen, string? cpu, string? lanzamiento)
		throws Error
		requires (gen >= 0)
	{
		assert (nombre != "");
		fabricante = (fabricante == null || fabricante == "") ?
			"NULL" : @"'$fabricante'";
		cpu = (cpu == null || cpu == "") ? "NULL" : @"'$cpu'";
		lanzamiento = (lanzamiento == null || lanzamiento == "") ?
			"NULL" : @"'$lanzamiento'";
		string stmt = @"INSERT INTO consolas (nombre, fabricante, gen, cpu, lanzamiento) VALUES ('$nombre', $fabricante, $gen, $cpu, $lanzamiento);"
	}

}