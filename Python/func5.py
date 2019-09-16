#func5.py
def func5(wordbook):
  for key, value in wordbook.items():
    print("{0:^10} : {1:5} {2:<10}".format(key,value[1],value[2]))