#!/usr/bin/python3
"""
script that starts a Flask web application:
display “Hello HBNB!” if route is like /
display “HBNB” if route is like /hbnb
"""

from flask import Flask
app = Flask(__name__)


@app.route('/', strict_slashes=False)
def main():
    return 'Hello HBNB!'


@app.route('/hbnb', strict_slashes=False)
def hbnb():
    return 'HBNB'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
