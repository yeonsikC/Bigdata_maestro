'''
    training10_2_scoretable_Inheritance.py
'''
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

class ComputerStudentInfo( StudentInfo ):
    '''
        컴퓨터학과 학생( ComputerStudentInfo ) class

        member : 전공 과목( major_subjects )

                 컴퓨터 학과 전공 과목수( COMPUTER_SUBJECT_MAX = 2 )

        method : 생성자( __init__() )
                 전공 과목 점수 읽기( getComputerSubjects() )
                 석차 기록하기( setRank() )
                 성적 계산( calcScore() )
                 학생 정보 읽기( readStudentInfo() )
    '''
    COMPUTER_SUBJECT_MAX = 2

    def __init__( self, name, department, common_subjects, major_subjects ): 
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
        
        self.average = self.total / ( StudentInfo.COMMON_SUBJECT_MAX + ComputerStudentInfo.COMPUTER_SUBJECT_MAX )
        
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
        s = s + '{0:3} {1:3}     {2:3} {3:3} {4:3} {5:5} {6:6.2f} {7:2} {8:<10}'.format( self.major_subjects[ 0 ],
                                                                                        self.major_subjects[ 1 ],
                                                                                        self.common_subjects[ 0 ],
                                                                                        self.common_subjects[ 1 ],
                                                                                        self.common_subjects[ 2 ],
                                                                                        self.total,
                                                                                        self.average,
                                                                                        self.rank,
                                                                                        self.grade )
        return s

class ElectronicStudentInfo( StudentInfo ):
    '''
        전가공학과 학생( ElectronicStudentInfo ) class

        member : 전공 과목( major_subjects )

                 전자 공학과 전공 과목수( ELECTRONIC_SUBJECT_MAX = 2 )

        method : 생성자( __init__() )
                 전공 과목 점수 읽기( getElectronicSubjects() )
                 석차 기록하기( setRank() )
                 성적 계산( calcScore() )
                 학생 정보 읽기( readStudentInfo() )
    '''
    ELECTRONIC_SUBJECT_MAX = 3

    def __init__( self, name, department, common_subjects, major_subjects ): 
        super().__init__( name, department, common_subjects )       
        self.major_subjects = [ v for v in major_subjects ]
        self.calcScore()

    def getElectronicSubjects( self ):
        return self.major_subjects

    def getAverage( self ):
        return self.average

    def setRank( self, rank ):
        self.rank = rank

    def calcScore( self ):
        self.total = super().calcScore()
        self.total = self.total + sum( [ v for v in self.major_subjects ] )
        
        self.average = self.total / ( StudentInfo.COMMON_SUBJECT_MAX + ElectronicStudentInfo.ELECTRONIC_SUBJECT_MAX )
        
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
        s = s + '{0:3} {1:3} {2:3} {3:3} {4:3} {5:3} {6:5} {7:6.2f} {8:2} {9:<10}'.format( self.major_subjects[ 0 ],
                                                                                        self.major_subjects[ 1 ],
                                                                                        self.major_subjects[ 2 ],
                                                                                        self.common_subjects[ 0 ],
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

def main():
    '''
        성적일람표 출력 프로그램 main()
    '''
    question_str = '''
1. 다음과 같이 출력하는 프로그램을 class를 작성하여 완성하세요.
   ( 10명이내 이름이 'end'이면 결과 출력, 90이상 Excellent 60이하 Fail )
   ( 상속과 control/entity class 형태로 구성 )

                       전공       공통
    Hong  computer     50 50    50 50 50 250 50.0  3 Fail
    Kim   Electronic   90 90 90 90 90 90 540 90.0  1 Excellent
    Nam   computer     70 70    70 70 70 350 70.0  2
    '''
    print( ''.center( 72, '=' ) )
    print( question_str )
    print( ''.center( 72, '=' ) )
    print()

    scoreTable = ScoreTable()

    count = 0

    name = input( '학생 이름 입력 ( "end" : quit ) : ' )
    while name != 'end' and count < ScoreTable.MAX:
        count = count + 1
        common_subjects = []
        major_subjects = []

        department = input( '전공 [ "computer" ] [ "electronic" ] 중 입력하세요 : ' )
        while ( department != 'computer' and department != 'electronic' ):
            print( '전공은 [ "computer" ] [ "electronic" ] 중 하나를 입력하세요' )
            department = input( '전공 [ "computer" ] [ "electronic" ] 중 입력하세요 : ' )

        if department == 'computer':
            for x in range( ComputerStudentInfo.COMPUTER_SUBJECT_MAX ):
                major_subject = int( input( '전공 {0:2} 과목중 {1:2} 번째 전공 과목 성적 입력 : '.format( ComputerStudentInfo.COMPUTER_SUBJECT_MAX, x + 1 ) ) )
                while ( major_subject < 0 or major_subject > 100 ):
                    print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                    major_subject = int( input( '전공 {0:2} 과목중 {1:2} 번째 전공 과목 성적 입력 : '.format( ComputerStudentInfo.COMPUTER_SUBJECT_MAX, x + 1 ) ) )    
                major_subjects.append( major_subject )

            print()
            for x in range( StudentInfo.COMMON_SUBJECT_MAX ):
                common_subject = int( input( '공통 {0:2} 과목중 {1:2} 번째 공통 과목 성적 입력 : '.format( StudentInfo.COMMON_SUBJECT_MAX, x + 1 ) ) )
                while ( common_subject < 0 or common_subject > 100 ):
                    print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                    common_subject = int( input( '공통 {0:2} 과목중 {1:2} 번째 공통 과목 성적 입력 : '.format( StudentInfo.COMMON_SUBJECT_MAX, x + 1 ) ) )

                common_subjects.append( common_subject )

            student = ComputerStudentInfo( name, department, common_subjects, major_subjects )

        elif department == 'electronic':
            for x in range( ElectronicStudentInfo.ELECTRONIC_SUBJECT_MAX ):
                major_subject = int( input( '전공 {0:2} 과목중 {1:2} 번째 전공 과목 성적 입력 : '.format( ElectronicStudentInfo.ELECTRONIC_SUBJECT_MAX, x + 1 ) ) )
                while ( major_subject < 0 or major_subject > 100 ):
                    print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                    major_subject = int( input( '전공 {0:2} 과목중 {1:2} 번째 전공 과목 성적 입력 : '.format( ElectronicStudentInfo.ELECTRONIC_SUBJECT_MAX, x + 1 ) ) )    
                major_subjects.append( major_subject )

            print()
            for x in range( ElectronicStudentInfo.COMMON_SUBJECT_MAX ):
                common_subject = int( input( '공통 {0:2} 과목중 {1:2} 번째 공통 과목 성적 입력 : '.format( ElectronicStudentInfo.COMMON_SUBJECT_MAX, x + 1 ) ) )
                while ( common_subject < 0 or common_subject > 100 ):
                    print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                    common_subject = int( input( '공통 {0:2} 과목중 {1:2} 번째 공통 과목 성적 입력 : '.format( ElectronicStudentInfo.COMMON_SUBJECT_MAX, x + 1 ) ) )

                common_subjects.append( common_subject )

            student = ElectronicStudentInfo( name, department, common_subjects, major_subjects )

        scoreTable.writeStudentInfo( student )
        
        name = input( '\n학생 이름 입력 ( "end" : quit ) : ' )

    print()
    studentInfos = scoreTable.printScoreTable()
    for studentInfo in studentInfos:
        print( studentInfo )
    print( '\ncount student : {0:2}'.format( ScoreTable.count_student ) )

    input( '\nPress any key to program stop...' )

if __name__ == '__main__':
    main() 