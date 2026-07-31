# TP Composición

## Tareas

- [ ] Aceptar el assignment y clonar el repositorio con el ejercicio
- [ ] Ir a la carpeta donde descargaste el ejercicio.
- [ ] Reemplazar nombre y legajo en el archivo README.md
- [ ] Resolver el ejercicio siguiendo [un esquema de trabajo](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/trabajo.md), eso incluye
- [ ] Ejecutar los tests con `stack test` y que den verde
- [ ] A medida que vas resolviendo el ejercicio, subir [el progreso a git](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/git/resolverConflictos.md)

## Nombre y legajo

- Legajo: 233.215-2
- Nombre: Francisco Baquero

## El enunciado


Resolver este TP  **usando composición y aplicación parcial**. Escribir todos los tests que consideren necesarios para cada punto.

### Parte 1: Hamburguesas

Nos pusimos una hamburguesería y queremos implementar un sistema para calcular los precios de las hamburguesas que vamos a vender. Cada hamburugesa tiene un precio base y una lista de ingredientes.

El precio final de una hamburguesa es la sumatoria de los precios de los ingredientes + el precio base.

- Carne = 20
- Pan = 2
- Panceta = 10
- Cheddar = 10
- Pollo = 10
- Curry = 5
- QuesoDeAlmendras = 15
- BaconDeTofu = 12
 
Un ejemplo de hamburguesa es el **cuartoDeLibra**, una hamburguesa de pan, carne, cheddar, pan y su precio base es de 20.

 Partiendo de esto modelamos:
 
- **agrandar**: cada vez que se agranda una hamburguesa se agrega otro ingrediente base (por ahora, son Carne o Pollo), se elige el ingrediente base a agregar según lo que ya haya en la hamburguesa (si había carne se agrega carne, si había pollo se agrega pollo, si había ambos da igual cuál se agregue).
- **agregarIngrediente**: recibe un ingrediente y una hambrugesa lo agrega a la hamburguesa.
- **descuento**: recibe un % de descuento, y devuelve la hamburguesa con ese descuento aplicado al precio base.
- la **pdepBurger**, que es un cuarto de libra agrandado 2 veces con panceta, cheddar y 20% de descuento. Su precio final deberia ser 110.

### PARTE 2: Algunas hamburguesas más
El negocio se agrandó y queremos agregar las siguientes hamburguesas:
- **dobleCuarto** = es un cuarto de libra con carne y cheddar. El precio final deberia ser 84.
- **bigPdep** = es un doble cuarto con curry. El precio final deberia ser 89.
- **delDia** = es una promo que, dada una hamburguesa, le agrega Papas y un descuento del 30%. Por ejemplo, podría pedir una big pdep del dia y debería ser como una big pdep (doble cuarto con curry) pero con papas y el descuento del 30%. Por ejemplo una doble cuarto del día deberia valer 88.

Las papas son un ingrediente que cuesta $10.

### PARTE 3: algunos cambios más 

Queremos modelar los siguientes modificadores:
- **hacerVeggie** : cambia todos los ingredientes base que hayan en la hamburguesa por PatiVegano (nuevo ingrediente base, también de precio 10), el cheddar lo cambia por queso de almendras y la panceta por bacon de tofu.

  _Nota: ahora que hay un nuevo ingrediente base, **agrandar** una hamburguesa debería modificarse de manera acorde. Es decir, agrandar una hamburguesa cuyo ingrediente base es un PatiVegano debería agregarle otro PatiVegano._
- **cambiarPanDePati** : cambia el Pan que haya en la hamburguesa por PanIntegral (ingrediente de precio 3).
- hacer el **dobleCuartoVegano**, que es un dobleCuarto veggie con pan integral.

