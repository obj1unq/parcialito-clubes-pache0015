import socios.*
import club.*

class Actividades {

	var property _club
	var property _sanciones

	method sancionarActividad(sancion) {
		_sanciones += sancion
	}

	method evaluacion()

}

class EquiposDeportivos inherits Actividades {

	var property _capitan
	var property _plantel = [ _capitan ]
	var property _campeonatosObtenidos = 0
	var _puntosParaEvaluacion = 0

	method cantidadDeSanciones() {
		return self._sanciones() + _club._sanciones()
	}

	override method evaluacion() {
		return _puntosParaEvaluacion += (5 * _campeonatosObtenidos) + self.puntosPorPlantel() + self.puntosPorCapitan() - self.puntosPorSancion()
	}

	method puntosPorPlantel() {
		return 2 * _plantel.size()
	}

	method puntosPorCapitan() {
		return if (_capitan.esEstrella()) {
			5
		} else {
			0
		}
	}

	method puntosPorSancion() {
		return 20 * self.cantidadDeSanciones()
	}

	method esExperimentado() {
		return _plantel.all({ jugador => jugador._partidosJugados() >= 10 })
	}

}

class EquipoDeFutbol inherits EquiposDeportivos {

	override method evaluacion() {
		return super() + self.puntosPorPlantelEstrella()
	}

	method puntosPorPlantelEstrella() {
		return (_plantel.count({ miembro => miembro.esEstrella() })) * 5
	}

	override method puntosPorSancion() {
		return 30 * self.cantidadDeSanciones()
	}

}

class ActividadesSociales inherits Actividades {

	var property _socioOrganizador
	var property _sociosParticipantes = []
	var _estado
	var property _valorParaEvaluacion

	override method sancionarActividad(sancion) {
		super(sancion)
		_estado = "suspendido"
	}

	method reanudarActividad() {
		_estado = "habilitado"
	}

	method actividadSupendidal() {
		return _estado == "suspendido"
	}

	override method evaluacion() {
		return if (_sanciones > 0) {
			0
		} else {
			_valorParaEvaluacion
		}
	}

}

