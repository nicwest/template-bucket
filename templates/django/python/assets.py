from django_assets import Bundle, register

js_all = Bundle(
    'filename.js',
    filters="jsmin",
    output='generated/packed.js')

css_all = Bundle(
    'filename.sass',
    filters='scss',
    output='generated/sass.css',
    depends='sass/*.scss')

register('js_all', js_all)
register('css_all', css_all)
