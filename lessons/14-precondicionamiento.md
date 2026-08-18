# 14. Precondicionamiento

## Por qué esto importa

La velocidad de convergencia del gradiente conjugado depende del número de condición de `A` (lección 11): cuanto más grande, más lento converge. El precondicionamiento es una técnica para atacar ese problema sin cambiar la solución: transformar el sistema en uno equivalente con mejor número de condición, y resolver ese en su lugar.

```julia
using LinearAlgebra
```

## La idea

Si `M` es una matriz tal que `M ≈ inv(A)` (de alguna forma razonable, sin necesitar calcular la inversa exacta), entonces el sistema `M*A*x = M*b` tiene la misma solución que `A*x = b` (porque multiplicar ambos lados por `M`, que es invertible, no cambia la solución), pero `M*A` está más cerca de la identidad que `A`, y por lo tanto mejor condicionado.

## Un precondicionador simple: el de Jacobi

El precondicionador más simple posible es `M = inv(D)`, con `D` la parte diagonal de `A`. Es barato de calcular y de aplicar, y ayuda especialmente cuando los elementos de la diagonal de `A` tienen magnitudes muy distintas entre sí.

```julia
M = Diagonal(1.0 ./ diag(A))
```

`diag(A)` te da un vector con los elementos de la diagonal, y `Diagonal(...)` arma una matriz diagonal a partir de ese vector, sin necesidad de calcular una inversa completa.

## Gradiente conjugado precondicionado

La versión precondicionada del gradiente conjugado (lección 13) es casi idéntica a la original: la única diferencia es que en vez de trabajar directamente con el residuo `r`, usa `z = M*r` en los lugares clave.

```julia
function mi_gc_precondicionado(A, b, M, x0, tol, maxiter)
    # completar: es muy parecido a mi_gradiente_conjugado de la lección 13,
    # pero en vez de usar r directamente para la primera dirección y para
    # el cociente rho, usá z = M*r. Arrancá con x = x0, r = b - A*x,
    # z = M*r, rho = dot(r, z), d = copy(z). En cada vuelta: si norm(r) < tol,
    # devolvé x. Si no: w = A*d, alpha = rho / dot(d, w), x = x + alpha*d,
    # r = r - alpha*w, z = M*r, rho_old = rho, rho = dot(r, z),
    # beta = rho / rho_old, d = z + beta*d
end
```

**Verificalo:** armá una matriz sdp con número de condición alto, por ejemplo con elementos de la diagonal muy distintos entre sí:

```julia
n = 10
A = Matrix(Diagonal([1000.0 / i for i in 1:n]))
A .+= 0.1
A = (A + A') / 2
b = ones(n)
```

`A .+= 0.1` le suma `0.1` a cada elemento (para que la matriz no quede exactamente diagonal), y `(A + A') / 2` la simetriza. Confirmá con `cond(A)` que el número de condición es alto, y compará cuántas iteraciones necesita `mi_gradiente_conjugado(A, b, zeros(n), 1e-8, 100000)` contra `mi_gc_precondicionado(A, b, M, zeros(n), 1e-8, 100000)` con el precondicionador de Jacobi. La diferencia debería ser notable.

## Más allá de Jacobi

El precondicionador de Jacobi es el más simple, pero no siempre el más efectivo: solo corrige diferencias de escala entre las variables, no la estructura completa de `A`. Existen precondicionadores más sofisticados (factorizaciones de Cholesky incompletas, precondicionadores basados en la estructura del problema, como el multigrid que menciona el apunte de la materia) que logran mejoras mucho mayores, a costa de ser más elaborados de construir. Quedan fuera del alcance de esta guía, pero vale la pena saber que existen si en algún momento el precondicionador de Jacobi no alcanza.

## Antes de seguir

En el REPL, sin mirar el archivo:

1. Armá una matriz sdp con número de condición alto y calculá su `cond(A)`.
2. Construí el precondicionador de Jacobi `M = Diagonal(1.0 ./ diag(A))`.
3. Escribí de nuevo `mi_gc_precondicionado` y compará cuántas iteraciones necesita, con y sin precondicionador, para la misma tolerancia.

---

**Ejercicios de esta lección:** [exercises/14-precondicionamiento.jl](../exercises/14-precondicionamiento.jl)
**Próxima lección:** [15. GMRes: sistemas no simétricos](15-gmres.md)
