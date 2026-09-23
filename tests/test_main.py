from fastapi.testclient import TestClient
from mi_api.main import app

client = TestClient(app)

def test_root():
    respuesta = client.get("/")
    assert respuesta.status_code == 200
    assert respuesta.json() == {"mensaje": "¡Hola desde mi API empaquetada!"}

def test_salud():
    respuesta = client.get("/salud")
    assert respuesta.status_code == 200