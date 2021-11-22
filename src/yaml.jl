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



"""Create document settings object from a string source.

$(SIGNATURES)
"""
function settings(src)
    if isempty(src)
        nullSettings()
    else

        yaml = YAML.load(src)

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

        maxheight = haskey(yaml, "maxheight") ? yaml["maxheight"] : 500

        Settings(
            ict,
            iiifurl,
            iiifpath,
            maxheight
        )
    end
end