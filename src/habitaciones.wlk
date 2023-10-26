import persona.*

class Casa{
	var habitaciones = []
	var familiaDuenia
	
	method agregarHabitaciones(lista){
		habitaciones.addAll(lista)
	}
	method cambiarFamilia(family){
		familiaDuenia.remove(familiaDuenia.get(0))
		familiaDuenia.addAll(family)
	}
	method habitacionesOcupadas() = habitaciones.filter({n => n.personasAdentroActualmente().size() > 0})
	method responsables() = self.habitacionesOcupadas().map({n => n.habitanteMasViejoDeLaHabitacion()})
	method familiaAgusto() = familiaDuenia.map({n => n.confort()}).max()/familiaDuenia.integrantes().size() > 40
}

class HabitacionGeneral {
	var personasAdentroActualmente = []
	const property metrosCuadrados
	
	method habitanteMasViejoDeLaHabitacion() = personasAdentroActualmente.map({n => n.edad()}).max()
	method confortQueOtorga(persona) = 10
	method personasAdentroActualmente() = personasAdentroActualmente
	
	method puedeEntrar(persona) = true

}

class Banio inherits HabitacionGeneral {
	
	override method confortQueOtorga(persona) = super(persona) + if (persona.edad() > 4 ) {4} else {2}
	override method puedeEntrar(persona) = super(persona) and if (personasAdentroActualmente.size() > 1) {persona.edad() < 5} else {true}
}

class Dormitorio inherits HabitacionGeneral {
	var duenios = []

	method agregarDuenios(listaDuenios){
		duenios.addAll(listaDuenios)
		listaDuenios.forEach({n => n.cambiarDormitorio(self)})
	}
	
	override method confortQueOtorga(persona) = super(persona) + if(duenios.contains(persona)) {10/duenios.size()} else{0}
	override method puedeEntrar(persona) = duenios.contains(persona) or duenios.all({n => personasAdentroActualmente.contains(n) })
}
class Cocina inherits HabitacionGeneral{
	override method confortQueOtorga(persona) = super(persona) + if(persona.habilidosoEnLaCocina()){metrosCuadrados * porcentajeConfort.valor()} else {0}
	override method puedeEntrar(persona) = super(persona) and if (persona.habilidosoEnLaCocina()){not personasAdentroActualmente.filter({n => n.habilidosoEnLaCocina()}.size() > 0 )} else {true}
}

object porcentajeConfort{
	var valor = 0.10
	
	method valor() = valor
	method cambiarPorcentaje(porcentaje){
		valor = porcentaje
	}
}