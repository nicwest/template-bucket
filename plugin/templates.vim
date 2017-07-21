command! -bang -bar -nargs=+ -complete=custom,templates#completion
      \ Template call templates#apply("<bang>" == "!", <f-args>,)
command! -bar -nargs=* -complete=custom,templates#completion
      \ TemplateEdit call templates#edit(<f-args>)
command! -bar -nargs=* -complete=custom,templates#completion
      \ TemplateNew call templates#new(<f-args>)
