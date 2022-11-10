from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework import status
from django.contrib.auth.hashers import make_password
from django.http import Http404

import string, random

from .models import Cow, WorkRelation, User, AgrOp, Message
from .serializer import UserSerializer, CowSerializer, CowListSerializer, AgrOpSerializer, WorkRelationCheckSerializer
from .serializer import AgrOpAddSerializer, WorkRelationSerializer, MessagesSerializer, WorkRelationListNewSerializer

def generate_search_code():
    lettersAndDigits = string.ascii_uppercase + string.digits
    return ''.join(random.choice(lettersAndDigits) for i in range(6))

class Register(APIView):
    permission_classes = (AllowAny,)

    def post(self, request, format = None):
        newUser = {
            'password': '',
            'username': request.POST.get('username',''),
            'first_name': request.POST.get('first_name',''),
            'last_name': request.POST.get('last_name',''),
            'email': request.POST.get('email',''),
        }
        password = request.POST.get('password','')
        if password != '':
            newUser['password'] = make_password(password)
        else:
            newUser['password'] = password
        serialized = UserSerializer(data=newUser)
        if serialized.is_valid():
            serialized.save()
            return Response(serialized.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serialized._errors, status=status.HTTP_400_BAD_REQUEST)

class AgrOpView(APIView):
    permission_classes = (IsAuthenticated,)

    def get_object(self, pk):
        try:
            return AgrOp.objects.get(pk = pk)
        except AgrOp.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        agrop = self.get_object(pk)
        workRelation = WorkRelation.objects.all().filter(agrop = agrop).filter(user__id = request.user.id)
        if len(workRelation) > 0:
            serializer = AgrOpSerializer(agrop)
            return Response(serializer.data)
        else:
            return Response({'detail': 'Permission Denied'}, status=status.HTTP_403_FORBIDDEN)

    def post(self, request, pk, format=None):
        agrop = self.get_object(pk)
        if betrieb.owner_user == request.user:
            changedAgrOp = {
                'owner': request.POST.get('owner', agrop.owner),
                'post_code': request.POST.get('post_code', agrop.post_code),
                'city': request.POST.get('city', agrop.city),
                'street': request.POST.get('street', agrop.street),
                'street_number': request.POST.get('street_number', agrop.street_number),
            }
            serializer = AgrOpSerializer(agrop, data=changedAgrOp)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({'detail': 'Permission Denied'}, status=status.HTTP_403_FORBIDDEN)

