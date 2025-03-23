from django.urls import path
from .views import RescueInstanceListCreateAPIView

urlpatterns = [
    path('rescue-instances/', RescueInstanceListCreateAPIView.as_view(), name='rescue-instances'),
]
