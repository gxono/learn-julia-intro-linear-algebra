# Ejercicio 09: métodos directos (LU, pivoteo, Cholesky)

using LinearAlgebra

# TODO: implementá mi_triinf(L, b) para sustitución hacia adelante (ver lección 09)
# y verificá que mi_triinf(L, b) ≈ L \ b para una matriz L triangular inferior

# TODO (desafío opcional): implementá mi_trisup(U, b) para sustitución hacia atrás
# y verificá contra U \ b

# TODO: implementá mi_lu(A) y verificá que mi_lu(A) devuelve L, U tales que L*U ≈ A

# TODO: probá mi_lu sobre [0.0 1; 1 1] y confirmá que falla por división por cero

# TODO: comparalo con lu(A, NoPivot()), que también debería fallar en ese caso

# TODO: implementá mi_cholesky(A) para una matriz sdp y verificá que
# mi_cholesky(A)' * mi_cholesky(A) ≈ A

println("Ejercicio 09 completo")
