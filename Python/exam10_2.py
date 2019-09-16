'''
    day10_word_3layer.py

    1. 50개 이내의 단어, 품사, 뜻을 저장한 단어장을 구성한 후
       단어장을 출력하는 프로그램을 class를 이용하여 작성한다.
       ( 단어가 '0'이면 단어 입력 종료 )  
       ( 단어는 최대 20자, 품사는 최대 10자, 뜻은 최대 50자 )

        2. boundary class와 control class와 Entity class 관계로 구성한다.
'''
class Word:
    '''
        단어( Word ) 클래스

        member : 단어 - wordname
                 품사 - wordclass
                 뜻 - wordmeaning

                 단어 길이 - WORD_LENGTH = 20
                 품사 길이 - CLASS_LENGTH = 10
                 뜻 길이 - MEANING_LENGTH = 50
                
        method : 생성자( __init__() )
                 단어 읽기( getWordName() )
                 품사 읽기( getWordClass() )
                 뜻 읽기( getWordMeaning() )
                 단어 쓰기( writeWord() )
                 단어 내용 읽기( readWord() )
    '''
    WORD_LENGTH = 20
    CLASS_LENGTH = 10
    MEANING_LENGTH = 50

    def __init__( self, wordname, wordclass = None, wordmeaning = None ):
        self.wordname = wordname
        self.wordclass = wordclass
        self.wordmeaning = wordmeaning

    def getWordName( self ):
        return self.wordname

    def getWordClass( self ):
        return self.wordclass

    def getWordMeaning( self ):
        return self.wordmeaning

    def writeWord( self, wordname, wordclass, wordmeaning ):
        self.wordname = wordname
        self.wordclass = wordclass
        self.wordmeaning = wordmeaning

    def readWord( self ):
        return self.wordname, self.wordclass, self.wordmeaning

    def __eq__( self, other ):
        return self.wordname == other.wordname and self.wordclass == other.wordclass

    def __ne__( self, other ):
        return self.wordname != other.wordname or self.wordclass != other.wordclass

    def __repr__( self ):
        s = '{0:<20} ( {1:<10} ) {2:<50}'.format( self.wordname, 
                                                  self.wordclass, 
                                                  self.wordmeaning )
        return s

class WordBook:
    '''
        단어장( WordBook ) 클래스

        member : 단어장 - wordbook

                 최대 단어 개수 - MAX_WORD = 50
                 기재된 단어 수 - count_word
                
        method : 생성자( __init__() )
                 단어를 읽는다.( readWord() )
                 단어를 기록한다.( writeWord() )
                 전체 단어장 내용을 확인한다.( printWordBook() )
    '''
    MAX_WORD = 50

    count_word = 0

    def __init__( self ):
        self.wordbook = {}

    def readWord( self, key ):
        return self.wordbook[ key ].readWord()
        
    def writeWord( self, wordname, wordclass, wordmeaning ):
        self.wordbook[ wordname ] = Word( wordname, wordclass, wordmeaning )
        WordBook.count_word += 1

    def printWordBook( self ):
        return tuple( self.wordbook.values() )

class WordBookUI:
    '''
        단어장 UI( WordBookUI ) 클래스

        member : 단어장( wordbook ) - 단어장 클래스 연결
                 
                 프로그램 표제( question_str )
                 입력 단어수( count )
                 단어 이름( word_name )
                 단어 품사( word_class )
                 단어 뜻( word_meaning )

        method : 생성자( __init__() )
                 단어장 표제를 출력하다.( printTitle() )
                 단어를 입력하다.( inputWord() )
                 단어장을 출력하다.( printWord() )
    '''
    def __init__( self ):
        self.count = 0
        self.wordbook = WordBook()
        self.printTitle()

    def printTitle( self ):
        self.question_str = '''
1. 50개 이내의 단어, 품사, 뜻을 저장한 단어장을 구성한 후
   단어장을 출력하는 프로그램을 class를 이용하여 작성한다.
   ( 단어가 '0'이면 단어 입력 종료 )  
   ( 단어는 최대 20자, 품사는 최대 10자, 뜻은 최대 50자 )

   2. boundary class와 control class와 Entity class 관계로 구성한다.
        '''
        print( ''.center( 68, '=' ) )
        print( self.question_str )
        print( ''.center( 68, '=' ) )
        print()

    def inputWord( self ):
        self.word_name = input( '최대 {0:2}글자의 단어를 입력 ( "0" : quit ) : '.format( Word.WORD_LENGTH ) )
        while len( self.word_name ) < 1 or len( self.word_name ) > Word.WORD_LENGTH:
            print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.WORD_LENGTH ) )
            self.word_name = input( '최대 {0:2}글자의 단어를 입력 ( "0" : quit ) : '.format( Word.WORD_LENGTH ) )
            
        while self.word_name != '0' and self.count < WordBook.MAX_WORD:
            self.count += 1
            self.word_class = input( '"{0:<10}" 단어의 최대 {1:10}글자 품사 입력 : '.format( self.word_name, Word.CLASS_LENGTH ) )
            while len( self.word_class ) < 1 or len( self.word_class ) > Word.CLASS_LENGTH:
                print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.CLASS_LENGTH ) )
                self.word_class = input( '"{0:<10}" 단어의 최대 {1:10}글자 품사 입력 : '.format( self.word_name, Word.CLASS_LENGTH ) )

            self.word_meaning = input( '"{0:<10}" 단어의 최대 {1:10}글자 뜻 입력 : '.format( self.word_name, Word.MEANING_LENGTH ) )
            while len( self.word_meaning ) < 1 or len( self.word_meaning ) > Word.MEANING_LENGTH:
                print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.MEANING_LENGTH ) )
                self.word_meaning = input( '"{0:<10}" 단어의 최대 {1:10}글자 뜻 입력 : '.format( self.word_name, Word.MEANING_LENGTH ) )

            self.wordbook.writeWord( self.word_name, self.word_class, self.word_meaning )
        
            self.word_name = input( '\n최대 {0:2}글자의 단어를 입력 ( "0" : quit ) : '.format( Word.WORD_LENGTH ) )
            while len( self.word_name ) < 1 or len( self.word_name ) > Word.WORD_LENGTH:
                print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.WORD_LENGTH ) )
                self.word_name = input( '최대 {0:2}글자의 단어를 입력 ( "0" : quit ) : '.format( Word.WORD_LENGTH ) )

    def printWordBook( self ):
        print()
        print( ''.center( 78, '=' ) )
        print( '단어장'.center( 78, ' ' )  )
        print( ''.center( 78, '=' ) )
        for word in self.wordbook.printWordBook():
            print( word )
        print( ''.center( 78, '=' ) )
        print( '총 단어수 : {0:5}\n'.format( WordBook.count_word  ) )

def main():
    wordbookUI = WordBookUI()

    wordbookUI.inputWord()
    wordbookUI.printWordBook()    
    
if __name__ == '__main__':
    main()