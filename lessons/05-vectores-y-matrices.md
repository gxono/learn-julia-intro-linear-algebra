# 05. Vectores y matrices

## Por qué esto importa

En la lección 03 viste vectores y matrices como arreglos genéricos. Ahora vamos a las operaciones que los convierten en objetos de álgebra lineal de verdad: suma, producto punto, norma, transposición. Son la base de todo lo que viene después.

## Vectores: repaso rápido de acceso

```julia
v = [1, 2, 3, 4]
v[1]
v[2]
```

## Coma o espacio: no es lo mismo

Ya viste `[1, 2, 3]` (con comas) y `[1 2; 3 4]` (con espacios y punto y coma) por separado, pero la diferencia entre coma y espacio dentro de los corchetes importa más de lo que parece, y vale la pena dejarla clara antes de seguir.

```julia
a = [1, 2, 3]
b = [1 2 3]
```

Aunque a simple vista `a` y `b` tienen "los mismos números", son cosas distintas para Julia:

```julia
julia> typeof(a)
Vector{Int64}

julia> typeof(b)
Matrix{Int64}
```

`a`, con comas, es un `Vector` de 3 elementos: lo que normalmente entendés como "un vector" en álgebra lineal, y lo que vas a usar en casi todos los ejemplos de esta guía. `b`, con espacios, es una `Matrix` de 1 fila y 3 columnas (un "vector fila"). Se ven parecidos al imprimirlos, pero no se comportan igual.

**Investigá:** esto se nota cuando multiplicás una matriz por un vector. Con una matriz `A` de 2x2, `A * [1, 2]` (columna, con comas) funciona. Probá `A * [1 2]` (fila, con espacio) y fijate qué error da (`DimensionMismatch`). Es un error común cuando escribís una coma de más o de menos sin darte cuenta.

Como regla práctica: cuando quieras un vector "normal" (para sumar, hacer producto punto, resolver un sistema), usá comas. Reservá los espacios para cuando estés armando una matriz de verdad con más de una fila.

## Suma de vectores

```julia
u = [1, 2, 3]
v = [4, 5, 6]

u + v
```

La suma es elemento a elemento: el primer elemento de `u` se suma con el primero de `v`, y así siguiendo. Para esto, `u` y `v` tienen que tener el mismo tamaño.

**Predecí:** ¿qué pasa si sumás dos vectores de tamaños distintos, como `[1, 2]` y `[1, 2, 3]`? Probalo y fijate qué error da Julia (`DimensionMismatch`). Vale la pena reconocer ese error ahora, porque lo vas a volver a ver cuando trabajes con matrices de tamaños que no calzan.

## Producto punto

```julia
using LinearAlgebra

dot(u, v)
```

El producto punto multiplica los elementos correspondientes y suma los resultados: `u[1]*v[1] + u[2]*v[2] + u[3]*v[3]`. Si ya viste esta cuenta en algún curso de álgebra, es exactamente la misma.

**Predecí antes de correr:** calculá a mano `dot([1, 0], [0, 1])`. Dos vectores perpendiculares tienen producto punto cero, así que debería darte `0`. Confirmalo.

### Implementá tu propio producto punto

Esta es una materia de álgebra lineal numérica, así que además de usar `dot` conviene entender qué hace por dentro. Con lo que ya sabés de la lección 02 (funciones, `for`) y `length(v)` (te da la cantidad de elementos de `v`), podés escribirlo vos misma:

```julia
function mi_dot(u, v)
    # completar: recorré u y v con un for (1:length(u)), multiplicá cada
    # par de elementos correspondientes y acumulá la suma en un total
end
```

**Verificalo:** corré `mi_dot(u, v) == dot(u, v)`. Si te da `true`, tu implementación calcula lo mismo que la función de la librería.

Un detalle para más adelante: la forma más idiomática de recorrer un vector en Julia es `for i in eachindex(u)` en vez de `for i in 1:length(u)`. Acá usamos la segunda porque ya la conocés de la lección 02, pero cuando te sientas más cómoda vale la pena adoptar `eachindex`.

## Norma: el largo de un vector

```julia
norm(u)
```

La norma es la raíz cuadrada de la suma de los cuadrados de sus componentes, la misma idea que el teorema de Pitágoras extendida a más de dos dimensiones.

**Verificalo vos:** probá `norm([3, 4])`. Como `3`, `4`, `5` es un triángulo rectángulo conocido, el resultado debería ser `5.0`.

### Implementá tu propia norma

Con `mi_dot` ya hecho, la norma sale casi gratis: es la raíz cuadrada del producto punto de un vector consigo mismo.

```julia
function mi_norm(v)
    # completar: usá mi_dot(v, v) y sqrt()
end
```

**Verificalo:** corré `mi_norm(u) == norm(u)`.

