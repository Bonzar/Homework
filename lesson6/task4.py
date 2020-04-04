def print_stats(type_car):
    print('---------------------------------------------------')
    print(f'{type_car.name}, {type_car.color}')
    type_car.show_speed()
    type_car.go()
    type_car.show_speed()
    type_car.turn('left')
    type_car.stop()
    type_car.show_speed()


class Car:
    def __init__(self, name, color, speed_in_trip, is_police=False):
        self.speed_in_trip = speed_in_trip
        self.color = color
        self.name = name
        self.speed = 0

    def go(self):
        self.speed = self.speed_in_trip
        print('Car is start driving')

    def stop(self):
        self.speed = 0
        print('Car is stopped')

    def turn(self, turn):
        if turn.lower() == 'left':
            print('Car turn left')
        elif turn.lower() == 'right':
            print('Car turn left')

    def show_speed(self):
        print(f'Current speed = {self.speed} km/h')


class TownCar(Car):

    def show_speed(self):
        print(f'Current speed = {self.speed} km/h')
        if self.speed > 60:
            print('You are exceeding the speed limit of 60 km/h')


class SportCar(Car):
    pass


class WorkCar(Car):
    def show_speed(self):
        print(f'Current speed = {self.speed} km/h')
        if self.speed > 40:
            print('You are exceeding the speed limit of 40 km/h')


class PoliceCar(Car):
    def __init__(self, name, color, speed_in_trip, is_police=False):
        super().__init__(name, color, speed_in_trip)
        self.is_police = is_police

    def show_speed(self):
        print(f'Current speed = {self.speed} km/h')
        if self.is_police and self.speed > 0:
            print('You can drive at any speed!')


t = TownCar('Town car', 'red', 120)
print_stats(t)
s = SportCar('Sport car', 'yellow', 140)
print_stats(s)
w = WorkCar('Work car', 'black', 60)
print_stats(w)
p = PoliceCar('Police car', 'black&white', 100, True)
print_stats(p)
