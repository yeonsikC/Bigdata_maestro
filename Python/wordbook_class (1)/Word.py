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

    def __init__( self, wordname = None, wordclass = None, wordmeaning = None ):
        Word.count_word += 1
        
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
