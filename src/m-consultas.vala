using M.Tablas;

/**
 * Clase para crear consultas (strings SQL) para operaciones NO SELECT sobre una
 * base de datos.
 *
 * Las instancias de esta clase pueden crear strings que contienen consultas
 * SQL para realizar operaciones NO SELECT sobre una base de datos, como son:
 *
 *  * DELETE
 *  * UPDATE
 *  * INSERT
 *  * Crear relaciones entre tablas.
 *
 * Se pueden agregar, actualizar o eliminar:
 *
 *  * Videojuegos
 *  * Desarrolladoras
 *  * Publicadoras
 *  * Consolas
 *
 * Las relaciones que se pueden crear son:
 *
 *  * Desarrolla para (relaciona una desarrolladora con una consola)
 *  * Publica para (relaciona una publicadora con una consola)
 *  * Disponible para (relaciona un videojuego con una consola)
 */
public class M.Consultas : GLib.Object {
	
	/**
	 * Crea una consulta SQL para agregar un videojuego a la base de datos.
	 *
	 * Crea un string que contiene una consulta SQL para agregar un nuevo
	 * videojuego a la base de datos con los parámetros especificados.
	 *
	 * @param nombre El nombre del videojuego (distinto de la cadena vacía).
	 *
	 * @param motor El motor usado para desarrollar el videojuego, o null.
	 *
	 * @param desarrolladora La desarrolladora del videojuego (distinto de la
	 *        cadena vacía).
	 *
	 * @param publicadora La publicadora del videojuego (distinto de la cadena
	 *        vacía).
	 *
	 * @return La consulta SQL para agregar un videojuego a la base de datos.
	 */
	public string? agrega_vj (string nombre, string? motor,
							  string desarrolladora, string publicadora)
	{
		if (nombre == "" || desarrolladora == "" || publicadora == "") {
			return null;
		}
		string m = (motor == null || motor == "") ? "NULL" : @"\"$motor\"";
		string query = @"INSERT INTO videojuegos (nombre, motor, dev, pub) VALUES (\"$nombre\", $m, \"$desarrolladora\", \"$publicadora\");";
		return query;
	}

	/**
	 * Crea una consulta SQL para agregar una desarrolladora a la base de datos.
	 *
	 * Crea un string que contiene una consulta SQL para agregar una nueva
	 * desarrolladora a la base de datos con los parámetros especificados.
	 *
	 * @param nombre El nombre de la desarrolladora (distinto de la cadena
	 *        vacía).
	 *
	 * @param sede La sede de la desarrolladora, o null.
	 *
	 * @param activo Un entero que representa es estado actual de la
	 *        desarrolladora: 1 si sigue activa, 0 si no sigue activa.
	 *
	 * @param fundacion La fecha de fundación de la desarrolladora en formato
	 *        YYYY-MM-DD, o null.
	 *
	 * @return La consulta SQL para agregar una desarrolladora a la base de
	 *         datos.
	 */
	public string? agrega_dev (string nombre, string? sede,
							   int activo, string? fundacion)
	{
		if (nombre == "") {
			return null;
		}
		string s = (sede == null || sede == "") ? "NULL" : @"\"$sede\"";
		string f = (fundacion == null || fundacion == "") ?
			"NULL" : @"\"$fundacion\"";
		string query = @"INSERT INTO desarrolladoras (nombre, sede, activo, fundacion) VALUES (\"$nombre\", $s, $activo, $f);";
		return query;
	}

	/**
	 * Crea una consulta SQL para agregar una publicadora a la base de datos.
	 *
	 * Crea un string que contiene una consulta SQL para agregar una nueva
	 * publicadora a la base de datos con los parámetros especificados.
	 *
	 * @param nombre El nombre de la publicadora (distinto de la cadena vacía).
	 *
	 * @param sede La sede de la publicadora, o null.
	 *
	 * @param activo Un entero que representa es estado actual de la
	 *        publicadora: 1 si sigue activa, 0 si no sigue activa.
	 *
	 * @param fundacion La fecha de fundación de la publicadora en formato
	 *        YYYY-MM-DD, o null.
	 *
	 * @return La consulta SQL para agregar una publicadora a la base de datos.
	 */
	public string? agrega_pub (string nombre, string? sede,
							   int activo, string? fundacion)
	requires (activo == 0 || activo == 1)
	{
		if (nombre == "") {
			return null;
		}
		string s = (sede == null || sede == "") ? "NULL" : @"\"$sede\"";
		string f = (fundacion == null || fundacion == "") ?
			"NULL" : @"\"$fundacion\"";
		string query = @"INSERT INTO publicadoras (nombre, sede, activo, fundacion) VALUES (\"$nombre\", $s, $activo, $f);";
		return query;
	}

