def del_for_2(num1, num2):
    try:
        result = int(num1) / int(num2)
        print(result)
    except ZeroDivisionError:
        print('Делить на 0 не этично!')
    except ValueError:
        print('Как вы делите буквы??')


del_for_2(input('Введите 1-е число: '), input('Введите 2-ое число: '))
