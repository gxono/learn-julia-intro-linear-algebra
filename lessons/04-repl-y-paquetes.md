# 04. REPL y paquetes

## Por qué esto importa

A partir de la próxima lección vas a usar funciones que no vienen incluidas por defecto en Julia, sino que viven en el paquete `LinearAlgebra`. Para no perderte cuando algo no funcione como esperás, conviene manejarte con soltura entre el modo normal del REPL, el modo ayuda y el modo paquetes.

## Repaso rápido del REPL

Ya lo viste en la lección 00: el REPL evalúa cada línea que escribís y te muestra el resultado al toque.

```julia
julia> 2 + 3
5

julia> sqrt(9)
3.0
```

## Modo ayuda: preguntarle a Julia qué hace una función

Si escribís `?` seguido del nombre de una función, el REPL te muestra su documentación:

```julia
julia> ?sin
```

**Probá:** entrá al modo ayuda y buscá `?println` y `?typeof`. Para salir del modo ayuda sin escribir nada, apretá backspace en una línea vacía.

## Modo shell: comandos del sistema sin salir de Julia

Escribiendo `;` al principio de una línea entrás al modo shell, donde podés correr comandos del sistema operativo directamente:

```julia
julia> ; dir
```

(En Windows es `dir`; si alguna vez trabajás en Linux o Mac vas a ver `ls` en su lugar). Para salir del modo shell, igual que con el modo ayuda, backspace en una línea vacía.

## Modo paquetes: instalar y revisar qué tenés

Escribiendo `]` entrás al modo de gestión de paquetes:

```julia
julia> ]
(@v1.x) pkg>
```

Desde ahí podés instalar un paquete nuevo:

```julia
(@v1.x) pkg> add Plots
```

Y ver qué paquetes tenés instalados:

```julia
(@v1.x) pkg> status
```

Para salir del modo paquetes, backspace en una línea vacía, igual que los otros modos.

## using: cargar lo que necesitás

`LinearAlgebra` es distinto a un paquete como `Plots`: viene incluido con Julia (es parte de su librería estándar), así que no hace falta instalarlo con `add`. Alcanza con cargarlo:

```julia
using LinearAlgebra
```

Después de esto, todas las funciones que trae (`dot`, `norm`, `det`, y las que vas a ver en las próximas lecciones) quedan disponibles directamente, sin tener que escribir ningún prefijo.

**Antes de seguir:** cargá `LinearAlgebra` en el REPL y usá el modo ayuda para leer la documentación de `?dot`, aunque todavía no sepas exactamente para qué sirve. La vas a usar en la próxima lección.

---

**Ejercicios de esta lección:** [exercises/04-repl-y-paquetes.jl](../exercises/04-repl-y-paquetes.jl)
**Próxima lección:** [05. Vectores y matrices](05-vectores-y-matrices.md)
