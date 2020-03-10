from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse

@csrf_exempt
def create_user(request, username):
    if (username != "Piki"):
        return HttpResponse(username)
    return None