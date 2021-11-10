import planta.*

class Parcela {
    var property ancho
    var property largo
    var property horasSolPorDia
    const property plantas = #{}

    method superficie() {return ancho * largo}

    method cantidadMaximaDePlantas() {
        if (ancho > largo) {
            return self.superficie() / 5
        } else {
            return self.superficie() / 3 + largo
        }
    }

    method tieneComplicaciones() {return plantas.any({p => p.horasQueTolera() < horasSolPorDia})}

    method tienePermisoParaPlantar(planta) {return plantas.size() + 1 <= self.cantidadMaximaDePlantas() or (horasSolPorDia - planta.horasQueTolera() < 2)}

    method plantarPlanta(planta) {
        if (self.tienePermisoParaPlantar(planta)) {
            plantas.add(planta)
        }
        else {
            self.error("Esta planta no se puede plantar.")
        }
    }
    method asociaBien(planta) {return false}
    method porcentajeBienAsociadas() {return (plantas.count({p=>self.asociaBien(p)})/plantas.size())*100}
}

class Ecologica inherits Parcela {

    override method asociaBien(planta) {return not self.tieneComplicaciones() and planta.esIdeal(self)}

}

class Industrial inherits Parcela {

    override method asociaBien(planta) {return self.plantas().size() <= 2 and planta.esFuerte()}

}

object inta {
    const property parcelas = #{}

	method plantasPorParcela() {return self.parcelas().sum({pl => pl.plantas().size() })}
	method cantidadDeParcelas() {return self.parcelas().size()}
    method promedioDePlantas() {return self.plantasPorParcela()/ self.cantidadDeParcelas()}
    method masAutosustentable() {return self.parcelas().filter({p=>p.plantas().size()>4}).max({pl=>pl.porcentajeDeBienAsociadas()})}
    method setearParcela(parcela){parcelas.add(parcela)}
    
  
}
