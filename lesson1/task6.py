start = int(input('Введите значение километража: '))
result = int(input('Введите значение километража: '))
i = 1
while start < result:
    i += 1
    start = start + start / 10
print(f'на {i}-й день спортсмен достиг результата — не менее {result} км.')