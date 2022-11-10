from django.contrib import admin
from .models import Cow, AgrOp, User, WorkRelation

admin.site.register(User)
admin.site.register(AgrOp)
admin.site.register(WorkRelation)
admin.site.register(Cow)
