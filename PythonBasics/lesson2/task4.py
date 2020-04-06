text = input('Введите слова через пробел: ')
for ind, text in enumerate(text.split(), 1):
    print(f'{ind} - {text[:10]}')
