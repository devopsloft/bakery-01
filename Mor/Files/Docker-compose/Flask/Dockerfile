FROM python:3-onbuild
COPY . /usr/src/app
WORKDIR /usr/src/app
EXPOSE 5000
RUN pip install -r requirements.txt
CMD [ "python","app.py" ]