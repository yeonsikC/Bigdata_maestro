class StudentInfo:
    '''
        학생( StudentInfo ) class

        member : 이름( name )
                 전공( major )
                 공통 과목( common_subjects )
                 총점( total )
                 평균( average )
                 석차( rank )
                 판정( grade )

                 공통 과목 수( COMMON_SUBJECT_MAX = 3 )
                 Excellent 등급 기준 점수( EXCELLENT_BASE )
                 Fail 등급 기준 점수( FAIL_BASE )

        method : 생성자( __init__() )
                 이름 읽기( getName() )
                 공통 과목 점수 읽기( getCommonSubjects() )
                 성적 계산( calcScore() )
                 학생 정보 읽기( readStudentInfo() )
    '''
    COMMON_SUBJECT_MAX = 3
    EXCELLENT_BASE = 90
    FAIL_BASE = 60

    def __init__( self, name, major, common_subjects ):        
        self.name = name
        self.major = major
        self.common_subjects = [ v for v in common_subjects ]

    def getName( self ):
        return self.name

    def getCommonSubjects( self ):
        return self.common_subjects

    def calcScore( self ):
        return sum( [ v for v in self.common_subjects ] )

    def readStudentInfo( self ):
        return self.name, self.major

    def __repr__( self ):
        s = '{0:<10} {1:<20}'.format( self.name, self.major )
        return s

class Major( StudentInfo ):
    '''
        전공 class

        member : 전공 과목( major_subjects )

                 컴퓨터 학과 전공 과목수( COMPUTER_SUBJECT_MAX = 2 )

        method : 생성자( __init__() )
                 전공 과목 점수 읽기( getComputerSubjects() )
                 석차 기록하기( setRank() )
                 성적 계산( calcScore() )
                 학생 정보 읽기( readStudentInfo() )
    '''

    def __init__( self, name, department, common_subjects, major_subjects): 
        super().__init__( name, department, common_subjects )       
        self.major_subjects = [ v for v in major_subjects ]
        self.calcScore()

    def getComputerSubjects( self ):
        return self.major_subjects

    def getAverage( self ):
        return self.average

    def setRank( self, rank ):
        self.rank = rank

    def calcScore( self ):
        self.total = super().calcScore()
        self.total = self.total + sum( [ v for v in self.major_subjects ] )
        
        self.average = self.total / ( StudentInfo.COMMON_SUBJECT_MAX + Major.major_max )
        
        if self.average >= StudentInfo.EXCELLENT_BASE:
            self.grade = 'Excellent'
        elif self.average < StudentInfo.FAIL_BASE:
            self.grade = 'Fail'
        else:
            self.grade = ''

    def readStudentInfo( self ):
        return super().readStudentInfo(), tuple( self.common_subjects ), tuple( self.major_subjects ), self.total, self.average, self.grade

    def __repr__( self ):
        s = super().__repr__()
        for i in range(Major.major_max):
            s += '{0:3}'.format(self.major_subjects[i])
        s = s + '{0:3} {1:3} {2:3} {3:5} {4:6.2f} {5:2} {6:<10}'.format(self.common_subjects[ 0 ],
                                                                        self.common_subjects[ 1 ],
                                                                        self.common_subjects[ 2 ],
                                                                        self.total,
                                                                        self.average,
                                                                        self.rank,
                                                                        self.grade )
        return s

class Department:
    MAX = 0
    count_department = 0

    def __init__(self):
        self.departments = {}

    def readDepartmentInfo(self, key):
        return self.departments[key]

    def writeDepartmentInfo( self, major ):
        self.departments[major] = Major.major_max
        Department.count_department += 1

class ScoreTable:
    '''
        성적 일람표( ScoreTable ) class

        member : 성적일람표( scoretable ) - 학생 정보 저장

                 최대 학생수( MAX )
                 등록 학생수( count_student )

        method : 생성자( __init__() )
                 학생 정보를 읽는다.( readStudentInfo() )
                 학생 정보를 기록한다.( writeStudentInfo() )
                 학생별 석차를 계산한다.( calcRank() )
                 성적 일람표를 출력한다.( printScoreTable() )
    '''
    MAX = 10
    count_student = 0

    def __init__( self ):
        self.scoretable = {}

    def readStudentInfo( self, key ):
        return self.scoretable[ key ].readStudentInfo()

    def writeStudentInfo( self, student ):
        self.scoretable[ ScoreTable.count_student ] = student
        ScoreTable.count_student += 1
        self.calcRank()
    
    def calcRank( self ):
        keys = self.scoretable.keys()
        for key in keys:
            rank = 1
            average = self.scoretable[ key ].getAverage()
            for k in self.scoretable:
                if average < self.scoretable[ k ].getAverage():
                    rank += 1
            self.scoretable[ key ].setRank( rank )

    def printScoreTable( self ):
        return list( self.scoretable.values() )

