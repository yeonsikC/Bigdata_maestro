'''
    단어 수정 함수
'''
def modifyword( wordbook ):
    modify_word_name = input( '\n수정 단어 입력 ( "end" : quit ) : ' )
    while len( modify_word_name ) < 1:
        print( '\nError : 단어의 글자수는 최소 한 글자 이상 입력하세요...\n' )
        modify_word_name = input( '수정 단어 입력 ( "end" : quit ) : ' )

    while modify_word_name != 'end':
        search_result = wordbook.get( modify_word_name, () )

        if search_result:
            select = int( input( '"{0:<30} 단어의 [ 1 ] 품사 수정\t[ 2 ] 뜻 수정 [ 3 ] 수정 종료 중 선택하세요 : '.format( search_result[ 0 ] ) ) )
            while select < 1 or select > 3:
                print( '\nError : 1 ~ 3사이의 숫자를 입력하세요...\n' )
                select = int( input( '"{0:<30} 단어의 [ 1 ] 품사 수정\t[ 2 ] 뜻 수정 [ 3 ] 수정 종료 중 선택하세요 : '.format( search_result[ 0 ] ) ) )
            
            if select == 1:
                modify_word = list( search_result )
                modify_word_class = input( '"{0:<30}" 단어의 현재 품사는 {1:<10}의 수정 내용 입력 : '.format( modify_word[ 0 ], modify_word[ 1 ] ) )
                while len( modify_word_class ) < 1:
                    print( '\nError : 단어 품사 글자수는 최소 한 글자 이상 입력하세요...\n' )
                    modify_word_class = input( '"{0:<30}" 단어의 현재 품사는 {1:<10}의 수정 내용 입력 : '.format( modify_word[ 0 ], modify_word[ 1 ] ) )
                modify_word[ 1 ] = modify_word_class
                wordbook[ modify_word[ 0 ] ] = tuple( modify_word )
            elif select == 2:
                modify_word_meaning = input( '"{0:<30}" 단어의 현재 내용은 {1:<50}의 수정 내용 입력 : '.format( search_result[ 0 ], search_result[ 2 ] ) )
                while len( modify_word_meaning ) < 1:
                    print( '\nError : 단어 뜻 글자수는 최소 한 글자 이상 입력하세요...\n' )
                    modify_word_meaning = input( '"{0:<30}" 단어의 현재 내용은 {1:<50}의 수정 내용 입력 : '.format( search_result[ 0 ], search_result[ 2 ] ) )
                modify_word[ 2 ] = modify_word_meaning
                wordbook[ modify_word[ 0 ] ] = tuple( modify_word )
            else:
                break
        else:
             print( '\n{0:<10} 단어는 등록되어 있지 않습니다...ㅠㅠ'.format( modify_word_name ) )

        modify_word_name = input( '\n수정 단어 입력 ( "end" : quit ) : ' )
        while len( modify_word_name ) < 1:
            print( '\nError : 단어의 글자수는 최소 한 글자 이상 입력하세요...\n' )
            modify_word_name = input( '수정 단어 입력 ( "end" : quit ) : ' )

    return
    