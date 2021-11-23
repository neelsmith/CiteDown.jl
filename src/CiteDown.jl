module CiteDown

using CommonMark
using YAML
using CitableObject
using CitableImage

using Documenter, DocStringExtensions

include("settings.jl")
include("yaml.jl")
include("rewrite.jl")


export rewrite
export settings

end # module