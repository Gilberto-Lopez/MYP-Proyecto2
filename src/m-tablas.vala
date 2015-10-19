namespace M.Tablas {

	/**
	 * Tabla Videojuegos.
	 *
	 * Contiene los campos de la tabla 'videojuegos' de la base de datos. Cada
	 * columna tiene un tipo de dato en la base de datos.
	 *
	 * || "Columna" || "Tipo" ||
	 * || nombre || TEXT ||
	 * || motor || TEXT ||
	 * || dev (desarrolladora) || TEXT ||
	 * || pub (publicadora) || TEXT ||
	 */
	public enum Videojuegos {
		/**
		 * El nombre del videojuego, único y no nulo.
		 */
		NOMBRE,
		/**
		 * EL motor del videojuego.
		 */		
		MOTOR,
		/**
		 * El nombre de la desarolladora del videojuego, que debe existir de
		 * ante mano.
		 */
		DESARROLLADORA,
		/**
		 * El nombre de la publicadora del videojuego, que debe existir de
		 * ante mano.
		 */		
		PUBLICADORA
	}

	/**
	 * Tabla Desarrolladoras.
	 *
	 * Contiene los campos de la tabla 'desarrolladoras' de la base de datos.
	 * Cada columna tiene un tipo de dato en la base de datos.
	 *
	 * || "Columna" || "Tipo" ||
	 * || nombre || TEXT ||
	 * || sede || TEXT ||
	 * || activo || INTEGER  ||
	 * || fundacion || DATE ||
	 */
	public enum Desarrolladoras{
		/**
		 * El nombre de la desarrolladora, único y no nulo.
		 */
		NOMBRE,
		/**
		 * La sede actual de la desarrolladora.
		 */
		SEDE,
		/**
		 * 0 si la desarrolladora no sigue actualmente activa, 1 en caso
		 * contrario.
		 */
		ACTIVO,
		/**
		 * La fecha de fundación de la desarrolladora, en formato YYYY-MM-DD.
		 */
		FUNDACION
	}

	/**
	 * Tabla Publicadoras.
	 *
	 * Contiene los campos de la tabla 'publicadoras' de la base de datos. Cada
	 * columna tiene un tipo de dato en la base de datos.
	 *
	 * || "Columna" || "Tipo" ||
	 * || nombre || TEXT ||
	 * || sede || TEXT ||
	 * || activo || INTEGER ||
	 * || fundacion || DATE ||
	 */
	public enum Publicadoras {
		/**
		 * El nombre de la publicadora, único y no nulo.
		 */
		NOMBRE,
		/**
		 * La sede actual de la publicadora.
		 */
		SEDE,
		/**
		 * 0 si la publicadora sigue actualmente activa, 1 en caso contrario.
		 */
		ACTIVO,
		/**
		 * La fecha de fundación de la publicadora, en formato YYYY-MM-DD.
		 */
		FUNDACION
	}

	/**
	 * Tabla Consolas.
	 *
	 * Contiene los campos de la tabla 'consolas' de la base de datos. Cada
	 * columna tiene un tipo de dato en la base de datos.
	 *
	 * || "Columna" || "Tipo" ||
	 * || nombre || TEXT ||
	 * || fabricante || TEXT ||
	 * || gen (generación) || INTEGER ||
	 * || cpu || TEXT ||
	 * || lanzamiento || TEXT ||
	 */
	public enum Consolas {
		/**
		 * El nombre de la consola, único y no nulo.
		 */
		NOMBRE,
		/**
		 * El nombre del fabricande de la consola.
		 */
		FABRICANTE,
		/**
		 * La generación de la consola, mayor a 0, o 0 si se desconoce.
		 */
		GENERACION,
		/**
		 * El CPU de la consola.
		 */
		CPU,
		/**
		 * La fecha de lanzamiento de la consola, e formato YYYY-MM-DD.
		 */
		LANZAMIENTO
	}
		   
}
