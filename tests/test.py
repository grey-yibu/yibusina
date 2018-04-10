# coding: utf-8 
# encoding=utf-8
"""
    Author      : grey(yangyuzhou)
    lastCtime   : 2018.4.4
    call        : 18813011762    563965323@qq.com
    args        : fileName1  => 切词较大的结果集，一条数据
    desc        : 汇总两个文件合并重复内容，输出结果
    输出        ：出现次数      \t      出现内容  (未排序)
"""
import os
import sys
import random
        
def main(argv):
    fileName  = argv[1]
    randCount = int(argv[2] )
    fp = open(fileName, "r")
    
    try:
        lines = fp.readlines()
        randSed = range(len(lines))
        randArray = random.sample(randSed,randCount)
        for i in randArray:
            print lines[i],
    finally:
        fp.close()
        
if __name__ == '__main__':
    main(sys.argv)

    
    
    