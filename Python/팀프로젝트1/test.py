from collections import Counter

def readCsv(addr):
    '''
    작성자 : 최연식
    csv파일을 한줄한줄 불러오는데,
    str형태로 불러와지므로 int형과 float형 변환까지 추가로 하였다.
    '''
    with open(addr,"r") as f:
        df=[]
        chk=0
        while True:
            line = f.readline()
            if not line:
                break
            line = line[:len(line)-1]
            a = line.split(',')
            for i in range(len(a)):
                if is_digit(a[i]) == True:
                    if is_float(a[i]) == True:
                        a[i] = float(a[i])
                    else:
                        a[i] = int(a[i])
            df.append(a)
        return df

def is_digit(str):
    '''
    작성자 : 최연식
    숫자인지 판단하는 작업.
    tmp에 float(값)을 넣었을 때,
    오류가 발생하면 문자형으로 인식
    '''
    try:
        tmp = float(str)
        return True
    except ValueError:
        return False

def is_float(str):
    '''
    작성자 : 최연식
    소수인지 판단하는 작업.
    float(값)을 1로 나누었을 때 그 값이 0보다 크게되면 소수로 판단.
    0보다 크지 않거나, 오류 발생시 소수가 아닌것으로 판단.
    '''
    try:
        if float(str)%1 > 0:
            return True
        else:
            return False
    except ValueError:
        return False

def printDf(df):
    '''
    작성자 : 최연식
    전체 데이터를 출력.
    '''
    for i in range(len(df)):
        print(df[i])

def printStr(df):
    '''
    작성자 : 최연식
    각 변수별 데이터 타입을 출력한다.
    '''
    chk = 0
    for i in range(1,len(df)):
        for j in range(len(df[0])):
            if df[i][j] == "NA":
                break
            chk += 1
        if chk==len(df[0]):
            for j in range(len(df[0])):
                type_var = type(df[i][j])
                print("{0:<10} 변수의 데이터 타입 : ".format(df[0][j] ), end='')
                print(type_var)

def printDim(df):
    '''
    작성자 : 최연식
    데이터셋의 변수의 수와, 데이터의 수를 출력한다.
    '''
    print('변수의 수 : {0}'.format(len(df[0])))
    print('데이터 수 : {0}'.format((len(df)-1)))

def varList(df):
    '''
    작성자 : 최연식
    변수명을 리턴
    '''
    df = df
    varList = df[0]
    return varList

def printHead(df, length=20):
    '''
    작성자 : 최연식
    전체 데이터셋에서, 원하는 수만큼 앞에서부터 데이터를 가져온다.
    매개변수를 입력하지 않을시, 20개를 가져온다.
    하지만, 데이터 수가 20개보다 적을 수 있으므로,
    그에 대비하여 20개보다 적을 시 그 데이터 개수만큼 출력한다.
    '''
    if len(df) < 20:
        if length == 20:
            for i in range(len(df)):
                print(df[i])
        else:
            for i in range(length+1):
                print(df[i])
    else:        
        for i in range(length+1):
            print(df[i])

def printTail(df, length=20):
    '''
    작성자 : 최연식
    전체 데이터셋에서, 원하는 수만큼 뒤에서부터 데이터를 가져온다.
    매개변수를 입력하지 않을시, 20개를 가져온다.
    하지만, 데이터 수가 20개보다 적을 수 있으므로,
    그에 대비하여 20개보다 적을 시 그 데이터 개수만큼 출력한다.
    '''
    print(varList(df))
    if len(df) < 20:
        if length == 20:
            for i in range(1, len(df)):
                print(df[i])
        else:
            for i in range(len(df),len(df)-length,-1):
                print(df[i-1])
    else:
        for i in range(len(df),len(df)-length,-1):
            print(df[i-1])

