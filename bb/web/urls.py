from django.urls import path
from . import views
from django.contrib import admin
from rest_framework import routers
from django.conf.urls import include, url
from rest_framework import viewsets
from web.serializers import *

router = routers.DefaultRouter()
router.register(r'students', Student)
router.register(r'daily_bonus', DailyBonus)
router.register(r'categories', Category)


class StudentViewSet(viewsets.ModelViewSet):
    queryset = Student.objects.all()
    serializer_class = StudentSerializer

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class DailyBonusViewSet(viewsets.ModelViewSet):
    queryset = DailyBonus.objects.all()
    serializer_class = DailyBonusSerializer


urlpatterns = [
    path('admin/', admin.site.urls),
    path('create_user/<username>', views.create_user),
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]

