class ItemInfo:
    def __init__(self, itemName, unitPrice):
        self.itemName = itemName
        self.unitPrice = unitPrice

    
    def getItemName(self):
        return self.itemName

    def getUnitPrice(self):
        return self.unitPrice

class ItemTable:

    count_item = 0

    def __init__(self):
        self.itemTable = {}
    
    def readItemInfo(self, key):
        return self.itemTable[ key ].readItemInfo()

    def writeItemInfo(self, item):
        self.itemTable[item] = item
        ItemTable.count_item += 1

    def printItemTable( self ):
        return list( self.itemTable.values() )

    def isItemInfo( self, key ):
        return self.itemTable.get( key, False )

class SaleInfo:
    def __init__(self, itemName, amount):
        self.itemName = itemName
        self.amonut = amount

class SaleTable:
    def __init__(self):
        self.saleTable = {}

    def readSaleInfo(self, key):
        return self.saleTable[ key ].readSaleInfo()

    def writeSaleInfo(self, itemName, amount):
        self.saleTable[itemName] = amount

    def printSaleTable( self ):
        return list( self.saleTable.items() )
   

class List(ItemInfo):
    def __init__(self, itemName, unitPrice, amount):
        super().__init__(itemName, unitPrice)
        self.amount = amount
        self.salesAmount()

    def salesAmounts(self):
        try:
            self.salesAmount = self.unitPrice * self.amount
        except ZeroDivisionError:
            self.salesAmount = 0

    def readList(self):
        return self.itemName, self.unitPrice, self.amount, self.salesAmount

    def __repr__( self ):
        s = '{0:10} {1:8} {2:3} {3:10}'.format(self.itemName,
                                               self.unitPrice,
                                               self.amount,
                                               self.salesAmount)
        return s

class ListUI:
    def __init__(self):
        self.itemTable = ItemTable()
        self.saleTable = SaleTable()

    def inputItemInfo( self ):
        select = input( '품목을 추가 하시겠습니까? (Y/N) : ' )
        while ( select.upper() != 'Y' and select.upper() != 'N' ):
            print( '\nError : Y 또는 N만 입력 가능합니다.\n' )
            select = input( '품목을 추가 하시겠습니까? (Y/N) : ' )

        while select.upper() == 'Y':
            itemName = input( '\n품목명을 입력하세요.( 최대 10자 ) : ' )
            while len( itemName ) < 0 or len( itemName ) > 10:
                print( '\nError : 품목명은 1 ~ 10자 이내만 가능합니다.\n' )
                itemName = input( '품목명을 입력하세요.( 최대 10자 ) : ' )
            unitPrice = int( input( '단가를 입력하세요.( 숫자만입력 ) : ' ) )
            item = ItemInfo( itemName, unitPrice )
            self.itemTable.writeItemInfo( item )

            select = input( '품목을 추가 하시겠습니까? (Y/N) : ' )
            while ( select.upper() != 'Y' and select.upper() != 'N' ):
                print( '\nError : Y 또는 N만 입력 가능합니다.\n' )
                select = input( '품목을 추가 하시겠습니까? (Y/N) : ' )

    def inputSalesInfo( self ):
        self.itemTable.printItemTable()
        itemName = input( '품목명을 입력하세요 : ' )
        while self.itemTable.isItemInfo( itemName ) == False:
            print( '\nError : {0:20} 품목은 등록되어 있지 않습니다. 다시 입력하세요.'.format( itemName ) )
            self.itemTable.printItemTable()
            itemName = input( '품목명을 입력하세요 : ' )            
        while  itemName != 0:
            amount = int(input("판매 수량을 입력하시오. (숫자만) : "))
            unitPrice = self.itemTable.readItemInfo(itemName)
            List(itemName, unitPrice, amount)
            itemName = input( '품목명을 입력하세요 : ' )

class Main():
    listUI = ListUI()
    listUI.inputItemInfo()
    listUI.inputSalesInfo()
