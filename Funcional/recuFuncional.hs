{-De cada aventurero nos interesa conocer: 
● Nombre  
● Carga un número que indica la carga en kilos que lleva el aventurero. 
● Salud un número entre 0 y 100 que representa su nivel de salud actual. 
● Coraje que indica si el aventurero conserva el coraje o lo perdió. 
● Criterio de Selección de Encuentros que dado el estado resultante del aventurero 
tras un encuentro, determina si el aventurero está conforme. -}
data Aventurero = Aventurero {
    nombre :: String,
    carga :: Int,
    salud :: Int,
    tieneCoraje :: Bool
    criterio :: Criterio
}


type Criterio = Aventurero -> Bool

type Encuentro = Aventurero -> Aventurero

{-● Conformista: Le viene bien cualquier resultado posible. 
● Valiente: Acepta si después del encuentro el aventurero tiene coraje o si su salud 
es mayor que 50. 
● LightPacker: Acepta si la carga final es menor a un valor umbral configurable. Por 
ejemplo puede pretender quedar con una carga menor a 15 kilos. Otros pueden ser 
más exigentes y preferir quedar con menos de 12 kilos
-}

conformista :: Criterio
conformista _ = True

valiente :: Criterio
valiente aventurero = tieneCoraje aventurero || tieneSaludMayor50 aventurero

tieneSaludMayor50 :: Aventurero -> Bool
tieneSaludMayor50 = (>50) . salud

lightPacker :: Int -> Criterio
lightPacker umbral  = (< umbral) . carga 

{-Dada una lista de aventureros y utilizando exclusivamente funciones de orden superior y 
aplicación parcial (sin recursividad) se pide: 
a) Determinar si existe algún aventurero cuyo nombre contenga más de 5 letras. 
b) Sumar la carga total de todos los aventureros cuya carga sea un número par.-}

aventureroConMasDe5 :: [Aventurero] -> Bool
aventureroConMasDe5 = any tieneMasDeCinco

tieneMasDeCinco :: Aventurero -> Bool
tieneMasDeCinco = (>5) . length . nombre

sumaCargaAventurerosPar :: [Aventurero] -> Int 
sumaCargaAventurerosPar = sum . map carga . filter tieneCargaPar

tieneCargaPar :: Aventurero -> Bool
tieneCargaPar = even . carga 

{-Un encuentro con un personaje promete alterar el estado del aventurero. Todos los 
encuentros con personajes le descarga 1 kilo de su carga dado que siempre les deja un 
souvenir y además cuando se encuentra con: 
● Curandero (Healer): Reduce la carga a la mitad y aumenta la salud un 20%. 
● Inspirador (Inspirer): Otorga coraje y aumenta la salud en un 10% sobre su valor 
actual. 
● Embaucador (Trickster): Quita el coraje, suma 10 a la carga, lo deja con la mitad de 
la salud y lo convence de que su criterio para los próximos encuentros tienen que 
ser de LightPacker con un máximo de 10 kilos. 
Debe evitar la repetición de lógica y respetar los límites mencionados anteriormente. -}

type EncuentroPersonaje = Aventurero -> Aventurero


souvenir :: EncuentroPersonaje
souvenir = modificarCarga (subtract 1)

curandero :: EncuentroPersonaje
curandero = souvenir . modificarCarga (`div` 2) . modificarSalud (* 1.2)

inspirador :: EncuentroPersonaje
inspirador = souvenir . modificarCoraje (const True) . modificarSalud (*1.1)

embaucador :: EncuentroPersonaje
embaucador = souvenir . modificarCoraje (const False) . modificarCarga (+10) . modificarSalud (`div` 2) . modificarCriterio (lightPacker 10)

modificarCarga :: (Int -> Int) -> Aventurero -> Aventurero
modificarCarga f a = a { carga = f (carga a) }

modificarSalud :: (Int -> Int) -> Aventurero -> Aventurero
modificarSalud f a = a { salud = f (salud a) }

modificarCoraje :: (Bool -> Bool) -> Aventurero -> Aventurero
modificarCoraje f a = a { tieneCoraje = f (tieneCoraje a) }

modificarCriterio :: Criterio -> Aventurero -> Aventurero
modificarCriterio f a = a { criterio = f (criterio a) }

{-Dada una lista de encuentros, queremos determinar a cuáles de ellos se enfrentaría un 
aventurero. La lógica es: 
● Tras cada encuentro, el aventurero evalúa su criterio. 
● Si el resultado no le satisface, no continúa con los encuentros siguientes. 
● Si le satisface se produce el encuentro y pasa al siguiente. 
Por ejemplo, si un aventurero con carga 6, salud 50, sin coraje, y criterio Valiente se 
enfrenta a la lista [Curandero, Inspirador, Embaucador, Curandero]: 
● Con Curandero: reduce la carga a 3 y queda con energía en 60 ⇒ cumple el criterio 
(energía > 50). 
● Con Inspirador: tiene coraje, salud aumenta a 66 ⇒ cumple el criterio. 
● Con Embaucador: quita el coraje y suma 10 a la carga y su salúd queda en 33⇒ no 
cumple criterio, entonces no se aplica y se descarta de la solución. 
Automáticamente corta la ejecución y no evalúa los siguientes resultados. 
Dada una persona (aventurero) y una lista de encuentros debe determinar la lista de 
encuentros que realmente enfrentaría mientras cumple su criterio.-}

encuentrosQueEnfrentaria :: Aventurero -> [Encuentro] -> [Encuentro]
encuentrosQueEnfrentaria _ [] = [] 
encuentrosQueEnfrentaria aventurero (encuentro : siguientesEncuentros)
    | aventureroSatisfecho = encuentro : encuentrosQueEnfrentaria aventureroResultante siguientesEncuentros
    | otherwise            = [] 
    where
        aventureroResultante = encuentro aventurero
        aventureroSatisfecho = (criterio aventurero) aventureroResultante

