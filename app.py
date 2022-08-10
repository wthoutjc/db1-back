from tkinter import N
from flask import Flask, request, jsonify, make_response, render_template
from flask_cors import CORS

# Database
from database.database import Database

# Tools
import json

# Utils
from utils.date_validation import date_validation
from utils.auxiliar import Auxiliar

# PDF
from PDF.pdf import PDF

app = Flask(__name__)

# Config del entorno
SECRET_KEY = '#1$1245l124$'
CORS(app)

app.config['SECRET_KEY'] = SECRET_KEY
app.config['JWT_SECRET_KEY'] = app.config['SECRET_KEY']

database = Database()
aux = Auxiliar()

pdf = PDF()


@app.route("/login", methods=["POST"])
def login():
    if request.data:
        data = request.data.decode("UTF-8")
        request_data = json.loads(data)
        message, success = database.read_auxiliar(request_data['cod'])
        print(message[0])
        if success:
            aux.set_data(json.loads(message[0]))
            return make_response(jsonify({"message": message[0], "status": "success"}), 200)
        return make_response(jsonify({"message": message, "status": "failed"}), 500)
    return make_response(jsonify({"message": 'not ok'}), 500)


@app.route("/docente/<name>")
def get_docente(name):
    message, success = database.read_docente(name)
    if success:
        id_docente = json.loads(message[0])['id']
        programacion, success = date_validation(
            database, id_docente, "docente")
        if success:
            practica_docente, success = database.get_data_practica_docente(
                json.loads(programacion[0])['idProgra'], name)
            if success:
                materiales, success = database.get_materiales(
                    json.loads(practica_docente[0])['id_sede'], json.loads(practica_docente[0])['id_deporte'])
                if success:
                    return make_response(jsonify({"message": message[0] | practica_docente[0] | materiales[0], "status": "success"}), 200)
                return make_response(jsonify({"message": message[0] | practica_docente[0], "status": "success"}), 200)
            return make_response(jsonify({"message": message[0], "status": "success"}), 200)
        return make_response(jsonify({"message": message[0], "status": "success"}), 200)
    return make_response(jsonify({"message": f'El profesor {name} no existe.'}), 500)


@app.route("/pasante/<id>")
def get_pasante(id):
    message, success = database.read_pasante(id)
    if success:
        programacion, success = date_validation(database, id,  "pasante")
        if success:
            practica_libre, success = database.get_data_practica_libre(
                id, json.loads(programacion[0])['idProgra'])
            print(message)
            if success:
                materiales, success = database.get_materiales(
                    json.loads(practica_libre[0])['id_sede'], json.loads(practica_libre[0])['id_deporte'])
                if success:
                    return make_response(jsonify({"message": message[0] | practica_libre[0] | materiales[0], "status": "success"}), 200)
                return make_response(jsonify({"message": message[0] | practica_libre[0], "status": "success"}), 200)
            return make_response(jsonify({"message": message[0], "status": "success"}), 200)
        return make_response(jsonify({"message": message[0], "status": "success"}), 200)
    return make_response(jsonify({"message": f'El pasante con {id} no existe.'}), 500)


@app.route("/miembro", methods=["POST"])
def get_miembro():
    if request.data:
        data = request.data.decode("UTF-8")
        request_data = json.loads(data)
        message, success = database.read_miembro(
            request_data['cod'], request_data['codEquipo'])
        if success:
            id_entrenador = json.loads(message[0])['entrenador']
            programacion, success = date_validation(
                database, id_entrenador, "pasante")
            if success:
                entrenamiento, success = database.get_data_entrenamiento(
                    id_entrenador, json.loads(programacion[0])['idProgra'])
                if success:
                    materiales, success = database.get_materiales(
                        json.loads(entrenamiento[0])['id_sede'], json.loads(entrenamiento[0])['id_deporte'])
                    if success:
                        return make_response(jsonify({"message": message[0] | entrenamiento[0] | materiales[0], "status": "success"}), 200)
                    return make_response(jsonify({"message": message[0] | entrenamiento[0], "status": "success"}), 200)
                return make_response(jsonify({"message": message[0], "status": "success"}), 200)
            return make_response(jsonify({"message": message[0], "status": "success"}), 200)
        return make_response(jsonify({"message": message, "status": "failed"}), 500)
    return make_response(jsonify({"message": 'Not ok.'}), 500)


@app.route("/prestar", methods=["POST"])
def prestar():
    if request.data:
        '''
        parameters: id elementodeportivo, idespacio
                    query: actualizar estado como prestado
                    return string[success, failed]
        '''
        return make_response(jsonify({"message": "ok", "status": "failed"}), 500)
    return make_response(jsonify({"message": 'not ok'}), 500)


@app.route("/pdf-pasante")
def pdf_pasante():
    '''
    parameters: id string, datetime
                query: obtener todos los pasantes con el periodo, la sede y las horas asistidas
                return filedatapdf
    '''
    # date_validation()
    pdf.add_page()
    pdf.logo('assets/sports.png', 0, 0, 60, 15)
    pdf.texts(' ')
    pdf.titles('Hola mundo!')
    pdf.set_author('Camilo')
    pdf.output('test.pdf', 'F')
    return make_response(jsonify({"message": "ok", "status": "failed"}), 500)


@app.route("/pdf-miembro")
def pdf_miembro():
    '''
    parameters: id string, datetime
                query: obtener horas asistidas de todos los miembros con periodo y sede
                return filedatapdf
    '''
    date_validation()
    return make_response(jsonify({"message": "ok", "status": "failed"}), 500)


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
