type Ingrediente = String 
data Hamburguesa = Hamburguesa {
    nombreHamburguesa :: String, 
    ingredientes :: [Ingrediente]
    } 
data Bebida = Bebida {
    nombreBebida :: String,
     tamanioBebida :: Number,
      light :: Bool
      } 
type Acompaniamiento = String 
type Combo = (Hamburguesa, Bebida, Acompaniamiento)

hamburguesa (h,_,_) = h 
bebida (_,b,_) = b 
acompaniamiento (_,_,a) = a

informacionNutricional = [("Carne", 250), ("Queso", 50), ("Pan", 20), ("Panceta", 541), 
("Lechuga", 5), ("Tomate", 6)] 

condimentos = ["Barbacoa","Mostaza","Mayonesa","Salsa big mac","Ketchup"] 

comboQyB = (qyb, cocaCola, "Papas") 
cocaCola = Bebida "Coca Cola" 2 False 
qyb = Hamburguesa "QyB" ["Pan", "Carne", "Queso", "Panceta", "Mayonesa", "Ketchup", "Pan"] 

--1) Queremos saber cuántas calorías tiene un ingrediente, esto puede obtenerse a partir de la información 
--nutricional, a menos que sea un condimento, en cuyo caso la cantidad de calorías es 10. 


esCondimento :: String -> Bool
esCondimento = (`elem` condimentos)


buscarCalorias :: String -> Int
buscarCalorias ingredienteBuscado = 
    snd . head . filter (\(nombre, _) -> nombre == ingredienteBuscado) $ informacionNutricional


calorias :: String -> Int
calorias ingrediente
    | esCondimento ingrediente = 10
    | otherwise                = buscarCalorias ingrediente


--2. Se quiere saber si un combo esMortal. Esto se cumple cuando la bebida no es dietética y el acompañamiento 
--no es ensalada, o si la hamburguesa es una bomba (si tiene entre sus ingredientes al menos uno que tenga más 
--de 300 calorías, o si en total la hamburguesa supera las 1000 calorías).

esMortal :: Combo -> Bool
esMortal unCombo = esBomba (hamburguesa unCombo)
                || caloriasTotalHamburguesa (hamburguesa unCombo) > 1000
                || esComboPesado unCombo


esComboPesado :: Combo -> Bool
esComboPesado unCombo = noEsBebidaDietetica (bebida unCombo) && acompaniamientoPesado (acompaniamiento unCombo)


esBomba :: Hamburguesa -> Bool
esBomba = any ((> 300) . calorias) . ingredientes

caloriasTotalHamburguesa :: Hamburguesa -> Int
caloriasTotalHamburguesa = sum . map calorias . ingredientes

noEsBebidaDietetica :: Bebida -> Bool
noEsBebidaDietetica = not . light

acompaniamientoPesado :: Acompaniamiento -> Bool
acompaniamientoPesado = (/= "Ensalada")

--3. Definir las siguientes funciones para alterar un combo y declarar el tipo de las mismas: 
--a. agrandarBebida: el combo alterado debería tener el mismo tipo de bebida pero incrementando en 1 su 
--tamaño. 
--b. cambiarAcompañamientoPor: el combo alterado debería tener el acompañamiento elegido por el 
--cliente. 
--c. peroSin: la hamburguesa del combo debería excluir ingredientes que cumplan con una determinada 
--condición. En principio nos interesa contemplar las siguientes condiciones sobre los ingredientes, pero 
--debería admitir otras condiciones del mismo tipo: 
--i. 
--esCondimento: un ingrediente cumple esta condición si es igual a alguno de los condimentos 
--conocidos. 
--ii. 
--masCaloricoQue: se cumple esta condición si las calorías del ingrediente superan un valor 
--dado.


agrandarBebida :: Combo -> Combo
agrandarBebida (hamburguesa, bebida, acompaniamiento) = 
    (hamburguesa, modificarTamanio (+1) bebida, acompaniamiento)

cambiarAcompañamientoPor :: Acompaniamiento -> Combo -> Combo
cambiarAcompañamientoPor nuevoAcompaniamiento (h, b, _) = (h, b, nuevoAcompaniamiento)


peroSin :: (Ingrediente -> Bool) -> Combo -> Combo
peroSin condicion (h, b, a) = (sacarIngredientes condicion h, b, a)


sacarIngredientes :: (Ingrediente -> Bool) -> Hamburguesa -> Hamburguesa
sacarIngredientes condicion = modificarIngredientes (filter (not . condicion))


esCondimento :: Ingrediente -> Bool
esCondimento = (`elem` condimentos)


masCaloricoQue :: Int -> Ingrediente -> Bool
masCaloricoQue umbral = (> umbral) . calorias