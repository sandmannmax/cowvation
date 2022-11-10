from rest_framework import serializers
from .models import Cow, User, AgrOp, WorkRelation, Message

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['password','username','first_name','last_name','email']

class AgrOpSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = AgrOp
        fields = ['owner','post_code','city','street','street_number']

class AgrOpGetSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = AgrOp
        fields = ['owner','post_code','city','street','street_number','search_code']

class AgrOpAddSerializer(serializers.ModelSerializer):
    class Meta:
        model = AgrOp
        fields = ['owner','post_code','city','street','street_number', 'owner_user', 'search_code']

class CowSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cow
        fields = ['number','image_one','image_two','image_three','number_ear','race','color_tendency','height','manual','fetch','group', 'agrop']

class CowListSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Cow
        fields = ['number','number_ear','race']

class WorkRelationSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkRelation
        fields = ['user','agrop','accepted','denied', 'canChangeCow']

class WorkRelationUserSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    first_name = serializers.CharField(max_length = 30)
    last_name = serializers.CharField(max_length = 150)
    canChangeCow = serializers.BooleanField()

    class Meta:
        fields = ['id','first_name','last_name','canChangeCow']

class WorkRelationListNewSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    owner = serializers.CharField(max_length = 50)
    post_code = serializers.CharField(max_length = 5)
    city = serializers.CharField(max_length = 30)
    street = serializers.CharField(max_length = 30)
    street_number = serializers.IntegerField()
    first_name = serializers.CharField(max_length = 30)
    last_name = serializers.CharField(max_length = 150)

    class Meta:
        fields = ['id', 'owner', 'post_code', 'city', 'street', 'street_number', 'first_name', 'last_name']

class WorkRelationCheckSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkRelation
        fields = ['accepted','denied']

class MessagesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['text', 'receiver', 'sender', 'created']

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['first_name', 'last_name']
