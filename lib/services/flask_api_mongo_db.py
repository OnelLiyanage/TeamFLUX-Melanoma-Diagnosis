# from crypt import methods
from http import client
from unittest import result
from flask import Flask,Response,request,session
from flask_ngrok import run_with_ngrok

#-----------DATABASE--------------#
import pymongo
client = pymongo.MongoClient()
mydb = client["mydb"]

#------------#
app = Flask(__name__)
run_with_ngrok(app)

@app.route('/webhook', methods = ["GET", "POST"])
def webhook():
	req=request.get_json(force=True)
	session=req["session"]
	query=req["queryResult"]["queryText"]
	result=req["queryResult"]["fulfillmentText"]

#---------------- Inserting in Database --------------------#

	data={"Query":query,
	"Result":result }
	mycol=mydb[session]
	mycol.insert_one(data)
	
	return Response(status=200)
	
#------------------------------------#

if __name__ == '__main__':
	app.run()