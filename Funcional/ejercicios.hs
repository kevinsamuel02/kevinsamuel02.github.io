data Cafe = Cafe {
    nombre :: String,
    temperatura :: Int,
    precio :: Float
} deriving(Show)


modificarTemperatura :: (Int -> Int) -> Cafe -> Cafe
modificarTemperatura f unCafe = unCafe {temperatura = f(temperatura unCafe)}

modificarPrecio :: (Float -> Float) -> Cafe -> Cafe
modificarPrecio f unCafe = unCafe {precio = f(precio unCafe)}

calentar :: Int -> Cafe -> Cafe
calentar cantidad = modificarTemperatura (sum cantidad) 

agregarCrema :: Cafe -> Cafe
agregarCrema unCafe =  (modificarTemperatura (const 5)) . (modificarPrecio (sum 50)) $ unCafe


type Pedido = [Cafe]

cafesFrios :: Pedido -> [Cafe]
cafesFrios = filter menosDeCuarenta

menosDeCuarenta :: Cafe -> Bool
menosDeCuarenta  = (<40) . temperatura 

calentarPedido :: Pedido -> Pedido
calentarPedido = map (calentar 10)

totalAbonar :: Pedido -> Float
totalAbonar = sum . map precio

--EJERCICIO 2 -----------------------------------------------------------------


data Cancion = Cancion {
    titulo :: String,
    duracion :: Int,
    reproducciones :: Int
} deriving (Show)

modificarDuracion :: (Int -> Int) -> Cancion -> Cancion
modificarDuracion f unaCancion = unaCancion {duracion = max 0 (f(duracion unaCancion))}

modificarReproducciones :: (Int -> Int) -> Cancion -> Cancion
modificarReproducciones f unaCancion = unaCancion {reproducciones = max 0 (f(reproducciones unaCancion))}

escuchar :: Cancion -> Cancion --aumenta el contador de reproducciones en 1
escuchar = modificarReproducciones (+1)

acortar :: Int -> Cancion -> Cancion -- resta esa cantidad de segundos a la cancion, NO TIENE QUE SER NEGATIVA
acortar segundos = modificarDuracion (subtract segundos)

esHit :: Cancion -> Bool --si tiene mas de 10.000 reproducciones
esHit = (>10000) . reproducciones

type Playlist = [Cancion]

duracionTotal :: Playlist -> Int -- Calculá cuántos segundos dura toda la playlist sumada.
duracionTotal = sum . map duracion

reproducirPlaylist :: Playlist -> Playlist -- La gente está a full. Aumentá en 1 la reproducción de todas las canciones de la lista.
reproducirPlaylist = map (modificarReproducciones (+1))

soloHits :: Playlist -> [String] -- Queremos la lista de títulos (Strings) de las canciones que son hits.
soloHits = map titulo . filter esHit


--Ejercicio 3 ---------------------------------------------------------

data Mago = Mago {
    vida :: Int,
    mana :: Int
} deriving (Show)


modificarVida f unMago = unMago { vida = f (vida unMago) }
modificarMana f unMago = unMago { mana = f (mana unMago) }

lanzarHechizo :: Mago -> Mago -- Gasta 20 de maná
lanzarHechizo = modificarMana (subtract 20)

tomarPocion :: Mago -> Mago -- Recupera 50 de maná y 10 de vida
tomarPocion = modificarVida (+10) . modificarMana (+50)

recibirGolpe :: Int -> Mago -> Mago -- Pierde esa cantidad de vida
recibirGolpe cantidad = modificarVida (subtract cantidad)

aventuras :: [Mago -> Mago]
aventuras = [lanzarHechizo, tomarPocion, recibirGolpe 30, lanzarHechizo]

viajeFinal :: Mago -> [Mago -> Mago] -> Mago
viajeFinal unMago = foldl (\mago evento -> evento mago) unMago


-- Ejercicio 4 ---------------------Nivel 1------------------------------------------

data Billetera = Billetera { 
    plata :: Int 
} deriving (Show)

-- Movimientos: [100, -20, 50, -10]

modificarPlata :: (Int -> Int) -> Billetera -> Billetera
modificarPlata f unaBilletera = {plata = max 0 (f(plata unaBilletera))}

procesarMovimientos :: Billetera -> [Int] -> Billetera -- La función acumuladora tiene que agarrar la billetera y sumarle (o restarle) el movimiento actual.
procesarMovimientos unaBilletera = foldl (\billetera transaccion -> transaccion billetera) unaBilletera


-- Ejercicio 5 -----------------------Nivel 2----------------------------------------

data Robot = Robot { 
    x :: Int, 
    y :: Int 
} deriving (Show)

-- Helpers
modificarX f r = r { x = f (x r) }
modificarY f r = r { y = f (y r) }

-- Acciones
irAlNorte = modificarY (+1)
irAlEste  = modificarX (+1)
irAlSur   = modificarY (subtract 1)
irAlOeste = modificarX (subtract 1)

ejecutarComandos :: Robot -> [Robot -> Robot] -> Robot
ejecutarComandos unRobot = foldl (\robot movimiento -> movimiento robot) unRobot

-- Ejercicio 6 -----------------------Nivel 3----------------------------------------
data Participante = Participante { 
    nombre :: String, 
    puntos :: Int 
} deriving (Show)

ganador :: [Participante] -> Participante
ganador 
