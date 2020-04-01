def translate(number):
    dictRusNumbers = {0: 'Ноль', 1: 'Один', 2: 'Два', 3: 'Три', 4: 'Четыре', 5: 'Пять', 6: 'Шесть', 7: 'Семь',
                      8: 'Восемь',
                      9: 'Девять', 10: 'Десять'}
    dictEngNumbers = {0: 'Zero', 1: 'One', 2: 'Two', 3: 'Three', 4: 'Four', 5: 'Five', 6: 'Six', 7: 'Seven', 8: 'Eight',
                      9: 'Nine', 10: 'Ten'}
    if number.isdigit():
        if input('Какое значение вы хотите, русское или английское?(r/e)\n').upper() == 'R':
            return dictRusNumbers[number]
        else:
            return dictEngNumbers[number]
    else:
        if number in list(dictRusNumbers.values()):
            return dictEngNumbers[list(dictRusNumbers.values()).index(number)]
        else:
            return dictRusNumbers[list(dictEngNumbers.values()).index(number)]


with open('text_4.txt', '+r', encoding='utf-8') as txt_text_4:
    numbers = {int(line.split(' - ')[1]): line.split(' - ')[0].title() for line in txt_text_4.readlines()}
    line = 1
    for key, value in numbers.items():
        name_file = f'line{line}.txt'
        with open(name_file, 'w', encoding='utf-8') as name_file:
            print(f'{translate(value)} - {key}', file=name_file)
        line += 1
