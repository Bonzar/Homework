from functools import reduce


# gen = (reduce(lambda a, b: a * b, list(range(1, i))) for i in range(2, 25))
#
# c = 0
# for el in gen:
#     if c > 15:
#         break
#     else:
#         print(el)
#         c += 1

def fibo_gen():
    for i in range(2, 25):
        fibo = reduce(lambda a, b: a * b, range(1, i))
        yield fibo


c = 0
for el in fibo_gen():
    if c > 15:
        break
    else:
        print(el)
        c += 1
