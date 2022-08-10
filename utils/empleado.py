

class Auxiliar():
    def __init__(self):
        self.name = ''
        self.sede = ''
        self.date = ''
        self.time = ''

    def set_data(self, data):
        self.name = data['name']
        self.sede = data['sede']
        self.date = data['date']
        self.time = data['time']


class Director():
    def __init__(self):
        self.sede = ''

    def set_data(self, data):
        self.sede = data['sede']
