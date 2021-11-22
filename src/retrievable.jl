#

"""Rewrite contents of file f with URNs
replaced by URLs if they are configured
for citable services in the file's YAML header.

$(SIGNATURES)
"""
function rewrite(f)
    (yaml, md) = pageparts(f)
    stgs = Settings(yaml)

end


function linkedMarkdownImage(img::AbstractString, cdsettings::Settings)

    srvc = IIIFservice(cdsettings.iiifurl, cdsettings.iiifpath)
    linkedMarkdownImage(cdsettings.ict, img, srvc; ht = cdsettings.maxheight, caption = "image")
end


function urlize(md, cdsettings::Settings)
    p = Parser()
    parsed = p(md)
    for (node, enter) in parsed
        if enter
            if node.t isa CommonMark.Image
                #node.t.destination = rewrite_imglink(node.t.destination, dir)
                @info("Rewrite image ", node.t.destination)
                linked = linkedMarkdownImage(node.t.destination, cdsettings)
                #@info()
            end

        end
    end
end


#=
function adjustpaths(mdsrc, dir; relpath = "")
    linkbase = join(splitpath(relpath), "-")
    p = Parser()
    parsed = p(mdsrc)
    for (node, enter) in parsed
        if enter
            if node.t isa CommonMark.Image
                node.t.destination = rewrite_imglink(node.t.destination, dir)

            elseif node.t isa CommonMark.Link
                if ! isempty(linkbase)
                    newdest = "#" * join([linkbase, node.t.destination],"-")
                    node.t.destination = rewrite_internallink(node.t.destination, newdest)
                end
            end
        end
    end
    
    # Format rewritten AST as a markdown string:
    iobuf = IOBuffer()
    env = Dict{String,Any}()
    writer = CommonMark.Writer(CommonMark.Markdown(iobuf), iobuf, env)
    CommonMark.write_markdown(writer, parsed)
    String(take!(iobuf))
end
=#