using SafeTestsets
using Test

@testset "JuliaProject.jl" begin
    @time @safetestset "Doubling" begin include("doubling.jl") end
end
