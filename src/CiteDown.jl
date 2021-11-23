module CiteDown

import CitableImage: linkedMarkdownImage

using CommonMark
using YAML
using CitableObject
using CitableImage


export linkedMarkdownImage

using Documenter, DocStringExtensions

include("settings.jl")
include("yaml.jl")
include("rewrite.jl")


export rewrite

end # module