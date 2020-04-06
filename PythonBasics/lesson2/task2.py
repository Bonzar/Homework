my_list = []
while True:
    if input('Введите "+", для добовления элемента, или "-", для продолжения: ') == '+':
        my_list.append(input('Введите элемент: '))
    else:
        break

for i in my_list:
    if (my_list.index(i) % 2) != 0:
        my_list[my_list.index(i) - 1:(my_list.index(i) + 1)] = [my_list[my_list.index(i)],
                                                                my_list[my_list.index(i) - 1]]
print(my_list)