	/**
	 * Crea una consulta SQL para agregar una consola a la base de datos.
	 *
	 * Crea un string que contiene una consulta SQL para agregar una nueva
	 * consola a la base de datos con los parámetros especificados.
	 *
	 * @param nombre El nombre de la consola (distinto de la cadena vacía).
	 *
	 * @param fabricante El fabricante de la consola.
	 *
	 * @param gen La generación a la que pertenece la consola (> 0), o 0 si se
	 *        desconoce.
	 *
	 * @param cpu El CPU instalado en la consola, o null.
	 *
	 * @param lanzamiento La fecha de lanzamiento de la consola en formato
	 *        YYYY-MM-DD, o null.
	 *
	 * @return La consulta SQL para agregar una consola a la base de datos.
	 */
	public string? agrega_con (string nombre, string fabricante,
							   int gen, string? cpu, string? lanzamiento)
	requires (gen >= 0)
	{
		if (nombre == "" || fabricante == "") {
			return null;
		}
		string c = (cpu == null || cpu == "") ? "NULL" : @"\"$cpu\"";
		string l = (lanzamiento == null || lanzamiento == "") ?
			"NULL" : @"\"$lanzamiento\"";
		string query = @"INSERT INTO consolas (nombre, fabricante, gen, cpu, lanzamiento) VALUES (\"$nombre\", \"$fabricante\", $gen, $c, $l);";
		return query;
	}

	/**
	 * Crea una consulta SQL para actualizar un videojuego existente en la base
	 * de datos.
	 *
	 * Crea un string que contiene una consulta SQL para actualizar un campo de 
	 * un videojuego existente en la base de datos. El videojuego se busca por
	 * su nombre, no se puede alterar el nombre del videojuego. Se puede
	 * modificar el motor, la desarrolladora o la publicadora del videojuego.
	 *
	 * @param nombre El nombre del videojuego a modificar.
	 * 
	 * @param columna La columna que contiene el dato a modificar.
	 *
	 * @param valor El nuevo valor, o null para eliminar el dato.
	 *
	 * @return La consulta SQL para actualizar un videojuego de la base de
	 *         datos.
	 */
	public string? actualizar_vj (string nombre, Videojuegos columna,
								  string? valor)
	requires (columna != Videojuegos.NOMBRE)
	{
		if (nombre == "") {
			return null;
		}
		string v = (valor == null || valor == "") ?
			"NULL" : @"\"$valor\"";
		string col = ""; //para evitar advertencias del compilador
		switch (columna) {
		case Videojuegos.MOTOR :
			col = "motor";
			break;
		case Videojuegos.DESARROLLADORA :
			col = "desarrolladora";
			break;
		case Videojuegos.PUBLICADORA :
			col = "publicadora";
			break;
		}
		string query = @"UPDATE videojuegos SET $col = $v WHERE nombre = \"$nombre\";";
		return query;
	}

	/**
	 * Crea una consulta SQL para actualizar una desarrolladora existente en la
	 * base de datos.
	 *
	 * Crea un string que contiene una consulta SQL para actualizar un campo de 
	 * una desarrolladora existente en la base de datos. La desarrolladora se
	 * busca por su nombre, no se puede alterar el nombre de la desarrolladora.
	 * Se puede modificar la sede, su estado de actividad o la fecha de
	 * fundación.
	 *
	 * @param nombre El nombre de la desarrolladora a modificar.
	 * 
	 * @param columna La columna que contiene el dato a modificar.
	 *
	 * @param valor El nuevo valor, o null para eliminar el dato.
	 *
	 * @return La consulta SQL para actualizar una desarrolladora de la base de
	 *         datos.
	 */
	public string? actualizar_dev (string nombre, Desarrolladoras columna,
								   string? valor)
	requires (columna != Desarrolladoras.NOMBRE)
	{
		string v = "";
		if (nombre == "") {
			return null;
		}
		if (valor == null || valor == "") {
			v = "NULL";
		} else {
			if (columna == Desarrolladoras.ACTIVO) {
				int val = int.parse (valor);
				assert (val == 0 || val == 1);
			} else {
				v = @"\"$valor\"";
			}
		}
		string col = ""; //para evitar advertencias del compilador
		switch (columna) {
		case Desarrolladoras.SEDE :
			col = "sede";
			break;
		case Desarrolladoras.ACTIVO	:
			col = "activo";
			break;
		case Desarrolladoras.FUNDACION :
			col = "fundacion";
			break;
		}
		string query = @"UPDATE desarrolladoras SET $col = $v WHERE nombre = \"$nombre\";";
		return query;
	}

