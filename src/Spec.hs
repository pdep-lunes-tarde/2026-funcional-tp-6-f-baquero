module Spec where
import PdePreludat
import Library
import Test.Hspec
import Control.Exception (evaluate)

correrTests :: IO ()
correrTests = hspec $ do
    describe "Precios de ingredientes nuevos" $ do
        it "BaconDeTofu cuesta 12" $ precioIngrediente BaconDeTofu `shouldBe` 12
        it "PatiVegano cuesta 10" $ precioIngrediente PatiVegano `shouldBe` 10
        it "PanIntegral cuesta 3" $ precioIngrediente PanIntegral `shouldBe` 3
        it "Papas cuesta 10" $ precioIngrediente Papas `shouldBe` 10

    describe "Parte 1: Hamburguesas" $ do
        it "el precio de cuartoDeLibra es 54" $
            precioFinal cuartoDeLibra `shouldBe` 54

        it "agregarIngrediente agrega sin tocar el precio base" $ do
            let conPanceta = agregarIngrediente Panceta cuartoDeLibra
            ingredientes conPanceta `shouldBe` (Panceta : ingredientes cuartoDeLibra)
            precioBase conPanceta `shouldBe` precioBase cuartoDeLibra

        it "descuento reduce el precio base y no toca los ingredientes" $ do
            let conDescuento = descuento 20 cuartoDeLibra
            precioBase conDescuento `shouldBe` 16
            ingredientes conDescuento `shouldBe` ingredientes cuartoDeLibra

        it "agrandar una hamburguesa con carne agrega carne" $
            ingredientes (agrandar cuartoDeLibra) `shouldBe` (Carne : ingredientes cuartoDeLibra)

        it "agrandar una hamburguesa con pollo agrega pollo" $ do
            let hamburguesaPollo = Hamburguesa { precioBase = 15, ingredientes = [Pan, Pollo] }
            ingredientes (agrandar hamburguesaPollo) `shouldBe` [Pollo, Pan, Pollo]

        it "pdepBurger cuesta 110" $
            precioFinal pdepBurger `shouldBe` 110

    describe "Parte 2: algunas hamburguesas más" $ do
        it "dobleCuarto cuesta 84" $
            precioFinal dobleCuarto `shouldBe` 84

        it "bigPdep cuesta 89" $
            precioFinal bigPdep `shouldBe` 89

        it "dobleCuarto del dia cuesta 88" $
            precioFinal (delDia dobleCuarto) `shouldBe` 88

        it "delDia agrega papas y aplica 30% de descuento" $ do
            let promo = delDia cuartoDeLibra
            (Papas `elem` ingredientes promo) `shouldBe` True
            precioBase promo `shouldBe` 14

    describe "Parte 3: veggie" $ do
        it "hacerVeggie reemplaza carne/pollo, cheddar y panceta" $ do
            let veggie = hacerVeggie dobleCuarto
            (Carne `elem` ingredientes veggie) `shouldBe` False
            (Cheddar `elem` ingredientes veggie) `shouldBe` False
            (PatiVegano `elem` ingredientes veggie) `shouldBe` True
            (QuesoDeAlmendras `elem` ingredientes veggie) `shouldBe` True

        it "agrandar una hamburguesa veggie agrega otro patiVegano" $ do
            let veggie = hacerVeggie cuartoDeLibra
            ingredientes (agrandar veggie) `shouldBe` (PatiVegano : ingredientes veggie)

        it "cambiarPanDePati reemplaza el pan por pan integral" $ do
            let integral = cambiarPanDePati cuartoDeLibra
            (Pan `elem` ingredientes integral) `shouldBe` False
            (PanIntegral `elem` ingredientes integral) `shouldBe` True

        it "dobleCuartoVegano no tiene cheddar, carne ni pan común" $ do
            let ingr = ingredientes dobleCuartoVegano
            (Cheddar `elem` ingr) `shouldBe` False
            (Carne `elem` ingr) `shouldBe` False
            (Pan `elem` ingr) `shouldBe` False
            precioFinal dobleCuartoVegano `shouldBe` 76