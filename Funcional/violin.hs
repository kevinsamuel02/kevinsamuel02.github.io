data Musico = {
    nombre :: String,
    gradoDeExperiencia :: Int,
    instrumentoFavorito :: String,
    actuaciones :: [Actuacion]
}

data Actuacion = {
    fecha :: (Int, Int, Int),
    cantidadPublico :: Int
}

masDe5000 :: Musico -> Bool
masDe5000 = any (>5000) . map cantidadPublico . actuaciones

cantActuacionesEnAnio :: Int -> Musico -> Int
cantActuacionesEnAnio unAnio = length . filter ((== unAnio) . last . fecha) . actuaciones

type Actividad = Musico -> Musico

tocarUnInstrumento :: String -> Actividad
tocarUnInstrumento unInstrumento unMusico
    |   esInstrumentoEspecial unInstrumento = modificarInstrumento unInstrumento unMusico && modificarExperiencia (+1) unMusico
    |   otherwise                           = modificarExperiencia (+1) unMusico

modificarExperiencia :: (Int -> Int) -> Musico -> Musico
modificarExperiencia f unMusico = unMusico { gradoDeExperiencia = f (gradoDeExperiencia unMusico) }

esInstrumentoEspecial :: String -> Bool
esInstrumentoEspecial unInstrumento = unInstrumento == "oboe" || unInstrumento == "fagot" || unInstrumento == "cello"

modificarInstrumento :: String -> Musico -> Musico
modificarInstrumento unInstrumento unMusico = instrumentoFavorito unMusico (==unInstrumento)

cantar :: Actividad 
cantar = "Lalala" ++ instrumentoFavorito

hacerUnaPresentacion :: Actuacion -> Actividad 
hacerUnaPresentacion unaActuacion unMusico = siToca . modificarExperiencia (+1) . actuaciones unMusico ++ unaActuacion

siToca :: Actividad 
siToca unMusico 
    |   esInstrumentoEspecial instrumentoFavorito unMusico = modificarExperiencia (+1)
    |   otherwise                                          = id


pensar :: Actividad
pensar = id

kevo :: Musico
kevo = Musico kevo 5 "piano" []

ejemplo :: Actividad
ejemplo = pensar . hacerUnaPresentacion (Actuacion (2,8,2025) 300) . cantar . tocarUnInstrumento "fagot" 

