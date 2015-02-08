function! templates#render#render(t, s) abort
  " Where: a:t is the path to the template file to be rendered
  "        a:s is a dict containing the settings for the current template
  " Returns: a list of lines to be applied to the current buffer with all key
  "          words replaced with the correct values.
  if !filereadable(a:t)
    throw 'TE002: Template file `' . a:t . '` not readable'
  endif

  let l:template = readfile(a:t)
  let l:output = []
  
  for l:line in l:template
    call extend(l:output, s:expand_keywords(l:line, a:s))
  endfor

  return l:output
endfunction

let s:line_contains_var = '^.*%\{2}\s*.\+\s*%\{2}.*$'
let s:var_pat = '%\{2}\s*\(\S\+\)\s*\(.*\)\s*%\{2}'
let s:var_sub = '\=s:replace_keyword(submatch(1), submatch(2))'

function! s:expand_keywords(l, s)
  " Where: a:l is a line from a template
  "        a:s is a dict containing the settings for the current template
  " Returns: a list of expanded lines
  if a:l !~ s:line_contains_var
    return [a:l]
  endif

  return split(substitute(a:l, s:var_pat, s:var_sub, 'g'), "\n")
endfunction

function! s:replace_keyword(name, args)
  let l:args = eval('[' . a:args . ']')
  return call(function('templates#vars#' . tolower(a:name)), l:args)
endfunction
" vim: set ft=vim ts=2 sw=2 tw=78 fdm=marker et
