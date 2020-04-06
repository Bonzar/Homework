from itertools import cycle
from time import sleep


class TrafficLight:
    def __init__(self, color1, color2, color3):
        self._listOfColor = [color1, color2, color3, color2]
        if color2 != 'yellow'.title():
            print('The wrong sequence of colors!')
            quit()

    def running(self):
        for color in cycle(self._listOfColor):
            if color.title() == 'Red':
                print(f'\r\033[31m{chr(9632)} \033[30m{chr(9632)} {chr(9632)}', end='')
                sleep(7)
            elif color.title() == 'Yellow':
                print(f'\r\033[30m{chr(9632)} \033[33m{chr(9632)} \033[30m{chr(9632)}', end='')
                sleep(2)
            else:
                print(f'\r\033[30m{chr(9632)} {chr(9632)} \033[32m{chr(9632)}', end='')
                sleep(9)


trafficLight = TrafficLight('Red', 'Yellow', 'Green')
trafficLight.running()
