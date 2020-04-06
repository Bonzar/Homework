from functools import reduce


# gen = (reduce(lambda a, b: a * b, list(range(1, i))) for i in range(2, 25))
#
# c = 0
# for el in gen:
#     if c > 14:
#         break
#     else:
#         c += 1
#         print(f'Факториал {c} = {el}')


def fibo_gen():
    for i in range(2, 25):
        fibo = reduce(lambda a, b: a * b, range(1, i))
        yield fibo


c = 0
for el in fibo_gen():
    if c > 14:
        break
    else:
        c += 1
        print(f'Факториал {c} = {el}')
