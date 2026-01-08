data Serie = Serie {
    nombreSerie :: String,
    actores :: [Actor],
    presupuesto :: Int,
    temporadasEstimadas :: Int,
    rating :: Float,
    cancelada :: Bool
}

data Actor = Actor {
    nombreActor :: String,
    sueldo :: Int,
    restricciones :: [String]
}

-- PUNTO 1 

-- a. Saber si la serie está en rojo
--Si el presupuesto no alcanza a cubrir lo que quieren cobrar todos
estaEnRojo :: Serie -> Bool
estaEnRojo unaSerie = presupuesto unaSerie < totalSueldos unaSerie

totalSueldos :: Serie -> Int
totalSueldos = sum . map sueldo . actores


-- b. Saber si una serie es problemática
-- Ocurre si tienen más de 3 actores con más de 1 restricción
esProblematica :: Serie -> Bool
esProblematica unaSerie = cantidadActoresComplicados unaSerie > 3


cantidadActoresComplicados :: Serie -> Int
cantidadActoresComplicados = length . filter tieneMuchasRestricciones . actores

tieneMuchasRestricciones :: Actor -> Bool
tieneMuchasRestricciones = (> 1) . length . restricciones

type Productor = Serie -> Serie

modificarActores :: ([Actor] -> [Actor]) -> Serie -> Serie
modificarActores f unaSerie = unaSerie { actores = f (actores unaSerie) }

modificarTemporadas :: (Int -> Int) -> Serie -> Serie
modificarTemporadas f unaSerie = unaSerie { temporadasEstimadas = f (temporadasEstimadas unaSerie) }

-- a. Con Favoritismos
-- Reemplaza los dos primeros actores por sus favoritos.
conFavoritismos :: [Actor] -> Productor
conFavoritismos favoritos = modificarActores (\listaActual -> favoritos ++ drop 2 listaActual)

-- b. Tim Burton
-- Es un caso particular de favoritismos con sus actores fetiche.
timBurton :: Productor
timBurton = conFavoritismos [johnnyDepp, helenaBonhamCarter]

johnnyDepp :: Actor
johnnyDepp = Actor "Johnny Depp" 20000000 []

helenaBonhamCarter :: Actor
helenaBonhamCarter = Actor "Helena Bonham Carter" 15000000 []

-- c. Gatopardeitor
-- No cambia nada.
gatopardeitor :: Productor
gatopardeitor = id

-- d. Estireitor
-- Duplica la cantidad de temporadas.
estireitor :: Productor
estireitor = modificarTemporadas (*2)

-- e. Desespereitor
-- Hace un combo de ideas (recibe una lista de productores y los aplica todos).
desespereitor :: [Productor] -> Productor
desespereitor productores = foldr (.) id productores

-- f. Canceleitor
-- Cancela si está en rojo o si el rating es bajo.
canceleitor :: Float -> Productor
canceleitor cifraRating unaSerie
    | estaEnRojo unaSerie || rating unaSerie < cifraRating = unaSerie { cancelada = True }
    | otherwise = unaSerie

{-3. Calcular el bienestar de una serie, en base a la sumatoria de estos conceptos:
- Si la serie tiene estimadas más de 4 temporadas, su bienestar es 5, de lo contrario
es (10 - cantidad de temporadas estimadas) * 2
- Si la serie tiene menos de 10 actores, su bienestar es 3, de lo contrario es (10 -
cantidad de actores que tienen restricciones), con un mínimo de 2
Aparte de lo mencionado arriba, si la serie está cancelada, su bienestar es 0 más
allá de cómo diesen el bienestar por longitud y por reparto.-} 
bienestar :: Serie -> Int
bienestar unaSerie
    | cancelada unaSerie = 0
    | otherwise          = bienestarPorLongitud unaSerie + bienestarPorReparto unaSerie


bienestarPorLongitud :: Serie -> Int
bienestarPorLongitud unaSerie
    | temporadasEstimadas unaSerie > 4 = 5
    | otherwise                        = (10 - temporadasEstimadas unaSerie) * 2


bienestarPorReparto :: Serie -> Int
bienestarPorReparto unaSerie
    | length (actores unaSerie) < 10 = 3
    | otherwise                      = max 2 (10 - cantidadConRestricciones unaSerie)

