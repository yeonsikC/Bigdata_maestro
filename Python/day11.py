f = open('sample.txt', 'w')
for i in range(1, 10):
    s = '{0:2} x {1:2} = {2:2}\n'.format(3, i, 3*i)
    f.write(s)
f.close()
print('\tsample.txt 내용 load')
f = open('sample.txt', 'r')
data = f.read()         #파일 전체 읽기
print(data)
f.close()

print('\tsample.txt 내용 2차 load')
f = open('sample.txt', 'r')
line = f.readline()     #한줄씩 읽기
while line:
    print( line, end = '')
    line = f.readline()
f.close()

print('\tsample.txt 내용 3차 load')
f = open('sample.txt', 'r')
lines = f.readlines()    #파일 내용을 읽어서 리스트로 반환
for line in lines:
    print(line)
f.close()

print('\tsample.txt 내용 4차 load')
f = open('sample.txt', 'r') #파일 객체 자체가 read 기능을 가지고 있음
for line in f:
    print(line, end = '')
f.close()

print('\tsample.txt 내용 5차 load')
with open('sample.txt', 'r') as f: #with문이 끝나면 자동적으로 f.close()가 됨.
    lines = f.readlines()
    for line in lines:
        print(line)