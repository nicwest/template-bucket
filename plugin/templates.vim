command! -bang -bar -nargs=+ -complete=custom,templates#completion
      \ Template call templates#apply("<bang>" == "!", <f-args>,)
