using JuliaProject

@test 2 == double(1)
input = "x"
@test input * input == double(input)
