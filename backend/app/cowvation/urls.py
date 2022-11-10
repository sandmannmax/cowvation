from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('token/', TokenObtainPairView.as_view()),
    path('token/refresh/', TokenRefreshView.as_view()),
    path('', include('api.urls')),
    path('v2/token/', TokenObtainPairView.as_view()),
    path('v2/token/refresh/', TokenRefreshView.as_view()),
    path('v2/', include('apiv2.urls')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
