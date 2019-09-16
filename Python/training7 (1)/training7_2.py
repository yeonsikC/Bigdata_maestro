'''
문제 : 단어장 관리 프로그램 다음 메뉴를 이용하여 동작하는 프로그램

	1. 단어 입력
	2. 단어 수정
	3. 단어 삭제
	4. 단어 검색
	5. 단어장 전체 출력
	0. 종료
	select menu ...

data : 단어장 - wordbook : dict

algorithm : 1. 메뉴를 선택할 때 까지 반복한다.
                1.1 선택한 메뉴에 대한 함수를 호출한다.

함수 : inputword() - 단어 입력 함수
       modifyword() - 단어 수정 함수
       deleteword() - 단어 삭제 함수
       searchword() - 단어 검색 함수 
       printwordbook() - 단어장 전체 출력 함수
'''
from wordlib_input import inputword
from wordlib_modify import modifyword
from wordlib_delete import deleteword
from wordlib_search import searchword
from wordlib_print import printwordbook

menu = '''
>>> 단어장 <<<

1. 단어 입력
2. 단어 수정
3. 단어 삭제
4. 단어 검색
5. 단어장 전체 출력
0. 종료
select menu : '''


def main():
    '''
        1. 종료 메뉴를 선택하기 전까지 무한 반복한다.
            1.1 선택한 메뉴의 함수를 호출한다.
    '''
    wordbook = {}

    func_dict = { 1:inputword, 2:modifyword, 3:deleteword, 4:searchword, 5:printwordbook }
    while True:
        print( menu, end = ' ' )
        selectMenu = int( input() )

        if selectMenu == 0:
            break
        elif 1 <= selectMenu <= 5:
            func_dict[ selectMenu ]( wordbook )

    return

if __name__ == '__main__':
    main()
