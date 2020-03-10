from django.db import models
from django.contrib.auth.models import User
from django.contrib.postgres.fields import ArrayField

class Category(models.Model):
    title = models.CharField(max_length=25)
    first = models.CharField(max_length=25)
    second = models.CharField(max_length=25)
    third = models.CharField(max_length=25)
    forth = models.CharField(max_length=25)

    first_cost = models.IntegerField()
    second_cost = models.IntegerField()
    third_cost = models.IntegerField()
    forth_cost = models.IntegerField()


class Student(models.Model):
    achievments = ArrayField(models.CharField(max_length=100), default=list)
    name = models.CharField(max_length=100)
    status = models.CharField(max_length=25)
    level = models.IntegerField()

    categories = models.ManyToManyField(Category)


class DailyBonus(models.Model):
    title = models.CharField(max_length=64)
    description = models.CharField(max_length=256)
