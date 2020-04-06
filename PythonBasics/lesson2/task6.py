my_list, names, costs, counts, units = [], [], [], [], []
i = 1
while True:
    if input('Хотите ввести новый товар? ') == 'да':
        print('-------------')
        name = input('Введите название товара: ')
        names.append(name)
        cost = input('Введите цену товара: ')
        costs.append(cost)
        count = input('Введите кол-во товара: ')
        counts.append(count)
        unit = input('Введите ед. измерения товара: ')
        units.append(unit)
        my_list.append((i, {'Название': name, 'Цена': cost, 'Кол-во': count, 'Ед': unit}))
        print('-------------')
    else:
        break
    i += 1
print('-------------')
for i in my_list:
    print(i)
print('-------------')
my_dict = {'Название': names, 'Цена': costs, 'Кол-во': counts, 'Ед': units}
for keys, values in my_dict.items():
    print(f'{keys} - {values}')
