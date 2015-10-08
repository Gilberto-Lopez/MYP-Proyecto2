namespace M.Tablas {

	/**
	 * Tabla Videojuegos.
	 *
	 * Contiene los campos de la tabla 'videojuegos' de la base de datos. Cada
	 * columna tiene un tipo de dato en la base de datos.
	 *
	 * || "columna" || "tipo" ||
	 * || nombre || TEXT ||
	 * || motor || TEXT ||
	 * || dev (desarrolladora) || TEXT ||
	 * || pub (publicadora) || TEXT ||
	 */
	public enum Videojuegos {
		NOMBRE,
		MOTOR,
		DESARROLLADORA,
		PUBLICADORA
	}

	/**
	 * Tabla Desarrolladoras.
	 *
	 * Contiene los campos de la tabla 'desarrolladoras' de la base de datos.
	 * Cada columna tiene un tipo de dato en la base de datos.
	 *
	 * || "columna" || "tipo" ||
	 * || nombre || TEXT ||
	 * || sede || TEXT ||
	 * || activo || INTEGER  ||
	 * || fundacion || TEXT ||
	 */
	public enum Desarrolladoras{
		NOMBRE,
		SEDE,
		ACTIVO,
		FUNDACION
	}

	/**
	 * Tabla Publicadoras.
	 *
	 * Contiene los campos de la tabla 'publicadoras' de la base de datos. Cada
	 * columna tiene un tipo de dato en la base de datos.
	 *
	 * || "columna" || "tipo" ||
	 * || nombre || TEXT ||
	 * || sede || TEXT ||
	 * || activo || INTEGER ||
	 * || fundacion || TEXT ||
	 */
	public enum Publicadoras {
		NOMBRE,
		SEDE,
		ACTIVO,
		FUNDACION
	}

	/**
	 * Tabla Consolas.
	 *
	 * Contiene los campos de la tabla 'consolas' de la base de datos. Cada
	 * columna tiene un tipo de dato en la base de datos.
	 *
	 * || "columna" || "tipo" ||
	 * || nombre || TEXT ||
	 * || fabricante || TEXT ||
	 * || gen (generación) || INTEGER ||
	 * || cpu || TEXT ||
	 * || lanzamiento || TEXT ||
	 */
	public enum Consolas {
		NOMBRE,
		FABRICANTE,
		GENERACION,
		CPU,
		LANZAMIENTO
	}
		   
}
