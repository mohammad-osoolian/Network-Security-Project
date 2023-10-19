from django.db import models

class HostInfo(models.Model):
    total_memory = models.CharField(max_length=512)
    cpu_model = models.CharField(max_length=512)
    os = models.CharField(max_length=512)
    disk_space = models.CharField(max_length=512)
    hostname = models.CharField(max_length=512)
    MACs = models.CharField(max_length=512)
    users = models.CharField(max_length=512)
    available_memory = models.CharField(max_length=512)
    disk_usage = models.CharField(max_length=512)
    IPs = models.CharField(max_length=512)
    kernel = models.CharField(max_length=512)
    free_space = models.CharField(max_length=512)
    open_ports = models.CharField(max_length=512)

    def __str__(self):
        return self.IPs.split(' ')[0]