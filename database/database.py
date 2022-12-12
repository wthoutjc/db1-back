import oracledb

from database.connect import Connect


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
            self.connection = Connect()
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
            query = """
            SELECT JSON_OBJECT(
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
                        e.codempleado = """ + id + """
                    AND e.codempleado = ec.codempleado
                    AND ec.idcargo = 'au'
                    AND ec.codespacio = es.codespacio
            """
            cur.execute(query)
            rows = cur.fetchone()
            print(rows)
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
                        AND p.consecprogra = '""" + str(id_prog) + """'
                        AND r.consecprogra = p.consecprogra
                        AND ( lower(doc.nomempleado|| ' '|| doc.apellempleado) ) LIKE '""" + str(name).lower() + """'
                """)  # curso, deporte, espacio, numestud
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'El docente llamado {id_prog} no existe o no tiene programado un espacio.', False]
        except oracledb.Error as error:
            print('get_data_practica_docente Error: ' + str(error))
            return [f'Falló la consulta del docente', False]

    def read_pasante(self, id_pasante):
        try:
            cur = self.login_database()
            print(id_pasante)
            query = """
            SELECT JSON_OBJECT(
                    KEY 'id_est' IS  e.codestu,
                    KEY 'name' IS  e.nomestu||' '||e.apelestu, 
                    KEY 'dia' IS d.nomdia,
                    KEY 'horai' IS p.idhora,
                    KEY 'horaf' IS p.hor_idhora,
                    KEY 'periodo' IS p.idperiodo
                    )
                FROM 
                    estudiante e, 
                    responsable r, 
                    programacion p, 
                    dia d
                WHERE 
                        e.codestu = """ + id_pasante + """
                    AND r.codestu = e.codestu
                    AND r.consecprogra = p.consecprogra
                    AND p.iddia = d.iddia
            """
            print(query)
            cur.execute(query)
            rows = cur.fetchone()
            print(rows)
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
                        AND es.codestu = '"""+str(id_pasante)+"""'
                        AND es.codestu  = r.codestu
                        AND p.consecprogra = '"""+str(id_prog)+"""'
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
                        KEY 'entrenador' is em.codempleado,
                        KEY 'item' is m.itemmiembro,
                        KEY 'id_equipo' is eq.conseequipo
                        )
                    FROM 
                        estudiante e, 
                        equipo eq, 
                        miembroequipo m, 
                        deporte de, 
                        empleado em
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

    def get_asistencia_miembro(self, id_prog, id_equipo, item):
        try:
            message, success = self.register_asistencia_miembro(
                id_prog, id_equipo, item)
            if success:
                cur = self.login_database()
                cur.execute(
                    """
                        SELECT JSON_OBJECT
                            (*)
                        FROM 
                            asismiemequipo
                        WHERE
                            itemmiembro = '""" + str(item) + """'
                    """)
                rows = cur.fetchone()
                self.logout_database()
                if rows:
                    return rows, True
                return [f'No se encontraron asistencias.', False]
            return [f'NO hay asistencias.', False]
        except oracledb.Error as error:
            print('get_asistencia_miembro Error: ' + str(error))
            return [f'Falló la consulta de la asistencia', False]

    def process_date_query(self, query):
        try:
            cur = self.login_database()
            cur.execute(query)
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'Fuera de rango', False]
        except oracledb.Error as error:
            print('process_date_query Error: ' + str(error))
            return [f'Falló la consulta de la fecha', False]

    def register_prestamo(self, programacion):
        pass

    def update_materiales(self, request_data):
        try:
            cur = self.login_database()
            query = "UPDATE ELEMENDEPORTIVO SET IDESTADO = '" + \
                request_data['idEstado'] + "' WHERE CONSEC = '" + \
                    request_data["CODEMPLEADO"] + "'"
            cur.execute(query)
            self.connection.based.commit()
            self.logout_database()
            return [f'Empleado con código {request_data["CODEMPLEADO"]} actualizado exitosamente', True]
        except oracledb.Error as error:
            print('update_materiales Error: ' + str(error))
            return [f'Falló el proceso de actualizar el empleado con código {request_data["CODEMPLEADO"]}', False]

    def register_asistencia_miembro(self, id_prog, id_equipo, item):
        try:
            cur = self.login_database()
            query = "INSERT INTO ASISMIEMEQUIPO VALUES(:id_prog, default, :id_equipo, :item)"
            cur.execute(query, [
                id_prog,
                id_equipo,
                item
            ])
            self.connection.based.commit()
            self.logout_database()
            return [f'La asistencia del miembro {item} se ha registrado exitosamente', True]
        except oracledb.Error as error:
            print('register_asistencia Error: ' + str(error))
            return [f'Falló el registro de la asistencia para el miembro {item}', False]

    def get_asistencia_responsable(self, id_prog, id_res):
        print(id_prog, id_res)
        try:
            message, success = self.register_asistencia_responsable(
                id_prog, id_res)
            if success:
                cur = self.login_database()
                cur.execute(
                    """
                        SELECT JSON_OBJECT
                            (*)
                        FROM 
                            asistirresponsable
                        WHERE
                            consecres = '""" + str(id_res) + """'
                    """)
            rows = cur.fetchone()
            self.logout_database()
            if rows:
                return rows, True
            return [f'NO se lleno asistencia.', False]
        except oracledb.Error as error:
            print('get_asistencia_responsable Error: ' + str(error))
            return [f'Falló al registrar la asistencia', False]

    def register_asistencia_responsable(self, id_prog, id_res):
        try:
            cur = self.login_database()
            query = "INSERT INTO ASISTIRRESPONSABLE VALUES(:id_prog, :id_res, default, current_date, sysdate)"
            cur.execute(query, [
                id_prog,
                id_res,
            ])
            self.connection.based.commit()
            self.logout_database()
            return [f'La asistencia del responsable se ha registrado exitosamente', True]
        except oracledb.Error as error:
            print('register_asistencia Error: ' + str(error))
            return [f'Falló el registro de la asistencia del responsable', False]

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
            rows = cur.fetchmany()
            print(rows)
            self.logout_database()
            if rows:
                return rows, True
            return [f'No se pudieron obtener los materiales', False]
        except oracledb.Error as error:
            print('read_docente Error: ' + str(error))
            return [f'Falló la consulta de materiales', False]

    def prestar(self, data):
        try:
            cursor = self.login_database()
            for item in data:
                query = "UPDATE ELEMENDEPORTIVO SET IDESTADO = 'pr' WHERE CONSECELEMENTO ='" + \
                    str(item["idElemento"]) + "'AND CODESPACIO = '" + \
                    str(item["idEspacio"]) + "'"
                cursor.execute(query)
                self.connection.based.commit()
            self.logout_database()


            
            return [f'Los elementos se han prestado exitosamente', True]
        except oracledb.Error as error:
            print('prestar Error: ' + str(error))
            return [f'Falló el prestamo de materiales', False]

    def get_reporte_miembros(self, sede):
        try:
            cur = self.login_database()
            cur.execute(
                """
                    SELECT JSON_OBJECT (
                        KEY 'cod' is e.codestu,
                        KEY 'nom' is d.nomdeporte,
                        KEY 'nomesp' is es.nomespacio,
                        KEY 'sum' is 4)
                    FROM
                        programacion      p,
                        asismiemequipo    am,
                        miembroequipo     me,
                        estudiante        e,
                        equipo            eq,
                        deporte           d,
                        espaciodeporte    ed,
                        espacio           es,
                        tipoespacio       te
                    WHERE
                            p.consecprogra = am.consecprogra
                        AND am.itemmiembro = me.itemmiembro
                        AND me.codestu = e.codestu
                        AND eq.conseequipo = me.conseequipo
                        AND d.iddeporte = eq.iddeporte
                        AND d.iddeporte = ed.iddeporte
                        AND es.codespacio = e.codespacio
                        AND es.idtipoespacio = te.idtipoespacio
                        AND e.codespacio = es.codespacio                        
                        AND lower(es.nomespacio) LIKE '""" +  str(sede).lower() + """'
                    GROUP BY
                        e.codestu,
                        d.nomdeporte,
                        es.nomespacio
                """)
            rows = cur.fetchmany()
            print(rows)
            self.logout_database()
            if rows:
                return rows, True
            return [f'No se pudieron obtener las asistencias', False]
        except oracledb.Error as error:
            print('read_docente Error: ' + str(error))
            return [f'Falló la consulta de materiales', False]

    def get_test(self):
        try:
            cur = self.login_database()
            cur.execute(
                """
                    SELECT 
                        *
                    FROM
                        empleado
                """)
            rows = cur.fetchmany()
            print(rows)
            self.logout_database()
            if rows:
                return rows, True
            return [f'No se pudieron obtener las asistencias', False]
        except oracledb.Error as error:
            print('read_docente Error: ' + str(error))
            return [f'Falló la consulta de materiales', False]
