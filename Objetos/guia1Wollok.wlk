//EJERCICIO 1
object pepita {
    var energia = 100
    var lugar = "Bombonera"

    method volar(kilometros) {
        energia -= kilometros + 10
    }

    method comer(gramos) {
        energia += 4 * gramos
    }

    method energiaActual() {
        return energia
    }
}



//EJERCICIO 3
// ---------------- CATEGORÍAS ----------------

object gerente {
    method neto() {
        return 1000
    }
}

object cadete {
    method neto() {
        return 1500
    }
}


// ---------------- BONO POR PRESENTISMO ----------------

// Caso 1: 100 si no faltó nunca, 50 si faltó un día, 0 en otro caso
object presentismoFlexible {
    var property diasFaltados = 0

   

    method bono() {
        if (diasFaltados == 0) return 100
        if (diasFaltados == 1) return 50
        return 0
    }
}

// Caso 2: Sin bono
object sinPresentismo {
    method bono() {
        return 0
    }
}


// ---------------- BONO POR RESULTADOS ----------------

object bono10Porciento {
    method bonoSobre(neto) {
        return neto * 0.1
    }
}

object bono80Fijo {
    method bonoSobre(neto) {
        return 80
    }
}

object sinBonoResultados {
    method bonoSobre(neto) {
        return 0
    }
}


// ---------------- PERSONA (PEPE) ----------------

object pepe {
    var property categoria = gerente
    var property bonoPresentismo = presentismoFlexible
    var property bonoResultados = bono10Porciento

    method sueldo() {
        var neto = categoria.neto()
        var bonoPres = bonoPresentismo.bono()
        var bonoRes = bonoResultados.bonoSobre(neto)

        return neto + bonoPres + bonoRes
    }
}
