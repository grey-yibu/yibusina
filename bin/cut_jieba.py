# coding: utf-8 
# encoding=utf-8
"""
    Author      : grey(yangyuzhou)
    lastCtime   : 2018.4.4
    call        : 18813011762    563965323@qq.com
    args        : fileName  => 数据文件
    desc        : 语义处理，分为：
                    1.符号过滤
                    2.动词过滤(长度<=4,含动词)
                    3.首尾词性过滤(长度<=4,首:{o,m,uj,c,t,d},尾:{ul,m,d,})
    输出        ：出现次数      \t      出现内容  (未排序)
"""
import os
import sys
import jieba.posseg as pseg

reload(sys)
sys.setdefaultencoding('utf-8')

# 语义处理，分为：
# 1.符号过滤
# 2.动词过滤(长度<=4,含动词)
# 3.首尾词性过滤(长度<=4,首:{o,m,uj,c,t,d},尾:{ul,m,d,})
def cut_jieba(lines):
    for i in lines:
        i = unicode(i,"utf-8")
        i = i.split("\t")
        words = list( pseg.cut(i[1]) )
        ifCorrect  = 1
        errorFlag  = 0
        startEncorrectSet = ["o","m","uj","c","t","d","ul","p","q","f"]
        endEncorrectSet = ["ul","m","d"]
        a1,a2 = words[0]
        b1,b2 = words[len(words)-1]
        if len(i[1]) <= 4 and (a2 in startEncorrectSet or b2 in endEncorrectSet):
            ifCorrect  = 0
        for word, flag in words:
            if flag == "x" or ifCorrect == 0:
                ifCorrect  = 0
                errorFlag  = 1
                break
            if len(i[1]) <= 4 and flag == "v":
                ifCorrect  = 0
                errorFlag  = 2
                break
        # if ifCorrect == 0:
            # print i[0],i[1]
            # for word, flag in words:
                # print word,flag,
            # print errorFlag,len(i[1]),"\t"
        if ifCorrect == 1:
            print i[0],i[1]
            # for word, flag in words:
                # print word,flag,
            # print "\t"
        
def main(argv):
    fileName = argv[1]
    fp = open(fileName, "r")
    try:
        lines = fp.readlines()
        cut_jieba(lines)
    finally:
        fp.close()
        
if __name__ == '__main__':
    main(sys.argv)

    
    
    