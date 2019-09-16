'''
    training11_1_scoretable_Inheritance_3layer.py
'''
class DepartmentInfo:
    '''
        학과 정보( DepartmentInfo ) class

        member : 학과 이름( departmentname )
                 전공 과목수( majorsubjectmax )

        method : 생성자( __init__() )
                 학과 이름 읽기( getDepartmentName() )
                 전공 과목수 읽기( getMajorSubjectMax() )
                 학과 정보 읽기( readDepartmentInfo() )
    '''
    def __init__( self, departmentname, majorsubjectmax ):
        self.departmentname = departmentname
        self.majorsubjectmax = majorsubjectmax

    def getDepartmentName( self ):
        return self.departmentname

    def getMajorSubjectMax( self ):
        return self.majorsubjectmax

    def readDepartmentInfo( self ):
        return self.departmentname, self.majorsubjectmax

    def readMajorSubjectMax( self ):
        return self.majorsubjectmax

    def __repr__( self ):
        s = '{0:20} {1:2}'.format( self.departmentname, self.majorsubjectmax )

        return s

class DepartmentTable:
    '''
        학과 테이블( DepartmentTable ) class

        member : 학과 목록( departments )

        method : 생성자( __init__() )
                 학과 정보 읽기( readDepartmentInfo() )
                 학과 전공 과목수 읽기( readMajorSubjectMax() )
                 학과 정보 쓰기( writeDepartmentInfo() )
                 학과 테이블 읽기( printDepartmentInfo() )
    '''
    def __init__( self ):
        self.departments = {}
        self.departmentCount = 0

    def getfDepartmentCount( self ):
        return self.departmentCount

    def isDepartmentInfo( self, key ):
        return self.departments.get( key, False )

    def readDepartmentInfo( self, key ):
        return self.departments[ key ].readDepartmentInfo()

    def readMajorSubjectMax( self, key ):
        return self.departments[ key ].readMajorSubjectMax()

    def writeDepartmentInfo( self, department ):
        self.departments[ department.getDepartmentName() ] = department
        self.departmentCount += 1 

    def printDepartmentInfos( self ):
        keys = self.departments.keys()
        for key in keys:
            print( self.departments[ key ] )

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

    def __init__( self, name, department, common_subjects ):        
        self.name = name
        self.department = department
        self.common_subjects = [ v for v in common_subjects ]

    def getName( self ):
        return self.name

    def getCommonSubjects( self ):
        return self.common_subjects

    def calcScore( self ):
        return sum( [ v for v in self.common_subjects ] )

    def readStudentInfo( self ):
        return self.name, self.department

    def __repr__( self ):
        s = '{0:<10} {1:<20}'.format( self.name, self.department )
        return s

