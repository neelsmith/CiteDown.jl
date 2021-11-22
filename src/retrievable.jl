"""Rewrite contents of file f with URNs
replaced by URLs if they are configured
for citable services in the file's YAML header.

$(SIGNATURES)
"""
function rewrite(f)
    (yaml, md) = pageparts(f)
    cdsettings = settings(yaml)
    urlize(md, cdsettings)
end

"""Compose markdown wrapping IIIF URL for image linked to an image citation tool installation.

$(SIGNATURES)

# Arguments

- `img` URN string
- `cdsettings` CiteDown.Settings

"""
function linkedMarkdownImage(img::AbstractString, cdsettings::Settings)
    srvc = IIIFservice(cdsettings.iiifurl, cdsettings.iiifpath)
    linkedMarkdownImage(cdsettings.ict, Cite2Urn(img), srvc; ht = cdsettings.maxheight, caption = "image")
end

"""Convert URNs in markdown image references to URL values.
$(SIGNATURES)
"""
function urlize(md, cdsettings::Settings)
    p = Parser()
    parsed = p(md)
    for (node, enter) in parsed
        if enter
            if node.t isa CommonMark.Image
                linked = linkedMarkdownImage(node.t.destination, cdsettings)
                node.t.destination = linked
                #@info("Rewrite image ", node.t.destination, linked) 
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

