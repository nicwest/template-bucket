" Used for local development, with vim-scriptease
let s:path = expand('<sfile>:p:h')
exe 'Runtime'  s:path . '/plugin/templates.vim' 
exe 'Runtime'  s:path . '/autoload/templates.vim'
exe 'Runtime'  s:path . '/autoload/templates/render.vim'
exe 'Runtime'  s:path . '/autoload/templates/vars.vim'
