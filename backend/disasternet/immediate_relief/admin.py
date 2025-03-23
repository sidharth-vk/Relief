from django.contrib import admin
from .models import *

class MediaInline(admin.TabularInline):
    model = Media
    extra = 1  # Number of empty forms to display by default (can change as needed)
    # If you want to display additional fields, you can specify them here:
    fields = ['image']

class RescueInstanceAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'state', 'city', 'phone_number']
    search_fields = ['name', 'state', 'city']
    inlines = [MediaInline]  # This adds the MediaInline to the RescueInstance form

admin.site.register(RequestRescue, RescueInstanceAdmin)
admin.site.register(Media)  # Register Media separately if you want it to be managed separately in the admin
