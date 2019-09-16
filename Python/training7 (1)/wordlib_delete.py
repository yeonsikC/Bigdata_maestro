'''
    단어 삭제 함수
'''
def deleteword( wordbook ):
    delete_word_name = input( '\n삭제 단어 입력 ( "end" : quit ) : ' )
    while len( delete_word_name ) < 1:
        print( '\nError : 단어의 글자수는 최소 한 글자 이상 입력하세요...\n' )
        delete_word_name = input( '\n삭제 단어 입력 ( "end" : quit ) : ' )

    while delete_word_name != 'end':
        search_result = wordbook.get( delete_word_name, () )

        if search_result:
            print( '\n{0:<30} ( {1:<10} ) : {2:<50}'.format( search_result[ 0 ],
                                                             search_result[ 1 ],
                                                             search_result[ 2 ] ) )
            delete_select = input( '\n삭제 하시겠습니까? (Y/N) : ' )
            if delete_select.upper() == 'Y':
                wordbook.pop( search_result[ 0 ] )
                print( '\n{0:<30} 단어가 삭제 되었습니다...'.format( delete_word_name ) )
            else:
                print( '\n{0:<30} 단어가 삭제가 취소 되었습니다...'.format( delete_word_name ) )
        else:
            print( '\n{0:<10} 단어는 등록되어 있지 않습니다...ㅠㅠ'.format( delete_word_name ) )
        
        delete_word_name = input( '\n삭제 단어 입력 ( "end" : quit ) : ' )
        while len( delete_word_name ) < 1:
            print( '\nError : 단어의 글자수는 최소 한 글자 이상 입력하세요...\n' )
            delete_word_name = input( '\n삭제 단어 입력 ( "end" : quit ) : ' )
                
    return
    