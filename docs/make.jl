# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'julia -e 'using LiveServer; serve(dir="docs/build")' 
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using CiteDown

makedocs(
    sitename="CiteDown.jl",
    pages = [
        "Guide" => "index.md",
        "API" => "api.md"
    ],
    )

deploydocs(
        repo = "github.com/neelsmith/CiteDown.jl.git",
)