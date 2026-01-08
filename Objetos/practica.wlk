class Ave{
    var property energia = 100

    method comer (gramos) {
        energia += gramos * 2
    }

    method volar (km) {
        energia -= km
    }
}


class Golondrina inherits Ave {}


class Aguila inherits Ave {
    override method comer (gramos) {
        energia += gramos * 4
    }
}

class Colibri inherits Ave {
    override method volar (km) {
        super(km)
        energia -= 2
    }
}




-------------------------------------------------
//PARCIAL 2024 _________________________--------------------------
object baseEnemiga {
    var property puntosDeVida = 1000

    method recibirDano(cantidad) {
        puntosDeVida -= cantidad
    }


}

class Combatienete {

    method atacar(unTerreno, unaBase) {}
}


class Soldado inherits Combatiente {
    var property fuerza = 10 
    override method atacar(unTerreno, unaBase) {
        unTerreno.recibirAtaqueDeSoldado(self, unaBase)
    }
}

class Tanque inherits Combatiente {
    var property fuerza = 50 
    override method atacar(unTerreno, unaBase) {
        unTerreno.recibirAtaqueDeTanque(self, unaBase)
    }
}


class Terreno {
    method recibirAtaqueDeSoldado(unSoldado, unaBase) {}

    method recibirAtaqueDeTanque(unTanque, unaBase) {}
}

class TerrenoPlano inherits Terreno {
    override method recibirAtaqueDeSoldado(unSoldado, unaBase) {
        unaBase.recibirDano(unSoldado.fuerza())
    }

    override method recibirAtaqueDeTanque(unTanque, unaBase) {
        unaBase.recibirDano(unTanque.fuerza())
    }       

}

class Bosque inherits Terreno {
    override method recibirAtaqueDeSoldado(unSoldado, unaBase) {
        unaBase.recibirDano(unSoldado.fuerza() / 2)
    }

    override method recibirAtaqueDeTanque(unTanque, unaBase) {
        unaBase.recibirDano(0)
    }
}

object batalla {
    const laBaseEnemiga = baseEnemiga
    const terrenoDeJuego = new Bosque ()
    const ejercito = [new Soldado(), new Tanque(), new Soldado()]

    method simular() {
        ejercito.forEach({combatiente => combatiente.atacar(terrenoDeJuego, laBaseEnemiga)})
    }
}





//------------------------------------------------- PARCIAL GEMINI ------------------------------------------------------
class Ingrediente {
    var property puntos = 10
}