from django import shortcuts
from django.conf import settings
from django.contrib import messages
from django.core.urlresolvers import reverse_lazy
from django.views.generic import TemplateView
%%DJANGO_RELATED_IMPORTS%%


class View(TemplateView):
    """
    Write Docs!
    """
    template_name = '.html'

    def method_name(self):
        pass
