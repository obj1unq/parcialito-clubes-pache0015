import club.*
import actividades.*

class Socio {

	var property _antiguedad = 0
	var property club
	var property actividades = []

	method esEstrella() {
		return _antiguedad > 20
	}

}

class Jugador inherits Socio {

	var property _valorDePase = 0
	var property _partidosJugados = 0

	override method esEstrella() {
		return self.mayoriaDePartidos() or self.estrellaSegunClub()
	}

	method mayoriaDePartidos() {
		return _partidosJugados >= 50
	}

	method estrellaSegunClub() {
		var _perfilClub = self.club()._perfil()
		return if (_perfilClub == "profesional") {
			self.valorDePaseMayorAlRequerido()
		} else if (_perfilClub == "comunitario") {
			self.actividadesNecesarias()
		} else {
			self.actividadesNecesarias() or self.valorDePaseMayorAlRequerido()
		}
	}

	method valorDePaseMayorAlRequerido() {
		return _valorDePase > self.valorRequeridoParaSerEstrella()
	}

	method actividadesNecesarias() {
		return actividades > 3
	}

	method valorRequeridoParaSerEstrella() {
		return self.club()._valorRequeridoParaSerEstrella()
	}

}

