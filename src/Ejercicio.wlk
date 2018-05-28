object municipio{
	var _clubes = []
	
	method evaluarClub(){
		
	}
}

class Club{
	var _equiposDeportes = []
	var _actividades = []
	var property perfil =
	
	method evaluacion()
}

class Actividades{
	var property sanciones
	
	method evaluacion()
	
}

class EquiposDeportivos inherits Actividades{
	var property _plantel = []
	var property _capitan 
	
}

	class Jugador inherits Socio{
		var property _valorDePase  
		var property _partidosJugados 
	}

class ActividadesSociales inherits Actividades{
	var property _socioOrganizador
	var property _sociosParticipantes = []	
}

	class Socio{
		var property _antiguedad = 0
		var property club 
	}