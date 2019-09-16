'''
    training11_3_sales_3layer_file.py
'''
class Item:
    '''
        품목 정보( Item ) class

        member : 품목 이름( itemaname )
                 단가( price )
                 수량( quantity )
                 금액( amount )

        method : 생성자( __init__() )
                 판매 정보를 기록하다.( setSaleData() )
                 수량 정보를 기록하다.( setQuantity() )
                 판매 금액을 계산하다.( calcAmount() )
                 품목 정보를 파일에 기록하다.( saveItem() )
    '''
    def __init__( self, itemname, price ):
        self.itemname = itemname
        self.price = price
        self.quantity = 0
        self.amount = 0

    def setSaleData( self, quantity, amount ):
        self.quantity = quantity
        self.amount = amount
        return
    
    def setQuantity( self, quantity ):
        self.quantity += int( quantity )
        self.CalcAmount()
        return

    def CalcAmount( self ):
        self.amount = self.price * self.quantity
        return
    
    def saveItem( self, f ):
        f.write( self.itemname + ' ' )
        f.write( str( self.price ) + ' ' )
        f.write( str( self.quantity ) + ' ' )
        f.write( str( self.amount ) + '\n' )
        return
    
    def __repr__( self ):
        return '{0:<10} {1:>5} {2:>3} {3:>8}'.\
               format( self.itemname, self.price, self.quantity, self.amount )
    

class Sales:
    '''
        판매 정보( Sales ) class

        member : 판매 정보( salesInfo ) - list

        method : 생성자( __init__() )
                 품목 정보를 기록하다.( registrationItemInfo() )
                 품목 정보를 갱신하다.( updateItemInfo() )
                 품목 정보를 검색하다.( searchItemInfo() )
                 판매 현황표를 출력하다.( printSalesTable() )
                 품목 정보를 파일로부터 읽는다.( loadSalesInfo() )
                 품목 정보를 파일에 기록하다.( saveSalesInfo() )
    '''
    def __init__( self ):
        self.salesInfo = {}
        self.loadSalesInfo()

    def loadSalesInfo( self ):
        try :
            with open( 'items.txt', 'r' ) as f:
                while True:
                    data = f.readline()
                    if not data:
                        break
                    itemdata = list( data.split() )
                    item = Item( itemdata[0], int( itemdata[1] ) )
                    item.setSaleData( int( itemdata[2] ), int( itemdata[3] ) )
                    self.salesInfo[ item.itemname ] = item

        except FileNotFoundError:
            pass
                            
        return

    def saveSalesInfo( self ):
        with open( 'items.txt', 'w' ) as f:
            for key in self.salesInfo:
                self.salesInfo[ key ].saveItem( f )
        return

    def registrationItemInfo( self, itemInfo ):
        self.salesInfo[ itemInfo.itemname ] = itemInfo 
        return

    def updateItemInfo( self, itemInfo ):
        self.salesInfo[ itemInfo.itemname ] = itemInfo 
        return

    def searchItemInfo( self, item ):
        return self.salesInfo.get( item )

    def printSalesTable( self ):
        with open( 'salesTable.txt', 'w' ) as f:
            print( '\n\t     {0:*^19}\n'.format( ' Sales Table ' ) )
            f.write( '\n\t     {0:*^19}\n\n'.format( ' Sales Table ' ) )
            for key in self.salesInfo:
                print( '\t' + str( self.salesInfo[key] ) )
                f.write( '\t' + str( self.salesInfo[key] ) + '\n' )
        
class SalesView:   
    '''
        판매 정보 View( SalesView ) class

        member : 판매 정보( sales )

        method : 생성자( __init__() )
                 메인 메뉴( menu() )
                 품목 정보 등록( inputItem() )
                 판매 정보 등록( inputSaleInfo() )
                 판매 현황표 출력( printSalesTable() )
    '''    
    def __init__( self ):
        self.sales = Sales()

        self.question_str = '''
3. 품목 정보는 품목명, 단가이고, 판매 정보는 품목명, 판매 수량이며 
   판매 내역은 품목명, 단가, 판매 수량, 판매 금액일 때 다음 메뉴를 
   이용하여 동작하는 프로그램
   ( class 구성, file을 이용하여 처리 )
		
		1. 품목 정보 등록				
		2. 판매 정보 등록				
		3. 판매 현황표 출력				
		0. 종료	
        '''
        print( ''.center( 66, '=' ) )
        print( self.question_str )
        print( ''.center( 66, '=' ) )
        print()        

    def menu( self ):
        menu = '''
1. 품목 정보 등록
2. 판매 정보 등록
3. 판매 현황표 출력
0. 종료
select menu : '''
        func_dict = { 1:self.inputItem, 2:self.inputSaleInfo, 3:self.printSalesTable }
    
        while True:
            print( menu, end = ' ' )
            selectMenu = int( input() )

            if selectMenu == 0:
                self.sales.saveSalesInfo()
                break
            elif 1 <= selectMenu <= 3:
                func_dict[ selectMenu ]()
        return

    def inputItem( self ):
        print( '\n' )
        item = input( 'Input item name : ' )
        price = int( input( 'Input price : ' ) )

        itemInfo = Item( item, price )
        self.sales.registrationItemInfo( itemInfo )
        return

    def inputSaleInfo( self ):
        print( '\n' )
        item = input( 'Input item name : ' )

        itemInfo = self.sales.searchItemInfo( item )
        if itemInfo != None:
            quantity = int( input( 'Input quantity : ' ) )

            itemInfo.setQuantity( quantity )
            self.sales.updateItemInfo( itemInfo )
        else:
            print( 'Error : {:<10} not found!!!'.format( item ) )
        return

    def printSalesTable( self ):
        print( self.sales.printSalesTable() )
        return

def main():
    salesView = SalesView()
    salesView.menu()

if __name__ == '__main__':
    main()
