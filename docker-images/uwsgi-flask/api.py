import flask

app = flask.Flask(__name__)

@app.route('/', methods=['GET'])
def help():
    return "Hello World"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080, threaded=True)
