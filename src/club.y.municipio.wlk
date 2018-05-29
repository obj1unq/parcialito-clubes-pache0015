import actividades.*
import socios.*

// =============== MUNICIPIO =============
object municipio {

	var _clubes = []

	method evaluarClub() {
	}

	method transferirJugador(jugador, equipoOrigen, equipoDestino) {
		equipoOrigen.extraerJugador(jugador, equipoDestino)
		equipoDestino.sumarJugador(jugador)
	} // =================INCOMPLETO=====================

}

// ================ CLUB =====================
class Club {

	var _actividadesSociales = []
	var _actividadesDeportivas = []
	var property _valorRequeridoParaSerEstrella = 0
	var property _sanciones = 0
	var property _socios = []
	var property _gasto = 0

	method evaluacion() {
		return self.evaluacionBruta() / _socios
	}

	method sancionarClub(sancion) {
		if (_socios.size() >= 500) {
			_sanciones += sancion
		}
	}

	method evaluacionBruta() {
		return self.sumaDeEvaluacionDeActividades()
	}

	method sumaDeEvaluacionDeActividades() {
		return (_actividadesSociales.sum({ actividad => actividad.evaluacion() })) + (_actividadesDeportivas.sum({ actividad => actividad.evaluacion() }))
	}

	method sociosDestacados() {
		var _sociosDestacados = []
		_sociosDestacados.addAll(self.sociosCapitanes(_actividadesDeportivas))
		_sociosDestacados.addAll(self.sociosOrganizadores(_actividadesSociales))
		return _sociosDestacados
	}

	method sociosCapitanes(_actDeportivas) {
		return _actDeportivas.map({ _actividad => _actividad._capitan() })
	}

	method sociosOrganizadores(_actSociales) {
		return _actSociales.map({ _actividad => _actividad._socioOrganizador() })
	}

	method sociosDestacadosEstrella() {
		return (self.sociosDestacados().filter({ socio => socio.esEstrella() }))
	}

	method esPrestigioso() {
		return (self.tieneEquipoExperimentado(_actividadesDeportivas)) or (self.participantesEstrellaEnActividades(_actividadesSociales))
	}

	method tieneEquipoExperimentado(_actividades) {
		return _actividades.any({ _actividad => _actividad.esExperimentado() })
	}

	method participantesEstrellaEnActividades(_actividades) {
		return self.sociosParticipantesEstrella(_actividades) >= 5
	}

	method sociosParticipantesEstrella(_actividad) {
		return _actividad._sociosParticipantes().count({ _socio => _socio.esEstrella() })
	}

	method extraerJugador(jugador, equipoDestino) {
		if (_socios.contains(jugador) and !self.sociosDestacados().contains(jugador) and self != equipoDestino) {
			self.removerDeTodo(jugador)
		} else {
			self.error("No se puede transferir este jugador")
		}
	}

	method removerDeTodo(jugador) {
		_socios.remove(jugador)
		self.listaDeActDeportivasSegunJugador(jugador).foreach({ _actividad => _actividad._plantel().remove(jugador)})
		self.listaDeActSocialesSegunJugador(jugador).foreach({ _actividad => _actividad._sociosPArticipantes().remove(jugador)})
	}

	method listaDeActDeportivasSegunJugador(jugador) {
		return _actividadesDeportivas.filter({ _actividad => _actividad._plantel().contains(jugador) })
	}
	method listaDeActSocialesSegunJugador(jugador) {
		return _actividadesSociales.filter({ _actividad => _actividad._sociosParticipantes().contains(jugador) })
	}

	method sumarJugador(jugador) {
		jugador._partidosJugados(0)
		_socios.add(jugador)
	}

}

// ========== TIPOS DE CLUB =============
class Tradicional inherits Club {

	var _perfil = "tradicional"

	override method evaluacionBruta() { 		return super() - _gasto
	}

}

class Comunitario inherits Club {

	var _perfil = "comunitario"

// method evaluacionBruta() es igual que en super clase 
}

class Profesional inherits Club {

	var _perfil = "profesional"

	override method evaluacionBruta() {
		return super() - (5 * _gasto)
	}

}

