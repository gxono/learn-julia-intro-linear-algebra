# 06. Sistemas lineales

## Por qué esto importa

Resolver sistemas de ecuaciones es probablemente la razón principal por la que estás aprendiendo esto. Un sistema como

```
2x + y = 5
x - y = 1
```

se puede escribir en forma matricial como `Ax = b`, con

```
A = [2 1; 1 -1]
b = [5, 1]
```

y `x` es el vector de incógnitas que buscamos. Julia resuelve esto con una sola operación.

## Resolver un sistema

```julia
A = [2 1; 1 -1]
b = [5, 1]

x = A \ b
println(x)
```

La barra invertida `\` significa "encontrá el `x` tal que `A*x` sea `b`". Aunque se parezca a una división, acá es notación específica de álgebra lineal para resolver el sistema.

**Investigá:** verificá el resultado multiplicando `A` por la `x` que obtuviste, y compará con `b`.

```julia
println(A * x)
```

Si `x` es correcto, esto te debería devolver (aproximadamente) el mismo vector que `b`. Este chequeo, resolver y después verificar multiplicando de vuelta, es un hábito útil para cualquier cálculo numérico: te avisa si algo salió mal antes de seguir usando el resultado.

## Otro ejemplo

```julia
A = [1 2; 3 4]
b = [5, 11]

x = A \ b
println(x)
```

**Probá:** aplicá el mismo chequeo de arriba (`A * x` comparado con `b`) a este segundo sistema.

## Determinante

Para `det` e `inv` hace falta el paquete `LinearAlgebra` (si venís de la lección anterior y no cerraste el REPL, ya lo tenés cargado):

```julia
using LinearAlgebra

det(A)
```

El determinante te dice algo importante antes incluso de intentar resolver el sistema: si `det(A)` es cero, la matriz es singular y el sistema no tiene una solución única (puede no tener ninguna, o tener infinitas). Si vas a resolver muchos sistemas con la misma matriz, revisar el determinante primero es una buena costumbre.

**Investigá:** mirá qué pasa en la práctica si intentás resolver un sistema con una matriz singular:

```julia
A_singular = [1 2; 2 4]
println(det(A_singular))

A_singular \ [1, 2]
```

`det(A_singular)` da `0.0` (la segunda fila es exactamente el doble de la primera, así que no aportan información independiente). Al intentar resolverlo con `\`, Julia no te devuelve un resultado incorrecto en silencio: tira un error, `SingularException`. Es preferible a que el cálculo siga adelante con un resultado sin sentido.

### Implementá tu propio determinante (2x2)

Para una matriz 2x2, el determinante tiene una fórmula directa que seguramente ya conocés de álgebra: el producto de los elementos de la diagonal principal, menos el producto de los elementos de la diagonal secundaria.

```julia
function mi_det_2x2(A)
    # completar: usá A[1,1], A[1,2], A[2,1] y A[2,2]
end
```

**Verificalo:** una vez que la completes, corré `mi_det_2x2(A) == det(A)` con la `A` que ya tenías. Fijate que esta fórmula solo vale para matrices 2x2; `det` de la librería funciona para cualquier tamaño, usando un método distinto por dentro.

## Inversa

```julia
inv(A)
```

Calcula la matriz inversa de `A`. Con ella también podrías resolver el sistema como `x = inv(A) * b`, pero en la práctica conviene usar `A \ b` directamente: es más preciso numéricamente y no necesita calcular la inversa completa para llegar al resultado.

### Desafío opcional: resolvé un sistema 2x2 con la regla de Cramer

`A \ b` usa por dentro un método numérico general. Para sistemas 2x2 chicos, la regla de Cramer te da otra forma de llegar al mismo resultado, reemplazando una columna de `A` por `b` y usando `mi_det_2x2`:

```julia
function mi_resolver_2x2(A, b)
    # completar: usá mi_det_2x2 sobre A, y sobre A con una columna
    # reemplazada por b (una vez por cada columna)
end
```

La idea de la regla de Cramer: si armás `Ax` como `A` con la primera columna reemplazada por `b`, y `Ay` con la segunda, el cociente entre el determinante de cada una y el determinante de `A` te da la componente correspondiente de la solución.

**Verificalo:** corré `mi_resolver_2x2(A, b) ≈ A \ b` (el `≈`, que se escribe con `\approx` y tab en el REPL, compara con una tolerancia chica para redondeos de punto flotante, en vez de exigir igualdad exacta).

## Antes de seguir

En el REPL, sin mirar el archivo:

1. Definí una matriz `A` de 2x2 y un vector `b` de 2 elementos, inventados por vos.
2. Resolvé el sistema con `A \ b`.
3. Verificá el resultado multiplicando `A * x` y comparando con `b`.
4. Calculá `det(A)` antes de resolver la próxima vez, y pensá qué significaría si te diera 0.
5. Escribí de nuevo `mi_det_2x2` sin mirar el archivo, y confirmá que coincide con `det`.

---

**Ejercicios de esta lección:** [exercises/06-sistemas-lineales.jl](../exercises/06-sistemas-lineales.jl)
**Próxima lección:** [07. Fundamentos de LinearAlgebra](07-linearalgebra-fundamentos.md)
