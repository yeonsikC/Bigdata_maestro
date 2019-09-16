# -*- coding: utf-8 -*-
"""day7_exam.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1BvYcuTQx1quqQJFfFt9xzcx3ZCNS8iYA
"""

#1
def exam():
  
  name=[]
  score=[]
  
  for i in range(1, 11):
    info = input("{0:>2}/10, 학생이름 점수를 띄어쓰기로 구분하여 입력하시오.".format(i))
    info_split = info.split(' ')
    name.append(info_split[0])
    score.append(int(info_split[1]))
  
  print()
  
  for i in range(10):
    print("이름 : {0:<5}   성적 : {1:<3}".format(name[i],score[i]))
  print()
  
  max_score = score[0]
  min_score = score[0]
  for i in range(1,10):
    if max_score < score[i]:
      max_score = score[i]
    if min_score > score[i]:
      min_score = score[i]

  max_name = []
  min_name = []
  for i in range(10):
    if score[i] == max_score:
      max_name.append(name[i])
    if score[i] == min_score:
      min_name.append(name[i])
      
  avg = 0
  sum = 0
  for i in range(10):
    sum += score[i]
  avg = sum/10
  
  grade = []
  for i in range(10):
    for j in range(90, -1, -10):
      if score[i] >= j:
        grade.append(j)
        break
  
  
  
  print("최고점 학생 정보 : {0} {1:<3}점 \n".format(max_name, max_score))
  print("최저점 학생 정보 : {0} {1:<3}점 \n".format(min_name, min_score))
  print("평균점수 : {0}점 \n".format(avg))
  for i in range(90, -1, -10):
    print("{0:>2}점대 : {1}명".format(i, grade.count(i)))

if __name__ == '__main__':
  exam()