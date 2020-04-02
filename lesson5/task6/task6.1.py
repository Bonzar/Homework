from functools import reduce
from json import dumps


def numbs_out_str(line_with_numbers):
    full_number_list = []
    list_numbers_inline = []
    for hours in line_with_numbers:
        if hours.isdigit():
            list_numbers_inline.append(hours)
    ind = 0
    count = 0
    numbers = [list_numbers_inline[ind]]
    for i in range(len(list_numbers_inline)):
        ind += 1
        try:
            while line_with_numbers.find(list_numbers_inline[ind - 1]) - line_with_numbers.find(
                    list_numbers_inline[ind], line_with_numbers.find(
                            list_numbers_inline[ind - 1]) + 1) == -1:
                numbers.append(list_numbers_inline[ind])
                ind += 1
                if line_with_numbers.find(list_numbers_inline[ind - 1]) == line_with_numbers.find(
                        list_numbers_inline[ind]):
                    count += 1
            else:
                full_number_list.append(int(reduce(lambda a, b: a + b, numbers)))
                count = 0
                line_with_numbers = line_with_numbers[line_with_numbers.find(numbers[0]) + len(numbers):]
                numbers = [list_numbers_inline[ind]]
        except IndexError:
            full_number_list.append(int(reduce(lambda a, b: a + b, numbers)))
            break
    return full_number_list


with open('text_6.txt', 'r', encoding='utf-8') as text_6:
    dictSubject = {line.split(': ')[0].title(): line.split(': ')[1][:-1] for line in text_6.readlines()}
    for key, value in dictSubject.items():
        dictSubject[key] = sum(numbs_out_str(value))
    print(dumps(dictSubject, indent=4, separators=('', ': ')))