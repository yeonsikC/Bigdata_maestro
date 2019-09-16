#dict_main.py
from func1 import *
from func2 import *
from func3 import *
from func4 import *
from func5 import *

'''
    menu_test.py
'''

menu = '''

1. 단어 입력

2. 단어 수정

3. 단어 삭제

4. 단어 검색

5. 단어장 전체 출력

0. 종료

select menu : '''

def main():
    wordbook = {}
    func_dict = { 1:func1, 2:func2, 3:func3, 4:func4, 5:func5 }
    while True:
        print( menu, end = ' ' )
        selectMenu = int( input() )
        if selectMenu == 0:
            break
        elif 2 <= selectMenu <= 5:
            func_dict[ selectMenu ](wordbook)
        elif selectMenu == 1 :
            wordbook = func_dict[ selectMenu ](wordbook)
    return

if __name__ == '__main__':
    main()