FROM python:3.9.2-alpine
WORKDIR /usr/src/app
COPY ./requirements.txt /usr/src/app
RUN pip install -r requirements.txt
COPY . /usr/src/app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
