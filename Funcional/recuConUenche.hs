data Persona = Persona {
    nombre :: String,
    nivelDeStress :: Int,
    preferencias :: [String],
    cantidadDeAmigos :: Int
}

type Contigente = [Persona]

totalDeStressGlotona :: Contigente -> Int
totalDeStressGlotona unContigente = sum (filter leGustaLaGastronomia  )

