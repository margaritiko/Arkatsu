from django.contrib import admin

from .models import *

admin.site.register(Sound)
admin.site.register(User)
admin.site.register(Group)
admin.site.register(Track)
admin.site.register(Log)
admin.site.register(Location)
admin.site.register(Inventory)
admin.site.register(Effect)

