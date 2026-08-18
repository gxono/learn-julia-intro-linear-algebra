# 15. GMRes: sistemas no simétricos

## Por qué esto importa

El gradiente conjugado (lección 13) necesita que `A` sea simétrica y definida positiva. ¿Qué hacés si tu sistema no es simétrico? Ahí entra **GMRes** (Generalized Minimum Residual), un método basado en la misma idea de subespacios de Krylov que ya usaste, pero que funciona para cualquier matriz no singular.

```julia
using LinearAlgebra
```

## La idea: minimizar el residuo sobre un subespacio de Krylov

En cada paso `k`, GMRes busca, dentro de un espacio generado por `r0, A*r0, A^2*r0, ..., A^(k-1)*r0` (el espacio de Krylov, el mismo tipo de espacio que usa el gradiente conjugado), el `x` que hace `norm(b - A*x)` lo más chico posible. Para poder resolver ese problema de mínimos cuadrados de forma práctica, hace falta una base ortonormal de ese espacio, que se construye con el **proceso de Arnoldi**.

## El proceso de Arnoldi

Es Gram-Schmidt (lección 10) aplicado a los vectores de Krylov: en vez de ortogonalizar las columnas de una matriz que ya tenés armada de antemano, en cada paso generás el vector siguiente multiplicando el último por `A`, y lo ortogonalizás contra todos los anteriores, igual que hacías columna por columna en `mi_gram_schmidt`.

Aplicado paso a paso, el proceso de Arnoldi va llenando una matriz `V` (con las columnas ortonormales del espacio de Krylov) y una matriz `H` (que guarda los coeficientes de cada ortogonalización), de manera que `A*V ≈ V*H`, con `H` casi triangular (una forma llamada Hessenberg).

## Ejemplo resuelto: GMRes completo

Ensamblar Arnoldi con la resolución del problema de mínimos cuadrados en cada paso es más largo que los algoritmos anteriores, así que acá tenés una implementación completa, a modo de ejemplo resuelto, para que veas cómo se arma todo el algoritmo:

```julia
function mi_gmres(A, b, x0, tol, kmax)
    n = length(b)
    r0 = b - A * x0
    beta = norm(r0)
    rho = beta
    V = zeros(n, kmax + 1)
    V[:, 1] = r0 / beta
    H = zeros(kmax + 1, kmax)
    k = 0
    y = zeros(0)
    while rho > tol * norm(b) && k < kmax
        k += 1
        w = A * V[:, k]
        for j in 1:k
            H[j, k] = dot(w, V[:, j])
            w -= H[j, k] * V[:, j]
        end
        H[k+1, k] = norm(w)
        V[:, k+1] = w / H[k+1, k]

        e1 = zeros(k + 1)
        e1[1] = beta
        y = H[1:k+1, 1:k] \ e1
        rho = norm(H[1:k+1, 1:k] * y - e1)
    end
    x = x0 + V[:, 1:k] * y
    return x, k
end
```

Fijate el patrón: cada vuelta del `while` agrega una columna a `V` (el paso de Arnoldi que acabás de ver, adentro del `for`), va armando la matriz Hessenberg `H` a partir de los coeficientes que guarda, y resuelve un problema de mínimos cuadrados chico (de tamaño `k`, no `n`) con `\` para encontrar la mejor combinación de esas columnas. El apunte de la materia señala que esto es válido en la práctica porque `k` suele ser mucho más chico que `n`.

**Probalo:** con una matriz `A` que **no** sea simétrica, por ejemplo `A = [4.0 1 0; 2 5 1; 0 1 3]` y un `b` cualquiera, corré `x, k = mi_gmres(A, b, zeros(3), 1e-10, 100)` y confirmá que `x` da (aproximadamente) lo mismo que `A \ b`. Podés confirmar que `A` no es simétrica con `issymmetric(A)`.

## Ahora te toca: experimentá con GMRes

En vez de reimplementar `mi_gmres` desde cero (ya viste la implementación completa arriba), el ejercicio de esta lección es aplicarlo y ponerlo a prueba vos misma: probalo con distintos sistemas no simétricos, comparando siempre contra `A \ b`, y fijate cómo cambia la cantidad de iteraciones `k` según el tamaño y la forma de la matriz. La teoría dice que GMRes encuentra la solución exacta en a lo sumo `n` pasos (para un sistema de `n x n`); confirmalo con algún ejemplo.

## Más allá de esta guía

`LinearAlgebra` (la librería estándar que venís usando en toda la guía) no incluye GMRes ni gradiente conjugado: son parte de paquetes externos como `IterativeSolvers.jl` o `Krylov.jl`, pensados específicamente para sistemas grandes y ralos donde estos métodos son la opción práctica. No hace falta instalarlos para seguir esta guía, pero vale la pena saber que existen para cuando trabajes con sistemas más grandes que los que viste acá.

## Referencia rápida: lecciones 09 a 15

| Lección | Tema | Función propia | Función de la librería |
|---|---|---|---|
| 09 | Métodos directos | `mi_triinf`, `mi_trisup`, `mi_lu`, `mi_cholesky` | `lu(A)`, `cholesky(A)` |
| 10 | Factorización QR | `mi_gram_schmidt` | `qr(A)` |
| 11 | Métodos iterativos | `es_edd`, `mi_jacobi`, `mi_gauss_seidel` | `norm(v, p)`, `opnorm(A, p)`, `cond(A)` |
| 12 | Autovalores | `mi_metodo_potencias`, `mi_potencias_inversas` | `eigvals(A)`, `eigvecs(A)` |
| 13 | Métodos de descenso | `mi_descenso`, `mi_gradiente_conjugado` | (no hay en `LinearAlgebra`) |
| 14 | Precondicionamiento | `mi_gc_precondicionado` | (no hay en `LinearAlgebra`) |
| 15 | GMRes | `mi_gmres` | (no hay en `LinearAlgebra`, ver `IterativeSolvers.jl`/`Krylov.jl`) |

## Antes de seguir

En el REPL, sin mirar el archivo:

1. Planteá un sistema no simétrico de 4x4 o 5x5.
2. Resolvelo con `mi_gmres` y con `A \ b`, y confirmá que coinciden.
3. Contá en cuántas iteraciones convergió, y compará con el tamaño del sistema.

---

**Ejercicios de esta lección:** [exercises/15-gmres.jl](../exercises/15-gmres.jl)
**Volver al índice:** [README](../README.md)
