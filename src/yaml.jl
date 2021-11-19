
"""Extract YAML header from a Vector of string values.

$(SIGNATURES)
"""
function header(lines)
    yamllines = []
    begun = false
    #@info("ARRAY ", lines)
    for l in lines
        #@info("LINE" , l)
        if strip(l) == "---" 
            begun ? break : begun = true
        else
            if begun 
                push!(yamllines, l)
            end
        end
    end
    join(yamllines, "\n")
end

"""Create document settings object from a string source.

$(SIGNATURES)
"""
function settings(src)
    yaml = header(src) |> YAML.load

    ict = haskey(yaml, "ict") ? yaml["ict"] : nothing
   
    iiifurl = nothing
    if haskey(yaml, "iiif") 
        dict = yaml["iiif"] 
        iiifurl = haskey(dict, "service") ? dict["service"] : nothing
    end
        
    iiifpath = nothing
    if haskey(yaml, "iiif") 
        dict = yaml["iiif"] 
        iiifpath = haskey(dict, "path") ? dict["path"] : nothing
    end

    maxwidth = haskey(yaml, "maxwidth") ? yaml["maxwidth"] : 500

    CiteDown.Settings(
        ict,
        iiifurl,
        iiifpath,
        maxwidth
    )
end