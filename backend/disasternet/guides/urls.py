# urls.py
from django.urls import path
from .views import FAQListView, FAQDetailView

urlpatterns = [
    path('faqs/', FAQListView.as_view(), name='faq-list'),
    path('faqs/<int:pk>/', FAQDetailView.as_view(), name='faq-detail'),
]
