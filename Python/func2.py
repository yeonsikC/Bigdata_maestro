#func2.py
def func2(wordbook):
  modify_word = input("수정할 단어를 입력하세요.")
  if modify_word in wordbook.keys():
    modify = wordbook.get(modify_word)
    print(" 단어 : {0:<5} \n 품사 : {1} \n 뜻   : {2}".format(modify[0], modify[1], modify[2]))
    class_name = input("품사를 수정하시오.")
    meaning = input("뜻을 수정하시오.")
    wordbook[modify_word] = modify_word, class_name, meaning
  else:
    print("해당 단어는 사전에 존재하지 않습니다.")    
  return wordbook