class DepartmentStudentInfo( StudentInfo ):
    '''
        학과 학생( DepartmentStudentInfo ) class

        member : 전공 과목 수( maxsubjectmax )
                 전공 과목 점수( major_subjects )
                 

                 컴퓨터 학과 전공 과목수( COMPUTER_SUBJECT_MAX = 2 )

        method : 생성자( __init__() )
                 전공 과목수 읽기( getMajorSubjectMax() )
                 전공 과목 점수 읽기( getComputerSubjects() )
                 석차 기록하기( setRank() )
                 성적 계산( calcScore() )
                 학생 정보 읽기( readStudentInfo() )
    '''
    def __init__( self, name, department, majorsubjectmax, common_subjects, major_subjects ): 
        super().__init__( name, department, common_subjects )  
        self.majorsubjectmax = majorsubjectmax     
        self.major_subjects = [ v for v in major_subjects ]
        self.calcScore()

    def getMajorSubjectMax( self ):
        return self.majorsubjectmax

    def getComputerSubjects( self ):
        return self.major_subjects

    def getAverage( self ):
        return self.average

    def setRank( self, rank ):
        self.rank = rank

    def calcScore( self ):
        self.total = super().calcScore()
        self.total = self.total + sum( [ v for v in self.major_subjects ] )
        
        self.average = self.total / ( StudentInfo.COMMON_SUBJECT_MAX + self.majorsubjectmax )
        
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
        spaces = '          '
        for i in range( self.majorsubjectmax ):
            s = s + '{0:3} '.format( self.major_subjects[ i ] )
        s = s + '\t\t' + spaces[ self.majorsubjectmax::self.majorsubjectmax ]        
        s = s + '{0:3} {1:3} {2:3} {3:5} {4:6.2f} {5:2} {6:<10}'.format( self.common_subjects[ 0 ],
                                                                         self.common_subjects[ 1 ],
                                                                         self.common_subjects[ 2 ],
                                                                         self.total,
                                                                         self.average,
                                                                         self.rank,
                                                                         self.grade )
        return s

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
                 입력 학생 전공 과목수( majorsubjectmax )
                 입력 학생 전공 과목 점수( major_subject )
                 입력 학생 전공 과목 점수 목록( major_subjects )
                 입력 학생 공통 과목 점수( common_subject )
                 입력 학생 공통 과목 점수 목록( common_subjects )
                 입력 학생( student )
                 출력 학생 정보 목록( studentInfos )

        method : 생성자( __init__() )
                 학과 목록 출력한다.( printDepartmentTable() )
                 학과 정보를 입력한다.( inputDepartmentInfo() )
                 학과 정보를 조회한다.( searchDepartmentInfo() )
                 학생 정보를 입력한다.( inputStudentInfo() )
                 성적일람표를 출력한다.( inputStudentInfo() )
    '''
    def __init__( self ):
        self.scoreTable = ScoreTable()
        self.departmentTable = DepartmentTable()

        self.question_str = '''
