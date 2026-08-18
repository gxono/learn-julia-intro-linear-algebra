# 00. Instalación y entorno

## ¿Qué es Julia?

Julia es un lenguaje de programación pensado para cálculos numéricos y científicos. Tiene una sintaxis muy legible y un rendimiento cercano al de lenguajes compilados.

Se usa mucho en:

- álgebra lineal
- estadística
- optimización
- ciencia de datos
- simulación numérica

## Antes de instalar nada: ¿qué es "la terminal"?

Si nunca programaste, esto te va a parecer raro al principio: en vez de hacer clic en botones, vas a escribir texto en una ventana y apretar Enter para que pase algo. Esa ventana se llama **terminal** (o **consola**).

No tiene nada de misterioso ni de "hackeo": es simplemente un lugar donde escribís una instrucción, apretás Enter, y la computadora te contesta con texto. Vas a ver esto todo el tiempo en esta guía. Es normal sentirse perdida las primeras veces, a todos nos pasó.

Dentro de una terminal, cuando corrés Julia, aparece algo llamado **REPL** (se pronuncia "repl", viene de "Read-Eval-Print Loop"). Es el modo interactivo de Julia: escribís una línea de código, apretás Enter, y Julia te muestra el resultado al toque. Se reconoce porque el renglón donde escribís empieza con:

```julia
julia>
```

## Instalar Julia (desde Microsoft Store)

1. Abrí la **Microsoft Store** (buscá "Microsoft Store" en el botón Inicio de Windows).
2. Buscá **Julia**.
3. Instalá la app oficial (el publicador debería figurar como "Julia Computing" o similar).
4. Cuando termine de instalar, buscá **Julia** en el menú Inicio y abrila.

Al abrirla se va a abrir una ventana con fondo oscuro y texto. Esa es la terminal de la que hablamos arriba, y adentro ya está corriendo el REPL de Julia. Vas a ver el prompt:

```julia
julia>
```

Con eso ya tenés Julia instalado y funcionando.

## Instalar VS Code (desde Microsoft Store)

VS Code es el editor donde vas a escribir y organizar tu código (en vez de trabajar solamente en la terminal negra).

1. Abrí la **Microsoft Store**.
2. Buscá **Visual Studio Code**.
3. Instalá la app oficial (publicador: Microsoft).
4. Abrila desde el menú Inicio.

## Instalar la extensión de Julia en VS Code

Una extensión es un "complemento" que le agrega funciones a VS Code, en este caso para que entienda y ejecute código Julia.

1. Adentro de VS Code, mirá la barra de íconos del costado izquierdo.
2. Hacé clic en el ícono que parece piezas de rompecabezas (**Extensiones**).
3. Escribí **Julia** en el buscador.
4. Instalá la extensión llamada "Julia" (del publicador `julialang`).

## Verificar que todo está listo

Ahora sí, probemos que todo funciona. Adentro de VS Code:

1. Abrí una terminal: menú **Terminal** (arriba) → **New Terminal**.
2. Se va a abrir un panel abajo con un cursor esperando texto. Escribí:

```bash
julia --version
```

y apretá Enter. Si te contesta con algo como `julia version 1.x.x`, ya está todo instalado correctamente.

> Nota: `julia --version` se escribe en la terminal normal (antes de entrar a Julia), no en el REPL. Son dos prompts distintos: la terminal del sistema (por ejemplo, algo como `PS C:\...>`) y el REPL de Julia (`julia>`). Todavía no entramos al REPL en este paso.

## Abrir el REPL de Julia desde VS Code

Esta va a ser tu forma habitual de trabajar mientras seguís las lecciones. Dos maneras, cualquiera funciona:

- **Más simple**: apretá `Ctrl+Shift+P`, escribí `Julia: Start REPL` y apretá Enter.
- **Alternativa**: en la terminal que abriste recién, escribí `julia` y apretá Enter.

Ahora sí ves el prompt `julia>`. Estás adentro del REPL.

## Primeros pasos en el REPL

```julia
julia> 2 + 3
5

julia> println("Hola, Julia")
Hola, Julia
```

### Modos del REPL

- modo normal: para ejecutar código
- `?`: ayuda de una función
- `;`: entrar al shell del sistema
- `]`: entrar al modo de paquetes

Ejemplo:

```julia
julia> ?sin
```

Y el modo paquete:

```julia
julia> ]
(@v1.x) pkg>
```

## Paquetes básicos

El paquete más importante para esta guía es `LinearAlgebra`. Viene incluido con Julia, así que no hace falta instalarlo, solo cargarlo:

```julia
using LinearAlgebra
```

## Primer ejemplo

```julia
x = 10
println("x = ", x)
```

## Consejos para empezar

- probá cosas en el REPL antes de escribir programas completos
- leé los errores con calma, al principio parecen texto en otro idioma, pero casi siempre dicen exactamente qué salió mal
- no te preocupes por hacer cosas "raras"; la mejor forma de aprender es experimentar

## Objetivo de esta guía

Aprender Julia desde cero, con especial atención a vectores, matrices, sistemas lineales y todo lo que ofrece `LinearAlgebra`.

---

**Próxima lección:** [01. Variables y tipos](01-variables-y-tipos.md)
