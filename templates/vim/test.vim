let s:suite = themis#suite('%%BASENAME%%')
let s:assert = themis#helper('assert')

function! s:suite.before() abort
  call ForceLoad('%%BASENAME%%')
  let s:sid = GetSID('autoload/%%BASENAME%%.vim')
endfunction

function! s:suite.after_each() abort
  norm! gg"_dG
endfunction

