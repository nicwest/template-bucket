from django.contrib import admin
from . import models


class Admin(admin.ModelAdmin):
    search_fields = ('field_name', )
    list_display = ('field_name', )


admin.site.register(models.Model, Admin)
