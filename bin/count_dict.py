# coding: utf-8 
# encoding=utf-8
"""
    Author      : grey(yangyuzhou)
    lastCtime   : 2018.4.10
    call        : 18813011762    563965323@qq.com
    args        : CUT_LENGTH => 切词后每个词的长度
                  _fileName  => 需要被切词的文件 默认值(0.txt)
    desc        : 按照切词长度对文件进行深度遍历切词，结果保存至dict
                  过程：
                      1.从文件中读出每一行存到lines组里
                      2.对lines的每一行数据，进行长度为CUT_LENGTH的
                        滑动窗口。对于每一次滑动，要求保证第一个字符
                        和最后一个字符非空
                      3.结果进行字典计数，并输出
                  叠词处理:
                      在深度遍历时，对于叠词会出现过度统计(叠加统计)
                      因此设计一个算法尽可能还原叠词真实次数
                        得分(预计实际次数)=1/叠词层数 -1
                      将得分累加即为所求(总叠词真实次数)
"""
import os
import re
import sys

reload(sys)
sys.setdefaultencoding('utf-8')

_fileName = "0.txt"
dict = {}
CUT_LENGTH = 5

def dictory(lines):
    for i in lines:
        i = unicode(i,"utf-8")
        for j in range(0,len(i),1):
            if i[j].isspace() or i[j] == "#":                   # 去掉开头有空格的
                continue
            if j + CUT_LENGTH < len(i):
                score = 1
                words = i[j:j+CUT_LENGTH]
                spaceFlag = 0
                for k in words :                                # 去掉结尾有空格的
                    if k.isspace() or k == "#": 
                        spaceFlag = 1
                        break
                if spaceFlag :
                    continue
                if words.count(i[j]) == CUT_LENGTH:      # 叠词处理,得分=1/叠词层数 -1
                    score = score / (float)(CUT_LENGTH - 1)
                if dict.has_key(words):
                    dict[words] += score
                else:
                    dict[words] = score
        
def show_dic():
    for i in dict:
        print   str(int(dict[i])) + "\t" + i + "\t"

def main(argv):
    global CUT_LENGTH
    global _fileName
    if len(argv) == 2 :
        CUT_LENGTH = int(argv[1])
    elif len(argv) >= 3 :
        CUT_LENGTH = int(argv[1])
        _fileName  = argv[2]
    fp = open(_fileName, "r")
    try:
        lines = fp.readlines()

        dictory(lines)
        show_dic()
    finally:
        fp.close()
        
if __name__ == '__main__':
    main(sys.argv)

    
    
    