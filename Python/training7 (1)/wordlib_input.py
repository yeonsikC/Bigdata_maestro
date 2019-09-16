'''
    단어 입력 함수
'''
def inputword( wordbook ):
    word_name = input( '\n단어 입력 ( "end" : quit ) : ' )
    while len( word_name ) < 1:
        print( '\nError : 단어의 글자수는 최소 한 글자 이상 입력하세요...\n' )
        word_name = input( '단어 입력 ( "end" : quit ) : ' )

    while word_name != 'end':
        word_class = input( '"{0:<30}" 단어 품사 입력 : '.format( word_name ) )
        while len( word_class ) < 1:
            print( '\nError : 단어 품사 글자수는 최소 한 글자 이상 입력하세요...\n' )
            word_class = input( '"{0:<30}" 단어 품사 입력 : '.format( word_name ) )

        word_meaning = input( '"{0:<30}" 단어 뜻 입력 : '.format( word_name ) )
        while len( word_meaning ) < 1:
            print( '\nError : 단어 뜻 글자수는 최소 한 글자 이상 입력하세요...\n' )
            word_meaning = input( '"{0:<30}" 단어 뜻 입력 : '.format( word_name ) )

        word = ( word_name, word_class, word_meaning )
        wordbook[ word_name ] = word    

        word_name = input( '\n단어 입력 ( "end" : quit ) : ' )
        while len( word_name ) < 1:
            print( '\nError : 단어의 글자수는 최소 한 글자 이상 입력하세요...\n' )
            word_name = input( '단어 입력 ( "end" : quit ) : ' )

    return
    