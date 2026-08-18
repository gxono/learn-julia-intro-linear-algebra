# 12. Autovalores numéricos: método de las potencias y potencias inversas

## Por qué esto importa

En la lección 07 usaste `eigvals` y `eigvecs` como cajas negras. Vale la pena saber qué hay adentro: a diferencia de casos como `det` o `tr`, que tienen fórmulas cerradas, calcular autovalores en general **no** tiene una fórmula finita, ni siquiera en teoría (para matrices de 5x5 o más, ni existe una fórmula algebraica posible). Por eso todo método para autovalores es necesariamente iterativo. Esta lección muestra el más simple de todos: el método de las potencias.

```julia
using LinearAlgebra
```

## La idea central

Si multiplicás repetidamente un vector cualquiera por `A`, la dirección del resultado tiende a alinearse con la dirección del autovector correspondiente al autovalor de mayor módulo (el "autovalor dominante"). Intuitivamente: cada autovector se estira en cada multiplicación por un factor igual a su autovalor, así que el que tiene el autovalor más grande en módulo termina dominando a los demás después de muchas multiplicaciones.

Para que el vector no crezca (o se achique) sin límite, se normaliza en cada paso.

### Implementá tu propio método de las potencias

```julia
function mi_metodo_potencias(A, u0, tol, maxiter)
    # completar: normalizá u0 para arrancar. En cada vuelta (hasta maxiter):
    # multiplicá u por A, normalizá el resultado para obtener el nuevo u,
    # y estimá el autovalor con el cociente de Rayleigh, u'*A*u. Cuando la
    # diferencia entre esa estimación y la de la vuelta anterior sea menor
    # que tol, devolvé el autovalor, el autovector u, y en cuántas vueltas
    # se llegó
end
```

Cada iteración hace `u = A*u` (normalizado), y estima el autovalor con el **cociente de Rayleigh** `u'*A*u` (que para `u` normalizado da la mejor aproximación posible del autovalor asociado a esa dirección).

**Verificalo:** con `A = [2.0 1; 1 3]`, corré `lambda, u, k = mi_metodo_potencias(A, [1.0, 0.0], 1e-10, 1000)` y compará `lambda` con `maximum(eigvals(A))`. También podés comparar `u` (en valor absoluto, porque el signo del autovector no está determinado) con la columna correspondiente de `eigvecs(A)`.

## Cuándo funciona y cuándo no

El método de las potencias tiene limitaciones importantes, que vale la pena conocer antes de confiar en él:

- Solo converge a un autovalor **dominante**, es decir, uno cuyo módulo sea estrictamente mayor que el de todos los demás. Si dos autovalores empatan en módulo máximo (por ejemplo, autovalores complejos conjugados de una matriz real), el método no converge a nada en particular.
- La velocidad de convergencia depende del cociente entre el segundo autovalor y el dominante, `|λ2/λ1|`: cuanto más parecidos sean en módulo, más lento converge.
- Por eso, en la práctica, el método de las potencias no se usa como algoritmo general para hallar todos los autovalores. Sirve para casos puntuales donde te interesa específicamente el autovalor dominante y sabés que está bien separado del resto.

## Método de las potencias inversas

Una variante: en vez de multiplicar por `A`, se multiplica por `(A - μI)⁻¹` para algún número `μ` cercano a un autovalor que te interese (no necesariamente el dominante). Esto hace que el autovalor "dominante" de la matriz transformada sea el más cercano a `μ`, así que el método converge hacia ese autovalor en particular, no solo al de módulo máximo. La desventaja es que hay que resolver un sistema lineal en cada paso, pero si ya tenés `μ` cerca del autovalor buscado, la convergencia puede ser muy rápida.

### Implementá tu propio método de las potencias inversas

Es prácticamente el mismo algoritmo que `mi_metodo_potencias`, cambiando la multiplicación por `A` por resolver un sistema con `A - μI`.

```julia
function mi_potencias_inversas(A, u0, mu, tol, maxiter)
    # completar: normalizá u0 para arrancar. En cada vuelta (hasta maxiter):
    # en vez de multiplicar por A, resolvé el sistema v = (A - mu*I) \ u
    # (mu*I usa la identidad de LinearAlgebra, se adapta al tamaño de A).
    # Normalizá v para obtener el nuevo u. Estimá el autovalor con
    # lambda = 1 / dot(u, v) + mu. Cuando la diferencia entre esa
    # estimación y la de la vuelta anterior sea menor que tol, devolvé
    # el autovalor, el autovector u, y en cuántas vueltas se llegó
end
```

La fórmula del autovalor sale de invertir la relación: si `v` es (aproximadamente) un autovector de `(A - μI)⁻¹` con autovalor `1/(λ - μ)`, despejando `λ` se obtiene `λ = 1/(uᵀv) + μ`, con `u` el autovector normalizado de la vuelta anterior.

**Verificalo:** con `A = [2.0 1; 1 3]` (autovalores aproximadamente `1.38` y `3.62`, confirmalo con `eigvals(A)`), probá apuntar al autovalor más chico con un `μ` cercano a él, por ejemplo `mi_potencias_inversas(A, [1.0, 0.0], 1.3, 1e-10, 1000)`. Fijate que el resultado se acerca a `1.38`, no a `3.62` como hacía `mi_metodo_potencias` sin importar el punto de partida.

**Investigá:** probá con otro valor de `μ`, esta vez cercano al autovalor más grande, y confirmá que ahora converge a ese otro autovalor. El valor de `μ` es lo que decide a cuál converge, no la matriz `A` sola.

## Lo que hace `eigvals` en realidad

Ni el método de las potencias ni el de las potencias inversas son lo que usa `eigvals` por defecto: internamente, Julia usa el **algoritmo QR** para autovalores, que itera factorizando la matriz como `A = QR` y recomponiéndola como `RQ`, repetidamente. Se puede demostrar que esta sucesión converge a una matriz triangular con los autovalores en la diagonal. La demostración y la implementación eficiente (que primero lleva la matriz a una forma casi triangular, llamada Hessenberg, para abaratar cada paso) quedan fuera del alcance de esta guía, pero ahora sabés que `eigvals(A)` no es magia: es una versión mucho más refinada de la misma idea de ir aplicando factorizaciones QR repetidamente que ya conocés de la lección 10.

## Antes de seguir

En el REPL, sin mirar el archivo:

1. Escribí de nuevo `mi_metodo_potencias` y probala con una matriz 2x2 o 3x3 de la que conozcas los autovalores.
2. Compará el resultado con `eigvals` y `eigvecs`.
3. Pensá (o probá) qué pasaría si le dieras a `mi_metodo_potencias` una matriz cuyos dos autovalores más grandes tengan el mismo módulo. ¿Converge?
4. Escribí de nuevo `mi_potencias_inversas` y probala con dos valores de `μ` distintos sobre la misma matriz, confirmando que cada uno converge al autovalor más cercano a ese `μ`.

---

**Ejercicios de esta lección:** [exercises/12-autovalores-numericos.jl](../exercises/12-autovalores-numericos.jl)
**Próxima lección:** [13. Métodos de descenso: descenso más pronunciado y gradiente conjugado](13-metodos-de-descenso.md)
