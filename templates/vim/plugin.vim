" Vimscript Setup: {{{1
let s:save_cpo = &cpo
set cpo&vim

" load guard
" uncomment after plugin development.
"if exists("g:loaded_%%BASENAME%%")
"      \ || v:version < %%VIM_VERSION%%
"      \ || v:version == %%VIM_VERSION%% && !has('patch%%VIM_PATCH%%')
"  let &cpo = s:save_cpo
"  finish
"endif
"let g:loaded_%%BASENAME%% = 1

" Options: {{{1
if !exists('g:%%BASENAME%%_some_plugin_option')
  let g:%%BASENAME%%_some_plugin_option = 0
endif


" Teardown: {{{1
let &cpo = s:save_cpo

" Misc: {{{1
%%MODELINE%%
