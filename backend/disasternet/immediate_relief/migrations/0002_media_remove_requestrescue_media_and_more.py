# Generated by Django 5.1.7 on 2025-03-19 06:51

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('immediate_relief', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Media',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='rescue_images/')),
            ],
        ),
        migrations.RemoveField(
            model_name='requestrescue',
            name='media',
        ),
        migrations.RemoveField(
            model_name='requestrescue',
            name='explain_situation',
        ),
        migrations.AddField(
            model_name='requestrescue',
            name='explanation',
            field=models.TextField(default=1),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='requestrescue',
            name='city',
            field=models.CharField(max_length=100),
        ),
        migrations.AlterField(
            model_name='requestrescue',
            name='state',
            field=models.CharField(max_length=100),
        ),
        migrations.DeleteModel(
            name='MediaFile',
        ),
        migrations.AddField(
            model_name='requestrescue',
            name='media',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, related_name='rescue_requests', to='immediate_relief.media'),
            preserve_default=False,
        ),
    ]
