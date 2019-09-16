'''
    Student.py

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
class Student:
    def __init__( self, name = None, subject1 = 0, subject2 = 0, subject3 = 0 ):
        self.SUBJECT_MAX = 3
        self.EXCELLENT_BASE = 90
        self.FAIL_BASE = 60

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
        self.average = self.total / self.SUBJECT_MAX
        if self.average >= self.EXCELLENT_BASE:
            self.grade = 'Excellent'
        elif self.average < self.FAIL_BASE:
            self.grade = 'Fail'
        else:
            self.grade = ''

    def readStudentInfo( self ):
        return self.name, self.subject1, self.subject2, self.subject3, self.total, self.average, self.grade

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

    def readStudentInfo( self ):
        return self.name, self.subject1, self.subject2, self.subject3, self.total, self.average, self.grade
