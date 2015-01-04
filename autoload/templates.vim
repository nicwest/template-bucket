let s:sfile = expand('<sfile>:p:h:h')
let s:T = {} " Template dict

" Templates: {{{1
" Vim: {{{2
let s:T.vim = {}
let s:T.vim.plugin = {'ft': 'vim', 'temp': 'plugin.vim'}
let s:T.vim.autoload = {'ft': 'vim', 'temp': 'autoload.vim'}
" Django: {{{2
let s:T.django = {}
let s:T.django.admin = {'ft': 'python.django', 'temp': 'python/admin.py'}
let s:T.django.assets = {'ft': 'python.django', 'temp': 'python/assets.py'}
let s:T.django.celery = {'ft': 'python.django', 'temp': 'python/celery.py'}
let s:T.django.signals = {'ft': 'python.django', 'temp': 'python/signals.py'}
let s:T.django.views = {'ft': 'python.django', 'temp': 'python/views.py'}
let s:T.django.models = {'ft': 'python.django', 'temp': 'python/models.py'}
let s:T.django.forms = {'ft': 'python.django', 'temp': 'python/forms.py'}
let s:T.django.unittests = {'ft': 'python.django', 'temp': 'python/unittests.py'}
let s:T.django.factories = {'ft': 'python.django', 'temp': 'python/factories.py'}
let s:T.django.base = {'ft': 'htmldjango', 'temp': 'html/base.html'}
let s:T.django.content = {'ft': 'htmldjango', 'temp': 'html/content.html'}
" Python: {{{2
let s:T.python = {}
let s:T.python.tasks = {'ft': 'python', 'temp': 'tasks.py'}

" Patterns: {{{1
let s:insert_pat = '^.*%\{2\}\s*INSERT\s*%\{2\}.*$'

" Functions: {{{1
function! templates#apply(bang, lang, name) abort
  if !a:bang && line('$') != 1 && getline(1) != '' 
    throw 'TE001: This buffer has something in it! use :Template! to override the buffer contents'
  endif
  let l:settings = s:T[a:lang][a:name]
  let l:template = s:sfile . '/templates/' . a:lang . '/' . l:settings.temp
  let b:template = a:lang . '/' . l:settings.temp
  exe 'set ft=' . l:settings.ft
  let l:output = templates#render#render(l:template, l:settings)
  if a:bang
    sil norm! gg"_dG
  endif
  call append(0, l:output)
  sil norm! zR
  sil norm! G"_ddgg
endfunction

function! templates#edit(...) abort
  if a:0 == 0
    if exists('b:template')
      exe 'sf' s:sfile . '/templates/' . b:template
    else
      throw 'There is no record of what template was used to create this file'
    endif
  elseif a:0 == 2
    let l:settings = s:T[a:1][a:2]
    let l:template = a:1 . '/'. l:settings.temp
    exe 'sf' s:sfile . '/templates/' . l:template
  else
    throw 'Not enough arguments :('
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
