# 13. Métodos de descenso: descenso más pronunciado y gradiente conjugado

## Por qué esto importa

Jacobi y Gauss-Seidel (lección 11) son simples, pero su velocidad de convergencia depende de tener una matriz con una estructura favorable (como ser edd), y no siempre son rápidos. Para matrices sdp existe otra familia de métodos iterativos, basada en una idea distinta: convertir "resolver `Ax = b`" en "minimizar una función", y moverse paso a paso hacia ese mínimo. El más importante de esta familia, y uno de los más usados en la práctica para sistemas sdp grandes, es el **gradiente conjugado**.

```julia
using LinearAlgebra
```

## De resolver un sistema a minimizar una función

Si `A` es sdp, resolver `Ax = b` es exactamente lo mismo que encontrar el mínimo de la función

```
φ(x) = (1/2) xᵀAx - xᵀb
```

(esto se puede demostrar, no lo vamos a hacer acá). El gradiente de `φ` es `∇φ(x) = Ax - b`, que es exactamente el opuesto del residuo `r = b - Ax`. Es decir: el residuo apunta en la dirección en la que `φ` decrece más rápido en ese punto. Esta es la idea que van a explotar los dos métodos de esta lección.

## Descenso más pronunciado (steepest descent)

La idea más simple: en cada paso, movete en la dirección del residuo (la de mayor descenso), con un tamaño de paso `α` elegido para minimizar `φ` exactamente en esa dirección. Se puede demostrar que ese `α` óptimo es `dot(r,r) / dot(r, A*r)`.

```julia
function mi_descenso(A, b, x0, tol, maxiter)
    # completar: arrancá con x = x0 y r = b - A*x. En cada vuelta (hasta
    # maxiter): si norm(r) < tol, devolvé x y listo. Si no, calculá
    # alpha = dot(r,r) / dot(r, A*r), actualizá x = x + alpha*r,
    # y recalculá r = b - A*x para la próxima vuelta
end
```

**Verificalo:** con `A = [4.0 1; 1 3]` (sdp) y `b = [1.0, 2]`, corré `x, k = mi_descenso(A, b, zeros(2), 1e-10, 10000)` y confirmá que `x ≈ A \ b`.

El problema de este método: si las curvas de nivel de `φ` son muy alargadas (lo cual pasa cuando el número de condición de `A` es grande), el descenso más pronunciado va en zigzag y tarda muchas vueltas en llegar. Ahí es donde entra el gradiente conjugado.

## Gradiente conjugado

En vez de usar siempre la dirección del residuo, el gradiente conjugado elige direcciones de búsqueda "A-ortogonales" entre sí (`dot(di, A*dj) == 0` para `i ≠ j`), lo que evita el zigzagueo. La consecuencia teórica más notable: en aritmética exacta, converge a la solución exacta en a lo sumo `n` pasos (`n` = tamaño del sistema), aunque en la práctica se usa como método iterativo, deteniéndolo mucho antes con una tolerancia.

```julia
function mi_gradiente_conjugado(A, b, x0, tol, maxiter)
    # completar: arrancá con x = x0, r = b - A*x, d = copy(r), y
    # rho = dot(r, r). En cada vuelta (hasta maxiter): si sqrt(rho) < tol,
    # devolvé x. Si no: calculá w = A*d, alpha = rho / dot(d, w), actualizá
    # x = x + alpha*d y r = r - alpha*w. Guardá rho_old = rho, recalculá
    # rho = dot(r, r), calculá beta = rho / rho_old, y actualizá
    # d = r + beta*d para la próxima vuelta
end
```

**Verificalo:** con el mismo `A` y `b` de arriba, corré `mi_gradiente_conjugado(A, b, zeros(2), 1e-10, 10000)` y compará cuántas iteraciones necesitó contra `mi_descenso`. Para un sistema de 2x2, el gradiente conjugado debería resolverlo en apenas 2 o 3 vueltas.

**Investigá:** armá una matriz sdp de 3x3 y confirmá que `mi_gradiente_conjugado` converge en a lo sumo 3 o 4 vueltas, sin importar el punto de partida.

## Antes de seguir

En el REPL, sin mirar el archivo:

1. Escribí de nuevo `mi_descenso` y `mi_gradiente_conjugado`.
2. Resolvé el mismo sistema sdp con ambos y compará cuántas iteraciones necesitó cada uno.
3. Pensá qué tienen en común `mi_descenso`, `mi_gradiente_conjugado` y `mi_jacobi`/`mi_gauss_seidel` de la lección 11 (todos arrancan de una aproximación y la van corrigiendo), y qué los distingue (la forma de elegir la dirección de corrección en cada paso).

---

**Ejercicios de esta lección:** [exercises/13-metodos-de-descenso.jl](../exercises/13-metodos-de-descenso.jl)
**Próxima lección:** [14. Precondicionamiento](14-precondicionamiento.md)
