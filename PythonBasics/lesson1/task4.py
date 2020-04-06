number = int(input('Введите целое положительное число: '))
max_number = ost = number % 10
while number != 0:
    if max_number == 9:
        break
    elif ost > max_number:
        max_number = ost
    number = number // 10
    ost = number % 10
print(max_number)
