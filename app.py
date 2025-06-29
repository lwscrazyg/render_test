import os
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/", methods=["POST"])
def hello():
    """
    Espera (opcionalmente) un JSON de entrada con un
    campo `name`.  Si no llega nada, usa “world”.
    Devuelve siempre un JSON: {"message": "..."}.
    """
    data = request.get_json(silent=True) or {}
    name = data.get("name", "world")
    return jsonify(message=f"Hello {name}, welcome to RENDER!")
