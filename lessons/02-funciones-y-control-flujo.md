# 02. Funciones y control de flujo

## Por qué esto importa

En álgebra lineal vas a repetir el mismo cálculo muchas veces sobre distintos datos: sumar todas las filas de una matriz, repetir un método numérico hasta que el resultado converja, aplicar la misma fórmula a cada elemento de un vector. Las funciones te dejan empaquetar un cálculo con nombre para reusarlo, y `if`, `for`, `while` te dejan decidir y repetir. Sin esto, cada línea de código serviría para un solo caso puntual.

## Funciones: empaquetar un cálculo con nombre

```julia
function sumar(a, b)
    return a + b
end

println(sumar(2, 3))
```

Acá `function ... end` define un bloque con nombre `sumar`, que recibe dos valores (`a` y `b`) y devuelve su suma con `return`. Después, `sumar(2, 3)` la ejecuta con esos valores puntuales.

**Predecí:** ¿qué devuelve `sumar(10, -3)`? Probalo.

Para funciones cortas, Julia tiene una forma compacta en una sola línea, muy común cuando la función se parece a una fórmula matemática:

```julia
f(x) = x^2
println(f(5))
```

**Probá / modificá:** cambiá `f` para que devuelva el cubo en vez del cuadrado, o creá una función nueva `cubo(x) = x^3` y probala.

## if / elseif / else: tomar decisiones

```julia
x = 10

if x > 0
    println("positivo")
elseif x == 0
    println("cero")
else
    println("negativo")
end
```

Julia evalúa las condiciones de arriba hacia abajo y ejecuta solo el primer bloque cuya condición sea verdadera.

**Ojo con esto:** para comparar si dos valores son iguales se usa `==` (doble igual). Un solo `=` es asignación, no comparación. Si escribís `if x = 0` por error, Julia te va a marcar un error de sintaxis, así que no vas a arrastrar el bug muy lejos, pero vale la pena tenerlo presente desde ahora.

**Predecí:** cambiá `x` a `-5` y después a `0`, y anticipá qué va a imprimir cada vez antes de correrlo.

## for: repetir una cantidad conocida de veces

```julia
for i in 1:5
    println(i)
end
```

`1:5` es un rango (ya lo vas a ver en detalle en la próxima lección): representa la secuencia 1, 2, 3, 4, 5. El `for` toma cada valor del rango, uno por uno, y lo usa como `i` dentro del bloque.

**Probá / modificá:** cambiá el rango a `1:10`, y después probá `1:2:10` (el número del medio es el "paso"). ¿Qué números imprime?

## while: repetir mientras se cumpla una condición

```julia
n = 1
while n <= 5
    println(n)
    n += 1
end
```

A diferencia del `for`, acá no sabés de antemano cuántas vueltas va a dar el bucle: sigue mientras la condición sea verdadera. `n += 1` es una forma corta de escribir `n = n + 1`.

Tal cual está arriba, el ejemplo funciona bien si lo escribís línea por línea en el REPL. Pero si lo guardás en un archivo `.jl` y lo corrés con `julia archivo.jl`, Julia va a tirar un error (`UndefVarError`).

Esto pasa por una regla del lenguaje llamada "soft scope": dentro de un `for`/`while` al nivel superior de un archivo, si reasignás una variable que ya existía afuera del bucle, tenés que aclarar que es la variable global con `global`:

```julia
n = 1
while n <= 5
    println(n)
    global n += 1
end
```

En el REPL no hace falta el `global` porque el REPL trata cada línea que escribís como global directamente. Es una de las rarezas más comunes al pasar código del REPL a un script, así que convenía saberlo desde ya.

## break y continue

```julia
for i in 1:10
    if i == 5
        continue
    end
    println(i)
    if i == 8
        break
    end
end
```

`continue` corta la vuelta actual del bucle y pasa directo a la siguiente (por eso el `5` no se imprime). `break` corta el bucle entero (por eso no llega a imprimir nada después del `8`).

**Predecí antes de correr:** ¿qué números se imprimen en total? Después corré el bloque y comparalo con lo que pensaste.

## Antes de seguir

Sin mirar el archivo, andá al REPL y probá:

1. Escribí una función `es_par(n)` que devuelva `true` si `n` es par y `false` si no (pista: `n % 2 == 0` te dice si el resto de dividir por 2 es cero).
2. Usá un `for` para imprimir, del 1 al 10, si cada número es par o impar, llamando a tu función `es_par`.

Si te trabaste en algún paso, volvé a la sección correspondiente antes de seguir.

---

**Ejercicios de esta lección:** [exercises/02-funciones-y-control-flujo.jl](../exercises/02-funciones-y-control-flujo.jl)
**Próxima lección:** [03. Arreglos y colecciones](03-arreglos-y-colecciones.md)
