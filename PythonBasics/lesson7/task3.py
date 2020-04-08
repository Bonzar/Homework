class Cell:
    def __init__(self, count):
        self.count = count

    def __add__(self, other):
        return Cell(self.count + other.count)

    def __sub__(self, other):
        if self.count < other.count:
            print(f"\r\033[31mThe number of instances of the first cell is less than that of the second.")
        else:
            return Cell(self.count - other.count)

    def __mul__(self, other):
        return Cell(self.count * other.count)

    def __truediv__(self, other):
        return Cell(round(self.count / other.count))

    def make_order(self, count_inst):
        line, rem = divmod(self.count, count_inst)
        return ('*' * count_inst + '\n') * line + '*' * rem

    def __str__(self):
        return str(self.count)


first_c = Cell(15)
print(f'1 - {first_c}')
second_c = Cell(8)
print(f'2 - {second_c}')
third_c = Cell(21)
print(f'3 - {third_c}')
four_c = first_c / second_c + third_c
print(f'4 - {four_c}')
five_c = four_c * (four_c - first_c)
print(f'5 - {five_c}')
print(five_c.make_order(20))
