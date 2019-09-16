'''
    단어 검색 함수
'''
def searchword( wordbook ):
    search_word_name = input( '\n검색 단어 입력 ( "end" : quit ) : ' )
    while len( search_word_name ) < 1:
        print( '\nError : 단어의 글자수는 최소 한 글자 이상 입력하세요...\n' )
        search_word_name = input( '검색 단어 입력 ( "end" : quit ) : ' )

    while search_word_name != 'end':
        search_result = wordbook.get( search_word_name, () )

        if search_result:
            print( '\n{0:<30} ( {1:<10} ) : {2:<50}'.format( search_result[ 0 ],
                                                             search_result[ 1 ],
                                                             search_result[ 2 ] ) )
        else:
            print( '\n{0:<10} 단어는 등록되어 있지 않습니다...ㅠㅠ'.format( search_word_name ) )
        
        search_word_name = input( '\n검색 단어 입력 ( "end" : quit ) : ' )
        while len( search_word_name ) < 1:
            print( '\nError : 단어의 글자수는 최소 한 글자 이상 입력하세요...\n' )
            search_word_name = input( '검색 단어 입력 ( "end" : quit ) : ' )

    return
    