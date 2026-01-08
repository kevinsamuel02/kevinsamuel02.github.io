class Jugador {
    var property color
    var property mochila = []
    var property nivelDeSospecha = 40
    var property tareasARealizar = []
    const property nave
    var property estaVivo = true
    var property personalidad
    var property votosEnContra = 0


    method usarItemMochila(item) {
        self.usarItem(item)
        self.removerItem(item)
    }

    method removerItem(item) {
        mochila.remove(item)
    }

    method esSospechoso() {
        self.nivelDeSospecha > 50
    }

    method buscarItem(item) {
        mochila.add(item)
    }

    method realizarUnaTarea(unaTarea)

    method realizoTodasLasTareas() = tareasARealizar.isEmpty()
    
    method tieneEnMochila(unElemento) = mochila.contains(unElemento)

    method aumentarSospecha(unaCantidad) {
        nivelDeSospecha += unaCantidad
    }

    method disminuirSospecha(unaCantidad) {
        nivelDeSospecha -= unaCantidad
    }

    method puedeRealizar(unaTarea) {
        tareasARealizar.contains(unaTarea)
    }

    method llamarReunionDeEmergencia() {
        nave.iniciarVotacion()
    }

    method irAVotar() {
        personalidad.irAVotarSegunPersonalidad(self, nave)
    }

    method sumarVotoEnContra() {
        votosEnContra += 1
    }

    method reestablecerVotosEnContra() {
        votosEnContra = 0
    }
    method eliminaUno()

}

class Impostor inherits Jugador {
    var property sabotajes = []
    override method realizoTodasLasTareas() = true

    override method irAVotar() {
        var jugadorElegido = nave.jugadores().anyOne()
        jugadorElegido.sumarVotoEnContra()
    }
    override method eliminaUno() {
        nave.descontarImpostor()
    }
    override method realizarUnaTarea(unaTarea) {}

}


class Tripulante inherits Jugador {
    override method realizarUnaTarea(unaTarea){
        if(self.puedeRealizar(unaTarea)){
            unaTarea.completarTarea(self)
            tareasARealizar.remove(unaTarea)
            self.informaANave()
        }
        
    }
    override method eliminaUno() {
        nave.descontarTripulante()
    }
}

-------------------------------------
object nave {
    var property jugadores = []
    var property tripulantesEnNave 
    var property impostoresEnNave 
    var property nivelDeOxigeno 
    var property votosEnBlanco = 0

    method informaANave(){
        if (jugadores.all({ jugador => jugador.realizoTodasLasTareas() })){
            throw new GanaronTripulantesException(message = "GANARON LOS TRIPULANTES")
        } 
    }

    method aumentarNivelDeOxigeno(unaCantidad){
        nivelDeOxigeno += unaCantidad
    }
    method disminuirOxigeno(unaCantidad){
        nivelDeOxigeno -= unaCantidad
        if(nivelDeOxigeno <= 0){
            throw new GanaronImpostoresException(message = "GANARON LOS IMPOSTORES")
        }
    }

    method algunoTieneEnMochila(unElemento) = jugadores.any({jugador => jugador.tieneEnMochila(unElemento)})
    
    method iniciarVotacion() {
        var jugadoresVivos = jugadores.filter({jugador => jugador.estaVivo()})
        jugadoresVivos.forEach({ jugador => jugador.irAVotar() })
    }

    method jugadoresNoSospechosos(){
        return jugadores.filter({jugador => not jugador.esSospechoso()})
    }

    method sumarVotoEnBlanco() {
        votosEnBlanco += 1
    }

    method reestablecerVotosEnBlanco() {
        votosEnBlanco = 0
    }

    method jugadoresSinNada() {
        return jugadores.filter({jugador => jugador.mochila().isEmpty()})
    }

