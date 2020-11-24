import os
from flask import Flask
app = Flask(__name__)

@app.route('/')
def welcome():
     return "Hello There, its working"

if __name__ == '__main__':
    #define the localhost ip and port
    app.run(host='0.0.0.0', port=os.getenv('PORT'))
