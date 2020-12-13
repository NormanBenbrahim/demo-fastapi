from fastapi import FastAPI 
from enum import Enum 
import uvicorn 
import logging 
import json 
from routers import health_check

formatter = logging.Formatter('%(asctime)s: %(levelname)s: %(message)s')

app = FastAPI()

# root route
@app.get("/")
async def root():
    return {200: "Successfully connected to API, visit /docs to view all routes"}

# include other routes

app.include_router(health_check.router)

if __name__ == '__main__':
    uvicorn.run(app, debug=True, host="0.0.0.0", port=8080)
    
    