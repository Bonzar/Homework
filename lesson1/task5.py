print('Расчёт выручки фирмы')
cost = int(input('Введите значение выручки: '))
revenue = int(input('Введите значение издержек: '))
if cost > revenue:
    print('Ваша фирма работает в прибыль!\n'
          f'Рентабельность выручки состовляет {cost / revenue}')
    number_people = int(input('Введите число сотрудников: '))
    print(f'Прибыль на одного сотрудника составляет: {cost / number_people}')
elif cost < revenue:
    print(f'Ваша фирма работает в убыток.')
else:
    print(f'Ваша фирма работает в 0.')