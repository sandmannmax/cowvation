from django.urls import path
from . import views

urlpatterns = [
    path('registrieren/', views.Register.as_view()),
    path('betrieb/', views.AgrOpView.as_view()),
    path('betrieb/erstellen/', views.AgrOpAddView.as_view()),
    path('arbeit/', views.WorkRelationAddView.as_view()),
    path('betrieb/arbeit/', views.WorkRelationNewView.as_view()),
    path('nachrichten/', views.MessageView.as_view()),
    path('kuh/', views.CowView.as_view()),
    path('kuh/hinzufuegen/', views.CowAddView.as_view()),
    path('betrieb/mitarbeiter/', views.WorkRelationAgropView.as_view()),
    path('benutzer/', views.UserView.as_view()),
]
