'''
    단어장 전체 출력 함수
'''
def printwordbook( wordbook ):
    keys = wordbook.keys()
    
    print()
    print( ''.center( 78, '=' ) )
    print( '단어장'.center( 78, ' ' )  )
    print( ''.center( 78, '=' ) )
    for key in keys:
        print( '{0:<30} ( {1:<10} ) {2:<50}'.format( wordbook[ key ][ 0 ], 
                                                     wordbook[ key ][ 1 ], 
                                                     wordbook[ key ][ 2 ] ) )
    print( ''.center( 78, '=' ) )
    print( '총 단어수 : {0:5}'.format( len( keys ) ) )

    return
    