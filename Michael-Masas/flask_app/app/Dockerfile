FROM python:3.9-buster
RUN mkdir /usr/src/app/
COPY . /usr/src/app/
WORKDIR /usr/src/app/
EXPOSE 5000
RUN pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r ./requirements.txt
RUN chmod 550 ./app.py 
CMD ["python", "app.py"]
