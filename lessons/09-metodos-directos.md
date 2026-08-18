# 09. Métodos directos: LU, pivoteo y Cholesky

## Por qué esto importa

Hasta acá resolviste sistemas con `A \ b` sin preguntarte qué hace Julia por dentro. Por dentro, básicamente hace lo mismo que el método de eliminación de Gauss que probablemente ya conocés: transforma el sistema en uno triangular y lo resuelve por sustitución. Esta lección abre esa caja negra: vas a ver cómo se resuelven los sistemas triangulares, cómo eliminación de Gauss se puede empaquetar como una factorización `A = LU` que se reutiliza para varios `b`, por qué a veces hace falta pivotear, y un caso especial (matrices simétricas y definidas positivas) que se resuelve más barato con la factorización de Cholesky.

```julia
using LinearAlgebra
```

## Sistemas triangulares: sustitución hacia adelante

Si `L` es triangular inferior (`L[i,j] = 0` para `j > i`) con diagonal no nula, resolver `Lx = b` es directo: la primera ecuación tiene una sola incógnita, la despejás, y la usás para la segunda, y así siguiendo.

```julia
L = [2.0 0 0; 1 3 0; 4 2 5]
b = [4.0, 10, 24]
```

### Implementá tu propia sustitución hacia adelante

```julia
function mi_triinf(L, b)
    # completar: recorré las filas i de 1 a n. Para cada una, restale a
    # b[i] lo que ya aportan las incógnitas anteriores (x[1] a x[i-1],
    # que ya calculaste) y dividí por L[i,i] para despejar x[i]
end
```

**Verificalo:** corré `mi_triinf(L, b) ≈ L \ b`.

### Desafío opcional: sustitución hacia atrás

Para `U` triangular superior, el mismo razonamiento funciona empezando por la última fila. Implementá `mi_trisup(U, b)` recorriendo `i` de `n` hacia `1`, y verificá contra `U \ b`.

## Factorización LU

La eliminación de Gauss, en cada paso, resta a las filas de abajo un múltiplo de la fila del pivote para hacer ceros. Si guardás esos multiplicadores en vez de descartarlos, obtenés dos matrices `L` (triangular inferior, con la diagonal en unos) y `U` (triangular superior, lo que queda después de eliminar) tales que `A = LU`.

```julia
function mi_lu(A)
    # completar: arrancá con L = matriz identidad de n x n (Matrix{Float64}(I, n, n))
    # y U = una copia de A. Recorré las columnas j de 1 a n-1, y para cada
    # fila i debajo de la diagonal: guardá el multiplicador L[i,j] = U[i,j]/U[j,j],
    # y restale a la fila i de U ese multiplicador por la fila j de U
end
```

`L[i,j]` es el multiplicador que usaste para hacer cero la posición `(i,j)`, y queda guardado justo ahí en vez de perderse.

**Verificalo:** con `A = [4.0 3 2; 6 3 5; 2 1 1]`, corré `L, U = mi_lu(A)` y confirmá que `L*U ≈ A`.

La ventaja de tener `A = LU` por separado aparece cuando necesitás resolver el sistema con la misma `A` pero varios `b` distintos: factorizás una sola vez, y cada resolución adicional es apenas dos sustituciones (mucho más barato que repetir Gauss entero). En Julia, la función de la librería para factorizar es `lu`:

```julia
F = lu(A)
F.L
F.U
F.p
```

Y ahora podés resolver usando directamente `\` sobre `F.L` y `F.U` (que al ser triangulares, `\` los resuelve por sustitución en vez de repetir Gauss):

```julia
y = F.L \ b
x = F.U \ y
```

Esto resuelve `Ax = b` en dos pasos, porque `Ax = b` es lo mismo que `L(Ux) = b`: primero resolvés `Ly = b`, después `Ux = y`. Es exactamente lo mismo que hace `mi_triinf` para el primer paso; para el segundo hace falta una sustitución hacia atrás, que es lo que pide el desafío opcional de más arriba.

## Pivoteo

`mi_lu` de arriba tiene un problema: si en algún paso el pivote `U[j,j]` da cero, divide por cero y todo se rompe. Peor aún, hay matrices que ni siquiera tienen factorización `LU` sin reordenar filas:

```julia
A0 = [0.0 1; 1 1]
```

**Investigá:** probá `mi_lu(A0)` y mirá qué pasa (pista: vas a dividir por `U[1,1] = 0`). El problema no es un bug de tu implementación, es que esta matriz específica no tiene factorización `LU` tal cual, sin importar cómo la calcules.

La solución es el *pivoteo*: en cada paso, antes de eliminar, intercambiar la fila del pivote por la fila de abajo que tenga el valor más grande en esa columna. Esto evita dividir por cero y además, como bonus, divide siempre por el número más grande posible, lo que reduce errores de redondeo. Por eso, `lu` de Julia pivotea por defecto:

```julia
lu(A0)
```

Esto sí funciona, porque Julia reordena las filas antes de eliminar (por eso `F.p` en la sección anterior: es el registro de qué filas se intercambiaron). Si quisieras forzar a Julia a *no* pivotear, para reproducir el error a propósito, existe `lu(A0, NoPivot())`.

## Factorización de Cholesky. Matrices sdp

Una matriz `A` es **simétrica y definida positiva** (sdp) si `A == A'` y `x'Ax > 0` para todo `x ≠ 0`. Este tipo de matrices aparece todo el tiempo en problemas numéricos (por ejemplo, `A'A` siempre es sdp si las columnas de `A` son independientes), y tiene una propiedad especial: se puede factorizar como `A = R'R`, con `R` triangular superior. A esto se lo llama **factorización de Cholesky**, y es aproximadamente la mitad de costosa que una `LU` genérica, porque aprovecha la simetría.

```julia
Asdp = [4.0 2 0; 2 3 1; 0 1 2]
```

### Implementá tu propia factorización de Cholesky

```julia
function mi_cholesky(A)
    # completar: es parecido a mi_lu, pero en vez de guardar multiplicadores
    # separados en L, vas armando una única R triangular superior tal que
    # R'R = A. Para cada fila i (de 1 a n): R[i,i] es la raíz cuadrada de
    # lo que queda en la posición (i,i) después de restar el aporte de las
    # filas anteriores de R; el resto de la fila i de R sale de dividir por
    # R[i,i]. Trabajá sobre una copia de A para no pisar la matriz original
end
```

**Verificalo:** corré `R = mi_cholesky(Asdp)` y confirmá que `R'*R ≈ Asdp`.

En Julia, la función de la librería es `cholesky`, y el factor `R` se obtiene con `.U`:

```julia
C = cholesky(Asdp)
C.U
```

## Antes de seguir

En el REPL, sin mirar el archivo:

1. Escribí de nuevo `mi_triinf` y verificala contra `L \ b`.
2. Factorizá una matriz 3x3 con `mi_lu` y confirmá que `L*U` reconstruye la matriz original.
3. Probá `mi_lu` sobre `[0.0 1; 1 1]` y confirmá que falla por división por cero.
4. Factorizá una matriz sdp 3x3 con `mi_cholesky` y confirmá que `R'*R` reconstruye la matriz original.

---

**Ejercicios de esta lección:** [exercises/09-metodos-directos.jl](../exercises/09-metodos-directos.jl)
**Próxima lección:** [10. Factorización QR: Gram-Schmidt y Householder](10-factorizacion-qr.md)
