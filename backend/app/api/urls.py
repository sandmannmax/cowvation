from django.urls import path
from . import views

urlpatterns = [
    path('registrieren/', views.Register.as_view()),
    path('betrieb/erstellen/', views.AgrOpAddView.as_view()),
    path('betrieb/<int:pk>/', views.AgrOpView.as_view()),
    path('arbeitsstelle/', views.WorkRelationAddView.as_view()),
    path('arbeitsstelle/neu/', views.WorkRelationListNewView.as_view()),
    path('arbeitsstelle/<int:pk>/', views.WorkRelationCheckView.as_view()),
    path('nachrichten/', views.MessageView.as_view()),
    path('kuh/<int:pkAgrOp>/', views.CowListView.as_view()),
    path('kuh/<int:pkAgrOp>/<int:pk>/', views.CowView.as_view()),
    path('kuh/<int:pkAgrOp>/hinzufuegen/', views.CowAddView.as_view()),
]
