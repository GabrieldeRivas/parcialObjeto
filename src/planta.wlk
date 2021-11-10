import parcela.*

class Planta {
	const property anioObtencion = 0
	var property altura = 0
	
	method horasQueTolera()
	method esFuerte() {return self.horasQueTolera() > 10}	
	method daNuevasSemillas() {return self.esFuerte()}
	method espacioOcupado()
	method esIdeal(parcela)
}

class Menta inherits Planta {

    override method horasQueTolera() {return 6}

    override method daNuevasSemillas() {return altura > 0.4 or super()}

    override method espacioOcupado() {return altura * 3}

    override method esIdeal(parcela) {return parcela.superficie() > 6}

}

class Soja inherits Planta {

    override method horasQueTolera() {
        if (altura < 0.5) {return 6} 
        else if (altura.between(0.5, 1)) {return 7} 
        else {return 9}
    }

    override method daNuevasSemillas() {return (anioObtencion > 2007 and altura > 1) or super()}

    override method espacioOcupado() {return altura / 2}

    override method esIdeal(parcela) {return self.horasQueTolera() == parcela.horasDeSolPorDia()}

}

class Quinoa inherits Planta {

    var property horasQueTolera

    override method espacioOcupado() {return 0.5}

    override method daNuevasSemillas() {return (anioObtencion < 2005) or super()}

    override method esIdeal(parcela) {return not parcela.plantas().any({p => p.altura() > 1.5})}

}

class SojaTransgenica inherits Soja {

    override method daNuevasSemillas() {return false}

    override method esIdeal(parcela) {return parcela.cantidadMaximaDePlantas() == 1}

}

class Hierbabuena inherits Menta {

    override method espacioOcupado() {return 2 * super()}

}