    method decidirVotacion() {
        var jugadorMasVotado = jugadores.max({jugador => jugador.votosEnContra()})
        if(jugadorMasVotado.votosEnContra() > votosEnBlanco) {
            self.expulsarJugador(jugadorMasVotado)
        } 
        self.finalizarVotacion()
    }

    method finalizarVotacion() {
        reestablecerVotosEnBlanco()
        jugadores.forEach({jugador => jugador.reestablecerVotosEnContra()})
        if(tripulantesEnNave == impostoresEnNave) {
            throw new GanaronImpostoresException(message = "GANARON LOS IMPOSTORES")
        } else if(impostoresEnNave == 0) {
            throw new GanaronTripulantesException(message = "GANARON LOS TRIPULANTES")
        }
    }

    method expulsarJugador(unJugador) {
        unJugador.eliminaUno()
    }

    method descontarImpostor() {
        impostoresEnNave -= 1
    }
    method descontarTripulante() {
        tripulantesEnNave -= 1
    }
}

-----------------------------------------
    class Tarea {
        method completarTarea(unTripulante)
    }

object arreglarTableroElectrico inherits Tarea {
    override method completarTarea(unTripulante) {
        if (unTripulante.tieneEnMochila("llaveInglesa")) {
             unTripulante.aumentarSospecha(10)
        } else {
            self.error("No puede completar la mision porque le falta la llave inglesa")
        }
    }
}

object sacarLaBasura inherits Tarea {
    override method completarTarea(unTripulante){
        if(unTripulante.tieneEnMochila("escoba") and unTripulante.tieneEnMochila("bolsa de consorcio")) {
            unTripulante.disminuirSospecha(4)
        } else {
            self.error("No puede completar la mision porque le falta la llave inglesa")
        }
    }
}

object ventilarLaNave inherits Tarea {
    override method completarTarea(unTripulante) {
        unTripulante.nave()aumentarNivelDeOxigeno(5)
    }
}

------------------------------------------------------------
class Sabotaje {
    method sabotajeRealizado(unImpostor, unaNave) {
        unImpostor.aumentarSospecha(5)
    }
}

object reducirElOxigeno inherits Sabotaje {
    override method sabotajeRealizado(unImpostor, unaNave) {
        super(unImpostor)
        if(not unaNave.algunoTieneEnMochila("tubo de oxigeno")) {
            unaNave.disminuirOxigeno(10)
        } 
    }
}

object impugnarAUnJugador inherits Sabotaje {
    override method sabotajeRealizado(unImpostor, unaNave) {

    }
}

--------------------------------------------------------
class Personalidad {
    var property jugadorElegido
    method irAVotarSegunPersonalidad(unJugador, unaNave)
    method irAVotar()
}

object troll inherits Personalidad {
    override method irAVotarSegunPersonalidad(unJugador, unaNave) {
        
        var jugadoresNoSospe = unaNave.jugadoresNoSospechosos()
        if(not jugadoresNoSospe.isEmpty()) {
            jugadorElegido = jugadoresNoSospe.anyOne()
            jugadorElegido.sumarVotoEnContra()
        } else {
            unaNave.sumarVotoEnBlanco()
        }
        
    } 

}

object detective inherits Personalidad {
     override method irAVotarSegunPersonalidad(unJugador, unaNave) {
        
            jugadorElegido = unaNave.jugadores().max({jugador => jugador.nivelDeSospecha() })
            jugadorElegido.sumarVotoEnContra()   
    } 

}

object materialista inherits Personalidad {
    override method irAVotarSegunPersonalidad(unJugador, unaNave) {
        
        var jugadoresSinNada = unaNave.jugadoresSinNada()
        if(not jugadoresSinNada.isEmpty()) {
            jugadorElegido = jugadoresSinNada.anyOne()
            jugadorElegido.sumarVotoEnContra()
        } else {
            unaNave.sumarVotoEnBlanco()
        }
        
    } 
}

class GanaronTripulantesException inherits Exception {}
class GanaronImpostoresException inherits Exception {}