def group_by(df):
    '''
    작성자 : 최연식
    그룹별 목적 변수에 대한 합계 또는 평균을 구하는 함수.
    첫 번째로, 그룹화할 변수를 선택.
    두 번째로, 목적 변수를 선택.
    세 번째로, 합계를 구할지 평균을 구할지 선택.
    '''
    group = ''
    purpose = ''
    chk1 = ''
    chk2 = ''
    g_name = []
    g_val = []
    mean_val = []
    total_mean = []
    total_sum = []
    val_chk = []
    print(varList(df))
    group = input("그룹화하고 싶은 변수를 선택하세요.")
    purpose = input("목적변수를 선택하세요.")
    sum_or_mean = int(input("1. 합계 구하기\n2. 평균 구하기\n(숫자만 입력하시오."))
    for i in range(len(df[0])):
        if df[0][i] == group:
            chk1 = i
            break
    for i in range(len(df[0])):
        if df[0][i] == purpose:
            chk2 = i
            break
    
    g_name.append(df[1][chk1])
    g_val.append(df[1][chk2])
    val_chk.append(1)
    for i in range(2, len(df)):
        for j in range(len(g_name)):
            chk = 0
            if g_name[j] == df[i][chk1]:
                g_val[j] += df[i][chk2]
                val_chk[j] += 1
                chk += 1
                break

        if chk == 0:
            g_name.append(df[i][chk1])
            g_val.append(df[i][chk2])
            val_chk.append(1)
    for i in range(len(val_chk)):
        mean_val.append(g_val[i]/val_chk[i])
        total_mean.append([g_name[i], mean_val[i]])
        total_sum.append([g_name[i], g_val[i]])

    if sum_or_mean == 1:
        return total_sum
    else:
        return total_mean

def barplot(df):
    '''
    작성자 : 최연식
    기준 그룹에 따른 목적변수 값을 평균 또는 합계를 통하여 막대그래프를 생성.
    '''
    total = []
    x = []
    y = []
    y_star = []
    total = []
    a = group_by(df)
    for i in range(len(a)):
        x.append(a[i][0])
        y.append(round(a[i][1]))
        y_star.append('*'*y[i])
        total.append([x[i],y[i],y_star[i]])
    
    total.insert(0,["그룹변수", "y값", "그래프길이"])

    choice = int(input("값에 따른 정렬을 하시겠습니까?(숫자입력)\n1. 예.\n2. 아니오."))
    if choice == 1:
        print("그룹변수, y값, 그래프길이")
        total = sort_1(total)
    print()

    print("1")
    print("|************** 11 그룹변수1")
    print("|************ 9 그룹변수2")
    print("|********* 7 그룹변수3")

    print("2")
    print("그룹변수1  11 |**************")
    print("그룹변수2  9  |************")
    print("그룹변수3  7  |***********")

    choice = int(input("원하는 출력형태를 고르시오.(숫자만 입력)\n(1 or 2)"))
    print('barplot'.center(40, '='))
    if choice == 1:
        for i in range(len(x)):
            print('|{0:<30} {1:<4} {2:<}'.format(total[i][2],total[i][1],total[i][0]))
    else:
        for i in range(len(x)):
            print('{0:<15} {1:<4} |{2:<}'.format(total[i][0],total[i][1],total[i][2]))
    print()

def text_mining():
    '''
    작성자 : 최연식
    입력받은 텍스트로부터 각 단어별 빈도분석을 한다.
    '''
    text = input("텍스트마이닝을 수행할 문장을 입력하시오.").lower().split()
    result = Counter(text)
    print(result)

def NaCh(df):
    '''
    작성자 : 김도윤
    결측치 확인 후 대체하거나 삭제하는 작업.
    '''
    dflist = []
    nalist = []
    isnach = int(input("결측치 확인 작업을 실행하겠습니까? 원한다면 '실행'을 입력하세요.: \n 1. 실행  2. 아니오"))
    if isnach == 1:  
        for i, v in enumerate(df): 
            chk = 0
            for a in range(len(v)):
                if df[i][a] == 'NA':
                    chk = 1
                    break
            if chk == 0:
                dflist.append(v)       
            else:
                nalist.append(v)
    else:
        pass
    print("결측치를 제외한 리스트 : {}".format(dflist))
    print("결측치가 포함된 리스트 : {}".format(nalist))

    newlist = []

    user = int(input("결측치를 0으로 전환하겠습니까? 아니면 삭제하겠습니까? 아니면 ('1 : 삭제' or '2 : 전환'): "))
    if user == 2:          
        for i, v in enumerate(nalist):
            for a, b in enumerate(v):
                if nalist[i][a] == 'na':
                    nalist[i][a] = 0 
                    newlist.append(v)
                    b == b[-1]
                    break
                    a = a + 1
    else:                
        del nalist
    return dflist