	/**
	 * Crea una consulta SQL para actualizar una publicadora existente en la
	 * base de datos.
	 *
	 * Crea un string que contiene una consulta SQL para actualizar un campo de 
	 * una publicadora existente en la base de datos. La publicadora se
	 * busca por su nombre, no se puede alterar el nombre de la publicadora.
	 * Se puede modificar la sede, su estado de actividad o la fecha de
	 * fundación.
	 *
	 * @param nombre El nombre de la publicadora a modificar.
	 * 
	 * @param columna La columna que contiene el dato a modificar.
	 *
	 * @param valor El nuevo valor, o null para eliminar el dato.
	 *
	 * @return La consulta SQL para actualizar una publicadora de la base de
	 *         datos.
	 */
	public string? actualizar_pub (string nombre, Publicadoras columna,
								   string? valor)
	requires (columna != Publicadoras.NOMBRE)
	{
		string v = "";
		if (nombre == "") {
			return null;
		}
		if (valor == null || valor == "") {
			v = "NULL";
		} else {
			if (columna == Publicadoras.ACTIVO) {
				int val = int.parse (valor);
				assert (val == 0 || val == 1);
			} else {
				v = @"\"$valor\"";
			}
		}
		string col = ""; //para evitar advertencias del compilador
		switch (columna) {
		case Publicadoras.SEDE :
			col = "sede";
			break;
		case Publicadoras.ACTIVO :
			col = "activo";
			break;
		case Publicadoras.FUNDACION :
			col = "fundacion";
			break;
		}
		string query = @"UPDATE publicadoras SET $col = $v WHERE nombre = \"$nombre\";";
		return query;
	}

	/**
	 * Crea una consulta SQL para actualizar una consola existente en la
	 * base de datos.
	 *
	 * Crea un string que contiene una consulta SQL para actualizar un campo de 
	 * una consola existente en la base de datos. La consola se
	 * busca por su nombre, no se puede alterar el nombre de la consola.
	 * Se puede modificar el fabricante, la generación, el CPU o la fecha de
	 * lanzamiento de la consola.
	 *
	 * @param nombre El nombre de la consola a modificar.
	 * 
	 * @param columna La columna que contiene el dato a modificar.
	 *
	 * @param valor El nuevo valor, o null para eliminar el dato.
	 *
	 * @return La consulta SQL para actualizar una consola de la base de datos.
	 */
	public string? actualizar_con (string nombre, Consolas columna,
								   string? valor)
	requires (columna != Consolas.NOMBRE)
	{
		string v = "";
		if (nombre == "") {
			return null;
		}
		if (valor == null || valor == "") {
			v = "NULL";
		} else {
			if (columna == Consolas.GENERACION) {
				int val = int.parse (valor);
				assert (val >= 0);
			} else {
				v = @"\"$valor\"";
			}
		}
		string col = ""; //para evitar advertencias del compilador
		switch (columna) {
		case Consolas.FABRICANTE :
			col = "fabricante";
			break;
		case Consolas.GENERACION :
			col = "gen";
			break;
		case Consolas.CPU :
			col = "cpu";
			break;
		case Consolas.LANZAMIENTO :
			col = "lanzamiento";
			break;
		}
		string query = @"UPDATE consolas SET $col = $v WHERE nombre = \"$nombre\";";
		return query;
	}

	/**
	 * Crea una consulta SQL para eliminar un videojuego de la base de datos.
	 *
	 * Crea un string que contiene una consulta SQL para eliminar un
	 * videojuego de la base de datos. El videojuego se busca por su nombre.
	 *
	 * @param nombre El nombre del videojuego a eliminar.
	 *
	 * @return La consulta SQL para eliminar un videojuego de la base de datos.
	 */
	public string? eliminar_vj (string nombre)
	{
		if (nombre == "") {
			return null;
		}
		string query = @"DELETE FROM videojuegos WHERE nombre = \"$nombre\";";
		return query;
	}

