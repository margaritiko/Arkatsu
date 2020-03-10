from django.contrib import admin
from django.urls import path
from django.conf.urls import include, url
from rest_framework import routers
from data.serializers import *
from data.sets import *
from data import views
from data.models import *

router = routers.DefaultRouter()
router.register(r'students', Student)
router.register(r'daily_bonus', DailyBonus)
router.register(r'categories', Category)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('create_user/<username>', views.create_user),
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
