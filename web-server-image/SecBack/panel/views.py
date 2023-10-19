from django.shortcuts import render
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json
from panel.models import HostInfo

@csrf_exempt
def postinfo(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        HostInfo.objects.create(
            total_memory = data["TotalMemory"],
            cpu_model = data["CPUModel"], 
            os = data["OperatingSystem"], 
            disk_space = data["DiskSpace"], 
            hostname = data["Hostname"], 
            MACs = data["MACAddresses"], 
            users = data["UserAccounts"], 
            available_memory = data["AvailableMemory"], 
            disk_usage = data["DiskUsage"], 
            IPs = data["IPAddresses"], 
            kernel = data["KernelVersion"], 
            free_space = data["FreeSpace"], 
            open_ports = data["OpenPorts"], 
            )

    return HttpResponse(200)