class Matrix:
    def __init__(self, *args, matrix_list=None):
        if matrix_list is None:
            matrix_list = []
        n1 = 1
        for i1 in range(1, len(args)):
            if (len(args) % i1 == 0) and (len(args) / i1 - i1 < len(args) / n1 - n1) and (len(args) / i1 - i1 >= 0):
                n1 = i1
        for i1 in range(n1):
            matrix_list.append([])
            matrix_list[i1].extend(args[i1 * int(len(args) / n1):(i1 + 1) * int(len(args) / n1)])
        self.matrix_list = matrix_list

    def __str__(self):
        print_matrix = ''
        for lines in self.matrix_list:
            print_line = ''
            for el in lines:
                print_line += str(self.matrix_list[self.matrix_list.index(lines)][lines.index(el)]) + ' '
            print_matrix += print_line + '\n'
        return print_matrix

    def __add__(self, other):
        new_matrix = []
        try:
            for line in range(len(self.matrix_list)):
                new_matrix.append([])
                for el in range(len(self.matrix_list[line])):
                    new_matrix[line].append(self.matrix_list[line][el] + other.matrix_list[line][el])
        except IndexError:
            print(f'\r\033[31mDifferent size of matrix!', end='')
            return ''
        else:
            return Matrix(matrix_list=new_matrix)


m = Matrix(11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 14, 12, 29)
n = Matrix(32, 12, 13, 14, 15, 36, 27, 18, 19, 31, 23, 32, 32, 65, 32)
print(m)
print(n)
print(m + n + m)