## Matrices: repaso rápido de acceso

```julia
A = [1 2; 3 4]
A[1, 2]
A[2, 1]
```

## Tamaño de una matriz

```julia
size(A)
```

Devuelve una tupla `(filas, columnas)`. Es útil para revisar, antes de operar, si dos matrices tienen tamaños compatibles.

## Suma, resta y multiplicación por un escalar

Igual que con los vectores, estas operaciones son elemento a elemento y requieren que las matrices tengan el mismo tamaño:

```julia
B = [5 6; 7 8]

A + B
A - B
2 * A
```

## Multiplicación de matrices

```julia
A * B
```

Esta **no** es una multiplicación elemento a elemento (para eso está `.*`, que ya viste con vectores en la lección 03 y que también funciona con matrices). `A * B` es la multiplicación matricial de verdad: cada elemento del resultado es un producto punto entre una fila de `A` y una columna de `B`.

Para que `A * B` tenga sentido, el número de columnas de `A` tiene que ser igual al número de filas de `B`. Si no coinciden, Julia tira `DimensionMismatch`, el mismo error que ya viste antes.

**Predecí:** con `A = [1 2; 3 4]` y `B = [5 6; 7 8]`, calculá a mano el elemento de la fila 1, columna 1 de `A * B` (es `1*5 + 2*7`). Confirmalo corriendo `A * B`.

### Desafío opcional: implementá tu propia multiplicación de matrices

Este es más largo que los anteriores, pero vale la pena intentarlo al menos una vez para entender qué hace `A * B` por dentro. La idea: cada elemento `C[i, j]` del resultado es el producto punto entre la fila `i` de `A` y la columna `j` de `B`.

```julia
function mi_matmul(A, B)
    # completar: usá size(A) y size(B) para saber filas, columnas y la
    # dimensión compartida, y tres for anidados para ir armando C[i,j]
    # como el producto punto entre la fila i de A y la columna j de B
end
```

Pista: `size(A)` devuelve `(filas, k)`, que podés separar en dos variables de una vez con `filas, k = size(A)`. El triple `for` tiene que recorrer cada fila de `A`, cada columna de `B`, y dentro de eso, cada término de la suma del producto punto.

**Verificalo:** corré `mi_matmul(A, B) == A * B`.

## Transpuesta

```julia
A'
```

La comilla simple después de una matriz o vector calcula su transpuesta: intercambia filas por columnas.

**Predecí:** ¿cómo se ve `A'` para `A = [1 2; 3 4]`? Escribilo en un papel antes de correr el código y confirmá.

## Matrices especiales

```julia
zeros(2, 2)
ones(3, 3)
```

`zeros(f, c)` crea una matriz de `f` filas y `c` columnas llena de ceros, y `ones(f, c)` lo mismo pero llena de unos. Son útiles como punto de partida cuando vas a ir llenando una matriz de a poco, o para inicializar un cálculo.

La otra matriz especial que vas a usar seguido es la **identidad**, la que tiene unos en la diagonal y ceros en el resto, y que cumple `A * I == A` para cualquier `A` cuadrada (el equivalente matricial del número 1). En `LinearAlgebra` se accede con `I`:

```julia
using LinearAlgebra

A + I
```

`I` no es una matriz común, es un objeto especial (`UniformScaling`) que se adapta automáticamente al tamaño que necesite la operación: por eso `A + I` funciona sin que vos le digas de qué tamaño es la identidad, Julia lo deduce del tamaño de `A`.

Si en cambio necesitás la identidad como matriz concreta, por ejemplo para imprimirla o guardarla en una variable por separado, indicá el tamaño:

```julia
I(3)
Matrix{Float64}(I, 3, 3)
```

**Probá:** creá una matriz `A` de 2x2 cualquiera y confirmá que `A * I` da exactamente `A`.

## Antes de seguir

Sin mirar el archivo, en el REPL:

1. Creá dos vectores de 3 elementos (con comas) y calculá su producto punto.
2. Calculá la norma de uno de ellos.
3. Creá dos matrices 2x2 y calculá su suma y su producto matricial (`A * B`).
4. Creá una matriz 2x2 y mostrá su transpuesta.
5. Creá una matriz de ceros de 4x4.
6. Confirmá que `A * I` te devuelve la misma matriz `A`.
7. Escribí de nuevo `mi_dot` y `mi_norm` sin mirar el archivo, y confirmá que coinciden con `dot` y `norm`.

Si te trabaste en algún paso, volvé a la sección correspondiente antes de seguir. En la próxima lección vamos a usar todo esto para resolver sistemas de ecuaciones.

---

**Ejercicios de esta lección:** [exercises/05-vectores-y-matrices.jl](../exercises/05-vectores-y-matrices.jl)
**Próxima lección:** [06. Sistemas lineales](06-sistemas-lineales.md)
