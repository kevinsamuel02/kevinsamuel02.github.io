data Material = Material {
    nombre :: String,
    calidad :: Int
} deriving (Show, Eq)

data Edificio = Edificio {
    tipoEdificio :: String,
    materiales :: [Material]
} deriving (Show, Eq)


data Aldea = Aldea {
    poblacion :: Int,
    materialesDisponibles :: [Material],
    edificios :: [Edificio]
} deriving (Show, Eq)


--esValioso que recibe un material y retorna true si su calidad es mayor a 20

esValioso :: Material -> Bool
esValioso = (>20) . calidad

--unidadesDisponibles que recibe el nombre de un material y una aldea y retorna la cantidad de materiales disponibles con ese nombre en la aldea

unidadesDisponibles :: String -> Aldea -> Int
unidadesDisponibles nombre  = length . filter (==nombre) . map nombre . materialesDisponibles 

-- Valor total recibe una aldea y retorna la suma de la calidad de todos los materiales que hay en la aldea. Estos son 
--tanto los disponibles como los usados en sus edificios. 


valorTotal :: Aldea -> Int
valorTotal unaAldea = sumaCalidadDisponibles unaAldea + sumaCalidadEdificios edificios unaAldea

sumaCalidadDisponibles :: Aldea -> Int
sumaCalidadDisponibles = sum . map calidad . materialesDisponibles

sumaCalidadEdificios :: [Edificio] -> Int
sumaCalidadEdificios = sum . map calidad . materiales


-- 2 a tenerGnomito que aumenta la poblacion de la aldea en 1

modificarPoblacion:: (Int -> Int) -> Aldea -> Aldea
modificarPoblacion f unaAldea = unaAldea { poblacion = f (poblacion unaAldea) }

type Tarea = Aldea -> Aldea

tenerGnomito :: Tarea
tenerGnomito = modificarPoblacion (+1)

-- 2.b Lustrar Maderas
-- Aumenta en 5 la calidad de los materiales que empiezan con "Madera".

lustrarMaderas :: Tarea
lustrarMaderas = modificarMateriales (map lustrarSiEsMadera)

-- Helper para encapsular la lógica de decisión por cada material
lustrarSiEsMadera :: Material -> Material
lustrarSiEsMadera unMaterial
    | empiezaConMadera unMaterial = aumentarCalidad 5 unMaterial
    | otherwise                   = unMaterial

-- Helper de condición: ¿Empieza con "Madera"?
-- Usamos 'take 6' para agarrar las primeras 6 letras y comparar.
empiezaConMadera :: Material -> Bool
empiezaConMadera = (== "Madera") . take 6 . nombre

-- Helper de modificación del material
aumentarCalidad :: Int -> Material -> Material
aumentarCalidad cantidad unMaterial = unMaterial { calidad = calidad unMaterial + cantidad }

-- Helper de estructura (para no repetir sintaxis de record)
modificarMateriales :: ([Material] -> [Material]) -> Aldea -> Aldea
modificarMateriales f unaAldea = unaAldea { materialesDisponibles = f (materialesDisponibles unaAldea) }


{-c. recolectar que dado un material  y una cantidad  de cuanto de ese material  se quiere recolectar, 
 incorpore a los materiales disponibles de la aldea ese mismo material tantas veces como se indique
-}

recolectar :: Material -> Int -> Tarea
recolectar unMaterial cantidad unaAldea = replicate cantidad unMaterial ++ materialesDisponibles unaAldea

{-3. Realizar las consultas que permitan:
a. Obtener los edificios chetos de una aldea, que son aquellos que tienen algún material valioso.
b. Obtener una lista de nombres de materiales comunes, que son aquellos que se encuentran en
todos los edificios de la aldeа.
-}

edificiosChetos :: Aldea -> [Edificio]
edificiosChetos unaAldea = map esCheto . edificios 

esCheto :: Edificio -> Bool
esCheto = any esValioso . materiales 

materialesComunes :: Aldea -> [Material]
materialesComunes unaAldea = map . 


esComun