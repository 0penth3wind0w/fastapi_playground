import sys
from typing import Optional
import json
import uuid

sys.path.insert(1, './packages/')

import urllib3
from fastapi import FastAPI, HTTPException
from mangum import Mangum
from request_body import Something, SomeContent

# Info
NAME = "FastAPI playground"
DESCRIPTION = "Nothing useful here"
VERSION = "0.0.1"

http = urllib3.PoolManager()
app = FastAPI(title=NAME, description=DESCRIPTION, version=VERSION)

@app.get("/")
def read_root():
    """Useless Hello World"""
    return {"Hello": "World"}

@app.get("/yomomma")
def read_item(index: Optional[int] = None):
    """Get yo momma insulting joke"""
    if index is not None:
        resp = http.request('GET', f"https://yomomma-api.herokuapp.com/jokes/{index}")
    else:
        resp = http.request('GET', "https://yomomma-api.herokuapp.com/jokes")
    if resp.status != 200:
        raise HTTPException(status_code=500, detail="Fail to get data")
    data_dict = json.loads(resp.data.decode('utf-8'))   
    return {'result': data_dict['joke'], "index": index}

# Sample without implementation
@app.post("/something")
def post_something(something: Something):
    """Create something"""
    if something.uid == None:
        something.uid = str(uuid.uuid4())
    return {'result': 'success', 'method': 'POST'} | dict(something)

@app.put("/something/{uid}")
def put_something(uid: str, somecontent: SomeContent):
    """Update something that received"""
    return {'result': 'success', 'method': 'PUT', 'something': uid} | dict(somecontent)

@app.delete("/something/{uid}")
def delete_something(uid: str):
    """Delete something"""
    return {'result': 'success', 'uid': uid, 'method': 'DELETE'}

@app.patch("/something/{uid}")
def patch_something(uid: str, somecontent: SomeContent):
    """Patch something that received"""
    result = {}
    if somecontent.some_number != None:
        result = result | {'some_number': somecontent.some_number}
    if somecontent.some_string != None:
        result = result | {'some_string': somecontent.some_string}
    return {'result': 'success', 'method': 'PATCH', 'something': uid} | result

handler = Mangum(app)
