data Mago = Mago {
    nombre :: String,
    edad :: Int,
    salud :: Float,
    hechizos :: [Hechizo]
}

type Hechizo = Mago -> Mago

modificarSalud :: (Float -> Float) -> Mago -> Mago
modificarSalud f unMago = unMago { salud = max 0 (f (salud unMago)) }

modificarHechizos :: ([Hechizo] -> [Hechizo]) -> Mago -> Mago
modificarHechizos f unMago = unMago { hechizos = f (hechizos unMago) }


--PUNTO 1 ---------------------------------------------------------------------

curar :: Float -> Hechizo
curar cantidad = modificarSalud (+ cantidad)

lanzarRayo :: Hechizo
lanzarRayo unMago
    | salud unMago > 10 = modificarSalud (subtract 10) unMago
    | otherwise         = modificarSalud (/ 2) unMago

amnesia :: Int -> Hechizo
amnesia n = modificarHechizos (drop n)

confundir :: Hechizo
confundir unMago = (head (hechizos unMago)) unMago

--PUNTO 2 ---------------------------------------------------------------------------

poder :: Mago -> Float
poder unMago = salud unMago + fromIntegral (edad unMago * cantidadHechizosConoce unMago)

cantidadHechizosConoce :: Mago -> Int
cantidadHechizosConoce unMago = length (hechizos unMago)

danio :: Hechizo -> Mago -> Float
danio unHechizo unMago = salud unMago - salud (unHechizo unMago)

diferenciaDePoder :: Mago -> Mago -> Float
diferenciaDePoder magoA magoB = abs (poder magoA - poder magoB)


--PUNTO 3 ------------------------------------------------------------------------


data Academia = Academia {
    magos :: [Mago],
    examenDeIngreso :: Mago -> Bool
} 


hayRincewindSinHechizos :: Academia -> Bool
hayRincewindSinHechizos unaAcademia = any esRincewindSinHechizos (magos unaAcademia)


esRincewindSinHechizos :: Mago -> Bool
esRincewindSinHechizos unMago = seLlama "Rincewind" unMago && esMuggle unMago


seLlama :: String -> Mago -> Bool
seLlama nombreBuscado = (== nombreBuscado) . nombre

esMuggle :: Mago -> Bool
esMuggle = null . hechizos

esMuggle = not (any hechizos)

esMuggle = (==0) . cantidadHechizosConoce 


todosLosViejosSonNionios :: Academia -> Bool
todosLosViejosSonNionios unaAcademia = all esNionio . filter esViejo $ magos unaAcademia

esViejo :: Mago -> Bool
esViejo = (> 50) . edad

esNionio :: Mago -> Bool
esNionio unMago = fromIntegral (cantidadHechizosConoce unMago) > salud unMago

cantidadQueNoPasarian :: Academia -> Int
cantidadQueNoPasarian unaAcademia = length . filter (not . examenDeIngreso unaAcademia) $ magos unaAcademia


sumatoriaEdadSabios :: Academia -> Int
sumatoriaEdadSabios = sum . map edad . filter sabeMasDe10Hechizos . magos

sabeMasDe10Hechizos :: Mago -> Bool
sabeMasDe10Hechizos = (> 10) . length . hechizos

--PUNTO 4 -------------------------------------------------------------
maximoSegun criterio valor comparables = foldl1 (mayorSegun $ criterio valor) comparables

mayorSegun evaluador comparable1 comparable2
    | evaluador comparable1 >= evaluador comparable2 = comparable1
    | otherwise                                      = comparable2


mejorHechizoContra :: Mago -> Mago -> Hechizo
mejorHechizoContra victima atacante = maximoSegun (flip daño) victima (hechizos atacante)


mejorOponente :: Mago -> Academia -> Mago
mejorOponente unMago academia = maximoSegun diferenciaDePoder unMago (magos academia)


--PUNTO 5 ------------------------------------------------------------