def rename(df):
    '''
    작성자 : 이경수
    data frame의 변수 이름을 변경하는 기능을 제공한다.
    '''

    print(df[0])
    k = input("번수명을 입력:")
    chk = 0
    for i in range(len(df[0])):
        if df[0][i] == k:
            chk = i
            break

    if k in df[0] :
        c = input("새로 바꿔줄 단어를 입력하세요 : ")
        df[0][chk] = c
    else:
        print("해당 변수명은 존재하지 않습니다.")
    return df

def m_var(df):
    '''
    작성자 : 이경수
    파생변수 추가 (연산자 & slicing)
    '''
    a = str(input('추가할 단어를 입력하세요:'))
    df[0].append(str(a))
    for i in range(1,len(df)):
        #df[i].append(df[i][1]-df[i][2])#연산자
        b = str(df[i][1]) # 연도에서 월만 추가하기 (str형태)
        b.split() #아무것도 없으면 list형태로 반환
        x = b[0:4]
        df[i].append(x)
    return df 

def n_var(df):
    '''
    작성자 : 이경수
    data frame에서 필요한 변수를 추출하는 기능을 제공한다.(select)
    '''
    b = []
    print(df[0])
    a = input('찾을 변수명을 입력하세요 : ')
    if a in df[0]:
        for i in range(len(df)):
            b.append(df[i][df[0].index(a)])
    return b

def filter(df):
    '''
    작성자 : 이경수
    data frame에서 조건에 따른 data를 추출하는 기능을 제공한다.(filter)
    결측치 없애고 해야
    '''
    y = []
    k = []
    chk = 0
    a = input("필터걸고싶은 변수를 선택하세요.")
    for i in range(len(df[0])):
        if df[0][i] == a:
            chk = i
            b = int(input("원하는 조건을 선택하세요. (번호 입력) \n1.원하는 문자만 추출.\n2.특정 값 이상 추출.\n3.특정 값 미만 추출\n"))
            if b == 1:
                c = input("원하는 문자를 입력하시오 : ")
                for t in range(len(df)):
                    if c == df[t][chk]:
                        k.append(df[t][:])

                                       
               
            if b == 2:
                c = int(input("몇 이상을 추출하시겠습니까? : "))
                k.append(df[0])
                for t in range(1,len(df)):
                    if df[t][chk] >= c:
                        k.append(df[t][:])
               

            
            if b == 3:
                c = int(input("몇 미만을 추출하시겠습니까? : "))
                k.append(df[0])
                for t in range(1,len(df)):
                    if df[t][chk] < c:
                        k.append(df[t][:])
    return k
                
def sort_1(df):
    '''
    작성자 : 이경수
    data frame의 data를 정렬하는 기능을 제공한다.( 오름/내림차순 기능 별도 제공 )
    #결측치 없애고 해야
    '''
    e = []
    d = []
    c = str(input('정렬 할 변수명을 입력하세요 : '))  
    if c in df[0]:
        for i in range(1,len(df)):
            b = df[i][:]
            d.append(b)
            i += 1
    a = int(input("오름/내림차순 기능을 선택하시오 (오름:1 /내림: 2)  : "))
    if a == 1:
        k = sorted(d, key=lambda d: d[df[0].index(c)])
        return k
        
    if a == 2:
        k = sorted(d, key=lambda d: d[df[0].index(c)],reverse=True)
        return k
            



def roll_back(data):
    '''
    작성자 : 최연식
    사용자가 원할시, 기존 데이터를 다시 불러옴.
    '''
    df = data
    return df

