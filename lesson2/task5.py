my_list = [7, 5, 3, 3, 2]
new_number = int(input('Введите новое значение рейтинга: '))
for i in my_list[:]:
    if new_number > i:
        print(i)
        my_list.insert(my_list.index(i), new_number)
        break
else:
    my_list.append(new_number)
print(my_list)
