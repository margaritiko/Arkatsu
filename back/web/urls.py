from django.urls import path
from django.contrib.auth.views import LoginView
from django.views.generic import RedirectView

from . import views

urlpatterns = [
    path(
        "api/v1/auth-token",
        views.ObtainStudentAuthTokenAPIView.as_view(),
        name="token-auth",
    ),
    path(
        "api/v1/register",
        views.StudentRegisterAPIView.as_view(),
        name="student-register",
    ),
    path("api/v1/event/list", views.EventsListAPIView.as_view(), name="events-list"),
    path(
        "api/v1/event/<int:pk>/achievments",
        views.AchievmentsListAPIView.as_view(),
        name="achievment-list",
    ),
]

