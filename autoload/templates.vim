let s:sfile = expand('<sfile>:p:h:h')
let s:T = {} " Template dict

" Templates: {{{1
" Vim: {{{2
let s:T.vim = {}
let s:T.vim.plugin = {'ft': 'vim', 'temp': 'plugin.vim'}
let s:T.vim.autoload = {'ft': 'vim', 'temp': 'autoload.vim'}
" Django: {{{2
let s:T.django = {}
let s:T.django.views = {'ft': 'python.django', 'temp': 'python/views.py'}
let s:T.django.unittest = {'ft': 'python.django', 'temp': 'python/unittests.py'}
let s:T.django.factory = {'ft': 'python.django', 'temp': 'python/factories.py'}

" Patterns: {{{1
let s:insert_pat = '^.*%\{2\}\s*INSERT\s*%\{2\}.*$'

" Functions: {{{1
function! templates#apply(bang, lang, name) abort
  if !a:bang && line('$') != 1 && getline(1) != '' 
    throw 'TE001: This buffer has something in it! use :Template! to override the buffer contents'
  endif
  let l:settings = s:T[a:lang][a:name]
  let l:template = s:sfile . '/templates/' . a:lang . '/' . l:settings.temp
  exe 'set ft=' . l:settings.ft
  let l:output = templates#render#render(l:template, l:settings)
  if a:bang
    sil norm! gg"_dG
  endif
  call append(0, l:output)
  sil norm! zR
  sil norm! G"_ddgg
  let l:insert = match(l:output, s:insert_pat)
  if l:insert > -1
    let l:insert_line = substitute(l:output[l:insert], '%\{2\}\s*INSERT\s*%\{2\}', '', '')
    let l:insert_location = match(l:output[l:insert], '%\{2\}\s*INSERT\s*%\{2\}')
    call setline(l:insert+1, l:insert_line)
    call cursor(l:insert+1, l:insert_location+1)
    startinsert
  endif
endfunction

function! templates#completion(A, L, P) abort
  let l:args = matchlist(a:L, 'Template!\?\s*\(\S*\)\(\s*\)\(\S*\).*') 
  if len(l:args[2]) == 0
    return join(keys(s:T), "\n") . "\n"
  else
    if !has_key(s:T, l:args[1])
      return ''
    endif
    return join(keys(s:T[l:args[1]]), "\n") . "\n"
  endif
endfunction

" Misc: {{{1
" vim: set ft=vim ts=2 sw=2 tw=78 et fdm=marker:
