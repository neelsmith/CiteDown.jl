"""Settings for interpreting URNs in markdown.
"""
struct Settings
    ict
    iiifurl
    iiifpath
    maxheight::Int
end

"""Initialize a `Settings` instance with empty values.

$(SIGNATURES)
"""
function null_settings()
    Settings("","","",0)
end