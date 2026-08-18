# 07. Fundamentos de LinearAlgebra

## Por qué esto importa

Esta lección junta las herramientas de `LinearAlgebra` que vas a usar todo el tiempo al trabajar con matrices: rango, traza, autovalores, autovectores, número de condición y factorizaciones. Ya usaste `dot`, `norm`, `det` e `inv` en las lecciones anteriores, así que el resto de esta lección te va a resultar familiar en la forma, aunque las funciones sean nuevas.

```julia
using LinearAlgebra
```

## Rango: cuántas filas o columnas son realmente independientes

```julia
A = [1 2; 2 4]
rank(A)
```

El rango te dice cuántas filas (o columnas) de la matriz aportan información realmente nueva. En este ejemplo, la segunda fila es exactamente el doble de la primera, así que no suma nada independiente: el rango es `1`, aunque la matriz sea 2x2. Es la misma matriz singular que viste en la lección anterior, y `rank(A) < tamaño de A` es otra forma de detectar ese problema.

**Verificalo vos:** calculá `rank` de una matriz cualquiera con filas independientes, como `[1 2; 3 4]`, y confirmá que te da `2`.

## Traza: la suma de la diagonal

```julia
A = [2 0; 0 3]
tr(A)
```

La traza suma los elementos de la diagonal principal (de arriba a la izquierda hacia abajo a la derecha). Para esta matriz, `tr(A)` es `2 + 3 = 5`.

**Verificalo vos:** antes de correrlo, sumá a mano los elementos de la diagonal y confirmá que coincide.

### Implementá tu propia traza

```julia
function mi_tr(A)
    # completar: usá size(A) y un for que recorra A[i, i] para cada i
end
```

Pista: `A[i, i]` recorre la diagonal, fila `i`, columna `i`, para cada `i` desde `1` hasta el tamaño de la matriz.

**Verificalo:** corré `mi_tr(A) == tr(A)`.

## Autovalores

```julia
println(eigvals(A))
```

Como `A` es diagonal, sus autovalores son directamente los números de la diagonal: `2.0` y `3.0`. Esto pasa por una propiedad de las matrices diagonales, y sirve como forma rápida de verificar que estás usando bien la función antes de aplicarla a matrices menos obvias.

## Autovectores

```julia
println(eigvecs(A))
```

Para esta misma matriz diagonal, los autovectores son los vectores de la base estándar, `[1, 0]` y `[0, 1]`. Cada columna de lo que devuelve `eigvecs` corresponde a un autovalor de `eigvals`, en el mismo orden.

A diferencia de `dot`, `norm`, `tr` o `det` de una matriz 2x2, calcular autovalores no tiene una fórmula corta para implementar a mano en general: los métodos reales (como el algoritmo QR iterativo) son justamente uno de los temas centrales de un curso de álgebra lineal numérica, y por eso acá los usamos de la librería en vez de reimplementarlos.

## Factorización QR

```julia
A2 = [4 1; 1 3]
F = qr(A2)
```

Una factorización descompone una matriz en un producto de matrices más simples, con propiedades útiles para resolver problemas numéricos. `qr` descompone `A2` en una matriz ortogonal `Q` y una triangular superior `R`, de forma que `Q * R` reconstruye `A2`.

Si imprimís `F.Q` directamente vas a ver una representación interna compacta, no una matriz común. Para verla como matriz normal, convertila con `Matrix`:

```julia
println(Matrix(F.Q))
println(F.R)
```

**Investigá:** multiplicá `Matrix(F.Q) * F.R` y compará con `A2` original. Deberían coincidir (con alguna diferencia mínima por redondeo de punto flotante).

## Número de condición: qué tan confiable es resolver con esta matriz

```julia
cond(A2)
```

Cuando trabajás con álgebra lineal numérica, no alcanza con saber si un sistema tiene solución (para eso está `det`), también importa qué tan sensible es esa solución a pequeños errores de redondeo, que son inevitables en cualquier cálculo con decimales. Eso es lo que mide el número de condición: cuanto más alto, más "delicada" es la matriz, y más puede amplificar errores chiquitos en los datos hasta convertirlos en errores grandes en la solución. Un número de condición cercano a 1 es ideal; uno muy alto (miles, millones) es una señal de alerta aunque `det(A)` no sea exactamente cero.

## Referencia rápida

Estas son las funciones de `LinearAlgebra` que ya usaste a lo largo de las últimas lecciones:

| Función | Qué hace |
|---|---|
| `dot(u, v)` | producto punto |
| `norm(v)` | norma (largo) del vector |
| `det(A)` | determinante |
| `inv(A)` | inversa |
| `rank(A)` | rango |
| `tr(A)` | traza |
| `eigvals(A)` | autovalores |
| `eigvecs(A)` | autovectores |
| `cond(A)` | número de condición |
| `qr(A)` | factorización QR |
| `I` | matriz identidad (se adapta al tamaño que necesite la operación) |

## Antes de seguir

En el REPL, sin mirar el archivo:

1. Definí una matriz 2x2 cualquiera (no diagonal esta vez).
2. Calculá su rango, su traza, sus autovalores y sus autovectores.
3. Calculá su número de condición.
4. Calculá su factorización QR y verificá que `Matrix(F.Q) * F.R` reconstruye la matriz original.
5. Escribí de nuevo `mi_tr` sin mirar el archivo, y confirmá que coincide con `tr`.

---

**Ejercicios de esta lección:** [exercises/07-linearalgebra-fundamentos.jl](../exercises/07-linearalgebra-fundamentos.jl)
**Próxima lección:** [08. Repaso general](08-repaso-general.md)
