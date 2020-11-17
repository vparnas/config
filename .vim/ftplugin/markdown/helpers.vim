" Generates a ## Refs section at the bottom with 
"   1. the link defs of all existing urls:
"       [site1]: url
"       [site2]: url
"   2. a list of the respective links in reference format:
"       - [site1][]
"       - [site2][]
" Converts the original inline links (format [name](url)) to reference format

function! GenRefSection()
    $norm o### Sources referenced <a name='#ref'></a>
    " Copy lines containing inline urls to the bottom section
    g/\[[^\]]\+\]([^)]\+)/t$
    " The Refs section starts from the '^' (last insertion) mark (for ease)
    " Convert all url-lines to link defs and reference links
    silent! '^,$s/\v[^\[]*(\[[^\]]+\])\(([^)]+)\)[^\[]*/- \1[]\r\1: \2\r/g
    " Delete all blank lines
    '^,$g/^$/d
    " Move the link defs to below the referenced links (up to now intermixed)
    '^,$g/^\[/m $
    " Convert the original inline links to refs
    silent! 1,'^s/\v(\[[^\]]+\])\([^)]+\)/\1[]/g
    $
endfunction
command! GenRefSection silent call GenRefSection()