class ScoreTableUI:
    '''
        성적 일람표 UI( ScoreTableUI ) class

        member : 성적일람표( scoretable ) - 성적 일람표 class 연결
                 
                 프로그램 표제( question_str )
                 입력 학생수( count )
                 입력 학생 이름( name )
                 입력 학생 전공( department )
                 입력 학생 전공 과목 점수( major_subject )
                 입력 학생 전공 과목 점수 목록( major_subjects )
                 입력 학생 공통 과목 점수( common_subject )
                 입력 학생 공통 과목 점수 목록( common_subjects )
                 입력 학생( student )
                 출력 학생 정보 목록( studentInfos )

        method : 생성자( __init__() )
                 학생 정보를 입력한다.( inputStudentInfo() )
                 성적일람표를 출력한다.( inputStudentInfo() )
    '''
    def __init__( self ):
        self.scoreTable = ScoreTable()
        self.department = Department()
        self.question_str = '''
1. 다음과 같이 출력하는 프로그램을 class를 작성하여 완성하세요.
   ( 10명이내 이름이 'end'이면 결과 출력, 90이상 Excellent 60이하 Fail )
   ( 상속과 control/entity class 형태로 구성 )

                       전공       공통
    Hong  computer     50 50    50 50 50 250 50.0  3 Fail
    Kim   Electronic   90 90 90 90 90 90 540 90.0  1 Excellent
    Nam   computer     70 70    70 70 70 350 70.0  2
        '''
        print( ''.center( 72, '=' ) )
        print( self.question_str )
        print( ''.center( 72, '=' ) )
        print()
        self.inputStudentInfo()

    def inputStudentInfo( self ):
        self.count = 0

        self.name = input( '학생 이름 입력 ( "end" : quit ) : ' )
        while  self.name != 'end' and  self.count < ScoreTable.MAX:
            self.count += + 1
            self.common_subjects = []
            self.major_subjects = []

            self.major = input( '전공을 입력하세요 : ' )

            if self.major in self.department.departments.keys():
                Major.major_max = self.department.readDepartmentInfo(self.major)
            else:
                Major.major_max = int(input( '전공강의 개수를 입력하세요 : '))
                self.department.writeDepartmentInfo(self.major)
            for x in range( Major.major_max ):
                self.major_subject = int( input( '전공 {0:2} 과목중 {1:2} 번째 전공 과목 성적 입력 : '.format( Major.major_max, x + 1 ) ) )
                while ( self.major_subject < 0 or self.major_subject > 100 ):
                    print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                    self.major_subject = int( input( '전공 {0:2} 과목중 {1:2} 번째 전공 과목 성적 입력 : '.format( Major.major_max, x + 1 ) ) )    
                self.major_subjects.append( self.major_subject )

            print()
            for x in range( StudentInfo.COMMON_SUBJECT_MAX ):
                self.common_subject = int( input( '공통 {0:2} 과목중 {1:2} 번째 공통 과목 성적 입력 : '.format( StudentInfo.COMMON_SUBJECT_MAX, x + 1 ) ) )
                while ( self.common_subject < 0 or self.common_subject > 100 ):
                    print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                    self.common_subject = int( input( '공통 {0:2} 과목중 {1:2} 번째 공통 과목 성적 입력 : '.format( StudentInfo.COMMON_SUBJECT_MAX, x + 1 ) ) )

                self.common_subjects.append( self.common_subject )
            self.student = Major( self.name, self.major, self.common_subjects, self.major_subjects )
            self.scoreTable.writeStudentInfo(self.student)
            self.name = input( '학생 이름 입력 ( "end" : quit ) : ' )

    def printScoreTable( self ):
        print()
        self.studentInfos = self.scoreTable.printScoreTable()
        for studentInfo in self.studentInfos:
            print( studentInfo )
        print( '\ncount student : {0:2}'.format( ScoreTable.count_student ) )

        input( '\nPress any key to program stop...' ) 

def main():
    '''
        성적일람표 출력 프로그램 main()
    '''
    scoreTableUI = ScoreTableUI()
    scoreTableUI.printScoreTable()

if __name__ == '__main__':
    main() 