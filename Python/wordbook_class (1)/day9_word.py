'''
    day9_word.py

    1. 50개 이내의 단어, 품사, 뜻을 저장한 단어장을 구성한 후
   단어장을 출력하는 프로그램을 class를 이용하여 작성한다.
   ( 단어가 '0'이면 단어 입력 종료 )  
   ( 단어는 최대 20자, 품사는 최대 10자, 뜻은 최대 50자 )
'''
from Word import Word

question_str = '''
1. 50개 이내의 단어, 품사, 뜻을 저장한 단어장을 구성한 후
   단어장을 출력하는 프로그램을 class를 이용하여 작성한다.
   ( 단어가 '0'이면 단어 입력 종료 )  
   ( 단어는 최대 20자, 품사는 최대 10자, 뜻은 최대 50자 )
'''
print( ''.center( 60, '=' ) )
print( question_str )
print( ''.center( 60, '=' ) )
print()

def main():
    MAX = 50
    count = 0

    wordbook = {}

    word_name = input( '최대 {0:2}글자의 단어를 입력 ( "end" : quit ) : '.format( Word.WORD_LENGTH ) )
    while len( word_name ) < 1 or len( word_name ) > Word.WORD_LENGTH:
        print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.WORD_LENGTH ) )
        word_name = input( '최대 {0:2}글자의 단어를 입력 ( "end" : quit ) : '.format( Word.WORD_LENGTH ) )
        
    while word_name != 'end' and count < MAX:
        count = count + 1
        word_class = input( '"{0:<10}" 단어의 최대 {1:10}글자 품사 입력 : '.format( word_name, Word.CLASS_LENGTH ) )
        while len( word_class ) < 1 or len( word_class ) > Word.CLASS_LENGTH:
            print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.CLASS_LENGTH ) )
            word_class = input( '"{0:<10}" 단어의 최대 {1:10}글자 품사 입력 : '.format( word_name, Word.CLASS_LENGTH ) )

        word_meaning = input( '"{0:<10}" 단어의 최대 {1:10}글자 뜻 입력 : '.format( word_name, Word.MEANING_LENGTH ) )
        while len( word_meaning ) < 1 or len( word_meaning ) > Word.MEANING_LENGTH:
            print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.MEANING_LENGTH ) )
            word_meaning = input( '"{0:<10}" 단어의 최대 {1:10}글자 뜻 입력 : '.format( word_name, Word.MEANING_LENGTH ) )

        wordbook[ word_name ] = Word( word_name, word_class, word_meaning ) 
    
        word_name = input( '\n최대 {0:2}글자의 단어를 입력 ( "end" : quit ) : '.format( Word.WORD_LENGTH ) )
        while len( word_name ) < 1 or len( word_name ) > Word.WORD_LENGTH:
            print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.WORD_LENGTH ) )
            word_name = input( '최대 {0:2}글자의 단어를 입력 ( "end" : quit ) : '.format( Word.WORD_LENGTH ) )

    print()
    print( ''.center( 78, '=' ) )
    print( '단어장'.center( 78, ' ' )  )
    print( ''.center( 78, '=' ) )
    for v in wordbook:
        print( '{0:<20} ( {1:<10} ) {2:<50}'.format( wordbook[ v ].getWordName(), 
                                                                                                   wordbook[ v ].getWordClass(), 
                                                                                                   wordbook[ v ].getWordMeaning() ) )
    print( ''.center( 78, '=' ) )
    print( '총 단어수 : {0:5}\n'.format( Word.count_word  ) )

if __name__ == '__main__':
    main()