from django.conf.urls import patterns, url
%%DJANGO_RELATED_IMPORTS%%

urlpatterns = patterns(
    "",
    url(r'^$', views.View, name='home'),
    url(r'slug/(?P<slug>\w+)/$', views.View, name='display')
)
