"""Rewrite contents of file f with URNs
replaced by URLs if they are configured
for citable services in the file's YAML header.

$(SIGNATURES)
"""
function rewrite(f)
    (yaml, md) = pageparts(f)
    cdsettings = CiteDown.settings(yaml)
    urlize(md, cdsettings)
end

"""Instantiate a `IIIFservice` based on settings.
$(SIGNATURES)
"""
function iiifservice(cdsettings::CiteDown.Settings)
    IIIFservice(cdsettings.iiifurl, cdsettings.iiifpath)
end



function rewrite_img(n,cdsettings::CiteDown.Settings)
    iiif = iiifservice(cdsettings)
    u = Cite2Urn(n.t.destination)
    imgdest = url(u, iiif, ht = cdsettings.maxheight)

    newimg =  CommonMark.Node(CommonMark.Image())
    newimg.t.destination = imgdest
    caption = n.first_child.literal
    captionnode = CommonMark.text("Rewrittten link to " * caption)
    CommonMark.append_child(newimg, captionnode)


    ictnode = CommonMark.Node(CommonMark.Link())
    ictdest = cdsettings.ict * "urn=" * n.t.destination
    ictnode.t.destination = ictdest

    CommonMark.append_child(ictnode, newimg)

    CommonMark.insert_before(n, ictnode)
  
end

"""Convert URNs in markdown image references to URL values.
$(SIGNATURES)
"""
function urlize(md::AbstractString, cdsettings::Settings)
    p = Parser()
    parsed = p(md)
    urlize(parsed, cdsettings)
    
end

"""Convert URNs in markdown image references to URL values.
$(SIGNATURES)
"""
function urlize(parsed::CommonMark.Node, cdsettings::Settings)
    rmlist = []
    for (node, enter) in parsed
        if enter
            @info(node.t)
            if node.t isa CommonMark.Image
                @info("Rewrite ", node.t.destination)
                CiteDown.rewrite_img(node, cdsettings)
                @info("Delete ", node.t)
                push!(rmlist, node)
            end
        end
    end
    for n in rmlist
        CommonMark.unlink(n)
    end
    # Format rewritten AST as a markdown string:
    ast2markdown(parsed)
end

"""Format AST as a markdown string.

$(SIGNATURES)
"""
function ast2markdown(parsed)
    iobuf = IOBuffer()
    env = Dict{String,Any}()
    writer = CommonMark.Writer(CommonMark.Markdown(iobuf), iobuf, env)
    CommonMark.write_markdown(writer, parsed)
    String(take!(iobuf))
end