class AgrOpAddView(APIView):
    permission_classes = (IsAuthenticated,)

    def post(self, request, format=None):
        acc = False
        newSearchCode = ''
        while not acc:
            newSearchCode = generate_search_code()
            agrOpSC = AgrOp.objects.all().filter(search_code = newSearchCode)
            if len(agrOpSC) == 0:
                acc = True
        newAgrOp = {
            'owner': request.POST.get('owner', ''),
            'post_code': request.POST.get('post_code', ''),
            'city': request.POST.get('city', ''),
            'street': request.POST.get('street', ''),
            'street_number': request.POST.get('street_number', ''),
            'owner_user': request.user.pk,
            'search_code': newSearchCode,
        }
        serializer = AgrOpAddSerializer(data=newAgrOp)
        if serializer.is_valid():
            savedAgrOp = serializer.save()
            newWorkRelation = WorkRelation()
            newWorkRelation.user = request.user
            newWorkRelation.agrop = savedAgrOp
            newWorkRelation.accepted = True
            newWorkRelation.denied = False
            newWorkRelation.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class WorkRelationAddView(APIView):
    permission_classes = (IsAuthenticated,)

    def get_agrop(self, search_code):
        try:
            return AgrOp.objects.get(search_code = search_code)
        except AgrOp.DoesNotExist:
            raise Http404

    def post(self, request, format=None):
        search_code = request.POST.get('search_code', '')
        agrop = self.get_agrop(search_code)
        newWorkRelation = {
            'user': str(request.user.pk),
            'agrop': str(agrop.pk),
            'accepted': '0',
            'denied': '0',
        }
        serializer = WorkRelationSerializer(data=newWorkRelation)
        if serializer.is_valid():
            newWorkRelation = serializer.save()
            newMessage = Message()
            newMessage.text = 'NEW_WORKER'
            newMessage.sender = request.user
            newMessage.receiver = newWorkRelation.agrop.owner_user
            newMessage.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class WorkRelationListNewView(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        uncheckedWR = WorkRelation.objects.all().filter(agrop__owner_user = request.user).filter(accepted = False).filter(denied = False)
        uncheckedWorkRelations = []
        for wr in uncheckedWR:
            newWR = {
                'id': wr.id,
                'owner': wr.agrop.owner,
                'post_code': wr.agrop.post_code,
                'city': wr.agrop.city,
                'street': wr.agrop.street,
                'street_number': wr.agrop.street_number,
                'first_name': wr.user.first_name,
                'last_name': wr.user.last_name,
            }
            uncheckedWorkRelations.append(newWR)
        serializer = WorkRelationListNewSerializer(uncheckedWorkRelations, many=True)
        return Response(serializer.data)

class WorkRelationCheckView(APIView):
    permission_classes = (IsAuthenticated,)

    def get_object(self, pk):
        try:
            return WorkRelation.objects.get(pk = pk)
        except WorkRelation.DoesNotExist:
            raise Http404

    def post(self, request, pk):
        workRelation = self.get_object(pk)
        accepted = request.POST.get('accepted', '')
        if accepted == '1':
            newWorkRelation = {
                'accepted': '1',
                'denied': '0',
            }
        elif accepted == '0':
            newWorkRelation = {
                'accepted': '0',
                'denied': '1',
            }
        else:
            return Response({'accepted': 'This field must be 1 or 0.'}, status=status.HTTP_400_BAD_REQUEST)
        serializer = WorkRelationCheckSerializer(workRelation, data=newWorkRelation)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class MessageView(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        messages = Message.objects.all().filter(receiver = request.user)
        serializer = MessagesSerializer(messages, many=True)
        context = serializer.data
        context.append({'number':len(context)})
        return Response(context)

class CowListView(APIView):
    permission_classes = (IsAuthenticated,)

    def get_agrop(self, pk):
        try:
            return AgrOp.objects.get(pk = pk)
        except AgrOp.DoesNotExist:
            raise Http404

    def get(self, request, pkAgrOp):
        agrop = self.get_agrop(pkAgrOp)
        workRelation = WorkRelation.objects.all().filter(agrop = agrop).filter(user = request.user)
        if len(workRelation) == 1:
            cowlist = Cow.objects.all().filter(agrop = agrop)
            serializer = CowListSerializer(cowlist, many=True)
            return Response(serializer.data)
        else:
            return Response({'detail': 'Permission Denied'}, status=status.HTTP_403_FORBIDDEN)

class CowView(APIView):
        permission_classes = (IsAuthenticated,)

        def get_cow(self, pk):
            try:
                return Cow.objects.get(pk = pk)
            except Cow.DoesNotExist:
                raise Http404

        def get_agrop(self, pk):
            try:
                return AgrOp.objects.get(pk = pk)
            except AgrOp.DoesNotExist:
                raise Http404

        def get(self, request, pkAgrOp, pk):
            cow = self.get_cow(pk)
            agrop = self.get_agrop(pkAgrOp)
            workRelation = WorkRelation.objects.all().filter(agrop = cow.agrop).filter(user = request.user)
            if len(workRelation) == 1 and agrop == cow.agrop:
                serializer = CowSerializer(cow)
                return Response(serializer.data)
            else:
                return Response({'detail': 'Permission Denied'}, status=status.HTTP_403_FORBIDDEN)

        def post(self, request, pkAgrOp, pk, format=None):
            cow = self.get_cow(pk)
            agrop = self.get_agrop(pkAgrOp)
            workRelation = WorkRelation.objects.all().filter(agrop = cow.agrop).filter(user = request.user)
            if len(workRelation) == 1 and agrop == cow.agrop:
                serializer = CowSerializer(cow, data=request.data)
                if serializer.is_valid():
                    serializer.save()
                    return Response(serializer.data)
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            else:
                return Response({'detail': 'Permission Denied'}, status=status.HTTP_403_FORBIDDEN)

        def delete(self, request, pkAgrOp, pk, format=None):
            cow = self.get_cow(pk)
            agrop = self.get_agrop(pkAgrOp)
            if cow.agrop.owner_user == request.user and agrop == cow.agrop:
                cow.delete()
                return Response(status=status.HTTP_204_NO_CONTENT)
            else:
                return Response({'detail': 'Permission Denied'}, status=status.HTTP_403_FORBIDDEN)

class CowAddView(APIView):
        permission_classes = (IsAuthenticated,)

        def get_agrop(self, pk):
            try:
                return AgrOp.objects.get(pk = pk)
            except AgrOp.DoesNotExist:
                raise Http404

        def post(self, request, pkAgrOp, format=None):
            agrop = self.get_agrop(pkAgrOp)
            if agrop.owner_user == request.user:
                serializer = CowSerializer(data=request.data)
                if serializer.is_valid():
                    serializer.save()
                    return Response(serializer.data)
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            else:
                return Response({'detail': 'Permission Denied'}, status=status.HTTP_403_FORBIDDEN)