1. 다음과 같이 출력하는 프로그램을 class를 작성하여 완성하세요.
   ( 10명이내 이름이 'end'이면 결과 출력, 90이상 Excellent 60이하 Fail )
   ( 상속과 control/entity class 형태로 구성 )
   학생정보를 상속받는 클래스를 하나로 하고, 학과 정보를 별도의 클래스로
   관리한다.
   
                       전공       공통
    Hong  computer     50 50    50 50 50 250 50.0  3 Fail
    Kim   Electronic   90 90 90 90 90 90 540 90.0  1 Excellent
    Nam   computer     70 70    70 70 70 350 70.0  2
        '''
        print( ''.center( 72, '=' ) )
        print( self.question_str )
        print( ''.center( 72, '=' ) )
        print()

    def printDepartmentTable( self ):
        print()
        print( ''.center( 30, '=' ) )
        print( '현재 등록된 학과 정보' )
        print( ''.center( 30, '-' ) )
        if self.departmentTable.getfDepartmentCount() > 0:
            self.departmentTable.printDepartmentInfos()
        print( ''.center( 30, '-' ) )
        print( '총 학과수 : {0:2}'.format( self.departmentTable.getfDepartmentCount() ) )
        print( ''.center( 30, '=' ) )
        print()

    def inputDepartmentInfo( self ):
        self.printDepartmentTable()
        
        select = input( '학과를 추가 하시겠습니까? (Y/N) : ' )
        while ( select.upper() != 'Y' and select.upper() != 'N' ):
            print( '\nError : Y 또는 N만 입력 가능합니다.\n' )
            select = input( '학과를 추가 하시겠습니까? (Y/N) : ' )

        while select.upper() == 'Y':
            departmentname = input( '\n학과명을 입력하세요.( 최대 20자 ) : ' )
            while len( departmentname ) < 0 or len( departmentname ) > 20:
                print( '\nError : 학과명은 1 ~ 20자 이내만 가능합니다.\n' )
                departmentname = input( '학과명을 입력하세요.( 최대 20자 ) : ' )
            majorsubjectmax = int( input( '학과 전공 과목수를 입력하세요.( 최대 10과목 이내 ) : ' ) )
            while majorsubjectmax < 0 and majorsubjectmax > 10:
                print( '\nError : 학과 전공 과목수는 1 ~ 10 이내만 가능합니다.\n' )    
                majorsubjectmax = int( input( '학과 전공 과목수를 입력하세요.( 최대 10과목 이내 ) : ' ) )
            department = DepartmentInfo( departmentname, majorsubjectmax )
            self.departmentTable.writeDepartmentInfo( department )

            select = input( '\n학과를 추가 하시겠습니까? (Y/N) : ' )
            while ( select.upper() != 'Y' and select.upper() != 'N' ):
                print( '\nError : Y 또는 N만 입력 가능합니다.' )
                select = input( '학과를 추가 하시겠습니까? (Y/N) : ' )

    def searchDepartmentInfo( self ):
        self.printDepartmentTable()
        departmentname = input( '전공 과목명을 입력하세요 : ' )
        while self.departmentTable.isDepartmentInfo( departmentname ) == False:
            print( '\nError : {0:20} 학과는 등록되어 있지 않습니다. 다시 입력하세요.'.format( departmentname ) )
            self.printDepartmentTable()
            departmentname = input( '전공 과목명을 입력하세요 : ' )    
        
        return self.departmentTable.readDepartmentInfo( departmentname )

    def inputStudentInfo( self ):
        self.count = 0

        self.name = input( '\n학생 이름 입력 ( "end" : quit ) : ' )
        while  self.name != 'end' and  self.count < ScoreTable.MAX:
            self.count += + 1
            self.common_subjects = []
            self.major_subjects = []

            self.department, self.majorsubjectmax = self.searchDepartmentInfo()

            print( '{0:20} 학과의 전공 과목은 총 {1:2} 과목 입니다.'.format( self.department, self.majorsubjectmax ) )
            for x in range( self.majorsubjectmax ):
                self.major_subject = int( input( '전공 {0:2} 과목중 {1:2} 번째 전공 과목 성적 입력 : '.format( self.majorsubjectmax, x + 1 ) ) )
                while ( self.major_subject < 0 or self.major_subject > 100 ):
                    print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                    self.major_subject = int( input( '전공 {0:2} 과목중 {1:2} 번째 전공 과목 성적 입력 : '.format( self.majorsubjectmax, x + 1 ) ) )    
                self.major_subjects.append( self.major_subject )

            print()
            for x in range( StudentInfo.COMMON_SUBJECT_MAX ):
                self.common_subject = int( input( '공통 {0:2} 과목중 {1:2} 번째 공통 과목 성적 입력 : '.format( StudentInfo.COMMON_SUBJECT_MAX, x + 1 ) ) )
                while ( self.common_subject < 0 or self.common_subject > 100 ):
                    print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                    self.common_subject = int( input( '공통 {0:2} 과목중 {1:2} 번째 공통 과목 성적 입력 : '.format( StudentInfo.COMMON_SUBJECT_MAX, x + 1 ) ) )
                self.common_subjects.append( self.common_subject )

            self.student = DepartmentStudentInfo( self.name, self.department, self.majorsubjectmax, self.common_subjects, self.major_subjects )

            self.scoreTable.writeStudentInfo( self.student )
            
            self.name = input( '\n학생 이름 입력 ( "end" : quit ) : ' )

    def printScoreTable( self ):
        print()
        self.studentInfos = self.scoreTable.printScoreTable()
        for studentInfo in self.studentInfos:
            print( studentInfo )
            with open('studentInfo.txt', 'a') as f:
                f.write(str(studentInfo)+'\n')
        print( '\ncount student : {0:2}'.format( ScoreTable.count_student ) )

        input( '\nPress any key to program stop...' ) 

def main():
    '''
        성적일람표 출력 프로그램 main()
    '''
    scoreTableUI = ScoreTableUI()

    scoreTableUI.inputDepartmentInfo() 
    if scoreTableUI.departmentTable.getfDepartmentCount() > 0:
        scoreTableUI.inputStudentInfo()   
        scoreTableUI.printScoreTable()

    else:
        print( '학과 정보가 없으므로 프로그램을 종료합니다...' )

if __name__ == '__main__':
    main() 