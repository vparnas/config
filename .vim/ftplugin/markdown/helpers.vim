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
    g/\[.\{-}](.\{-})/t$
    " The Refs section starts from the '^' (last insertion) mark (for ease)
    " Convert all url-lines to link defs and reference links
    silent! '^,$s/\v.{-}(\[.{-}])\((.{-})\).*/- \1[]\r\1: \2\r/g
    " Delete all blank lines
    '^,$g/^$/d
    " Move the link defs to below the referenced links (up to now intermixed)
    '^,$g/^\[/m $
    " Convert the original inline links to refs
    silent! 1,'^s/\v(\[.{-}])\(.{-}\)/\1[]/g
    $
endfunction
command! GenRefSection silent call GenRefSection()

" Generate a Table of Contents for section headings in a scratch buffer
" If parent (top-level) headings are deeper than H3 (###) may need to shift
"   one width left for the markdown to properly render in markdown
function! GenTOC()
    " Create an anchor for each section using first section word
    %s/\v^#.{-}(\w+).*/& <a name='\l\1'><\/a>/
    " Initially generate the TOC at the bottom of the main buffer
    $norm o### Contents
    1,'^-1g/^#/t$
    '^+,$s/#/ /g
    '^+,$s/^\s\+/&- /g
    '^+,$<
    '^+,$s/\v- \zs([^<]+)\s+.*["'](\w+)["'].*/[\1](#\2)/g
    " Move the TOC to the scratch buffer
    '^,$d
    new
    setlocal buftype=nofile bufhidden=hide noswapfile
    put
endfunction
command! GenTOC silent! call GenTOC()
