using M.Tablas;
using Sqlite;

public class M.ConsultasSelect : GLib.Object {

	private BaseDatos db;
	private const string vj = "SELECT nombre FROM videojuegos WHERE nombre = $NOM;";
	private const string dev = "SELECT nombre FROM desarrolladoras WHERE nombre = $NOM;";
	private const string pub = "SELECT nombre FROM publicadoras WHERE nombre = $NOM;";
	private const string con = "SELECT nombre FROM consolas WHERE nombre = $NOM;";
	private const string dev_to = "SELECT * FROM dev_to WHERE dev_n = $DVN AND con_n = $CNN;";
	private const string pub_to = "SELECT * FROM pub_to WHERE pub_n = $PBN AND con_n = $CNN;";
	private const string dis_to = "SELECT * FROM dis_to WHERE vj_n = $VJN AND con_n = $CNN;";

	/**
	 * Propiedad consulta_activa. Si una consulta está realizándose sobre la
	 * base de datos su valor es true, en caso contrario su valor es false.
	 */
	public bool consulta_activa { get; private set; }

	/**
	 * Crea un nuevo objeto ConsultasSelect para operar sobre una base de datos
	 * con una conexión previamente abierta.
	 *
	 * @param db Una base de datos con una conexión previamente abierta.
	 */
	public ConsultasSelect (BaseDatos db)
	{
		this.db = db;
	}

	/**
	 * Nos dice si un videojuego existe en la base de datos.
	 *
	 * Busca un videojuego en la base de datos por su nombre, si el videojuego
	 * existe regresa true; false en cualquier otro caso. En caso de error, el
	 * código de error se guarda en una variable tipo int proporcionada
	 * por el usuario.
	 *
	 * Importante: Para realizar esta consulta no debe estar activa otra
	 * consulta.
	 *
	 * @param nombre El nombre del videojuego a buscar.
	 *
	 * @param errcode Una variable int para guardar el código de error
	 * (!= Sqlite.OK) en caso de que un error llegue a ocurrir.
	 *
	 * @return true si el videojuego existe, false en cualquier otro caso.
	 */
	public bool existe_vj (string nombre, out int errcode)
	requires (!consulta_activa)
	{
		//Se inicia una consulta
		consulta_activa = true;
		
		if (nombre == "") {
			consulta_activa = false;
			return false;
		}
		Statement stmt;
		int stmt_r = db.crea_statement (vj, out stmt);
		if (stmt_r != Sqlite.OK) {
			errcode = stmt_r;
			consulta_activa = false;
			return false;
		}
		int i = stmt.bind_parameter_index ("$NOM");
		stmt.bind_text (i, nombre);
		stmt_r = stmt.step ();
		if (stmt_r == Sqlite.ROW) {
			consulta_activa = false;
			return true;
		}
		if (stmt_r != Sqlite.DONE) {
			errcode = stmt_r;
		}
		
		//La consulta finaliza
		consulta_activa = false;
		return false;
	}

	/**
	 * Nos dice si una desarrolladora existe en la base de datos.
	 *
	 * Busca una desarrolladora en la base de datos por su nombre, si la
	 * desarrolladora existe regresa true; false en cualquier otro caso. En
	 * caso de error, el código de error se guarda en una variable tipo int
	 * proporcionada por el usuario.
	 *
	 * Importante: Para realizar esta consulta no debe estar activa otra
	 * consulta.
	 *
	 * @param nombre El nombre de la desarrolladora a buscar.
	 *
	 * @param errcode Una variable int para guardar el código de error
	 * (!= Sqlite.OK) en caso de que un error llegue a ocurrir.
	 *
	 * @return true si la desarrolladora existe, false en cualquier otro caso.
	 */
	public bool existe_dev (string nombre, out int errcode)
	requires (!consulta_activa)
	{
		//Se inicia una consulta
		consulta_activa = true;

		if (nombre == "") {
			consulta_activa = false;
			return false;
		}
		Statement stmt;
		int stmt_r = db.crea_statement (dev, out stmt);
		if (stmt_r != Sqlite.OK) {
			errcode = stmt_r;
			consulta_activa = false;
			return false;
		}
		int i = stmt.bind_parameter_index ("$NOM");
		stmt.bind_text (i, nombre);
		stmt_r = stmt.step ();
		if (stmt_r == Sqlite.ROW) {
			consulta_activa = false;
			return true;
		}
		if (stmt_r != Sqlite.DONE) {
			errcode = stmt_r;
		}
		
		//La consulta finaliza
		consulta_activa = false;
		return false;
	}

