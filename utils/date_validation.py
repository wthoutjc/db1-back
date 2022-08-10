
def date_validation(database, id_asistente, tipo_asistencia):
    if tipo_asistencia == "docente":
        query = """
                    SELECT JSON_OBJECT(
                        KEY 'idProgra' IS p.consecprogra,
                        KEY 'idResp' IS r.consecres
                    )
                    FROM
                        responsable  r,
                        programacion p
                    WHERE
                        r.codempleado = '""" + id_asistente + """'
                        AND r.consecprogra = p.consecprogra
                        AND current_timestamp > to_timestamp(r.fechaini || ' ' || p.idhora)
                        AND current_timestamp < to_timestamp(r.fechaini || ' ' || p.hor_idhora)"""
        return database.process_date_query(query)  # to_char(current_date, 'HH24') DEVUELVE VALOR BOOLEANO
    if tipo_asistencia == "pasante":
        query = """
                    SELECT JSON_OBJECT(
                        KEY 'idProgra' IS p.consecprogra,
                        KEY 'idResp' IS r.consecres
                    )
                    FROM
                        responsable  r,
                        programacion p
                    WHERE
                            r.codestu = '""" + id_asistente + """'
                        AND r.consecprogra = p.consecprogra
                        AND current_timestamp BETWEEN to_timestamp(r.fechaini || ' ' || to_char(to_timestamp(r.fechaini || ' ' || p.idhora) - 15/24/60, 'HH24:mi'))
                        AND to_timestamp(r.fechaini || ' ' || to_char(to_timestamp(r.fechaini || ' ' || p.idhora) + 15/24/60, 'HH24:mi'))"""
        return database.process_date_query(query)
    if tipo_asistencia == "miembro":
        query = """
                    SELECT JSON_OBJECT(
                        KEY 'idProgra' IS p.consecprogra,
                        KEY 'idResp' IS r.consecres
                    )
                    FROM
                        responsable  r,
                        programacion p
                    WHERE
                            r.codempleado = '""" + id_asistente + """'
                        AND r.consecprogra = p.consecprogra
                        AND current_timestamp < to_timestamp(r.fechaini || ' ' || to_char(to_timestamp(r.fechaini || ' ' || p.idhora) + 90/24/60, 'HH24:mi'))
                        AND current_timestamp > to_timestamp(r.fechaini || ' ' || to_char(to_timestamp(r.fechaini || ' ' || p.idhora) - 15/24/60, 'HH24:mi'))"""
        return database.process_date_query(query)  # identrenador
    return False, None
