# 01. Variables y tipos

## Por qué esto importa

Todo lo que vas a hacer en álgebra lineal con Julia (vectores, matrices, sistemas de ecuaciones) arranca guardando números bajo un nombre y sabiendo qué tipo de dato es cada cosa. Si esta base queda floja, después vas a tener errores confusos en las lecciones de matrices que en realidad son errores de tipos. Conviene ir despacio acá.

## Variables: ponerle nombre a un valor

Una variable es simplemente un nombre que apunta a un valor. Cuando escribís esto:

```julia
x = 5
```

le estás diciendo a Julia: "guardá el valor `5` y, a partir de ahora, cuando yo escriba `x`, usá ese valor". El signo `=` acá funciona distinto a como lo usás en matemática: no afirma que x sea igual a 5 para siempre. Es una **asignación**, algo más parecido a pegarle una etiqueta a una caja.

**Predecí:** si ahora escribís `x + 1` en el REPL, ¿qué esperás que devuelva? Probalo y confirmá.

```julia
julia> x = 5
5

julia> x + 1
6
```

Podés reasignar la misma variable cuantas veces quieras, y pierde el valor anterior cada vez:

```julia
julia> x = 5
5

julia> x = 10
10
```

Los nombres pueden guardar cualquier tipo de valor, no solo números:

```julia
nombre = "Ana"
activo = true
```

**Probá / modificá:** cambiá `nombre` por el tuyo y corré `println(nombre)`. Después probá crear una variable `edad` con tu edad y mostrala con `println`.

## Tipos: Julia siempre sabe qué es cada valor

Aunque en Julia no hace falta declarar el tipo de una variable (a diferencia de otros lenguajes), por dentro Julia siempre sabe exactamente qué tipo de dato tiene cada valor. Podés preguntárselo con `typeof`:

```julia
julia> typeof(5)
Int64

julia> typeof(3.14)
Float64

julia> typeof("Ana")
String

julia> typeof(true)
Bool
```

Esto importa en la práctica: más adelante, cuando trabajes con matrices, el tipo de los números adentro (`Int64` vs `Float64`) va a determinar cómo se comportan ciertas operaciones. Acostumbrarte a preguntar `typeof(algo)` cuando algo no se comporta como esperás es un hábito que te va a ahorrar tiempo.

### Tipos principales que vas a usar seguido

| Tipo | Para qué sirve | Ejemplo |
|---|---|---|
| `Int` | números enteros | `5`, `-3` |
| `Float64` | números con decimales | `3.14`, `5.0` |
| `String` | texto | `"Ana"` |
| `Bool` | verdadero/falso | `true`, `false` |
| `Char` | un solo carácter | `'a'` |

**Predecí antes de correr:** ¿qué tipo creés que tiene `5`? ¿Y `5.0`? Son valores "iguales" matemáticamente, pero **no** tienen el mismo tipo:

```julia
julia> typeof(5)
Int64

julia> typeof(5.0)
Float64
```

El punto decimal es lo que le dice a Julia que trate ese valor como `Float64` en vez de `Int64`, aunque el número entero resultante sea el mismo.

## Operaciones aritméticas

```julia
julia> 2 + 3
5

julia> 5 - 2
3

julia> 4 * 6
24

julia> 10 / 2
5.0

julia> 2 ^ 3
8
```

**Ojo con `/`:** fijate que `10 / 2` dio `5.0`, no `5`. En Julia, la división `/` **siempre** devuelve `Float64`, incluso cuando el resultado es un número entero exacto. Esto es distinto a lo que pasa en varios otros lenguajes, y te vas a topar con esto seguido cuando trabajes con matrices (por eso casi todos los resultados de álgebra lineal en Julia terminan siendo `Float64`).

**Verificalo vos:** ¿qué tipo esperás que tenga el resultado de `10 / 2`? Confirmalo con `typeof(10 / 2)`.

## Comentarios

Todo lo que vaya después de un `#` en una línea, Julia lo ignora. Sirve para dejarte notas a vos misma:

```julia
# esto es un comentario, Julia no lo ejecuta
x = 42
```

## Strings: trabajar con texto

Para unir (concatenar) dos strings en Julia se usa `*`, no `+` como en varios otros lenguajes:

```julia
julia> saludo = "Hola"
"Hola"

julia> nombre = "Julia"
"Julia"

julia> frase = saludo * " " * nombre
"Hola Julia"

julia> println(frase)
Hola Julia
```

También podés **interpolar** el valor de una variable directamente adentro de un string, usando `$`:

```julia
julia> edad = 25
25

julia> println("Tengo $edad años")
Tengo 25 años
```

Esto reemplaza `$edad` por el valor de la variable al momento de armar el string. También funciona con expresiones si las envolvés entre paréntesis:

```julia
julia> println("El doble de mi edad es $(edad * 2)")
El doble de mi edad es 50
```

**Probá / modificá:** armá tu propia variable `edad` y escribí un `println` que diga "Tengo X años y en 10 años voy a tener Y", usando interpolación para ambos números (no escribas los números a mano).

## Conversión de tipos

A veces necesitás pasar un valor de un tipo a otro. Por ejemplo, convertir un `Float64` a `Int`:

```julia
julia> Int(3.0)
3
```

Esto funciona porque `3.0` es un entero "exacto", no tiene parte decimal de verdad. Pero si probás con un número que sí tiene parte decimal, Julia no adivina si querés redondear para arriba, para abajo, o truncar. Te obliga a vos a decidirlo, y directamente da error si le pedís algo ambiguo:

```julia
julia> Int(3.9)
ERROR: InexactError: Int64(3.9)
```

Para convertir a propósito un decimal a entero, tenés que elegir explícitamente la regla:

```julia
julia> round(Int, 3.9)   # redondea al más cercano
4

julia> trunc(Int, 3.9)   # descarta la parte decimal
3
```

Julia hace esto a propósito, para evitar que un redondeo silencioso te arruine un cálculo sin que te des cuenta. Cuando estás haciendo cuentas numéricas, eso importa.

Otras conversiones comunes:

```julia
julia> Float64(5)
5.0

julia> string(10)
"10"
```

## Antes de seguir

Andá al REPL y, sin mirar el archivo, intentá hacer esto de memoria:

1. Creá una variable con tu nombre y una con tu edad.
2. Mostrá ambas en un solo `println` usando interpolación.
3. Fijate qué tipo tiene cada una con `typeof`.
4. Probá dividir dos números y confirmá que el resultado es `Float64`.

Si te trabaste en algún paso, volvé a la sección correspondiente de esta lección antes de seguir.

---

**Ejercicios de esta lección:** [exercises/01-variables-y-funciones.jl](../exercises/01-variables-y-funciones.jl)
**Próxima lección:** [02. Funciones y control de flujo](02-funciones-y-control-flujo.md)
