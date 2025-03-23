from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from .models import *
from .serializers import RescueInstanceSerializer
from rest_framework import status
from rest_framework.parsers import MultiPartParser, FormParser

class RescueInstanceListCreateAPIView(APIView):
    authentication_classes = [TokenAuthentication]
    # permission_classes = [IsAuthenticated]  # Uncomment if you want to enforce authentication
    parser_classes = [MultiPartParser, FormParser]  # Required for file uploads

    def get(self, request):
        # Retrieve all rescue instances and their associated media
        rescue_instances = RequestRescue.objects.all()
        serializer = RescueInstanceSerializer(rescue_instances, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        # Create a new rescue instance along with associated media
        print("POST Data:", request.POST)  # Debugging
        print("FILES:", request.FILES)     # Debugging
        serializer = RescueInstanceSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"success": "Data successfully registered"}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# POST /api/rescue-instances/ HTTP/1.1
# Authorization: Token <your_token_here>
# Content-Type: multipart/form-data

# {
#     "name": "Rescue Request #1",
#     "explanation": "Urgent rescue needed",
#     "additional_information": "The situation is critical.",
#     "address": "123 Street Name",
#     "state": "SomeState",
#     "city": "SomeCity",
#     "phone_number": "1234567890",
#     "media": [
#         <image_file_1>, <image_file_2>, <image_file_3>
#     ]
# }
