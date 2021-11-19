#

"""Rewrite contents of file f with URNs
replaced by URLs if they are configured
for citable services in the file's YAML header.

$(SIGNATURES)
"""
function rewrite(f)
    lines = readlines(f)
    stgs = CiteDown.settings(lines)
end