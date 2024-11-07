from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Carro(BaseModel):
    id: int
    marca: str
    modelo: str
    ano: int
    cor: str

# Banco de dados fictício
carros_db = [
    {"id": 1, "marca": "Toyota", "modelo": "Corolla", "ano": 2020, "cor": "Prata"},
    {"id": 2, "marca": "Honda", "modelo": "Civic", "ano": 2019, "cor": "Preto"},
]

# Listar todos os carros
@app.get("/carros", response_model=List[Carro])
def listar_carros():
    return carros_db

# Adicionar um carro
@app.post("/carros")
def adicionar_carro(carro: Carro):
    carros_db.append(carro.dict())
    return {"mensagem": "Carro adicionado com sucesso"}

# Atualizar informações de um carro
@app.put("/carros/{id}")
def atualizar_carro(id: int, carro: Carro):
    for index, c in enumerate(carros_db):
        if c["id"] == id:
            carros_db[index] = carro.dict()
            return {"mensagem": "Carro atualizado com sucesso"}
    raise HTTPException(status_code=404, detail="Carro não encontrado")

# Deletar um carro
@app.delete("/carros/{id}")
def deletar_carro(id: int):
    for index, carro in enumerate(carros_db):
        if carro["id"] == id:
            carros_db.pop(index)
            return {"mensagem": "Carro deletado com sucesso"}
    raise HTTPException(status_code=404, detail="Carro não encontrado")