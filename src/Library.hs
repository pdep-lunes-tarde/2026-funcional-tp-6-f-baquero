module Library where
import PdePreludat

data Ingrediente =
    Carne | Pan | Panceta | Cheddar | Pollo | Curry | QuesoDeAlmendras | Papas | PatiVegano | BaconDeTofu | PanIntegral
    deriving (Eq, Show)

precioIngrediente :: Ingrediente -> Number
precioIngrediente Carne = 20
precioIngrediente Pan = 2
precioIngrediente Panceta = 10
precioIngrediente Cheddar = 10
precioIngrediente Pollo =  10
precioIngrediente Curry = 5
precioIngrediente QuesoDeAlmendras = 15
precioIngrediente Papas = 10
precioIngrediente PatiVegano = 10
precioIngrediente BaconDeTofu = 12
precioIngrediente PanIntegral = 3


data Hamburguesa = Hamburguesa {
    precioBase :: Number,
    ingredientes :: [Ingrediente]
} deriving (Eq, Show)

precioFinal :: Hamburguesa -> Number
precioFinal h = precioBase h + (sum . map precioIngrediente . ingredientes) h

cuartoDeLibra :: Hamburguesa
cuartoDeLibra = Hamburguesa {precioBase = 20, ingredientes = [Pan, Carne, Cheddar, Pan]}

agregarIngrediente :: Ingrediente -> Hamburguesa -> Hamburguesa
agregarIngrediente i h = h{ingredientes = i : ingredientes h}

descuento :: Number -> Hamburguesa -> Hamburguesa
descuento d h = h{precioBase = (precioBase h) * (100-d)/100}

pdepBurger :: Hamburguesa
pdepBurger = descuento 20 . agregarIngrediente Panceta . agregarIngrediente Cheddar .agrandar . agrandar $ cuartoDeLibra -- el "$" es para no poner (agrandar cuartoDeLibra)

dobleCuarto :: Hamburguesa
dobleCuarto = agregarIngrediente Carne . agregarIngrediente Cheddar $ cuartoDeLibra

bigPdep :: Hamburguesa
bigPdep = agregarIngrediente Curry dobleCuarto

delDia :: Hamburguesa -> Hamburguesa
delDia h = descuento 30 . agregarIngrediente Papas $ h

ingredientesBase :: [Ingrediente]
ingredientesBase = [Pollo, Carne, PatiVegano]

reemplazarPorVeggie :: Ingrediente -> Ingrediente
reemplazarPorVeggie Carne = PatiVegano
reemplazarPorVeggie Pollo = PatiVegano
reemplazarPorVeggie Cheddar = QuesoDeAlmendras
reemplazarPorVeggie Panceta = BaconDeTofu
reemplazarPorVeggie ingrediente = ingrediente 

reemplazarPan :: Ingrediente -> Ingrediente
reemplazarPan Pan = PanIntegral
reemplazarPan i = i

hacerVeggie :: Hamburguesa -> Hamburguesa
hacerVeggie h = h{ingredientes = map reemplazarPorVeggie (ingredientes h)}

cambiarPanDePati :: Hamburguesa -> Hamburguesa
cambiarPanDePati h = h{ingredientes = map reemplazarPan (ingredientes h)}

dobleCuartoVegano :: Hamburguesa
dobleCuartoVegano = cambiarPanDePati . hacerVeggie $ dobleCuarto

ingredienteBaseDe :: Hamburguesa -> Ingrediente
ingredienteBaseDe = head . filter (`elem` ingredientesBase) . ingredientes

agrandar :: Hamburguesa -> Hamburguesa
agrandar h = h {ingredientes = ingredienteBaseDe h: ingredientes h}