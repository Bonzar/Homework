class Stationery:
    def __init__(self, name):
        self.name = name

    def draw(self):
        print('Starting drawing')


class Pen(Stationery):
    def draw(self):
        print(f'Starting drawing with a {self.name}')


class Pencil(Stationery):
    def draw(self):
        print(f'Starting drawing with a {self.name}')


class Handle(Stationery):
    def draw(self):
        print(f'Starting drawing with a {self.name}')


s = Stationery(None)
s.draw()
p = Pen('Pen')
p.draw()
pe = Pencil('Pencil')
pe.draw()
h = Handle('Handle')
h.draw()
