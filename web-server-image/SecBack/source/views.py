from django.shortcuts import render
from django.http import HttpResponse

def getscript(request):
    with open('statics/infogather.sh', 'r') as file:
        scripttext = file.read()
    return HttpResponse(scripttext, content_type="text/plain")