from fastapi import FastAPI

app = FastAPI(title="Mi API de ejemplo")

@app.get("/")
def root():
    return {"mensaje": "¡Hola desde mi API empaquetada!"}

@app.get("/salud")
def salud():
    return {"estado": "ok"}