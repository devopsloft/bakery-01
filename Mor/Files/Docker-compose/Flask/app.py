import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy


database_uri = 'postgresql+psycopg2://{dbuser}:{dbpass}@{dbhost}/{dbname}'.format(
    dbuser=os.environ['POSTGRES_USER'],
    dbpass=os.environ['POSTGRES_PASSWORD'],
    dbhost=os.environ['POSTGRES_HOST'],
    dbname=os.environ['POSTGRES_DB']
)

app = Flask(__name__)
app.config.update(
    SQLALCHEMY_DATABASE_URI=database_uri,
    SQLALCHEMY_TRACK_MODIFICATIONS=False,
)

db = SQLAlchemy(app)


@app.route('/')

def hello_world():
    return 'Hello World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=os.getenv('PORT'))
    