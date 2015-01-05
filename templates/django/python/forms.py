from django import forms
from django.core.exceptions import ValidationError
from django.utils.translation import ugettext_lazy as _
%%DJANGO_RELATED_IMPORTS%%


class Form(forms.Form):
    """
    Write Docs!
    """
    field_name = forms.CharField(max_length=255)

    def clean_field_name(self):
        field_name = self.cleaned_data.get('field_name')
        if something:
            raise ValidationError('Something went wrong')
        return field_name

    def clean(self):
        data = self.cleaned_data
        field_name = data.get('field_name')

        if something:
            self.add_error('field_name', ValidationError('Broken!'))

        return data


class Form(forms.ModelForm):
    """
    Write Docs!
    """

    class Meta:
        model = models.Model
        fields = ('field_name',)
        labels = {
            'field_name': _('This is a Field!'),
        }
        error_messages = {
            'field_name': {
                'required': _('This field is required :('),
            },
        }
