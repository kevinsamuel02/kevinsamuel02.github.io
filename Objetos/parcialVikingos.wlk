class Vikingo {
    var property casta
    var property armas
    var property oro

    method subirAExpedicion(unaExpedicion) {
        if(self.puedeSubirAExpedicion()){
            unaExpedicion.sumarVikingo(self)
        } else {
            self.error("TIAGO ES PUTITI")
        }
    }

    method puedeSubirAExpedicion() {
       return self.esProductivo() and casta.puedeSubirAExpedicion(self)
    }

    method tieneArmas() = armas > 0
    method esProductivo() {}

    method ascenderSocialmente(casta) = casta.ascenderDeCasta(self)

    method modificarCasta(unaCasta) {
        casta = unaCasta
    }

    method modificarBotin(cantidad) {
        oro += cantidad
    }
}

class Soldado inherits Vikingo {
    var property vidasCobradas = 0
    override method esProductivo() =  vidasCobradas > 20 and self.tieneArmas()
    override method ascenderSocialmente(casta) {
        super(casta) and self.gana10Armas()
    }
    method gana10Armas() {
        armas += 10
    }
}

class Granjero inherits Vikingo {
    var property cantidadHijos 
    var property hectareasParaAlimentar

    override method esProductivo() = hectareasParaAlimentar >= cantidadHijos * 2
    
    override method ascenderSocialmente(casta) {
        super(casta) and gana2Hijos() and gana2Hectareas()
    }    
    method gana2Hijos() {
        cantidadHijos += 2
    }

    method gana2Hectareas() {
        hectareasParaAlimentar += 2
    }
   
}
-------------------------------------------

class CastaSocial {
    method puedeSubirAExpedicion(vikingo) = true
    method ascenderDeCasta(unVikingo) 
}

class Esclavo inherits CastaSocial {
    override method puedeSubirAExpedicion(vikingo) = not vikingo.tieneArmas()
    override method ascenderDeCasta(unVikingo) {
        unVikingo.modificarCasta(CastaMedia)
    }
}

class CastaMedia inherits CastaSocial {
    override method ascenderDeCasta(unVikingo) {
        unVikingo.modificarCasta(Nobles)
    }
}

class Nobles inherits CastaSocial {
    
}
-------------------------------------------
class Expedicion {
    var property vikingos = []
    var property lugares = []

    method valeLaPena() {
        lugares.all({ lugar => lugar.valeLaPenaLugar(self) })
    }

    method cantidadVikingosEnExpedicion() = vikingos.size()

    method sumarVikingo(unVikingo) {
        vikingos.add(unVikingo)
    }

    method completarInvasion() {
        if(self.valeLaPena()){
        lugares.forEach({lugar => lugar.seInvade(self) })
        var total = lugares.sum({lugar => lugar.botin()})
        var porcion = total / self.cantidadVikingosEnExpedicion()
        vikingos.forEach({vikingo => vikingo.modificarBotin(porcion)})
        }else {
            self.error("Tanque cala TODAS las balubis, si pici y ni il quisi")
        }
    }
}

class Objetivo {
    var property defensoresDerrotados = 0

    method valeLaPenaLugar(unaExpedicion)

    method botin() 

    method seInvade(unaExpedicion)
}
class Aldea inherits Objetivo {
    var property cantidadCrucifijos
    
    override method valeLaPenaLugar(unaExpedicion) {
        return self.botin() >= 15
    }
    override method botin() = cantidadCrucifijos
}

class AldeaAmurallada inherits Aldea {
    var property cantidadMinimaVikingos
    override method valeLaPenaLugar(unaExpedicion) = 
        super(unaExpedicion) and unaExpedicion.cantidadVikingosEnExpedicion() >= cantidadMinimaVikingos
}

class Capital inherits Objetivo {
    var property factorRiqueza 
    
    override method seInvade(unaExpedicion) {
        defensoresDerrotados = unaExpedicion.cantidadVikingosEnExpedicion()
    }

    override method valeLaPenaLugar(unaExpedicion) = 
        self.botin() >= unaExpedicion.cantidadVikingosEnExpedicion() * 3

    method botin() = defensoresDerrotados * factorRiqueza 


}