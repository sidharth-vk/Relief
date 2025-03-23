from rest_framework import serializers
from .models import RequestRescue, Media

class MediaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Media
        fields = ['id', 'image']

class RescueInstanceSerializer(serializers.ModelSerializer):
    media = serializers.ListField(
        child=serializers.FileField(),
        required=False,
        allow_empty=True
    )

    class Meta:
        model = RequestRescue
        fields = ['id', 'name', 'explanation', 'additional_information', 'address', 'state', 'city', 'phone_number', 'media']

    def create(self, validated_data):
        media_data = validated_data.pop('media', [])
        rescue_instance = RequestRescue.objects.create(**validated_data)
        
        for media_file in media_data:
            Media.objects.create(rescue_instance=rescue_instance, image=media_file)
        
        return rescue_instance