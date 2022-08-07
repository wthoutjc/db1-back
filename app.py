from flask import Flask, request, jsonify, make_response, render_template
from flask_cors import CORS

# Database
from database.database import Database

# Tools
import json

app = Flask(__name__)

#Config del entorno
SECRET_KEY = '#1$1245l124$'
CORS(app)

app.config['SECRET_KEY'] = SECRET_KEY
app.config['JWT_SECRET_KEY'] = app.config['SECRET_KEY']

@app.route("/", defaults={'id': None}, methods=["GET", "POST", "PUT"])
@app.route("/<id>", methods=["GET", "DELETE"])
def empleado_route(id):
    print('empleado_route') 
    database = Database()

    if request.method == "GET":
        print(f'GET {id}')
        # Leer todos los empleados
        if id:
            message, success = database.read_empleado(id)
            if success:
                return make_response(jsonify({"empleado": message[0]}), 200)
            else:
                return make_response(jsonify({"message": message}), 404)
        limit = int(request.args.get('limit', 20))
        offset = int(request.args.get('offset', 0))
        message, success = database.read_empleados(limit, offset)
        if success:
            result = []
            for data in message:
                print(data[0])
                result.append(json.loads(data[0]))
            return make_response(jsonify({"empleados": result}), 200)
        else:
            return make_response(jsonify({"message": message}), 404)

    elif request.method == "POST":
        print(f'GET {id}')
        # Registrar un empleado
        if not request.data:
            return make_response(jsonify({"message": "No request data"}), 500)
        data_raw = request.data.decode("utf-8")
        request_data = json.loads(data_raw)

        # Verificar que no exista
        message, success = database.read_empleado(request_data['idPersonal'])
        if success:
            return make_response(jsonify({"message": f"El empleado con cédula {request_data['idPersonal']} ya existe"}), 409)

        message, success = database.register_empleado(request_data)
        if success:
            return make_response(jsonify({"message": message}), 201)
        else:
            return make_response(jsonify({"message": message}), 500)

    elif request.method == "PUT":
        print(f'PUT')
        # Actualizar un empleado
        if not request.data:
            return make_response(jsonify({"message": "No request data"}), 500)
        data_raw = request.data.decode("utf-8")
        request_data = json.loads(data_raw)

        # Verificar que la informacion sea diferente
        message, success = database.read_empleado(request_data['idPersonal'])
        if not success:
            return make_response(jsonify({"message": f"El empleado con cédula {request_data['idPersonal']} no existe"}), 404)
        
        if request_data == message:
            return make_response(jsonify({"message": "No hay cambios"}), 200)

        message, success = database.update_empleado(request_data)
        if success:
            return make_response(jsonify({"message": message}), 200)
        else:
            return make_response(jsonify({"message": message}), 500)

    elif request.method == "DELETE":
        print(f'DELETE')
        # Eliminar un empleado

        # Verificar que exista
        message, success = database.read_empleado(id)
        if not success:
            return make_response(jsonify({"message": f"El empleado con cédula {id} no existe"}), 404)

        message, success = database.delete_empleado(id)
        if success:
            return make_response(jsonify({"message": message}), 200)
        else:
            return make_response(jsonify({"message": message}), 500)

    return make_response(jsonify({"message": "Method Not Allowed"}), 405)


@app.route("/login", methods=["POST"])
def login():
    if request.data: 
        data = request.data.decode("UTF-8")
        request_data = json.loads(data)
        print("data")
        print(request_data)
        return make_response(jsonify({"message": 'ok'}), 200)
    return make_response(jsonify({"message": 'not ok'}), 500)


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')