	/**
	 * Nos dice si una publicadora existe en la base de datos.
	 *
	 * Busca una publicadora en la base de datos por su nombre, si la
	 * publicadora existe regresa true; false en cualquier otro caso. En
	 * caso de error, el código de error se guarda en una variable tipo int
	 * proporcionada por el usuario.
	 *
	 * Importante: Para realizar esta consulta no debe estar activa otra
	 * consulta.
	 *
	 * @param nombre El nombre de la publicadora a buscar.
	 *
	 * @param errcode Una variable int para guardar el código de error
	 * (!= Sqlite.OK) en caso de que un error llegue a ocurrir.
	 *
	 * @return true si la publicadora existe, false en cualquier otro caso.
	 */
	public bool existe_pub (string nombre, out int errcode)
	requires (!consulta_activa)
	{
		//Se inicia una consulta
		consulta_activa = true;

		if (nombre == "") {
			consulta_activa = false;
			return false;
		}
		Statement stmt;
		int stmt_r = db.crea_statement (pub, out stmt);
		if (stmt_r != Sqlite.OK) {
			errcode = stmt_r;
			consulta_activa = false;
			return false;
		}
		int i = stmt.bind_parameter_index ("$NOM");
		stmt.bind_text (i, nombre);
		stmt_r = stmt.step ();
		if (stmt_r == Sqlite.ROW) {
			consulta_activa = false;
			return true;
		}
		if (stmt_r != Sqlite.DONE) {
			errcode = stmt_r;
		}
		
		//La consulta finaliza
		consulta_activa = false;
		return false;
	}

	/**
	 * Nos dice si una consola existe en la base de datos.
	 *
	 * Busca una consola en la base de datos por su nombre, si la
	 * consola existe regresa true; false en cualquier otro caso. En
	 * caso de error, el código de error se guarda en una variable tipo int
	 * proporcionada por el usuario.
	 *
	 * Importante: Para realizar esta consulta no debe estar activa otra
	 * consulta.
	 *
	 * @param nombre El nombre de la consola a buscar.
	 *
	 * @param errcode Una variable int para guardar el código de error
	 * (!= Sqlite.OK) en caso de que un error llegue a ocurrir.
	 *
	 * @return true si la consola existe, false en cualquier otro caso.
	 */
	public bool existe_con (string nombre, out int errcode)
	requires (!consulta_activa)
	{
		//Se inicia una consulta
		consulta_activa = true;

		if (nombre == "") {
			consulta_activa = false;
			return false;
		}
		Statement stmt;
		int stmt_r = db.crea_statement (con, out stmt);
		if (stmt_r != Sqlite.OK) {
			errcode = stmt_r;
			consulta_activa = false;
			return false;
		}
		int i = stmt.bind_parameter_index ("$NOM");
		stmt.bind_text (i, nombre);
		stmt_r = stmt.step ();
		if (stmt_r == Sqlite.ROW) {
			consulta_activa = false;
			return true;
		}
		if (stmt_r != Sqlite.DONE) {
			errcode = stmt_r;
		}
		
		//La consulta finaliza
		consulta_activa = false;
		return false;
	}

	/**
	 * Nos dice si una desarrolladora ha desarrollado juegos para una consola.
	 * 
	 * Busca una desarrolladora y una consola por sus nombres en la base de
	 * datos y, de existir ambas, nos dice si la desarrolladora ha desarrollado
	 * al menos un juego para dicha consola, en cuyo caso regresa true, en caso
	 * contrario (o si no existe) regresa false.
	 *
	 * Importante: Para realizar esta consulta no debe estar activa otra
	 * consulta.
	 *
	 * @param desarrolladora El nombre de la desarrolladora.
	 * 
	 * @param consola El nombre de la consola.
	 *
	 * @param errcode Una variable int para guardar el código de error
	 * (!= Sqlite.OK) en caso de que un error llegue a ocurrir.
	 *
	 * @return true si la desarrolladora ha desarrollado juegos para la consola.
	 */
	public bool desarrolla_para (string desarrolladora, string consola,
								 out int errcode)
	requires (!consulta_activa)
	{
		//Se inicia una consulta
		consulta_activa = true;

		if (desarrolladora == "" || consola == "") {
			consulta_activa = false;
			return false;
		}
		Statement stmt;
		int stmt_r = db.crea_statement (dev_to, out stmt);
		if (stmt_r != Sqlite.OK) {
			errcode = stmt_r;
			consulta_activa = false;
			return false;
		}
		int i = stmt.bind_parameter_index ("$DVN");
		stmt.bind_text (i, desarrolladora);
		i = stmt.bind_parameter_index ("$CNN");
		stmt.bind_text (i, consola);
		stmt_r = stmt.step ();
		if (stmt_r == Sqlite.ROW) {
			consulta_activa = false;
			return true;
		}
		if (stmt_r != Sqlite.DONE) {
			errcode = stmt_r;
		}
		
		//La consulta finaliza
		consulta_activa = false;
		return false;
	}

