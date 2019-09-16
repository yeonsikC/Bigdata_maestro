'''
문제 : 10명의 학생 이름, 점수를 입력받아, 10명의 학생 이름, 점수를 출력하고
       최고점 학생 정보, 최저점 학생 정보, 평균 점수, 점수대 인원수를 출력
       하는 프로그램( 함수로 구현 )

data : 10명 학생 성적 저장 공간 - students : list

algorithm : 1. 10명 학생 정보을 입력 받는다.
            2. 학생 정보와 최고점 학생 정보, 최저점 학생 정보, 평균 점수, 점수대 인원수를 출력한다.

함수 : inputdata() - 10명 학생 이름, 점수 입력 함수
       calcaverage() - 평균을 계산하는 함수
       calcmaxmin() - 최고점/최저점 학생 정보를 찾는 함수
       calcscoreboard() - 점수대 인원수 계산하는 함수 
       printdata() - 학생 정보를 출력하는 함수
'''
MAX = 3

def inputdata():
    '''
        1. 10번 반복하면서
            1.1 한번 반복할때 마다 학생 정보 입력
    '''
    students = {}
    for i in range( MAX ):
        student = []
        name = input( '\n{0:2}중 {1:2}번 학생 이름 입력 : '.format( MAX, i + 1 ) )
        score = int( input( '{0:2}중 {1:2}번 학생 점수 입력 : '.format( MAX, i + 1 ) ) )
        student.append( name )
        student.append( score)
        students[ i ] = student
 
    return students

def calcaverage( students ):
    '''
        1. 10명의 학생 점수에 대한 총점을 계산한다.
        2. 계산된 총점에 대한 평균을 구한다.
    '''
    total = 0
    keys = list( students.keys() )
    for key in keys:
        total += students[ key ][ 1 ]
    average = total / MAX

    return average

def printstudentdata( students ):
    '''
        1. 10번 반복하면서
            1.1 한번 반복할 때 학생 정보를 출력
    '''
    keys = list( students.keys() )
    
    print( '\n\t학생 정보 list\n')
    for key in keys:
        print( '{0:<20} {1:5}'.format( students[ key ][ 0 ], students[ key ][ 1 ] ) )
    print()

    return

def calcmaxmin( students ):
    '''
        1. 10번 반복하면서
            1.1 한번 반복할 때 최고점/최저점 학생 정보를 구한다.
    '''
    keys = list( students.keys() )
    maxmininfo = { 'max': [ '', 0 ], 'min': [ '', 100 ] }

    for key in keys:
        if maxmininfo[ 'max' ][ 1 ] < students[ key ][ 1 ]:
            maxmininfo[ 'max' ] = students[ key ]
        if maxmininfo[ 'min' ][ 1 ] > students[ key ][ 1 ]:
            maxmininfo[ 'min' ] = students[ key ]

    return maxmininfo

def calcscoreboard( students ):
    '''
        1. 10번 반복하면서
            1.1 한번 반복할 때 점수대 인원수를 누적한다.
    '''
    scoreboard = { k:0 for k in range( 1, 10 ) }
    keys = list( students.keys() )
    for key in keys:
        scoresection = students[ key ][ 1 ] // 10
        scoreboard[ scoresection ] += 1

    return scoreboard

def printdata( students ):
    '''
        1. 10명 학생 정보를 출력한다.
        2. 최고점/최저점을 출력한다.
        3. 평균 점수를 출력한다.
        4. 점수대 인원수를 출력한다.
    '''
    printstudentdata( students )

    maxmininfo = calcmaxmin( students )
    print( '\nmax score student : {0:<20} {1:5}'.format( maxmininfo[ 'max' ][ 0 ], maxmininfo[ 'max' ][ 1 ] ))
    print( 'min score student : {0:<20} {1:5}'.format( maxmininfo[ 'min' ][ 0 ], maxmininfo[ 'min' ][ 1 ] ))

    average = calcaverage( students )
    print( '\naverage score : {0:.2f}\n'.format( average ) )

    scoreboard = calcscoreboard( students )
    keys = scoreboard.keys()
    i = 10
    print( '점수대별 인원수\n')
    for key in keys:
        print( '{0:2}점대 인원수 : {1:2}'.format( i, scoreboard[ key ] ) )
        i += 10

    return

def main():
    students = inputdata()
    printdata( students )

if __name__ == '__main__':
    main()
