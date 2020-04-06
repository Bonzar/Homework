def func_sum():
    a = 0
    end = None
    while end != 'end':
        all_symbols = (input('Введите числа через пробел: ')).split()
        for i in all_symbols:
            if 33 <= ord(i[:1]) <= 47:
                end = 'end'
                break
            else:
                a += int(i)
        print(f'Сумма всех чисел равна = {a}')


func_sum()
