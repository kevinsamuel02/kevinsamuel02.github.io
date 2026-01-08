--PUNTO 1 ------------------------------------------------------

data Persona = Persona {
    nivelDeStress :: Int,
    nombre :: String,
    preferencias :: [String], 
    cantidadDeAmigos :: Int
} deriving (Show)

type Contingente = [Persona]


totalDeStressGlotona :: Contingente -> Int
totalDeStressGlotona = sum . map nivelDeStress . filter (elem "gastronomía" . preferencias) 


esContingenteRaro :: Contingente -> Bool
esContingenteRaro = all (even . cantidadDeAmigos) 


--PUNTO 2 ----------------------------------------------------


type Plan = Persona -> Persona


modificarStress :: (Int -> Int) -> Persona -> Persona
modificarStress f p = p { nivelDeStress = f (nivelDeStress p) }

modificarAmigos :: (Int -> Int) -> Persona -> Persona
modificarAmigos f p = p { cantidadDeAmigos = f (cantidadDeAmigos p) }


villaGesell :: Int -> Plan
villaGesell mes
    | mes `elem` [1, 2] = modificarStress (+10)
    | otherwise         = modificarStress (`div` 2)

lasToninas :: Bool -> Persona -> Persona
lasToninas conPlata persona
    | conPlata  = modificarStress (`div` 2) persona
    | otherwise = modificarStress (+ (10 * cantidadDeAmigos persona)) persona


puertoMadryn :: Plan
puertoMadryn = modificarAmigos (+1)


laAdela :: Plan
laAdela = id

--PUNTO 2A --------------------------------------------------
hayPlanPiola :: [Plan] -> Persona -> Bool
hayPlanPiola planes persona = any (reduceElStress persona) planes


reduceElStress :: Persona -> Plan -> Bool
reduceElStress persona plan = nivelDeStress persona > nivelDeStress (plan persona)


--PUNTO 2B Y 2C-------------------------------------------------
lucho :: Persona
lucho = Persona 100 "Lucho" [] 5

ejemploVariado :: Persona -> Bool
ejemploVariado unaPersona = hayPlanPiola [villaGesell 1, lasToninas True, puertoMadryn, laAdela] unaPersona

ejemploMalo :: Persona -> Bool
ejemploMalo unaPersona = hayPlanPiola [villaGesell 1, lasToninas False, puertoMadryn, laAdela] unaPersona