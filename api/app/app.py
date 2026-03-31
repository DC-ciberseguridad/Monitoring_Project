import os
import uuid
from fastapi import FastAPI
from mangum import Mangum
import boto3
from pydantic import BaseModel

app = FastAPI()

# Configuración de DynamoDB
# Usamos variables de entorno para que sea flexible
TABLE_NAME = os.environ.get("DYNAMODB_TABLE", "tickets")
dynamodb = boto3.resource("dynamodb", region_name="us-east-1")
table = dynamodb.Table(TABLE_NAME)

# Modelo de datos para validar la entrada
class Event(BaseModel):
    service_name: str
    status: str
    message: str

@app.get("/")
def read_root():
    return {"status": "API de Monitoreo Activa"}

@app.post("/events")
def create_event(event: Event):
    event_id = str(uuid.uuid4())
    
    # Insertar en DynamoDB
    table.put_item(
        Item={
            "ticket_id": event_id,     # Tu Hash Key de Terraform
            "service_name": event.service_name,
            "status": event.status,
            "message": event.message    # <-- ¡No olvides este!
        }
    )
    
    return {"message": "Evento registrado", "ticket_id": event_id}

# El handler para que AWS Lambda pueda ejecutar FastAPI
handler = Mangum(app)