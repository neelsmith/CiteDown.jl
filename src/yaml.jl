"""Split markdown file into YAML header and markdown body.
Returns a tuple of 2 strings.  If there is no YAML header, 
the first string will be empty.

$(SIGNATURES)
"""
function pageparts(f)
    lines = readlines(f)
    yaml = []
    markdown = []
    index = 1
    inheader = false
   
    for l in lines
        if inheader
            if l == "---"
                inheader = false
            else
                push!(yaml, l)  
            end

        else
            if l == "---"
                inheader = true
            else
                push!(markdown, l)  
            end
        end
    end
    (join(yaml, "\n"), join(markdown, "\n"))
end


"""Extract YAML header from a Vector of string values.

$(SIGNATURES)
"""
#=
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
=#

"""Create document settings object from a string source.

$(SIGNATURES)
"""
function settings(src)
    yaml = isempty(src) ? nothing : YAML.load(src)

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

    Settings(
        ict,
        iiifurl,
        iiifpath,
        maxwidth
    )
end