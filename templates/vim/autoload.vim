" Vimscript Setup: {{{1
let s:save_cpo = &cpo
set cpo&vim

" Private Functions: {{{1
function! s:local_function()
  echom "change s:local_function"
endfunction

" Library Interface: {{{1
function! %%BASENAME%%#some_function()
  echo "Hello world!"
endfunction

" Teardown:{{{1
let &cpo = s:save_cpo

" Misc: {{{1
%%MODELINE%%
