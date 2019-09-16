n = 6
edge = [[3, 6], [4, 3], [3, 2], [1, 3], [1, 2], [2, 4], [5, 2]]
import numpy as np
def solution(n, edge):
    answer = 0
    chk = []
    chks = []
    num = 0
    #1번 노드로부터 가장 멀리?
    #2~n번까지 한번 가보자
    count = np.zeros(n)

    for q in range(2, n+1):
        for i in range(len(edge)):
            point= 0 
            if edge[i][0] == 1:
                if edge[i][1] == q:
                    point += 1
                    chk.append(point)
                    continue
                else:
                    num = edge[i][1]
                    for i in range(len(edge)):
                        point += 1
                        if edge[i][0] == num:
                            if edge[i][1] == q:
                                point += 1
                                chk.append(point)
                                break
        chks.append(min(chks))
        chk = []

    answer = max(count)
                                            
    return answer
solution(n, edge)
