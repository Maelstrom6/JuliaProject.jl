# JuliaProject

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Maelstrom6.github.io/JuliaProject.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Maelstrom6.github.io/JuliaProject.jl/dev)
[![Build Status](https://github.com/Maelstrom6/JuliaProject.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/Maelstrom6/JuliaProject.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/Maelstrom6/JuliaProject.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Maelstrom6/JuliaProject.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

# Create the project
For more information see https://invenia.github.io/PkgTemplates.jl/stable/user/
```julia
] add PkgTemplates
using PkgTemplates
project_name = "JuliaProject"
cd("Suitable/Working/Directory")

t = Template(
    user="Maelstrom6",
    dir="",
    authors="Chris du Plessis",
    plugins=[
        License(; name="MIT"),
        Git(),
        GitHubActions(),
        Codecov(),
        Documenter{GitHubActions}(),
        Develop(),
        BlueStyleBadge(),
    ],
)
t(project_name)
```
"user" should be your Github unique username (not the display name) and "authors" can be a list of real names.

Then go into the project by doing:
File -> Open Folder -> Choose the folder that holds the correct project.


# Adding projects
Then open the Julia REPL and make sure Pkg is using the correct manifest by checking if `project_name` is next to pkg prompt when you type `]` into the repl
If it is not, then make sure Julia is started up in the correct directory and then go `activate .`.
Then type `] add Project` for whatever project you might have.


# Adding code
Add some code into the src folder
It can look something like
```julia
module JLProject

include("doubler.jl")

end
```
With "doubler.jl" looking like
```julia
export double
double(x) = 2x
double(x::String) = x * x
```

# Testing
Add SafeTestsets to the project by typing `] add SafeTestsets`, open "Project.toml" and move the entry for SafeTestsets to the a spot under [extras] instead of [deps].

The "runtests.jl" folder can look something like
```julia
using SafeTestsets
using Test

@testset "JLProject.jl" begin
    @time @safetestset "Doubling" begin include("doubling.jl") end
end
```
For each new file that you add, just copy the form above

With "doubling.jl" looking like
```julia
using JLProject

@test 2 == double(1)
input = "x"
@test input * input == double(input)
```
Now input should be inacessible to the "runtests.jl" file even though it has `include("doubling.jl")`.

# Uploading to Github
Go to Github and create a project with the same name as what you called the current project at creation except add a ".jl" at the end.
Make sure the poject is public create a blank project. The public project is needed otherwise Github will not allow Github Actions on your project.
Now go to the source control tab on the side of the screen and you should see some edited files. Do not commit them yet. Instead click the ... icon and click "push". It will ask you if a master branch should be published and say yes.
It should now be updated.

Testing should automatically be done.


# Documentation
For more information see https://juliadocs.github.io/Documenter.jl/stable/man/guide/
## General documentation structure
The "make.jl" file defines the structure of your documentation page.
The src folder under the docs folder is where all the documentation layout pages are.
The files in this folder should all be markdown files and one can have folders in here too.
When adding a markdown file, the navigation pane on the documentation page will give it the same name as the main heading specified within the markdown file unless otherwise specified in the "make.jl" file. Within the "make.jl" file under the `pages`, one should map what you want it to be called. 
The argument can look something like this:
```julia
pages=[
        "Home" => "index.md",
        "Other" => [
            "One" => "index1.md",
            "Two" => "index2.md",
        ],
    ],
```

## Within each markdown document
Most markdown documents will look something like this
```md
# Core Types

These are types that are most often used. They are simple and are used by all other functions.

There is basic support for continuous Markov chains. All applicable functions also work for continuous chains.

## Contents

`@contents
Pages = ["basic.md"]
`

## Index

`@index
Pages = ["basic.md"]
`

## Documentation

The main type is `DiscreteMarkovChain`:

`@docs
DiscreteMarkovChains.DiscreteMarkovChain
DiscreteMarkovChains.ContinuousMarkovChain

DiscreteMarkovChains.state_space
DiscreteMarkovChains.transition_matrix
DiscreteMarkovChains.probability_matrix

DiscreteMarkovChains.embedded
`
```

## Docstrings
Docstrings start with the methods of the function tabbed out.
A descrption is provided after that.
The code block's "language" must be jldoctest and must include a line containing exactly the text # output. The text before this line is the contents of the script that is run. The text that appears after # output is the textual representation that would be shown in the Julia REPL if the script had been included. In particular, semicolons ; at the end of a line have no effect.
To preserve definitions within a docstring, add a common label after "jldoctest" for example "```jldoctest myFunction".

## Doctests
One can add the following under runtests.jl
```julia
using Documenter
doctest(MyPackage)
```
They are automatically tested when being made.

## Adding a logo
Put the chosen picure under "docs/src/assets/" and call it "logo" with the suitable file extension.
If you want a separate logo for dark themes, have a second picutre called "logo-dark".

# Hosting the documentation on Github
Go to settings on the Github repo.
Go to the Github Pages section and choose the source as "gh-pages".
It should take a few minutes to update and then you are done.

Now you need to be able to host tagged versions of the repo.


# Publishing to the Julia ecosystem
See https://github.com/JuliaRegistries/Registrator.jl
Install the registrator, give it access to the specific project.

# What to do before pushing
in the Julia repl type
```julia
] test
] build
```

