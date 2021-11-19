
function header(src)
    lines = split(src, "\n")
    yamllines = []
    begun = false
    for l in lines
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

function settings(src)
    yaml = header(src) |> YAML.load
end