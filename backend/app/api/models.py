from django.db import models
from django.contrib.auth.models import AbstractUser
import os

def get_image_path(instance, filename):
    return os.path.join(str(instance.number), filename)

class User(AbstractUser):
    def __str__(self):
        ret = str(self.username) + ' - ' + str(self.first_name) + ' ' + str(self.last_name)
        return ret

class AgrOp(models.Model):
    owner = models.CharField(max_length = 50)
    owner_user = models.ForeignKey(User, on_delete = models.PROTECT)
    post_code = models.CharField(max_length = 5)
    city = models.CharField(max_length = 30)
    street = models.CharField(max_length = 30)
    street_number = models.IntegerField()
    search_code = models.CharField(max_length = 6, unique = True)

    def __str__(self):
        ret = str(self.owner) + ' ' + str(self.city)
        return ret

    class Meta:
        verbose_name_plural = "Agricaltural Operations"

class WorkRelation(models.Model):
    user = models.ForeignKey(User, on_delete = models.PROTECT)
    agrop = models.ForeignKey(AgrOp, on_delete = models.PROTECT)
    accepted = models.BooleanField()
    denied = models.BooleanField()
    canChangeCow = models.BooleanField()

    def __str__(self):
        if self.accepted == True:
            ret = str(self.user) + ' - ' + str(self.agrop) + ' - Angenommen'
        elif self.denied == True:
            ret = str(self.user) + ' - ' + str(self.agrop) + ' - Abgelehnt'
        else:
            ret = str(self.user) + ' - ' + str(self.agrop) + ' - Angefragt'
        return ret

class Cow(models.Model):
    number = models.IntegerField(primary_key=True);
    image_one = models.ImageField(upload_to=get_image_path, blank=True, null=True)
    image_two = models.ImageField(upload_to=get_image_path, blank=True, null=True)
    image_three = models.ImageField(upload_to=get_image_path, blank=True, null=True)
    number_ear = models.IntegerField(default=0);
    race = models.CharField(max_length=5, default="sb/fl")
    color_tendency = models.CharField(max_length=30, default="...")
    height = models.CharField(max_length=20, default="klein/mittel/groß")
    manual = models.BooleanField(null=False, default=False)
    fetch = models.BooleanField(null=False, default=False)
    group = models.CharField(max_length=5, choices= [('ak', 'Abkalbebox'), ('sep', 'Seperation'), ('stall', 'Stall'), ('trock', 'Trockengestellt')], default='stall')
    agrop = models.ForeignKey(AgrOp, on_delete = models.PROTECT)

    def __str__(self):
        ret = 'Kuh ' + str(self.number)
        return ret

class Message(models.Model):
    text = models.CharField(max_length = 30)
    receiver = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_messages')
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_messages')
    created = models.DateTimeField(auto_now=True)
