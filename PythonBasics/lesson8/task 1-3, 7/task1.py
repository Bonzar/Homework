class ClassData:
    def __init__(self, day, month, year):
        self.day = day
        self.month = month
        self.year = year

    def __str__(self):
        return f'{self.day}-{self.month}-{self.year}'

    @classmethod
    def apportion(cls, init_data=None):
        day = int(init_data.split('-')[0])
        month = int(init_data.split('-')[1])
        year = int(init_data.split('-')[2])
        return ClassData.validation(day, month, year)

    @staticmethod
    def validation(day, month, year):
        try:
            if 1 <= day <= 31:
                pass
            else:
                day = "'Day'"
                raise ValueError('Day should be from 1 to 31.')
        except ValueError as VE:
            print(VE)
        try:
            if 1 <= month <= 12:
                pass
            else:
                month = "'Month'"
                raise ValueError('Month should be from 1 to 12.')
        except ValueError as VE:
            print(VE)
        try:
            if 1 <= year:
                pass
            else:
                year = "'Year'"
                raise ValueError("Year can't be smaller then 1.")
        except ValueError as VE:
            print(VE)
        return ClassData(day, month, year)


print(ClassData.apportion('111-112-0'))
print('-' * 30)
print(ClassData.apportion('11-01-2007'))
print('-' * 30)
print(ClassData.apportion('32-13-2007'))
