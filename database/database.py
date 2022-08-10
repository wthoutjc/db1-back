from concurrent.futures import process
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

    def read_auxiliar(self, id):
        try:
            cur = self.login_database()
            cur.execute(
                """SELECT JSON_OBJECT(
                    KEY 'name'  IS e.nomempleado||' '||e.apellempleado,
                    KEY 'sede' IS es.nomespacio,
                    KEY 'date' IS to_char(current_date, 'DD/MM/YY'),
                    KEY 'time' IS to_char(current_date, 'HH24:mi')
                    )
                FROM
                    empleado      e,
                    empleadocargo ec,
                    espacio es
                WHERE
                        e.codempleado = '""" + id + """'
                    AND e.codempleado = ec.codempleado
                    AND ec.idcargo = 'au'
                    AND ec.codespacio = es.codespacio""")
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'El código {id} no corresponde a un auxiliar.', False]
        except oracledb.Error as error:
            print('read_auxiliar Error: ' + str(error))
            return [f'Falló la consulta de auxiliar con código {id}', False]

    def read_directordeportivo(self, id):
        try:
            cur = self.login_database()
            cur.execute(
                """SELECT JSON_OBJECT(
                    KEY 'name'  IS e.nomempleado||' '||e.apellempleado,
                    KEY 'sede' IS es.nomespacio,
                    KEY 'date' IS to_char(current_date, 'DD/MM/YY'),
                    KEY 'time' IS to_char(current_date, 'HH24:mi')
                    )
                FROM
                    empleado      e,
                    empleadocargo ec,
                    espacio es
                WHERE
                        e.codempleado = '""" + id + """'
                    AND e.codempleado = ec.codempleado
                    AND ec.idcargo = 'dd'
                    AND ec.codespacio = es.codespacio""")
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'El código {id} no corresponde a un empleado.', False]
        except oracledb.Error as error:
            print('read_auxiliar Error: ' + str(error))
            return [f'Falló la consulta de empleado con código {id}', False]

    def read_docente(self, name):
        try:
            cur = self.login_database()
            cur.execute(
                """
                    SELECT DISTINCT JSON_OBJECT(
                        KEY 'id' IS e.codempleado,
                        KEY 'name' IS e.nomempleado ||' '|| e.apellempleado,
                        KEY 'sede' IS es.nomespacio)
                    FROM
                        empleado      e,
                        empleadocargo ec,
                        espacio       es
                    WHERE
                        lower(e.nomempleado||' '|| e.apellempleado) = '""" + str(name).lower() + """'
                        AND ec.codespacio = es.codespacio
                        AND ec.idcargo = 'do'
                        AND e.codempleado = ec.codempleado
                        AND ec.fechafincar is NULL""")
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'El docente llamado {name} no existe.', False]
        except oracledb.Error as error:
            print('read_docente Error: ' + str(error))
            return [f'Falló la consulta del docente llamado {name}', False]

    def get_data_practica_docente(self, id_prog, name):
        try:
            cur = self.login_database()
            cur.execute(
                """
                    SELECT JSON_OBJECT (
                        KEY 'idprog' IS p.consecprogra,
                        KEY 'id_sede' IS s.codespacio,
                        KEY 'espacio' IS e.nomespacio,
                        KEY 'deporte' IS d.nomdeporte,
                        KEY 'id_deporte' IS d.iddeporte,
                        KEY 'num_est' IS p.noinscrito )
                    FROM
                        espacio e,
                        espacio s,
                        tipoespacio te,
                        deporte d,
                        programacion p,
                        responsable r,
                        empleado doc,
                        empleadocargo ec
                    WHERE
                            p.iddeporte = d.iddeporte
                        AND p.codespacio = e.codespacio
                        AND e.esp_codespacio = s.codespacio
                        AND doc.codempleado = ec.codempleado
                        AND ec.idcargo = 'do'
                        AND e.idtipoespacio = te.idtipoespacio
                        AND r.codempleado = doc.codempleado
                        AND p.consecprogra = '""" + id_prog + """'
                        AND r.consecprogra = p.consecprogra
                        AND ( lower(doc.nomempleado|| ' '|| doc.apellempleado) ) LIKE '""" + name + """'
                """)  # curso, deporte, espacio, numestud
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'El docente llamado {id} no existe o no tiene programado un espacio.', False]
        except oracledb.Error as error:
            print('get_data_practica_docente Error: ' + str(error))
            return [f'Falló la consulta del docente', False]

    def read_pasante(self, id_pasante):
        try:
            cur = self.login_database()
            cur.execute(
                """
                    SELECT JSON_OBJECT (
                        KEY 'id_est' is  e.codestu,
                        KEY 'name' is  e.nomestu||' '||e.apelestu, 
                        KEY 'dia' is d.nomdia,
                        KEY 'horai' is p.idhora,
                        KEY 'horaf' is p.hor_idhora,
                        KEY 'periodo' is p.idperiodo
                        )
                    FROM 
                        estudiante e, responsable r, programacion p, dia d
                    WHERE 
                        e.codestu = '""" + id_pasante + """'
                        and r.codestu = e.codestu
                        and r.consecprogra = p.consecprogra
                        and p.iddia = d.iddia
                """)
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'El pasante con {id_pasante} no existe.', False]
        except oracledb.Error as error:
            print('read_pasante Error: ' + str(error))
            return [f'Falló la consulta del pasante llamado {id_pasante}', False]

    def get_data_practica_libre(self, id_pasante, id_prog):
        try:
            cur = self.login_database()
            cur.execute(
                """
                    SELECT distinct JSON_OBJECT (
                        KEY 'idprog' IS p.consecprogra,
                        KEY 'sede' IS s.codespacio,
                        KEY 'espacio' IS e.nomespacio,
                        KEY 'id_deporte' IS d.iddeporte,
                        KEY 'deporte' IS d.nomdeporte,
                        KEY 'num_est' IS p.noinscrito )
                    FROM
                        espacio e,
                        espacio s,
                        tipoespacio te,
                        deporte d,
                        programacion p,
                        responsable r,
                        empleado doc,
                        empleadocargo ec,
                        estudiante es
                    WHERE
                            p.iddeporte = d.iddeporte
                        AND p.codespacio = e.codespacio
                        AND e.esp_codespacio = s.codespacio
                        AND e.idtipoespacio = te.idtipoespacio
                        AND es.codestu = '"""+id_pasante+"""'
                        AND es.codestu  = r.codestu
                        AND p.consecprogra = '"""+id_prog+"""'
                        AND r.consecprogra = p.consecprogra
                """)
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'No se encontraron practicas.', False]
        except oracledb.Error as error:
            print('get_data_practica_libre Error: ' + str(error))
            return [f'Falló la consulta del pasante', False]

    def read_miembro(self, id_miembro, id_equipo):
        try:
            cur = self.login_database()
            cur.execute(
                """
                    SELECT JSON_OBJECT (
                        KEY 'id' is  e.codestu,
                        KEY 'name' is  e.nomestu||' '||e.apelestu,
                        KEY 'deporte' is de.nomdeporte,
                        KEY 'entrenador' is em.codempleado
                    )
                    FROM 
                        estudiante e, equipo eq, miembroequipo m, deporte de, empleado em
                    WHERE  
                        e.codestu = '""" + id_miembro + """'
                        and eq.conseequipo = '""" + id_equipo + """'
                        and m.codestu = e.codestu
                        and m.conseequipo = eq.conseequipo
                        and eq.iddeporte = de.iddeporte
                        and eq.codempleado = em.codempleado
                """)
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'El miembro con {id_miembro} y equipo {id_equipo} no existe.', False]
        except oracledb.Error as error:
            print('read_miembro Error: ' + str(error))
            return [f'Falló la consulta del miembro con id {id_miembro}', False]

    def get_data_entrenamiento(self, id_entrenador, id_prog):
        try:
            cur = self.login_database()
            cur.execute(
                """
                    SELECT JSON_OBJECT (
                        KEY 'id_equipo' IS eq.conseequipo,
                        KEY 'id_sede' IS s.codespacio,
                        KEY 'espacio' IS e.nomespacio,
                        KEY 'deporte' IS d.nomdeporte,
                        KEY 'id_deporte' IS d.iddeporte,
                        KEY 'num_est' IS p.noinscrito )
                    FROM
                        espacio e,
                        espacio s,
                        tipoespacio te,
                        deporte d,
                        programacion p,
                        responsable r,
                        empleado doc,
                        empleadocargo ec,
                        equipo eq
                    WHERE
                            p.iddeporte = d.iddeporte
                        AND p.codespacio = e.codespacio
                        AND e.esp_codespacio = s.codespacio
                        AND doc.codempleado = ec.codempleado
                        AND ec.idcargo = 'en'
                        AND e.idtipoespacio = te.idtipoespacio
                        AND r.codempleado = doc.codempleado
                        AND p.consecprogra = '""" + id_prog + """'
                        AND r.consecprogra = p.consecprogra
                        AND eq.codempleado = doc.codempleado
                        AND r.codempleado = '""" + id_entrenador + """'
                """)  # curso, deporte, espacio, numestud
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'El docente llamado {id} no existe.', False]
        except oracledb.Error as error:
            print('get_data_entrenamiento Error: ' + str(error))
            return [f'Falló la consulta del docente', False]

    def process_date_query(self, query):
        try:
            cur = self.login_database()
            cur.execute(query)
            rows = cur.fetchone()
            print(rows)
            self.logout_database()
            if rows:
                return rows, True
            return [f'Fuera de rango', False]
        except oracledb.Error as error:
            print('process_date_query Error: ' + str(error))
            return [f'Falló la consulta de la fecha', False]

    def update_empleado(self, request_data):
        try:
            cur = self.login_database()
            query = "UPDATE EMPLEADO SET IDSEDE = '" + request_data['idSede'] + "', IDESPACIO = '" + request_data['idEspacio'] + "', IDEQUIPO = '" + request_data["idEquipo"] + "', SUPIDEQUIPO = " + str(
                request_data["supIdEquipo"] or 'null') + ", IDUDEPORTIVA = '" + request_data["idUDeportiva"] + "', NOMBRE = '" + request_data["nombre"] + "', APELLIDO = '" + request_data["apellido"] + "' WHERE CODEMPLEADO = '" + request_data["CODEMPLEADO"] + "'"
            cur.execute(query)
            self.connection.based.commit()
            self.logout_database()
            return [f'Empleado con código {request_data["CODEMPLEADO"]} actualizado exitosamente', True]
        except oracledb.Error as error:
            print('update_empleado Error: ' + str(error))
            return [f'Falló el proceso de actualizar el empleado con código {request_data["CODEMPLEADO"]}', False]

    def delete_empleado(self, id):
        print(f"Borrando {id}")
        try:
            cur = self.login_database()
            query = "DELETE FROM EMPLEADO WHERE CODEMPLEADO = '" + id + "'"
            cur.execute(query)
            self.connection.based.commit()
            self.logout_database()
            return [f'Empleado con código {id} eliminado satisfactoriamente', True]
        except oracledb.Error as error:
            print('delete_empleado Error: ' + str(error))
            return [f'Falló el proceso de borrar el empleado con código {id}', False]

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
            return [f'Empleado con código {request_data["CODEMPLEADO"]} registrado exitosamente', True]
        except oracledb.Error as error:
            print('register_empleado Error: ' + str(error))
            return [f'Falló el registro de empleado con código {request_data["CODEMPLEADO"]}', False]

    def get_materiales(self, id_sede, id_deporte):
        try:
            cur = self.login_database()
            cur.execute(
                """
                    SELECT JSON_OBJECT(
                        KEY 'idElemento' IS e.consecelemento,
                        KEY 'idEspacio' IS e.codespacio,
                        KEY 'marca' IS m.nommarca,
                        KEY 'material' IS te.desctipoelemento,
                        KEY 'sede' IS es.nomespacio,
                        KEY 'deporte' IS d.nomdeporte
                        )
                    FROM
                        elemendeportivo e,
                        marca m,
                        tipoelemento te,
                        espacio es,
                        deportetipoelem ted,
                        deporte d
                    WHERE
                        m.idmarca = e.idmarca and
                        e.idestado = 'ac' and
                        e.idtipoelemento = te.idtipoelemento and
                        e.codespacio = es.codespacio and
                        es.codespacio = '""" + id_sede + """' and
                        d.iddeporte = '""" + id_deporte + """' and
                        te.idtipoelemento = ted.idtipoelemento and
                        d.iddeporte = ted.iddeporte
                """)
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'No se pudieron obtener los materiales', False]
        except oracledb.Error as error:
            print('read_docente Error: ' + str(error))

            return [f'Falló la consulta de materiales', False]

