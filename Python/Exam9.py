'''
    Exam9.py

    학생 class

    member : 이름( name )
             과목1( subject1 )
             과목2( subject2 )
             과목3( subject3 )
             총점( total )
             평균( average )
             판정( grade )

    method : 생성자( __init__() )
             이름 읽기( getName() )
             과목1 점수 읽기( getSubject1() )
             과목2 점수 읽기( getSubject2() )
             과목3 점수 읽기( getSubject3() )
             성적 계산( calcScore() )
             학생 정보 읽기( readStudentInfo() )
'''
class StudentInfo:
    SUBJECT_MAX = 3
    EXCELLENT_BASE = 90
    FAIL_BASE = 60
    obj_count = 0

    def __init__( self, name = None, subject1 = 0, subject2 = 0, subject3 = 0 ):
        StudentInfo.obj_count += 1 
        
        self.name = name
        self.subject1 = subject1
        self.subject2 = subject2
        self.subject3 = subject3

        self.calcScore()

    def getName( self ):
        return self.name

    def getSubject1( self ):
        return self.subject1

    def getSubject2( self ):
        return self.subject2

    def getSubject3( self ):
        return self.subject3

    def calcScore( self ):
        self.total = sum( ( self.subject1, self.subject2, self.subject3 ) )
        self.average = self.total / StudentInfo.SUBJECT_MAX
        if self.average >= StudentInfo.EXCELLENT_BASE:
            self.grade = 'Excellent'
        elif self.average < StudentInfo.FAIL_BASE:
            self.grade = 'Fail'
        else:
            self.grade = ''
    def writePersonInfo(self, name, subject1, subject2, subject3):
        self.name = name
        self.subject1 = subject1
        self.subject2 = subject2
        self.subject3 = subject3

    def readStudentInfo( self ):
        return self.name, self.subject1, self.subject2, self.subject3, self.total, self.average, self.grade
	
    def __repr__(self):
        str = '{0:<10} {1:3} {2:3} {3:3} {4:5} {5:6.2f} {6:<10}'.format( self.name,
		    															 self.subject1,
																		 self.subject2,
																		 self.subject3,
																		 self.total,
																		 self.average,
																		 self.grade)
        return str

class ExamResult:
    MAX = 10
    count_person = 0

    def __init__( self ):
        self.examResult = {}

    def writeStudentInfo( self, name, subject1, subject2, subject3):
        self.examResult[ name ] = StudentInfo( name, subject1, subject2, subject3 )
        ExamResult.count_person += 1

    def readStudentInfo( self, key):
        return self.examResult[ key ].readStudentInfo()

    def printExamResult(self):
        for key in self.examResult:
            print(self.examResult[key])

    def __repr__( self ):
        s = []
        for key in self.examResult:
            s.append(self.examResult[ key ])
        return str(s)

def testMain():
    examResult = ExamResult()

    name = input( 'input name : ')
    while ExamResult.count_person < ExamResult.MAX and name != "end":
        subject1 = int(input('input subject1 : '))
        subject2 = int(input('input subject2 : '))
        subject3 = int(input('input subject3 : '))
        examResult.writeStudentInfo( name, subject1, subject2, subject3)
        name = input( 'input name : ')
        ExamResult.count_person += 1
    examResult.printExamResult()
    
if __name__ == "__main__":
    testMain()