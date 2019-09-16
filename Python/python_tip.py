#키 값과 value값 모두 가져옴
l = ['banana', 'apple', 'mango']
for i, v in enumerate( l ):
  print('[{0}] : {1}'.format(i, v))
  
#인덱스를 키로 한 dict 생성
#split을 통해, 문자열을 하나하나 단어로 만들고, enumerate를 통해 인덱스번호 부여 후 dict 형태로 변환.
d = {i:j for i,j in enumerate('hello World apple banana mango victory'.split())}
print(d)

#list일 때 많이 씀.
#별렬로 묶어줄 때 사용. 같은 인덱스에 해당하는 병렬의 리스트의 항목을 묶어줌.
#데이터 개수가 다르다면, 중복되는 곳 까지.
l1 = ['a1', 'a2', 'a3']
l2 = ['b1', 'b2', 'b3']
for a, b in zip(l1, l2):
	print('l1: {0}\tl2 : {1}'.format(a, b))
	
#각 인덱스별로 좌측 변수에 넣어줌.
a, b, c = zip((1,2,3), (10, 20, 30), (100, 200, 300))
print('{0}\t{1}\t{2}'.format(a, b, c))

#각 인덱스별 합계를 리스트형태로 변수에 넣어줌.
l = [sum(x) for x in zip((1,2,3), (10,20,30), (100,200,300))
print(l),

#인덱스는 i에, 값들은 a,b에 각각 넣어줌.
for i, (a,b) in enumerate(zip(l1, l2)):
	print( '[{0}] : {1} - {2}'.format(i, a, b))
	
#난수생성
import random
print( random.random())
print( round(random.random() * 1 ) + 5)

#괄호안에 정해준 값의 범위
data1 = random.randint(1,6)
data2 = random.randint(1,6)
print(data1,"\t",data2)

#1부터 10까지 2씩 증가
#0부터 99까지 10씩 증가
data1 = random.randrange(1,10,2)
data2 = random.randrange(0,100,10)
print('임의의 두 수 : {0} - {1}'.format(data1, data2))

#choice 함수 이용, 시퀀스 자료형에서 랜덤추출.
menu = ['김치찌개', '된장찌개', '보쌈', '순두부찌개', '제육덮밥']
print( '오늘의 점심은 -> {0}'.format(random.choice(menu)))

#앞의 인수중에서, 뒤의 인수만큼 추출.
print(random.sample([1, 2, 3, 4, 5], 2))

#_를 사용하는 것은, 내가 반복문을 사용하는데 그 인자값을 사용하지 않을 때 사용.
for i in range(10):
  print('Hello, World!!!')
print()
for _ in range(10):
  print('Hello, World!!!')
  
# __repr__(self)는 꼭 정의해줘야 좋음

# 실수형은 등가비교 불가. ex) 1.0 == 1.0  (x)