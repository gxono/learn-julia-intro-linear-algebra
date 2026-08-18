# 10. Factorización QR: Gram-Schmidt y Householder

## Por qué esto importa

En la lección 07 usaste `qr(A)` como una caja negra para descomponer una matriz en `Q` (ortogonal) y `R` (triangular superior). Esta lección explica para qué sirve esa descomposición en la práctica (ajustar datos por mínimos cuadrados) y cómo se calcula realmente, con dos métodos distintos: Gram-Schmidt, que probablemente ya conocés de álgebra lineal, y las reflexiones de Householder, que es lo que usa Julia por dentro.

```julia
using LinearAlgebra
```

## Mínimos cuadrados: el problema que motiva todo esto

Cuando tenés más ecuaciones que incógnitas (por ejemplo, ajustar una recta a 5 puntos que no caen exactamente sobre ninguna recta), el sistema `Ax = b` no tiene solución exacta. Lo que se busca en su lugar es el `x` que minimiza `norm(A*x - b)`, es decir, el que hace que `A*x` esté lo más cerca posible de `b`.

```julia
Am = [1.0 0; 1 1; 1 2]
bm = [6.0, 0, 0]
```

Acá `Am` tiene 3 filas y 2 columnas: 3 ecuaciones, 2 incógnitas. Una forma de resolver esto son las **ecuaciones normales**: se puede demostrar que el `x` que minimiza el error satisface `A'Ax = A'b`.

```julia
x_normal = (Am' * Am) \ (Am' * bm)
```

**Investigá:** en Julia, `A \ b` funciona también cuando `A` no es cuadrada, y automáticamente resuelve el problema de mínimos cuadrados. Corré `Am \ bm` y confirmá que da (aproximadamente) lo mismo que `x_normal`.

Las ecuaciones normales funcionan, pero tienen una desventaja numérica: calcular `A'A` puede amplificar errores de redondeo (empeora el número de condición). La factorización QR ofrece una vía más estable, y es lo que Julia usa por dentro cuando hacés `A \ b` con una matriz rectangular.

## Matrices ortogonales

Una matriz `Q` es ortogonal si `Q'Q = I`. Esto tiene una consecuencia útil: multiplicar por `Q` no cambia normas ni ángulos (`norm(Q*x) == norm(x)`), así que trabajar con `Q` no introduce ni amplifica errores. Por eso conviene basar los cálculos numéricos en matrices ortogonales cuando sea posible.

Si podés escribir `A = QR` con `Q` ortogonal y `R` triangular superior, entonces minimizar `norm(A*x - b)` es equivalente a minimizar `norm(R*x - Q'*b)` (porque multiplicar por `Q'` no cambia la norma), y ese último problema, al ser `R` triangular, se resuelve directo con sustitución hacia atrás.

## Ortogonalización de Gram-Schmidt

Dado un conjunto de vectores (las columnas de `A`), Gram-Schmidt los va reemplazando por una base ortonormal equivalente: a cada vector nuevo le resta las componentes que ya están cubiertas por los anteriores, y normaliza lo que sobra.

### Implementá tu propio Gram-Schmidt

```julia
function mi_gram_schmidt(A)
    # completar: arrancá con Q y R en cero, del tamaño adecuado (usá size(A)).
    # Para cada columna j de A: restale a esa columna sus componentes en las
    # direcciones de las columnas de Q ya calculadas (columnas 1 a j-1),
    # guardando cada producto punto en R[i,j]; lo que sobra, normalizado,
    # es la columna j de Q, y su norma va en R[j,j]
end
```

Para cada columna `j`, `R[i,j]` guarda cuánto de la columna `i` (ya ortonormalizada) había en la columna `j` original, se lo resta, y lo que queda (`v`) se normaliza para obtener la columna `j` de `Q`.

**Verificalo:** con `A = [1.0 1 0; 1 0 1; 0 1 1]`, corré `Q, R = mi_gram_schmidt(A)` y confirmá que `Q*R ≈ A` y que `Q'*Q ≈ I` (las columnas de `Q` son ortonormales).

Compará con la función de la librería: `qr(A)`. Los signos pueden salir distintos (ambas son factorizaciones QR válidas, pero no únicas), así que para comparar conviene mirar valores absolutos.

## Matrices de Householder

Gram-Schmidt es intuitivo, pero en la práctica numérica tiene un problema: acumula errores de redondeo más rápido que otros métodos, sobre todo cuando las columnas de `A` están casi alineadas entre sí. El método que usa Julia por dentro (y la mayoría del software numérico serio) se basa en **reflexiones de Householder**.

Una matriz de Householder tiene la forma `H = I - u*u'`, con `u` un vector de norma `√2`. Geométricamente, `H` refleja cualquier vector respecto de un hiperplano. Lo interesante es que se puede elegir `u` de manera que `H` lleve un vector dado `x` exactamente a `±norm(x) * e1` (un múltiplo del primer vector de la base canónica), haciendo cero todas las demás componentes de un solo golpe.

Aplicando esta idea columna por columna (como en la eliminación de Gauss, pero con reflexiones en vez de restas), se puede triangularizar toda la matriz. La demostración completa y la implementación quedan fuera del alcance de esta lección, pero la idea central (reflejar en vez de restar) es la diferencia clave con Gram-Schmidt, y es lo que hace que `qr(A)` sea numéricamente más confiable que tu propio `mi_gram_schmidt`.

## Antes de seguir

En el REPL, sin mirar el archivo:

1. Planteá un sistema sobredeterminado (más filas que columnas) y resolvelo con `A \ b`.
2. Resolvé el mismo problema con las ecuaciones normales y confirmá que da (aproximadamente) lo mismo.
3. Escribí de nuevo `mi_gram_schmidt` para una matriz de 3x3 con columnas independientes, y confirmá que `Q*R` reconstruye la matriz y que `Q` es ortogonal.

---

**Ejercicios de esta lección:** [exercises/10-factorizacion-qr.jl](../exercises/10-factorizacion-qr.jl)
**Próxima lección:** [11. Métodos iterativos: Jacobi y Gauss-Seidel](11-metodos-iterativos.md)
