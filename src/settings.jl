"""Settings for interpreting URNs in markdown.
"""
struct Settings
    ict
    iiifurl
    iiifpath
    maxheight::Int
end


"""Instantiate a `Settings` object with reasonable default values.

$(SIGNATURES)
"""
function settings()
    Settings(
        "http://www.homermultitext.org/ict2/?",
        "http://www.homermultitext.org/iipsrv",
        "/project/homer/pyramidal/deepzoom",
        500
    )
end