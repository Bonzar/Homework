# time = int(input('Введите время в секундах: '))
# hours = time // 3600
# minutes = (time - hours * 3600) // 60
# seconds = time - hours * 3600 - minutes * 60
# print(f'Ваше время в часах минутах и секундах: {hours}:{minutes}:{seconds}.')

time = int(input('Введите время в секундах: '))
seconds = time % 60
minutes = time // 60 % 60
hours = time // 3600
print(f'Ваше время в часах минутах и секундах: {hours}:{minutes}:{seconds}.')