def outlier_chk(df):
    chk = 0
    sum = 0
    data = []
    data.append(df[0])
    print(df[0])
    print("이상치 작업으로 ", end='')
    sort_df = sort_1(df)
    a = sort_df[0]
    q1_idx = round(len(sort_df) * 1/4)
    q2_idx = round(len(sort_df) * 1/2)
    q3_idx = round(len(sort_df) * 3/4)
    want = input("원하는 변수를 입력하세요.")
    for i in range(len(df[0])):
        if want == df[0][i]:
            chk=i
            break

    q1 = sort_df[q1_idx][chk]
    q2 = sort_df[q2_idx][chk]
    q3 = sort_df[q3_idx][chk]

    iqr = q3 - q1 
    upper_iqr = q3 + iqr*1.5
    lower_iqr = q1 - iqr*1.5
    if lower_iqr < 0:
        lower_iqr = 0
    user = int(input('확인하고 싶은 이상치의 방법을 선택하시오 : \n1. 이상치확인 \n2. 이상치제거 \n3. 이상치대체 '))

    for i in range(len(df[0])):
        if user==1: #이상치확인 
            for i in range(len(df[0])):
                if df[0][i] == a[0]:
                    chk = i
                    break

            for i in range(1,len(df)):               # 전체에 관한 데이터를 불러와서 쓰기
                if df[i][chk] < upper_iqr and df[i][chk] > lower_iqr:
                    data.append(df[i])#행전체 담기 

                    

        elif user == 2:   # 이상치 제거 
            for i in range(len(df[0])):
                if df[0][i] == a[0]:
                    chk = i #조건확인을 위해 체크(불러오는 열을 확인 #리스트값을 확인하는 것
                    break

            for i in range(1,len(df)):                                      # 전체에 관한 데이터를 불러와서 쓰기
                if df[i][chk] < upper_iqr and df[i][chk] > lower_iqr:
                    data.append(df[i])                                      # 행전체 담기 
    
        elif user == 3:  #이상치 대체   _ 이상치를 제거하고 만약 이상치가 발생했을 때 평균값으로 대체한다. 
            for i in range(1,len(df)): # data의 평균을 구하기 _ (이상치 대체에 use)
                sum += a[i]
                data_avg = (sum/len(df))
            for i in range(len(df[0])):
                if df[0][i] == a[0]:
                    chk = i
                    break
            for i in range(1,len(df)): 
                if (df[i][chk] >= upper_iqr) or (df[i][chk] <= lower_iqr):
                    df[i][chk] = data_avg
            data = df
    return data

