def my_func_2(a, b):
    for i in range(abs(b) - 1):
        a *= a
    return 1 / a


print('''Возвод числа в отрицательную степень')\n ----------------------''')
print(my_func_2(float(input('Введите число для возвода в степень: ')), int(input('Введите отрицательную степень: '))))
