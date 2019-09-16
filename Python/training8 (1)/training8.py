'''
    training8.py

    Python 8일차 실습

    1. 다음과 같이 출력하는 프로그램을 class를 작성하여 완성하세요.
   ( 10명이내 이름이 'end'이면 결과 출력, 90이상 Excellent 60이하 Fail )

    Hong 50 50 50 150 50.0 Fail
    Kim  90 90 90 270 90.0 Excellent
    Nam  70 70 70 210 70.0
'''
import Student

def main():
    question_str = '''
    4. 다음과 같이 출력하는 프로그램을 class를 작성하여 완성하세요.
    ( 10명이내 이름이 'end'이면 결과 출력, 90이상 Excellent 60이하 Fail )

        Hong 50 50 50 150 50.0 Fail
        Kim  90 90 90 270 90.0 Excellent
        Nam  70 70 70 210 70.0
    '''
    print( ''.center( 80, '=' ) )
    print( question_str )
    print( ''.center( 80, '=' ) )
    print()

    MAX = 10
    SUBJECT_MAX = 3

    students = []
    count = 0

    name = input( '학생 이름 입력 ( "end" : quit ) : ' )
    while name != 'end' and count < MAX:
        count = count + 1
        subjects = []

        for x in range( SUBJECT_MAX ):
            subject = int( input( '{0:2} 과목중 {1:2} 번째 과목 성적 입력 : '.format( SUBJECT_MAX, x + 1 ) ) )
            while ( subject < 0 or subject > 100 ):
                print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                subject = int( input( '{0:2} 과목중 {1:2} 번째 과목 성적 입력 : '.format( SUBJECT_MAX, x + 1 ) ) )

            subjects.append( subject )

        student = Student.Student( name, subjects[ 0 ], subjects[ 1 ], subjects[ 2 ] )
        students.append( student )
        
        name = input( '\n학생 이름 입력 ( "end" : quit ) : ' )

    print()
    for v in students:
        student = v.readStudentInfo()

        print( '{0:<10}'.format( student[ 0 ] ), end = '' )
        print( '{0:3} {1:3} {2:3}'.format( student[ 1 ], student[ 2 ], student[ 3 ] ), end = '' )
        print( '{0:5} {1:6.2f} {2:<10}'.format( student[ 4 ], student[ 5 ], student[ 6 ] ) )

    input( '\nPress any key to program stop...' )

def main_classvar():
    question_str = '''
    4. 다음과 같이 출력하는 프로그램을 class를 작성하여 완성하세요.
    ( 10명이내 이름이 'end'이면 결과 출력, 90이상 Excellent 60이하 Fail )

        Hong 50 50 50 150 50.0 Fail
        Kim  90 90 90 270 90.0 Excellent
        Nam  70 70 70 210 70.0
    '''
    print( ''.center( 80, '=' ) )
    print( question_str )
    print( ''.center( 80, '=' ) )
    print()

    MAX = 10

    students = []
    count = 0

    name = input( '학생 이름 입력 ( "end" : quit ) : ' )
    while name != 'end' and count < MAX:
        count = count + 1
        subjects = []

        for x in range( Student.StudentInfo.SUBJECT_MAX ):
            subject = int( input( '{0:2} 과목중 {1:2} 번째 과목 성적 입력 : '.format( Student.StudentInfo.SUBJECT_MAX, x + 1 ) ) )
            while ( subject < 0 or subject > 100 ):
                print( '\nError : 점수는 0 ~ 100 입니다...\n다시 입력 하십시요...\n' )
                subject = int( input( '{0:2} 과목중 {1:2} 번째 과목 성적 입력 : '.format( Student.StudentInfo.SUBJECT_MAX, x + 1 ) ) )

            subjects.append( subject )

        student = Student.StudentInfo( name, subjects[ 0 ], subjects[ 1 ], subjects[ 2 ] )
        students.append( student )
        
        name = input( '\n학생 이름 입력 ( "end" : quit ) : ' )

    print()
    for v in students:
        student = v.readStudentInfo()

        print( '{0:<10}'.format( student[ 0 ] ), end = '' )
        print( '{0:3} {1:3} {2:3}'.format( student[ 1 ], student[ 2 ], student[ 3 ] ), end = '' )
        print( '{0:5} {1:6.2f} {2:<10}'.format( student[ 4 ], student[ 5 ], student[ 6 ] ) )
    print( '\nCreate Object count : {0:2}'.format( Student.StudentInfo.obj_count ) )

    input( '\nPress any key to program stop...' )

if __name__ == '__main__':
    main()
    main_classvar()
