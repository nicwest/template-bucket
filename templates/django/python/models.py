from django.conf import settings
from django.db import models
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _
%%DJANGO_RELATED_IMPORTS%%


class Model(models.Model):
    """
    Write Docs!
    """
    feild_name = models.CharField(_('field name'), max_length=255)

    class Meta:
        verbose_name = _('model name')
        verbose_name_plural = _('model names')

    def method_name(self):
        pass

    def __unicode__(self):  # pragma: no cover
        return self.field_name
