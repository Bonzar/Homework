class ZeroDivision(Exception):
    def __init__(self, txt):
        self.txt = txt


def division(par_1, par_2):
    try:
        if par_2 == 0:
            raise ZeroDivision('Division on Zero!')
        else:
            return par_1 / par_2
    except ZeroDivision as zd:
        return zd


print(division(1, 0))