	/**
	 * Nos dice si una publicadora ha publicado juegos para una consola.
	 * 
	 * Busca una publicadora y una consola por sus nombres en la base de
	 * datos y, de existir ambas, nos dice si la publicadora ha publicado
	 * al menos un juego para dicha consola, en cuyo caso regresa true, en caso
	 * contrario (o si no existen) regresa false.
	 *
	 * Importante: Para realizar esta consulta no debe estar activa otra
	 * consulta.
	 *
	 * @param publicadora El nombre de la publicadora.
	 * 
	 * @param consola El nombre de la consola.
	 *
	 * @param errcode Una variable int para guardar el código de error
	 * (!= Sqlite.OK) en caso de que un error llegue a ocurrir.
	 *
	 * @return true si la publicadora ha publicado juegos para la consola.
	 */
	public bool publica_para (string publicadora, string consola,
							  out int errcode)
	requires (!consulta_activa)
	{
		//Se inicia una consulta
		consulta_activa = true;

		if (publicadora == "" || consola == "") {
			consulta_activa = false;
			return false;
		}
		Statement stmt;
		int stmt_r = db.crea_statement (pub_to, out stmt);
		if (stmt_r != Sqlite.OK) {
			errcode = stmt_r;
			consulta_activa = false;
			return false;
		}
		int i = stmt.bind_parameter_index ("$PBN");
		stmt.bind_text (i, publicadora);
		i = stmt.bind_parameter_index ("$CNN");
		stmt.bind_text (i, consola);
		stmt_r = stmt.step ();
		if (stmt_r == Sqlite.ROW) {
			consulta_activa = false;
			return true;
		}
		if (stmt_r != Sqlite.DONE) {
			errcode = stmt_r;
		}
		
		//La consulta finaliza
		consulta_activa = false;
		return false;
	}

	/**
	 * Nos dice si un videojuego está disponible para una consola.
	 * 
	 * Busca un videojuego y una consola por sus nombres en la base de
	 * datos y, de existir ambos, nos dice si el videojuego está disponible
	 * para dicha consola, en cuyo caso regresa true, en caso contrario (o si 
	 * no existen) regresa false.
	 *
	 * Importante: Para realizar esta consulta no debe estar activa otra
	 * consulta.
	 *
	 * @param videojuego El nombre del videojuego.
	 * 
	 * @param consola El nombre de la consola.
	 *
	 * @param errcode Una variable int para guardar el código de error
	 * (!= Sqlite.OK) en caso de que un error llegue a ocurrir.
	 *
	 * @return true si el videojuego está disponible para la consola.
	 */
	public bool disponible_para (string videojuego, string consola,
								 out int errcode)
	requires (!consulta_activa)
	{
		//Se inicia una consulta
		consulta_activa = true;

		if (videojuego == "" || consola == "") {
			consulta_activa = false;
			return false;
		}
		Statement stmt;
		int stmt_r = db.crea_statement (dis_to, out stmt);
		if (stmt_r != Sqlite.OK) {
			errcode = stmt_r;
			consulta_activa = false;
			return false;
		}
		int i = stmt.bind_parameter_index ("$VJN");
		stmt.bind_text (i, videojuego);
		i = stmt.bind_parameter_index ("$CNN");
		stmt.bind_text (i, consola);
		stmt_r = stmt.step ();
		if (stmt_r == Sqlite.ROW) {
			consulta_activa = false;
			return true;
		}
		if (stmt_r != Sqlite.DONE) {
			errcode = stmt_r;
		}
		
		//La consulta finaliza
		consulta_activa = false;
		return false;
	}

}