def main():
    menu = '''
    1. 데이터 출력
    ---(1) 데이터 전체 출력
    ---(2) 데이터 일부 출력
    -------(1) 데이터 앞부분 출력
    -------(2) 데이터 뒷부분 출력
    -------(3) 특정 변수 출력
    ---(3) 변수명 출력
    ---(4) 데이터 변수개수와 데이터 개수 출력
    ---(5) 변수 타입 출력
    2. 결측치 / 이상치 처리
    ---(1) 결측치 처리
    ---(2) 이상치 처리
    3. 변수 변환
    ---(1) 파생변수 생성
    ---(2) 변수명 변경
    4. 데이터 정렬
    5. 데이터 분석(그룹별 분석)
    6. 막대그래프(그룹별 그래프)
    7. 텍스트 마이닝
    8. 원데이터 불러오기
    0. 종료.
    '''
    menu1 = '''
    ---(1) 데이터 전체 출력
    ---(2) 데이터 일부 출력
    -------(1) 데이터 앞부분 출력
    -------(2) 데이터 뒷부분 출력
    -------(3) 특정 변수 출력
    ---(3) 변수명 출력
    ---(4) 데이터 변수개수와 데이터 개수 출력
    ---(5) 변수 타입 출력
    ---(0) 처음으로
    '''
    menu12 = '''
    -------(1) 데이터 앞부분 출력
    -------(2) 데이터 뒷부분 출력
    -------(3) 특정 변수 출력
    -------(0) 처음으로
    '''
    menu2 = '''
    ---(1) 결측치 처리
    ---(2) 이상치 처리
    ---(0) 처음으로
    '''
    menu3 = '''
    ---(1) 파생변수 생성
    ---(2) 변수명 변경
    ---(0) 처음으로
    '''
    
    while True:
        df=[]
        while len(df) == 0:
            addr = input("다음과 같은 형태로. 불러올 데이터를 입력하시오.\nC:\workspace\Python\dust_weather.csv >>>")
            data = readCsv(addr)
            df = data
        while True:
            df = df
            choice = int(input(menu))
            if choice == 1:
                choice1 = int(input(menu1))
                if choice1 == 1:
                    printDf(df)
                    back = input("아무키나 누르시오.")
                    if len(back) > 0:
                        continue

                elif choice1 == 2:
                    choice12 = int(input(menu12))
                    if choice12 == 1:
                        length = int(input("출력할 데이터 수를 입력하시오."))
                        printHead(df, length)
                        back = input("아무키나 누르시오.")
                        if len(back) > 0:
                            continue
                    elif choice12 == 2:
                        length = int(input("출력할 데이터 수를 입력하시오."))
                        printTail(df, length)
                        back = input("아무키나 누르시오.")
                        if len(back) > 0:
                            continue
                    elif choice12 == 3:
                        a = n_var(df)
                        for i in range(len(df)):
                            print(a[i])
                        back = input("아무키나 누르시오.")
                    if len(back) > 0:
                        continue

                    else:
                        continue
                elif choice1 == 3:
                    print(varList(df))
                    back = input("아무키나 누르시오.")
                    if len(back) > 0:
                        continue
                elif choice1 == 4:
                    printDim(df)
                    back = input("아무키나 누르시오.")
                    if len(back) > 0:
                        continue
                elif choice1 == 5:
                    printStr(df)
                    back = input("아무키나 누르시오.")
                    if len(back) > 0:
                        continue
                else:
                    continue
            elif choice == 2:
                choice2 = int(input(menu2))
                if choice2 == 1:
                    df = NaCh(df)
                elif choice2 == 2:
                    df = outlier_chk(df)
                else:
                    continue
            
            elif choice == 3:
                question = int(input(("결측치를 제거하지 않았다면 제거하고 다시 시행하여 주세요.(숫자입력)\n1. 제거   2. 무시")))
                if question == 1:
                    df = NaCh(df)
                choice3 = int(input(menu3))
                if choice3 == 1:
                    df = m_var(df)
                elif choice3 == 2:
                    df = rename(df)
                else:
                    continue
            
            elif choice == 4:
                question = int(input(("결측치를 제거하지 않았다면 제거하고 다시 시행하여 주세요.(숫자입력)\n1. 제거   2. 무시")))
                if question == 1:
                    df = NaCh(df)
                df = sort_1(df)

            elif choice == 5:
                question = int(input(("결측치를 제거하지 않았다면 제거하고 다시 시행하여 주세요.(숫자입력)\n1. 제거   2. 무시")))
                if question == 1:
                    df = NaCh(df)
                print(group_by(df))
                back = input("아무키나 누르시오.")
                if len(back) > 0:
                    continue
            
            elif choice == 6:
                question = int(input(("결측치를 제거하지 않았다면 제거하고 다시 시행하여 주세요.(숫자입력)\n1. 제거   2. 무시")))
                if question == 1:
                    df = NaCh(df)
                barplot(df)
                back = input("아무키나 누르시오.")
                if len(back) > 0:
                    continue

            elif choice == 7:
                text_mining()
                back = input("아무키나 누르시오.")
                if len(back) > 0:
                    continue

            elif choice == 8:
                df = roll_back(data)
                print("원 데이터를 불러왔습니다.\n결측치 작업을 다시 해야될 수 있습니다.")
                back = input("아무키나 누르시오.")
                if len(back) > 0:
                    continue
            else:
                break










if __name__ == '__main__':
    main()