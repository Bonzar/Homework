def int_func():
    text = ''
    while input('Y - Продолжить, N - Stop: ').upper() == 'Y':
        text += input('Введите слова через пробел: ')
        for i in text.split():
            text = text.replace(i, i.title())
        print(text)
        text += ' '
    return text


int_func()