cantidadConRestricciones :: Serie -> Int
cantidadConRestricciones = length . filter (not . null . restricciones) . actores


{-4. Dada una lista de series y una lista de productores, aplicar para cada serie el
productor que la haga más efectiva: es decir, el que le deja más bienestar.
-}

masEfectivas :: [Serie] -> [Productor] -> [Serie]
masEfectivas series productores = map (elegirMejorVersion productores) series


elegirMejorVersion :: [Productor] -> Serie -> Serie
elegirMejorVersion productores unaSerie = 
    foldl1 quedarseConLaMejor (versionesDeLaSerie productores unaSerie)


versionesDeLaSerie :: [Productor] -> Serie -> [Serie]
versionesDeLaSerie productores unaSerie = map (\productor -> productor unaSerie) productores

quedarseConLaMejor :: Serie -> Serie -> Serie
quedarseConLaMejor serie1 serie2
    | bienestar serie1 >= bienestar serie2 = serie1
    | otherwise                            = serie2

{-5 a. ¿Se puede aplicar el productor gatopardeitor con una lista infinita de actores? (lo hizo gemini)
Respuesta: SÍ.

Justificación: El productor gatopardeitor es la función identidad (id). Esto significa que devuelve la serie exactamente como le llegó, 
sin inspeccionar ni operar sobre sus componentes. Como Haskell trabaja con Evaluación Perezosa, no necesita recorrer la lista infinita
 de actores para devolver el objeto Serie. Simplemente pasa la referencia ("el puntero") de la estructura en memoria. Nada explota.-}

 {-b. ¿Y a uno con favoritismos? ¿De qué depende?
Respuesta: SÍ, se puede aplicar, pero que el programa termine o se cuelgue depende de qué hagamos después con el resultado.
Justificación de por qué se puede aplicar: La función conFavoritismos hace esto: favoritos ++ drop 2 actores.
drop 2: En una lista infinita, simplemente avanza el puntero dos lugares. No necesita llegar al final.
++: Construye una nueva lista pegando los favoritos adelante. Haskell construye esta nueva lista de forma perezosa.
 El resultado es una nueva lista infinita que empieza con los favoritos. La operación de transformación es instantánea y válida.
¿De qué depende que funcione o no? (El "Consumer") Depende de la consulta que hagas sobre esa serie resultante:
Funciona ✅: Si pedís nombre serie, take 10 (actores serie) o head (actores serie). Haskell solo evaluará lo necesario 
(los primeros elementos).
Se cuelga (Loop Infinito) 💀: Si intentás calcular el bienestar.
¿Por qué? Porque bienestar usa cantidadConRestricciones, que a su vez usa length.
Para saber la longitud de una lista infinita, Haskell tiene que recorrerla toda... y nunca termina.-}

{-6. Saber si una serie es controvertida, que es cuando no se cumple que cada actor de
la lista cobra más que el siguiente.-}

esControvertida :: Serie -> Bool
esControvertida unaSerie = not (cobraMasQueElSiguiente (actores unaSerie))


cobraMasQueElSiguiente :: [Actor] -> Bool
cobraMasQueElSiguiente listaActores = 
    all primeroGanaMas (armarParejas listaActores)

armarParejas :: [a] -> [(a,a)]
armarParejas lista = zip lista (tail lista)


primeroGanaMas :: (Actor, Actor) -> Bool
primeroGanaMas (uno, otro) = sueldo uno > sueldo otro

{-7. Explicar la inferencia del tipo de la siguiente función:
funcionLoca x y = filter (even.x) . map (length.y)

Respuesta final:

Haskell

funcionLoca :: (Int -> Int) -> (a -> [b]) -> [a] -> [Int]
(Nota técnica: Si querés ser súper preciso con Haskell, en lugar de [b] podrías poner Foldable t => t b, pero en un parcial [b] suele estar perfecto).

Resumen de la Lógica para justificar:
map dicta la estructura intermedia: Como usamos length, la lista se transforma en [Int].

filter confirma la salida: Filtra esa lista de enteros, así que devuelve [Int].

x conecta con el intermedio: Procesa los enteros que salen del length, así que va de Int -> Int.

y conecta con la entrada: Procesa los elementos originales (a) y devuelve algo medible (lista).-}