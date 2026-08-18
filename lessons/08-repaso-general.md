# 08. Repaso general

## Por qué esto importa

Ya viste, por separado, cada pieza: variables, control de flujo, arreglos, vectores, matrices y las funciones de `LinearAlgebra`. Esta lección junta todo en problemas más completos, del mismo estilo que te vas a encontrar cuando uses Julia para tus propios cálculos. Los ejercicios para resolver vos están en [exercises/08-ejercicios-practicos.jl](../exercises/08-ejercicios-practicos.jl); acá te dejo el razonamiento y un ejemplo resuelto para guiarte.

```julia
using LinearAlgebra
```

## Ejercicio 1: norma de un vector

```julia
v = [3, 4]
println(norm(v))
```

Nada nuevo acá, es un repaso directo de la lección 05.

## Ejercicio 2: determinante de una matriz

```julia
A = [1 2; 3 4]
println(det(A))
```

## Ejercicio 3: resolver un sistema y verificarlo

```julia
A = [2 1; 1 -1]
b = [5, 1]
x = A \ b
println(x)
```

Este es el que vale la pena resolver con el hábito que viste en la lección 06: no te quedes solo con el resultado, verificalo.

```julia
println(A * x)
```

Si `A * x` no se parece a `b`, algo está mal, ya sea en cómo planteaste `A` y `b`, o en algún paso anterior.

## Ejercicio 4: autovalores de una matriz diagonal

```julia
A = [2 0; 0 3]
println(eigvals(A))
```

## Ejercicio resuelto, como modelo para el ejercicio final

Antes de que hagas el tuyo en `exercises/08-ejercicios-practicos.jl`, mirá cómo se ve un mini script completo que combina varios pasos:

```julia
using LinearAlgebra

A = [3 1; 1 2]
println("Matriz A:")
println(A)

println("Determinante: ", det(A))

b = [9, 8]
x = A \ b
println("Solución x: ", x)
println("Verificación A*x: ", A * x)
```

Fijate el patrón: cargar el paquete, definir los datos, calcular, y verificar cada resultado antes de confiar en él.

## Ejercicio final

En [exercises/08-ejercicios-practicos.jl](../exercises/08-ejercicios-practicos.jl) tenés que escribir un script propio que:

1. cree una matriz 2x2 inventada por vos
2. la imprima
3. calcule su determinante
4. resuelva un sistema `A*x = b` con un vector `b` elegido por vos
5. verifique el resultado multiplicando `A * x` y comparándolo con `b`

## Qué sigue

Con esto cerrás la introducción a Julia y a `LinearAlgebra`. Las lecciones que siguen (09 a 15) van más al fondo de los algoritmos numéricos que hay detrás de funciones como `\`, `qr` o `eigvals`. La carpeta [scratch/](../scratch/) sigue siendo tu lugar para probar cosas sueltas sin la estructura de una lección, en cualquier punto del camino.

---

**Ejercicios de esta lección:** [exercises/08-ejercicios-practicos.jl](../exercises/08-ejercicios-practicos.jl)
**Próxima lección:** [09. Métodos directos: LU, pivoteo y Cholesky](09-metodos-directos.md)
