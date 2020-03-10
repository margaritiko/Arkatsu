from rest_framework import serializers
from web.models import Category
from web.models import Student
from web.models import DailyBonus

class DailyBonusSerializer(serializers.ModelSerializer):
    class Meta:
        model = DailyBonus
        fields = ['title', 'description']


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ['title', 'first', 'second', 'third', 'forth', 'first_cost', 'second_cost', 'third_cost', 'forth_cost']


class StudentSerializer(serializers.ModelSerializer):
    category_set = CategorySerializer(many=False, read_only=True)
    class Meta:
        model = Student
        fields = ['achievments', 'name', 'status', 'level', 'category_set']

