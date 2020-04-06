class Worker:
    def __init__(self, name, surname, position, wage, bonus, _income=None):
        self.name = name
        self.surname = surname
        self.position = position
        self._income = {'wage': wage, 'bonus': bonus}


class Position(Worker):

    def get_full_name(self):
        print(f'{self.name} {self.surname}, {self.position}')

    def get_total_income(self):
        print(f'Full income = {self._income["wage"] + self._income["bonus"]} gold')


p = Position('John', 'Silver', 'Pirate', 10000, 5000)
p.get_full_name()
p.get_total_income()
