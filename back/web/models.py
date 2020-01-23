from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class Student(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)

    name = models.CharField(max_length=25)
    group = models.CharField(max_length=25)
    age = models.IntegerField(default=1)


class StudentOrganization(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)

    name = models.CharField(max_length=25)
    description = models.TextField()


class Event(models.Model):
    organization = models.ForeignKey(
        StudentOrganization, related_name="events", on_delete=models.CASCADE
    )
    students = models.ManyToManyField(Student, related_name="events")

    name = models.CharField(max_length=25)
    description = models.TextField()


class Achievment(models.Model):
    event = models.ForeignKey(
        Event, related_name="achievments", on_delete=models.CASCADE
    )
    students = models.ManyToManyField(Student, related_name="achievments")

    name = models.CharField(max_length=25)
    description = models.TextField()

