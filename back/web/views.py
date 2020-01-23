from django.shortcuts import render, get_object_or_404

from rest_framework import status
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveUpdateAPIView
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView


from . import serializers, models

# Create your views here.


class ObtainStudentAuthTokenAPIView(ObtainAuthToken):
    serializer_class = serializers.StudentAuthTokenSerializer


class StudentRegisterAPIView(CreateAPIView):
    model = models.Student
    permission_classes = [AllowAny]
    serializer_class = serializers.StudentRegistrationSerializer


class EventsListAPIView(ListAPIView):
    model = models.Event
    serializer_class = serializers.EventSerializer

    def get_queryset(self):
        student = get_object_or_404(models.Student, user=self.request.user)
        return student.events


class AchievmentsListAPIView(ListAPIView):
    model = models.Achievment
    serializer_class = serializers.AchievmentSerializer

    def get_queryset(self):
        student = get_object_or_404(models.Student, user=self.request.user)
        event = get_object_or_404(models.Event, pk=self.kwargs["pk"])
        return models.Achievment.objects.filter(students=student, event=event)
