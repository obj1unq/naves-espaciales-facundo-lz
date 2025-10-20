class Nave{
	var velocidad = 0

	method velocidad(){
		return velocidad
	}

	method prepararseParaViajar(){
		self.aumentarVelocidadEn(15000)
	}

	method propulsar(){
		self.aumentarVelocidadEn(20000)
	}

	method aumentarVelocidadEn(velocidadAAumentar){
		velocidad = 300000.min(velocidad + velocidadAAumentar)
	}

	method recibirAmenaza(){}

	method encontrarEnemigo(){
		self.recibirAmenaza()
		self.propulsar()
	}
}

class NaveDeCarga inherits Nave{
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}
}

class NaveDeCargaRadioactiva inherits NaveDeCarga{
	var sellado

	method sellado(){
		return sellado
	}

	method sellar(){
		sellado = true
	}

	override method prepararseParaViajar(){
		sellado = true
		velocidad = 300000.min(velocidad + 15000)
	}

	override method recibirAmenaza(){
		velocidad = 0
	}
}

class NaveDePasajeros inherits Nave{
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}
}

class NaveDeCombate inherits Nave{
	var property modo = reposo
	const property mensajesEmitidos = []

	method velocidad(_velocidad){
		velocidad = _velocidad
	}

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method prepararseParaViajar(){
		super()
		modo.prepararseParaViajar(self)
	}
}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method prepararseParaViajar(nave){
		nave.emitirMensaje("Saliendo en misión")
	}
}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method prepararseParaViajar(nave){
		nave.emitirMensaje("Volviendo a la base")
	}
}