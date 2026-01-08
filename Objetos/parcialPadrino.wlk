abstract class Arma {
    abstract method usarContra(unaPersona)
}

class Revolver inherits Arma {
    var property balas

    override method usarContra(unaPersona){
        if(balas > 0){
            unaPersona.morir()
            balas -= 1
        } 
    }

}

class Escopeta inherits Arma {

    override method usarContra(unaPersona){
        if(unaPersona.herida){
            unaPersona.morir()
        } else {
            unaPersona.herida(true)
        }
    }

}

class CuerdaDePiano inherits Arma {
    var property esDeBuenaCalidad


    override method usarContra(unaPersona){
        if(esDeBuenaCalidad) {
            unaPersona.morir()
        }
    }

}

class Mafioso {
    var property herida = false
    var property vivo = true

    method morir() {
        vivo = false
    }
}

class Don inherits Miembro {
        method darOrden(){

        }
}

