" General: {{{1
function! templates#vars#date(format) abort
  return strftime(a:format)
endfunction

function! templates#vars#global_var (var) abort
  return eval('g:' . a:var)
endfunction

function! templates#vars#modeline () abort
    let l:modeline = printf(" vim: set ft=%s ts=%d sw=%d tw=%d %set %s:",
          \ &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no',
          \ &fdm == 'manual' ? 'fdm=marker' : '')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    return l:modeline
endfunction

function! templates#vars#filename () abort
  return expand('%:t')
endfunction

function! templates#vars#basename () abort
  return expand('%:t:r')
endfunction

function! templates#vars#dirname () abort
  return expand('%:p:h:t')
endfunction

function! templates#vars#cwd_path () abort
  return expand('%')
endfunction

function! templates#vars#abs_path () abort
  return expand('%:p')
endfunction

function! templates#vars#author_name () abort
  return exists("g:username") ? g:username :
        \ (exists("g:user") ? g:user : $USER)
endfunction

function! templates#vars#author_email () abort
  return exists("g:email") ? g:email : (templates#vars#author_name() . "@" . l:hostn)
endfunction

" Vim: {{{1
let s:vim_patch = filter(range(0,999), 'has("patch" . v:val)')[-1]
function! templates#vars#vim_version_patch () abort
  return string(v:version / 100.0) . '.' . s:vim_patch
endfunction

function! templates#vars#vim_version () abort
  return v:version
endfunction

function! templates#vars#vim_patch () abort
  return s:vim_patch
endfunction

" Django: {{{1

function! templates#vars#django_related_imports () abort
  let l:filename = expand('%:t')
  let l:app_path = expand('%:h')
  let l:file_path = expand('%:h')
  if expand('%:h:t') == 'tests'
    let l:app_path = expand('%:h:h')
  endif
  let l:related = ['models.py', 'views.py', 'utils.py', 'forms.py']
  if l:filename =~ "test_[a-zA-Z_]\+\.py"
    call extend(l:related, 'factories.py')
  endif
  let l:output = []
  for l:item in l:related
    let l:import = 'from . import ' . l:item[:-4]
    if l:item == l:filename
      continue
    endif
    if l:filename == 'models.py' && l:item != 'utils.py'
      continue
    endif
    if l:filename == 'urls.py' && l:item != 'views.py'
      continue
    endif
    if l:filename == 'admin.py' && l:item != 'models.py'
      continue
    endif
    if l:filename =~ 'test_[a-zA-Z_]\+\.py' 
          \ && matchstr(l:filename, 'test_\zs[a-zA-Z_]\+\ze\.py') . '.py' != l:item 
      continue
    endif
    if l:app_path != l:file_path
          \ && (l:filename == 'factories.py'
          \ || l:filename =~ 'test_[a-zA-Z_]\+\.py' && l:item != 'factories.py')
      let l:import = 'from .. import ' . l:item[:-4]
    endif
    if filereadable(l:app_path . '/' . l:item)
      call add(l:output, l:import)
    endif
  endfor
  return join(l:output, "\n")
endfunction

" Misc: {{{1
function! templates#vars#insert () abort
  return '%% INSERT %%'
endfunction

"vim: set ft=vim ts=2 sw=2 fdm=marker et :
