import json


class TypeOrgEquipmentError(Exception):
    def __init__(self, name, model):
        print(f'This model: {model} is not {name}')


class Warehouse:
    list_equipment = {'Printer': [], 'Scanner': [], 'PrinterScanner': [], 'Xerox': []}


class OrgEquipment:
    def __init__(self, firm, cost, model, size):
        self.firm = firm
        self.cost = cost
        self.size = size
        self.model = model
        self._list_of_params = {'firm': firm, 'cost': cost, 'model': model, 'size': size}

    @classmethod
    def add_to_warehouse(cls, *args):
        count = int(input(f'Count of {cls.__name__} {args[0]["firm"]} {args[0]["model"]}: '))
        if Warehouse.list_equipment[cls.__name__]:
            for i in range(len(Warehouse.list_equipment[cls.__name__])):
                if Warehouse.list_equipment[cls.__name__][i]["model"] == args[0]["model"]:
                    Warehouse.list_equipment[cls.__name__][i]['count'] += count
                    return
        Warehouse.list_equipment[cls.__name__].append({})
        for el in args:
            Warehouse.list_equipment[cls.__name__][-1] = {par: value for par, value in el.items()}
        Warehouse.list_equipment[cls.__name__][-1]['count'] = count


class Printer(OrgEquipment):
    def __init__(self, firm, cost, model, size, type_paint=None):
        super().__init__(firm, cost, model, size)
        self.type_paint = type_paint
        Printer._type_paint1(self)
        self._list_of_params = {'firm': firm, 'cost': cost, 'model': model, 'type_paint': self.type_paint, 'size': size}

    def _type_paint1(self):
        if self.type_paint is not None:
            pass
        elif self.model[-1].upper() == 'B':
            self.type_paint = 'Black & White'
        elif self.model[-1].upper() == 'C':
            self.type_paint = 'Colorful'

    def add_printer(self):
        try:
            if self.model.upper()[0] == 'P':
                Printer.add_to_warehouse(self._list_of_params)
            else:
                raise TypeOrgEquipmentError('Printer', self.model)
        except TypeOrgEquipmentError:
            return


class Scanner(OrgEquipment):
    def __init__(self, firm, cost, model, size, version_scanner=None):
        super().__init__(firm, cost, model, size)
        self.version_scanner = version_scanner
        Scanner._version_scanner1(self)
        self._list_of_params = {'firm': firm, 'cost': cost, 'model': model, 'version_scanner': self.version_scanner,
                                'size': size}

    def _version_scanner1(self):
        if self.version_scanner is not None:
            pass
        elif 'S' in self.model:
            number_of_version = self.model[self.model.index('S') + 1]
            if number_of_version.isdigit() and 1 <= int(number_of_version) <= 3:
                self.version_scanner = number_of_version

    def add_scanner(self):
        try:
            if self.model.upper()[0] == 'S':
                Scanner.add_to_warehouse(self._list_of_params)
            else:
                raise TypeOrgEquipmentError('Scanner', self.model)
        except TypeOrgEquipmentError:
            return


class PrinterScanner(Printer, Scanner):
    def __init__(self, firm, cost, model, size, version_scanner=None, type_paint=None):
        super().__init__(firm, cost, model, size)
        self.type_paint = type_paint
        Printer._type_paint1(self)
        self.version_scanner = version_scanner
        Scanner._version_scanner1(self)
        self._list_of_params = {'firm': firm, 'cost': cost, 'model': model, 'type_paint': self.type_paint,
                                'version_scanner': self.version_scanner,
                                'size': size}

    def add_printer_scanner(self):
        try:
            if self.model.upper()[:2] == 'PS':
                PrinterScanner.add_to_warehouse(self._list_of_params)
            else:
                raise TypeOrgEquipmentError('PrinterScanner', self.model)
        except TypeOrgEquipmentError:
            return


class Xerox(OrgEquipment):
    def add_xerox(self):
        Xerox.add_to_warehouse(self._list_of_params)


if __name__ == '__main__':
    p = Printer('Pop', 1000, 'P_1220c', '100x100')
    s = Scanner('Honor', 1000, 'S1_1220c', '100x100')
    ps = PrinterScanner('Canon', 12000, 'PS2_1000B', '120x20')
    ps1 = PrinterScanner('Apple', 22000, 'PS1_1000c', '120x30')
    x = Xerox('Wtf', 100, 'X_1000', '200x10')
    ps1.add_printer_scanner()
    p.add_printer()
    s.add_scanner()
    ps.add_printer_scanner()
    ps1.add_printer_scanner()
    print(json.dumps(Warehouse.list_equipment, indent=4))
