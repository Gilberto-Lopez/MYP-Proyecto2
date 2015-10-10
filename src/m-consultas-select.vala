using M.Tablas;
using Sqlite;

class M.ConsultasSelect : GLib.Object {

	private BaseDatos db;
	private const string vj = "SELECT nombre FROM videojuegos WHERE nombre = $NOM;";
	private const string dev = "SELECT nombre FROM desarrolladoras WHERE nombre = $NOM;";
	private const string pub = "SELECT nombre FROM publicadoras WHERE nombre = $NOM;";
	private const string con = "SELECT nombre FROM consolas WHERE nombre = $NOM;";
	private const string dev_to = "SELECT * FROM dev_to WHERE dev_n = $DVN AND con_n = $CNN;";
	private const string pub_to = "SELECT * FROM pub_to WHERE pub_n = $PBN AND con_n = $CNN;";
	private const string dis_to = "SELECT * FROM dis_to WHERE vj_n = $VJN AND con_n = $CNN;";
	
	public ConsultasSelect (BaseDatos db)
	{
		this.db = db;
	}
	
	public bool existe_vj (string nombre)
	{
		if (nombre == "") {
			return false;
		}
		Statement stmt;
		if (db.crea_statement (vj, out stmt) != Sqlite.OK) {
			return false;
		}
		int i = stmt.bind_parameter_index ("$NOM");
		stmt.bind_text (i, nombre);
		if (stmt.step () == Sqlite.ROW) {
			return true;
		} else {
			return false;
		}
	}

	public bool existe_dev (string nombre)
	{
		if (nombre == "") {
			return false;
		}
		Statement stmt;
		if (db.crea_statement (dev, out stmt) != Sqlite.OK) {
			return false;
		}
		int i = stmt.bind_parameter_index ("$NOM");
		stmt.bind_text (i, nombre);
		if (stmt.step () == Sqlite.ROW) {
			return true;
		} else {
			return false;
		}
	}
	
	public bool existe_pub (string nombre)
	{
		if (nombre == "") {
			return false;
		}
		Statement stmt;
		if (db.crea_statement (pub, out stmt) != Sqlite.OK) {
			return false;
		}
		int i = stmt.bind_parameter_index ("$NOM");
		stmt.bind_text (i, nombre);
		if (stmt.step () == Sqlite.ROW) {
			return true;
		} else {
			return false;
		}
	}
	
	public bool existe_con (string nombre)
	{
		if (nombre == "") {
			return false;
		}
		Statement stmt;
		if (db.crea_statement (con, out stmt) != Sqlite.OK) {
			return false;
		}
		int i = stmt.bind_parameter_index ("$NOM");
		stmt.bind_text (i, nombre);
		if (stmt.step () == Sqlite.ROW) {
			return true;
		} else {
			return false;
		}
	}

	public bool desarrolla_para (string desarrolladora, string consola)
	{
		if (desarrolladora == "" || consola == "") {
			return false;
		}
		Statement stmt;
		if (db.crea_statement (dev_to, out stmt) != Sqlite.OK) {
			return false;
		}
		int i = stmt.bind_parameter_index ("$DVN");
		stmt.bind_text (i, desarrolladora);
		i = stmt.bind_parameter_index ("$CNN");
		stmt.bind_text (i, consola);
		if (stmt.step () == Sqlite.ROW) {
			return true;
		} else {
			return false;
		}
	}

	public bool publica_para (string publicadora, string consola)
	{
		if (publicadora == "" || consola == "") {
			return false;
		}
		Statement stmt;
		if (db.crea_statement (pub_to, out stmt) != Sqlite.OK) {
			return false;
		}
		int i = stmt.bind_parameter_index ("$PBN");
		stmt.bind_text (i, publicadora);
		i = stmt.bind_parameter_index ("$CNN");
		stmt.bind_text (i, consola);
		if (stmt.step () == Sqlite.ROW) {
			return true;
		} else {
			return false;
		}
	}
	
	public bool disponible_para (string videojuego, string consola)
	{
		if (videojuego == "" || consola == "") {
			return false;
		}
		Statement stmt;
		if (db.crea_statement (dis_to, out stmt) != Sqlite.OK) {
			return false;
		}
		int i = stmt.bind_parameter_index ("$VJN");
		stmt.bind_text (i, videojuego);
		i = stmt.bind_parameter_index ("$CNN");
		stmt.bind_text (i, consola);
		if (stmt.step () == Sqlite.ROW) {
			return true;
		} else {
			return false;
		}
	}

}