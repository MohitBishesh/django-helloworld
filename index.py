from flask import Flask
helloworld = Flask(__name__)
@helloworld.route("/")
def run():
    return "{\"message\":\"Hello I am Mohit and this is my flask App.\"}"
if __name__ == "__main__":
    helloworld.run(host="0.0.0.0",port=int("3000"),debug=True)

