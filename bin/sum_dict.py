# coding: utf-8 
# encoding=utf-8
"""
    Author      : grey(yangyuzhou)
    lastCtime   : 2018.4.4
    call        : 18813011762    563965323@qq.com
    args        : fileName1  => 切词较大的结果集，一条数据
                                可能包含多个小结果集的数据
                                例：我爱北京天安门 (cut:7)
                  fileName2  => 切词较小的结果集
                                例：我爱北京、爱北京天、
                                    北京天安、京天安门 (cut:4)
    desc        : 汇总两个文件合并重复内容，输出结果
    输出        ：出现次数      \t      出现内容  (未排序)
"""
import os
import re
import sys

_firstFileRange = 50

def summ(lines1, lines2):
    dict  = {}
    count = 0
    for i in range(0,_firstFileRange) :
        if i >= len(lines1):
            break
        oneLine = lines1[i].split("\t")
        dict[oneLine[1]] = oneLine[0]
    for i in range(0,len(lines2)) :
        if count >= 50:
            break
        oneLine = lines2[i].split("\t")
        substringFlag = 0
        for j in dict:
            if j.find(oneLine[1]) >= 0 and int(dict[j]) > int(oneLine[0])/2 :
                substringFlag = 1
                break
        if substringFlag == 1 :
            continue
        else:
            dict[oneLine[1]] = oneLine[0]
            count += 1
    for i in dict :
        print   str(dict[i]) + "\t" + i + "\t"
    
def main(argv):
    global _firstFileRange
    fileName1 = argv[1]
    fileName2 = argv[2]
    _firstFileRange = int(argv[3])
    fp1 = open(fileName1, "r")
    fp2 = open(fileName2, "r")
    try:
        lines1 = fp1.readlines()
        lines2 = fp2.readlines()
    finally:
        fp1.close()
        fp2.close()
        
    summ(lines1,lines2)
        
if __name__ == '__main__':
    main(sys.argv)

    
    
    