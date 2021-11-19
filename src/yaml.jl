
function header(src)
    parts = split(src, r"^---")
    contentparts = filter(s -> ! isempty(s), parts)
    length(contentparts) > 1 ? contentparts[1] : nothing
end

function settings(src)
    nothing
end