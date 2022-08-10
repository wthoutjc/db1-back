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
        if success:
            aux.set_data(json.loads(message[0]))
            return make_response(jsonify({"message": message, "status": "success"}), 200)
        return make_response(jsonify({"message": message, "status": "failed"}), 500)
    return make_response(jsonify({"message": 'not ok'}), 500)


@app.route("/docente/<name>")
def get_docente(name):
    message, success = database.read_docente(name)
    if success:
        print(message)
        id_docente = json.loads(message[0])['id']
        if date_validation(database, id_docente, "docente"):
            practica_docente, success = database.get_data_practica_docente(
                name)  # puede que le mande más de una practica
            if success:
                return make_response(jsonify({"message": message | practica_docente, "status": "success"}), 200)
            return make_response(jsonify({"message": message, "status": "failed"}), 200)
        return make_response(jsonify({"message": message[0], "status": "success"}), 200)
    return make_response(jsonify({"message": f'El profesor {name} no existe.'}), 500)


@app.route("/pasante/<id>")
def get_pasante(id):
    message, success = database.read_pasante(id)
    if success:
        if date_validation(database, id,  "pasante"):
            message, success = database.get_data_practica_libre()
            print(message)
            if success:
                return make_response(jsonify({"message": message, "status": "success"}), 200)
            return make_response(jsonify({"message": message, "status": "failed"}), 500)
    return make_response(jsonify({"message": 'not ok'}), 500)


@app.route("/miembro", methods=["POST"])
def get_miembro():
    if request.data:
        '''
        parameters: id string, datetime
                    query: obtener datos estudiante
                    validar rango - usar date_validation 
                    if true registrar en asismiembroequipo
                    return datos estudiante, sede
        '''
        data = request.data.decode("UTF-8")
        request_data = json.loads(data)
        message, success = database.read_miembro(
            request_data['cod'], request_data['codEquipo'])
        if success:
            id_entrenador = json.loads(message[0])['entrenador']
            if(date_validation(database, id_entrenador, "pasante")):
                message, success = database.get_data_entrenamiento(
                    id_entrenador)
        return make_response(jsonify({"message": "ok", "status": "failed"}), 500)
    return make_response(jsonify({"message": 'not ok'}), 500)


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
