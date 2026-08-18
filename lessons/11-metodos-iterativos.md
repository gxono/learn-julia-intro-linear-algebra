# 11. Métodos iterativos: Jacobi y Gauss-Seidel

## Por qué esto importa

Los métodos directos (Gauss, LU, Cholesky) llegan a la solución exacta en un número finito de pasos, pero para matrices muy grandes y ralas (con muchos ceros), ese número de pasos puede ser carísimo, y además suele "rellenar" de números no nulos posiciones que en la matriz original eran cero. Los métodos iterativos, en cambio, generan una sucesión de aproximaciones que converge a la solución, y muchas veces alcanzan una precisión más que suficiente con muy pocas iteraciones, a un costo por iteración mucho menor. Esta lección cubre los dos métodos iterativos más básicos.

```julia
using LinearAlgebra
```

## Normas de vectores: 1, 2 e infinito

Ya usaste `norm(v)` para la norma euclídea (la de Pitágoras). Esa es la norma-2. Existen otras normas útiles:

```julia
v = [3.0, 4.0]
norm(v, 1)      # suma de los valores absolutos
norm(v, 2)      # la norma euclídea de siempre (equivalente a norm(v))
norm(v, Inf)    # el máximo valor absoluto
```

**Predecí:** para `v = [3.0, 4.0]`, calculá a mano `norm(v, 1)` (es `3 + 4`) y `norm(v, Inf)` (es el máximo entre `3` y `4`). Confirmalo.

## Normas de matrices

Para matrices, la norma inducida por una norma de vectores mide cuánto puede "estirar" esa matriz a un vector, en el peor caso. En Julia se calculan con `opnorm` (no con `norm`, que para matrices calcula otra cosa, la norma de Frobenius):

```julia
A = [1.0 2; 3 4]
opnorm(A, 1)      # el máximo de las sumas por columna
opnorm(A, Inf)    # el máximo de las sumas por fila
opnorm(A, 2)      # el valor singular máximo (la más costosa de calcular)
```

## Número de condición, revisitado

En la lección 07 usaste `cond(A)` sin entrar en detalle. Ahora que conocés las normas de matrices, la definición completa es:

```julia
κ(A) = opnorm(A) * opnorm(inv(A))
```

Se puede demostrar que si resolvés `Ax = b` con un error pequeño en `b` (por redondeo, por ejemplo), el error relativo en la solución `x` queda acotado por el error relativo en `b`, multiplicado por `κ(A)`. Por eso un número de condición grande es una señal de alerta: amplifica los errores inevitables de la aritmética de punto flotante.

## Métodos iterativos estacionarios

La idea general: dada `Ax = b`, se separa `A = L + D + U` (parte triangular inferior estricta, diagonal, parte triangular superior estricta) y se arma una iteración de la forma `x_{k+1} = M*x_k + c`, elegida de manera que si converge, converge justo a la solución de `Ax = b`.

### Método de Jacobi

En cada componente, despejás `x_i` de la ecuación `i` usando los valores de la iteración *anterior* para el resto:

```julia
function mi_jacobi(A, b, x0, tol, maxiter)
    # completar: repetí hasta maxiter veces (o hasta converger). En cada
    # vuelta, para cada i, calculá un xnuevo[i] = (b[i] - suma de A[i,j]*x[j]
    # para todo j != i) / A[i,i], usando siempre los x de la vuelta ANTERIOR.
    # Cuando la diferencia entre xnuevo y x (norm(., Inf)) sea menor que tol,
    # devolvé xnuevo y listo
end
```

**Verificalo:** con una matriz `A` de 3x3 (por ejemplo `[4.0 1 1; 1 5 1; 1 1 6]`) y `b = [6.0, 7, 8]`, corré `x, k = mi_jacobi(A, b, zeros(3), 1e-8, 1000)` y confirmá que `x ≈ A \ b`.

### Método de Gauss-Seidel

Es casi lo mismo que Jacobi, con una diferencia: en vez de esperar a la vuelta completa para usar los valores nuevos, usás cada componente recién calculada inmediatamente para las siguientes de la misma vuelta. Intuitivamente, si el método converge, un valor recién calculado ya es mejor aproximación que el de la vuelta anterior, así que tiene sentido usarlo cuanto antes.

```julia
function mi_gauss_seidel(A, b, x0, tol, maxiter)
    # completar: es casi igual a mi_jacobi, con una diferencia clave: en vez
    # de guardar los resultados nuevos aparte (en un xnuevo) y recién
    # reemplazar x al final de la vuelta, actualizá x[i] directamente apenas
    # lo calculás, para que las componentes siguientes de la misma vuelta ya
    # usen ese valor nuevo
end
```

**Comparalo:** corré `mi_gauss_seidel` con los mismos `A`, `b` que usaste para Jacobi, y compará cuántas iteraciones (`k`) necesitó cada uno para llegar a la misma tolerancia. Para matrices con buenas propiedades de convergencia, Gauss-Seidel suele necesitar menos.

## Cuándo convergen

Ninguno de los dos métodos converge siempre. Una condición suficiente simple es que `A` sea **estrictamente diagonalmente dominante** (edd): que en cada fila, el valor absoluto del elemento de la diagonal sea mayor que la suma de los valores absolutos del resto de la fila.

```julia
function es_edd(A)
    # completar: para cada fila i, sumá los valores absolutos de todos los
    # elementos de esa fila salvo el de la diagonal, y compará esa suma
    # contra abs(A[i,i]). Si en alguna fila la diagonal no gana, devolvé
    # false; si ninguna falla, devolvé true
end
```

Si `A` es edd, tanto Jacobi como Gauss-Seidel convergen a la solución correcta a partir de cualquier aproximación inicial. La matriz que usaste arriba, `[4.0 1 1; 1 5 1; 1 1 6]`, es edd (cada elemento de la diagonal es mayor que la suma de los otros dos de su fila).

## Antes de seguir

En el REPL, sin mirar el archivo:

1. Calculá `norm(v, 1)`, `norm(v, 2)` y `norm(v, Inf)` para un vector propio, y confirmá a mano el resultado de cada una.
2. Escribí de nuevo `es_edd` y verificá que la matriz `[4.0 1 1; 1 5 1; 1 1 6]` es edd.
3. Escribí de nuevo `mi_jacobi` y `mi_gauss_seidel`, resolvé el mismo sistema con ambos, y compará cuántas iteraciones necesitó cada uno.

---

**Ejercicios de esta lección:** [exercises/11-metodos-iterativos.jl](../exercises/11-metodos-iterativos.jl)
**Próxima lección:** [12. Autovalores numéricos: método de las potencias y potencias inversas](12-autovalores-numericos.md)
