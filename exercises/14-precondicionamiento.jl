# Ejercicio 14: precondicionamiento (gradiente conjugado precondicionado)

using LinearAlgebra

# TODO: armá una matriz A sdp con número de condición alto (por ejemplo,
# con elementos de la diagonal muy distintos entre sí, ver lección 14)

# TODO: construí el precondicionador de Jacobi M = Diagonal(1.0 ./ diag(A))

# TODO: implementá mi_gc_precondicionado(A, b, M, x0, tol, maxiter)
# (ver lección 14)

# TODO: compará cuántas iteraciones necesita mi_gradiente_conjugado
# (de la lección 13) contra mi_gc_precondicionado, para la misma tolerancia

println("Ejercicio 14 completo")
