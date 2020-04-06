class Road:
    def __init__(self, length, width):
        self._length = length
        self._width = width

    def mass(self):
        print(
            f'Asphalt required to cover the entire road(length = {self._length}, width = {self._width}): '
            f'{int(self._length * self._width * 25 * 5 / 1000)} t')


r = Road(20, 5000)
r.mass()
