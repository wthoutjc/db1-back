import oracledb

from database.connection import Connection


class Database():
    def __init__(self):
        '''
        Configuración de la base de datos Oracle
        '''
        self.connection = None

    # Config Access
    def login_database(self):
        '''
        Iniciamos una conexion a la base de datos.
        '''
        try:
            self.connection = Connection()
            return self.connection.cursor
        except oracledb.Error as error:
            print('Login database Error: ' + str(error))

    def logout_database(self):
        '''
        Cerramos la conexión a la base de datos.
        '''
        try:
            self.connection.__del__()
            self.connection = None
        except oracledb.Error as error:
            print('Logout database Error: ' + str(error))

    
    def read_empleados(self, limit, offset):
        try:
            cur = self.login_database()
            query = "SELECT JSON_OBJECT(*) FROM EMPLEADO ORDER BY CODEMPLEADO OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY"
            cur.execute(query, [offset, limit])
            rows = cur.fetchall()
            print(rows)
            self.logout_database()
            if rows:
                return rows, True
            return ['No existen empleados registrados', False]
        except oracledb.Error as error:
            print('read_empleados Error: ' + str(error))
            return ['Falló la consulta de empleados', False]

    def read_empleado(self, id):
        try:
            cur = self.login_database()
            cur.execute(
                "SELECT JSON_OBJECT(*) FROM EMPLEADO WHERE CODEMPLEADO = :CODEMPLEADO", [id])
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'El empleado con cédula {id} no existe.', False]
        except oracledb.Error as error:
            print('read_empleado Error: ' + str(error))
            return [f'Falló la consulta de empleado con cédula {id}', False]

    def update_empleado(self, request_data):
        try:
            cur = self.login_database()
            query = "UPDATE EMPLEADO SET IDSEDE = '" + request_data['idSede'] + "', IDESPACIO = '" + request_data['idEspacio'] + "', IDEQUIPO = '" + request_data["idEquipo"] + "', SUPIDEQUIPO = " + str(
                request_data["supIdEquipo"] or 'null') + ", IDUDEPORTIVA = '" + request_data["idUDeportiva"] + "', NOMBRE = '" + request_data["nombre"] + "', APELLIDO = '" + request_data["apellido"] + "' WHERE CODEMPLEADO = '" + request_data["CODEMPLEADO"] + "'"
            cur.execute(query)
            self.connection.based.commit()
            self.logout_database()
            return [f'Empleado con cédula {request_data["CODEMPLEADO"]} actualizado exitosamente', True]
        except oracledb.Error as error:
            print('update_empleado Error: ' + str(error))
            return [f'Falló el proceso de actualizar el empleado con cédula {request_data["CODEMPLEADO"]}', False]

    def delete_empleado(self, id):
        print(f"Borrando {id}")
        try:
            cur = self.login_database()
            query = "DELETE FROM EMPLEADO WHERE CODEMPLEADO = '" + id + "'"
            cur.execute(query)
            self.connection.based.commit()
            self.logout_database()
            return [f'Empleado con cédula {id} eliminado satisfactoriamente', True]
        except oracledb.Error as error:
            print('delete_empleado Error: ' + str(error))
            return [f'Falló el proceso de borrar el empleado con cédula {id}', False]

    def register_empleado(self, request_data):
        try:
            cur = self.login_database()
            query = "INSERT INTO EMPLEADO VALUES(:CODEMPLEADO, :idsede, :idespacio, :idequipo, :supidequipo, :idudeportiva, :nombre, :apellido)"
            cur.execute(query, [
                request_data["CODEMPLEADO"],
                request_data["idSede"],
                request_data["idEspacio"],
                request_data["idEquipo"],
                request_data["supIdEquipo"],
                request_data["idUDeportiva"],
                request_data["nombre"],
                request_data["apellido"]
            ])
            self.connection.based.commit()
            self.logout_database()
            return [f'Empleado con cédula {request_data["CODEMPLEADO"]} registrado exitosamente', True]
        except oracledb.Error as error:
            print('register_empleado Error: ' + str(error))
            return [f'Falló el registro de empleado con cédula {request_data["CODEMPLEADO"]}', False]
