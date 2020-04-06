from itertools import cycle, count


def new_list_numb(start_numb, finish_numb):
    list_of_numbers = []
    for i in count(start_numb):
        if i > finish_numb:
            break
        else:
            list_of_numbers.append(i)
            print(list_of_numbers)
            cycle_list(list_of_numbers)


def cycle_list(listed):
    c = 0
    for el in cycle(listed):
        if c >= len(listed):
            break
        else:
            print(el)
            c += 1


try:
    new_list_numb(int(input('Enter a start number: ')), int(input('Enter a finish number: ')))
except ValueError:
    print('Ошибка!!!\nЧисло должно состоять лишь из цифр. Одно число за раз.')
