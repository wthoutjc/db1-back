import oracledb

#Settings
from database.settings import SETTINGS

class Connection():
    def __init__(self):
        '''
        Configuración de la base de datos Oracle
        Iniciamos una conexion a la base de datos.
        '''
        try:
            self.based = oracledb.connect(user=SETTINGS["user"], password=SETTINGS["password"], dsn=SETTINGS["dsn"])
            self.cursor = self.based.cursor()
            print("Conectado a la base de datos")
        except oracledb.Error as error:
            print('Login database Error: ' + str(error))
    
    def __del__(self):
        '''
        Cerramos la conexión a la base de datos.
        '''
        try:
            if self.based:
                self.based = None
                print("Conexión cerrada")
            else:
                print("No hay conexión")
        except oracledb.Error as error:
            print('Logout database Error: ' + str(error))
