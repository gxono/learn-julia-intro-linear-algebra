using LinearAlgebra

v = [1, 2, 3]
A = [1 2; 3 4]
b = [5, 6]

println("vector: ", v)
println("norma: ", norm(v))
println("matriz: ")
println(A)
println("determinante: ", det(A))
println("solucion: ", A \ b)
