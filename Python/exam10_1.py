'''
    Word.py

    단어 클래스

    member : 단어 - wordname
             품사 - wordclass
             뜻 - wordmeaning

             단어 길이 - WORD_LENGTH = 20
             품사 길이 - CLASS_LENGTH = 10
             뜻 길이 - MEANING_LENGTH = 50
             단어수 - count_word
             
    method : 생성자( __init__() )
             단어 읽기( getWordName() )
             품사 읽기( getWordClass() )
             뜻 읽기( getWordMeaning() )
             단어 쓰기( writeWord() )
             단어 내용 읽기( readWord() )
'''
class Word:
    WORD_LENGTH = 20
    CLASS_LENGTH = 10
    MEANING_LENGTH = 50

    count_word = 0

    def __init__( self, wordName = None, wordClass = None, wordMeaning = None ):
        Word.count_word += 1
        
        self.wordName = wordName
        self.wordClass = wordClass
        self.wordMeaning = wordMeaning

    def getWordName( self ):
        return self.wordName

    def getWordClass( self ):
        return self.wordClass

    def getWordMeaning( self ):
        return self.wordMeaning

    def readWord( self ):
        return self.wordName, self.wordClass, self.wordMeaning

    def __repr__(self):
        str = '{0:<20} : ({1:^10}) {2:<50}\n'.format(self.wordName, self.wordClass, self.wordMeaning)
        return str


class Dictionary:
    MAX = 50
    count_word = 0

    def __init__(self):
        self.dictionary = {}

    def writeWord(self, wordName, wordClass, wordMeaning):
        self.dictionary[wordName] = Word(wordName, wordClass, wordMeaning)
        Dictionary.count_word += 1    
    
    def readWord(self, key):
        return self.dictionary[key].readWord()

    def printDictionary(self):
        return tuple(self.dictionary.values())

def main():
    MAX = 50
    count = 0
    question_str = '''
        1. 50개 이내의 단어, 품사, 뜻을 저장한 단어장을 구성한 후
        단어장을 출력하는 프로그램을 class를 이용하여 작성한다.
        ( 단어가 '0'이면 단어 입력 종료 )  
        ( 단어는 최대 20자, 품사는 최대 10자, 뜻은 최대 50자 )
        ( control class와 Entity class 관계로 구성한다.)
        ( boundary class와 control class, Entity class 관계로 구성한다.)
    '''
    print( ''.center( 60, '=' ) )
    print( question_str )
    print( ''.center( 60, '=' ) )
    print()

    dictionary = Dictionary()

    wordName = input( '최대 {0:2}글자의 단어를 입력 ( "end" : quit ) : '.format( Word.WORD_LENGTH ) )
    while len( wordName ) < 1 or len( wordName ) > Word.WORD_LENGTH:
        print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.WORD_LENGTH ) )
        wordName = input( '최대 {0:2}글자의 단어를 입력 ( "end" : quit ) : '.format( Word.WORD_LENGTH ) )
        
    while wordName != 'end' and count < MAX:
        count = count + 1
        wordClass = input( '"{0:<10}" 단어의 최대 {1:10}글자 품사 입력 : '.format( wordName, Word.CLASS_LENGTH ) )
        while len( wordClass ) < 1 or len( wordClass ) > Word.CLASS_LENGTH:
            print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.CLASS_LENGTH ) )
            wordClass = input( '"{0:<10}" 단어의 최대 {1:10}글자 품사 입력 : '.format( wordName, Word.CLASS_LENGTH ) )

        wordMeaning = input( '"{0:<10}" 단어의 최대 {1:10}글자 뜻 입력 : '.format( wordName, Word.MEANING_LENGTH ) )
        while len( wordMeaning ) < 1 or len( wordMeaning ) > Word.MEANING_LENGTH:
            print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.MEANING_LENGTH ) )
            wordMeaning = input( '"{0:<10}" 단어의 최대 {1:10}글자 뜻 입력 : '.format( wordName, Word.MEANING_LENGTH ) )

        dictionary.writeWord(wordName, wordClass, wordMeaning) 
    
        wordName = input( '\n최대 {0:2}글자의 단어를 입력 ( "end" : quit ) : '.format( Word.WORD_LENGTH ) )
        while len( wordName ) < 1 or len( wordName ) > Word.WORD_LENGTH:
            print( '\nError : 단어의 글자수는 최대 {0:2}글자 단어만 입력하세요...\n'.format( Word.WORD_LENGTH ) )
            wordName = input( '최대 {0:2}글자의 단어를 입력 ( "end" : quit ) : '.format( Word.WORD_LENGTH ) )

    print()
    print( ''.center( 78, '=' ) )
    print( '단어장'.center( 78, ' ' )  )
    print( ''.center( 78, '=' ) )
    
    for word in dictionary.printDictionary():
        print( word )

    print( ''.center( 78, '=' ) )
    print( '총 단어수 : {0:5}\n'.format( Word.count_word  ) )

if __name__ == '__main__':
    main()