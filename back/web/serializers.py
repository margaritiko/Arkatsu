from rest_framework.authtoken.serializers import AuthTokenSerializer
from rest_framework import serializers

from django.contrib.auth.models import User

from . import models


class StudentAuthTokenSerializer(AuthTokenSerializer):
    def validate(self, attrs):
        attrs = super().validate(attrs)
        user = attrs["user"]
        try:
            student = models.Student.objects.get(user=user)
        except models.Student.DoesNotExist:
            msg = _("No such Student")
            raise serializers.ValidationError(msg, code="authorization")
        return attrs


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    def create(self, validated_data):
        user = User(username=validated_data["username"])
        user.set_password(validated_data["password"])
        user.save()
        return user

    class Meta:
        model = User
        fields = ("username", "password")


class StudentRegistrationSerializer(serializers.ModelSerializer):
    user = UserSerializer(write_only=True)

    class Meta:
        model = models.Student
        fields = ("user", "name", "group")

    def create(self, validated_data):
        user_data = validated_data.pop("user")
        user = UserSerializer.create(UserSerializer(), validated_data=user_data)
        student = models.Student.objects.create(
            name=validated_data["name"], user=user, group=validated_data["group"]
        )
        return student


class EventSerializer(serializers.ModelSerializer):
    organization = serializers.SerializerMethodField()

    def get_organization(self, instance):
        return instance.organization.name

    class Meta:
        model = models.Event
        fields = ("organization", "name", "description")


class AchievmentSerializer(serializers.ModelSerializer):
    event = serializers.SerializerMethodField()

    def get_event(self, instance):
        return instance.event.name

    class Meta:
        model = models.Achievment
        fields = ("event", "name", "description")