	/**
	 * Crea una consulta SQL para eliminar una desarrolladora de la base de
	 * datos.
	 *
	 * Crea un string que contiene una consulta SQL para eliminar una
	 * desarrolladora de la base de datos. La desarrolladora se busca por su
	 * nombre.
	 *
	 * @param nombre El nombre de la desarrolladora a eliminar.
	 *
	 * @return La consulta SQL para eliminar una desarrolladora de la base de
	 *         datos.
	 */
	public string? eliminar_dev (string nombre)
	{
		if (nombre == "") {
			return null;
		}
		string query = @"DELETE FROM desarrolladoras WHERE nombre = \"$nombre\";";
		return query;
	}

	/**
	 * Crea una consulta SQL para eliminar una publicadora de la base de
	 * datos.
	 *
	 * Crea un string que contiene una consulta SQL para eliminar una
	 * publicadora de la base de datos. La publicadora se busca por su
	 * nombre.
	 *
	 * @param nombre El nombre de la publicadora a eliminar.
	 *
	 * @return La consulta SQL para eliminar una publicadora de la base de
	 *         datos.
	 */
	public string? eliminar_pub (string nombre)
	{
		if (nombre == "") {
			return null;
		}
		string query = @"DELETE FROM publicadora WHERE nombre = \"$nombre\";";
		return query;
	}
	
	/**
	 * Crea una consulta SQL para eliminar una consola de la base de
	 * datos.
	 *
	 * Crea un string que contiene una consulta SQL para eliminar una
	 * consola de la base de datos. La consola se busca por su
	 * nombre.
	 *
	 * @param nombre El nombre de la consola a eliminar.
	 *
	 * @return La consulta SQL para eliminar una consola de la base de
	 *         datos.
	 */
	public string? eliminar_con (string nombre)
	{
		if (nombre == "") {
			return null;
		}
		string query = @"DELETE FROM consolas WHERE nombre = \"$nombre\";";
		return query;
	}

	/**
	 * Crea una consulta SQL para relacionar una desarrolladora y una consola.
	 *
	 * Crea un string que contiene una consulta SQL para relacionar una
	 * desarrolladora y una consola, la relación es "desarrolla para". La
	 * desarrolladora y la consola deben existir en la base de datos.
	 *
	 * @param desarrolladora El nombre de la desarrolladora.
	 *
	 * @param consola El nombre de la consola.
	 *
	 * @return La consulta SQL para relacionar una desarrolladora y una consola.
	 */
	public string? relaciona_dev (string desarrolladora, string consola)
	{
		if (desarrolladora == "" || consola == "") {
			return null;
		}
		string query = @"INSERT INTO dev_to (dev_n, con_n) VALUES (\"$desarrolladora\", \"$consola\");";
		return query;
	}

	/**
	 * Crea una consulta SQL para relacionar una publicadora y una consola.
	 *
	 * Crea un string que contiene una consulta SQL para relacionar una
	 * publicadora y una consola, la relación es "publica para". La
	 * publicadora y la consola deben existir en la base de datos.
	 *
	 * @param publicadora El nombre de la publicadora.
	 *
	 * @param consola El nombre de la consola.
	 *
	 * @return La consulta SQL para relacionar una publicadora y una consola.
	 */
	public string? relaciona_pub (string publicadora, string consola)
	{
		if (publicadora == "" || consola == "") {
			return null;
		}
		string query = @"INSERT INTO pub_to (pub_n, con_n) VALUES (\"$publicadora\", \"$consola\");";
		return query;
	}

	/**
	 * Crea una consulta SQL para relacionar un videojuego y una consola.
	 *
	 * Crea un string que contiene una consulta SQL para relacionar un
	 * videojuego y una consola, la relación es "disponible para". El
	 * videojuego y la consola deben existir en la base de datos.
	 *
	 * @param videojuego El nombre del videojuego.
	 *
	 * @param consola El nombre de la consola.
	 *
	 * @return La consulta SQL para relacionar un videojuego y una consola.
	 */
	public string? relaciona_vj (string videojuego, string consola)
	{
		if (videojuego == "" || consola == "") {
			return null;
		}
		string query = @"INSERT INTO dis_to (vj_n, con_n) VALUES (\"$videojuego\", \"$consola\");";
		return query;
	}

}