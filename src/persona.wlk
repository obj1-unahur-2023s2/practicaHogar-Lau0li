import habitaciones.*
class Persona {
	var edad
	var dormitorio
	var habilidosoEnLaCocina = false
	var habitacionActual = null
	var property familia = null
	
	method confort() = if(habitacionActual != null){habitacionActual.confortQueOtorga()}else{0}
	method edad() = edad
	method habilidosoEnLaCocina() = habilidosoEnLaCocina
	method cambiarDormitorio(unDormitorio){
		dormitorio = unDormitorio
	}
	method aprenderACocinar(){
		habilidosoEnLaCocina = true
	}
	
	method entrarAUnaHabitacion(habitacion){
		if (habitacion.puedeEntrar(self)){
		if(habitacionActual != null){
			habitacionActual.PersonasAdentroActualmente().remove(self)
		}
		habitacionActual = habitacion
		habitacion.PersonasAdentroActualmente().add(self)
		}}
	method aGusto() = true
}

class Obsesivo inherits Persona{
	override method aGusto() = familia.casa().habitaciones().all({n => n.puedeEntrar(self)}) and familia.casa().habitaciones().all({n => n.personasAdentroActualmente() < 3})

}

class Goloso inherits Persona{
	override method aGusto() = familia.casa().habitaciones().all({n => n.puedeEntrar(self)}) and familia.integrantes().any({n => n.habilidosoEnLaCocina()})
}
class Sencillos inherits Persona{
	override method aGusto() = familia.casa().habitaciones().all({n => n.puedeEntrar(self)}) and familia.integrantes().size() > familia.casa().habitaciones()
}

class Familia{
	var integrantes = []
	var casa
	
	method casa() = casa
	method agregarIntegrantes(lista){
		integrantes.addAll(lista)
		lista.forEach({n => n.familia(self)})
	}
}
