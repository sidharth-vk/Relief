from django.db import models

class RequestRescue(models.Model):
    name = models.CharField(max_length=255,blank=True)
    explanation = models.TextField(blank=True)
    additional_information = models.TextField(blank=True)
    address = models.CharField(max_length=255,blank=True)
    state = models.CharField(max_length=100,blank=True)
    city = models.CharField(max_length=100,blank=True)
    phone_number = models.CharField(max_length=15,blank=True)

    def __str__(self):
        return self.name


class Media(models.Model):
    rescue_instance = models.ForeignKey(RequestRescue, related_name='media', on_delete=models.CASCADE,blank=True)
    image = models.ImageField(upload_to='rescue_images/',blank=True)

    def __str__(self):
        return f"Image {self.id} for Rescue {self.rescue_instance.name}"
