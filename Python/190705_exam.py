# -*- coding: utf-8 -*-
"""Untitled6.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1v6K4C-vnvyIQ8WiaaH8g5m-R_odlv4bS
"""

#1
def my_join(str1, str2):
  str = str1 + str2
  return str

my_join('aaa','bbb')

#2
def my_split(str, ch):
  split_list = str.split(ch)
  return split_list

my_split('abcde','c')