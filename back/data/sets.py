from rest_framework import viewsets
from data.serializers import *

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
