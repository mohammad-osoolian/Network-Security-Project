from django.contrib import admin
from panel.models import HostInfo

@admin.register(HostInfo)
class HostInfoAdmin(admin.ModelAdmin):
    pass
