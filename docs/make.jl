using JuliaProject
using Documenter

DocMeta.setdocmeta!(JuliaProject, :DocTestSetup, :(using JuliaProject); recursive=true)

makedocs(;
    modules=[JuliaProject],
    authors="Chris du Plessis",
    repo="https://github.com/Maelstrom6/JuliaProject.jl/blob/{commit}{path}#{line}",
    sitename="JuliaProject.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Maelstrom6.github.io/JuliaProject.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Maelstrom6/JuliaProject.jl",
    devbranch="master",
)
