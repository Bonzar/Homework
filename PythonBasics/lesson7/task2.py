from abc import abstractmethod, ABC


class Clothes(ABC):
    full_price = 0

    def __init__(self, name, size):
        self.name = name
        self.size = size

    @abstractmethod
    def consumption(self):
        pass


class Suit(Clothes, ABC):
    def __init__(self, name, size):
        super().__init__(name, size)
        print(f'Suit "{self.name}", height = {self.size}, consumption = {self.consumption}')

    @property
    def consumption(self):
        cloth = 2 * self.size + 0.3
        Clothes.full_price += cloth
        return cloth


class Coat(Clothes, ABC):
    def __init__(self, name, size):
        super().__init__(name, size)
        print(f'Coat "{self.name}", size = {self.size}, consumption = {round(self.consumption, 2)}')

    @property
    def consumption(self):
        cloth = round(self.size / 6.5 + 0.5, 2)
        Clothes.full_price += cloth
        return cloth


s = Suit('Boss', 176)
c = Coat('Snow Quinn', 46)
print(Clothes.full_price)
