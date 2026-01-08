class Contenido {
    const property titulo
    var property vistas = 0
    var property contenidoOfensivo = false
    var property tags = []
    var property monetizacion
    const plataforma   

    method esPopular()
    method maximaCotizacionPublicidad()
    method totalRecaudado() {
        return monetizacion.cotizar(self)
    }

    method cambiarMonetizacion(nuevaMonetizacion) {
        if(nuevaMonetizacion.puedeMonetizarse(self)) {
            monetizacion.resetear()
            monetizacion = nuevaMonetizacion
        } else {
            self.error("No se puede monetizar de esta manera")
        }
    }
    method esVideo() {
        return false
    }

}


class Videos inherits Contenido {
    override method esPopular() = vistas() > 10000
    override method maximaCotizacionPublicidad(){
        return 10000
    }
    override method esVideo() {
        return true
    }
}

class Imagenes inherits Contenido {
    override method esPopular() {
       plataforma.tagsDeModa().all ({tag => tags.contains(tag)})   
    }
    override method maximaCotizacionPublicidad() {
        return 4000
    }
}


---------------------------------------------

class Usuario {
    const property nombre
    const property email
    
    var property estaVerificado = false

    const property contenidos = []

    method saldoTotal() {
        return contenidos.sum({ contenido => contenido.totalRecaudado() })
    }

    method esSuperUsuario() {
        return contenidos.count({ contenido => contenido.esPopular() }) >= 10
    }
    method publicarContenido(unContenido, unaMonetizacion) {
        unContenido.cambiarMonetizacion(unaMonetizacion)
        contenidos.add(unContenido)
    }
}

---------------------------------------------------------------------

class Plataforma {
    var property usuarios = []

    const tagsDeModa = ["mkmsdkfsmsk","kfmdskdsmdk"]

    method usuariosVerificados() {
        return usuarios.filter({ usuario => usuario.estaVerificado() })
    }

    method email100UsuariosVerificadosConMayorSaldo() {
        const top100 = self.usuariosVerificados().sortedBy({ usu => usu.saldoTotal() }).take(100)
        return top100.map({ u => u.email() })
    }

    method cantidadSuperUsuario() {
        return usuarios.count({ usua => usua.esSuperUsuario() })
    }
}
-----------------------------------------------
class Monetizacion {
    method cotizar(unContenido)
    method puedeMonetizarse(unContenido) = true
    method resetear()
}

class Pubilicidad inherits Monetizacion {
    override method cotizar(unContenido) {
        var cotizacion = unContenido.vistas() * 0.05
        if(unContenido.esPopular()) {
            cotizacion += 2000
        }
        return cotizacion.min(unContenido.maximaCotizacionPublicidad())
    }
    override method puedeMonetizarse(unContenido) {
        return not unContenido.contenidoOfensivo()
    }
}

class Donaciones inherits Monetizacion {
    var property recaudacionTotal = 0

    override method cotizar(unContenido) {
        return recaudacionTotal
    }
    override method resetear() {
    recaudacionTotal = 0
}


    method recibirDonacion(monto) {
        recaudacionTotal += monto
    }


}

class VentaDeDescarga inherits Monetizacion {
    const propert precioFijo

    override method cotizar(unContenido) {
        return unContenido.vistas() * self.minimoPrecioValido()
    }

    method minimoPrecioValido() {
        return precioFijo.max(5)
    }

    override method puedeMonetizarse(unContenido) {
        return unContenido.esPopular()
    }
}

class Alquiler inherits VentaDeDescarga {
    override method minimoPrecioValido() {
        return precioFijo.max(1)
    }

    override method puedeMonetizarse(unContenido) {
        return super(unContenido) and unContenido.esVideo()
    }

}
