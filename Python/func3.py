#func3.py
def func3(wordbook):
  del_word = input("삭제할 단어를 입력하세요.")
  if del_word in wordbook.keys():
    del wordbook[del_word]
    print("단어 {0}가 삭제되었습니다.".format(del_word))
  else:
    print("해당 단어는 사전에 존재하지 않습니다.")
  return wordbook