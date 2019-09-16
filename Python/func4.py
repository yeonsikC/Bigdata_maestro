#func4.py
def func4(wordbook):
  search_word = input("검색할 단어를 입력하세요.")
  if search_word in wordbook.keys():
    search = wordbook.get(search_word)
    print(" 단어 : {0:<5} \n 품사 : {1} \n 뜻   : {2}".format(search[0], search[1], search[2]))
  else:
    print("해당 단어는 사전에 존재하지 않습니다.")    
  return wordbook