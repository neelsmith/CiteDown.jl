module CiteDown

using CommonMark
using YAML

using Documenter, DocStringExtensions

include("yaml.jl")
include("retrievable.jl")
include("settings.jl")

export rewrite

end # module
