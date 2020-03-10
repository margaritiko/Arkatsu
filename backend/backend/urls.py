"""backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from rest_framework import viewsets
from rest_framework import routers
from back.serializers import *
from back.models import *
from back import views
from django.conf.urls import include, url

# ViewSets define the view behavior.

class StudentViewSet(viewsets.ModelViewSet):
    queryset = Student.objects.all()
    serializer_class = StudentSerializer

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class DailyBonusViewSet(viewsets.ModelViewSet):
    queryset = DailyBonus.objects.all()
    serializer_class = DailyBonusSerializer

router = routers.DefaultRouter()
router.register(r'students', Student, basename='Student')
router.register(r'daily_bonus', DailyBonus, basename='DailyBonus')
router.register(r'categories', Category, basename='Category')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('create_user/<username>', views.create_user),
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
