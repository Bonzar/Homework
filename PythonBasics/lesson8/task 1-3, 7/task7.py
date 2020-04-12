class ComplexNumber:
    def __init__(self, number):
        self.integer = int(number.split(' + ')[0])
        self.imaginary = int(number.split(' + ')[1][:-1])

    def __add__(self, other):
        new_number = f'{self.integer + other.integer} + {self.imaginary + other.imaginary}i'
        return ComplexNumber(new_number)

    def __mul__(self, other):
        new_number = f'{self.integer * other.integer - self.imaginary * other.imaginary} + {self.imaginary * other.integer + self.integer * other.imaginary}i'
        return ComplexNumber(new_number)

    def __str__(self):
        return f'{self.integer} + {self.imaginary}i'


c = ComplexNumber('12 + 2i')
b = ComplexNumber('32 + 23i')
e = ComplexNumber('21 + 21i')
print((c + b) * e)
