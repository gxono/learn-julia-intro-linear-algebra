# 03. Arreglos y colecciones

## Por qué esto importa

Los vectores y matrices que vas a usar en las próximas lecciones son, por dentro, arreglos de Julia. Entender cómo se accede a sus elementos y cómo se recorren ahora te va a ahorrar confusión más adelante, cuando ya no estemos hablando de "arreglos" sino de vectores y matrices de álgebra lineal.

## Vectores: listas ordenadas de valores

```julia
v = [1, 2, 3, 4]
println(v)
```

Los corchetes con valores separados por coma crean un `Vector`, una colección ordenada. Se accede a un elemento por su posición (su índice):

```julia
v[1]
v[3]
```

**Ojo con esto:** en Julia los índices arrancan en 1, no en 0. Si venís de otro lenguaje donde el primer elemento es `v[0]`, este es el cambio de hábito más común al principio.

**Predecí:** ¿qué creés que pasa si pedís `v[5]`, si `v` solo tiene 4 elementos? Probalo y fijate qué tipo de error te da.

## Matrices: tablas de valores

```julia
A = [1 2; 3 4]
println(A)
```

Adentro de los corchetes, el espacio separa columnas y el punto y coma separa filas. Así que `[1 2; 3 4]` es una matriz de 2 filas y 2 columnas, con `1 2` en la primera fila y `3 4` en la segunda.

Para acceder a un elemento se usa `[fila, columna]`:

```julia
A[1, 2]
```

**Predecí:** antes de correrlo, decidí qué valor esperás de `A[2, 1]`. Confirmalo.

## Tuplas: colecciones que no cambian

```julia
t = (1, 2, 3)
```

Se parecen a los vectores, pero son inmutables: una vez creada una tupla no podés cambiar sus valores. Sirven para agrupar valores que van juntos y no tiene sentido que cambien por separado, como una coordenada `(x, y)`.

## Diccionarios: buscar por clave en vez de por posición

```julia
d = Dict("a" => 1, "b" => 2)
println(d["a"])
```

En vez de acceder por posición (`d[1]`), accedés por una clave (`d["a"]`). Sirve cuando lo que te interesa es el nombre de la cosa, no el orden en que la guardaste.

## Rangos: secuencias sin guardar todos los valores

```julia
r = 1:5
```

Ya usaste algo así en la lección anterior con `for i in 1:5`. `1:5` no guarda los cinco números en memoria de entrada, los genera a medida que los vas necesitando. Podés convertirlo en un vector de verdad con `collect(r)` si en algún momento necesitás la lista completa.

## Comprensiones: construir un vector a partir de una regla

```julia
v = [i^2 for i in 1:5]
println(v)
```

Se lee de adentro hacia afuera: "para cada `i` en `1:5`, calculá `i^2`, y juntá todo en un vector". Es una forma compacta de reemplazar un `for` que arma un vector elemento por elemento.

**Probá / modificá:** escribí una comprensión que genere los primeros 10 múltiplos de 3 (pista: `3*i` para `i` en `1:10`).

## Broadcasting: aplicar una operación a todos los elementos a la vez

```julia
v = [1, 2, 3]
println(v .+ 2)
```

El punto antes del operador (`.+`) le dice a Julia "aplicá esta operación elemento por elemento" en vez de tratar a `v` como un solo bloque. Esta va a ser una de las cosas que más vas a usar cuando trabajes con vectores y matrices: `.+`, `.-`, `.*`, `./`, `.^` todos aplican la operación a cada elemento por separado.

**Probá / modificá:** calculá `v .* 2` y `v .^ 2`, y compará mentalmente con lo que esperabas antes de correrlo.

## Antes de seguir

Andá al REPL y probá esto de memoria:

1. Creá un vector con 5 números y accedé al tercero.
2. Creá una matriz 3x3 y accedé al elemento de la fila 2, columna 3.
3. Usá una comprensión para crear un vector con los cuadrados del 1 al 10.
4. Usá broadcasting para restarle 1 a cada elemento de ese vector.

Si te trabaste en algún paso, volvé a la sección correspondiente antes de seguir.

---

**Ejercicios de esta lección:** [exercises/03-arreglos-y-colecciones.jl](../exercises/03-arreglos-y-colecciones.jl)
**Próxima lección:** [04. REPL y paquetes](04-repl-y-paquetes.md)
