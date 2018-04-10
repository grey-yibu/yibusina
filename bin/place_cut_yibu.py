# coding: utf-8 
# encoding=utf-8
'''
    Author      : grey(yangyuzhou)
    lastCtime   : 2018.4.10
    call        : 18813011762    563965323@qq.com
    args        : deal => 选择执行到第m项过滤(1~8)
                  log  => 用日志记录第n项过滤选中的结果
                  sourceFilePath => 切词源文件路径
    desc        : 使用n次正则，对原始数据进行过滤
                  通过两个参数，可以控制和观察过滤后，
                  以及被正则选择的结果都是什么
'''
import os
import re
import sys

reload(sys)
sys.setdefaultencoding('utf-8')

def regularFunc(lines, i, state, iflog):
    a1 = re.compile('')
    if state == 1:
        a1 = re.compile('\[.*?\]' )              # 去除  '[二哈][喵喵]' 这种
                                                 # 正则 : '[' 匹配 ']'
    elif state == 2:
        a1 = re.compile('\#.*?\#' )              # 去除  '#七夕我们在一起#'  这种
                                                 # 正则 : '#' 加第一次出现 '#'
    elif state == 3:
        a1 = re.compile('\@.*?\ ' )              # 去除  '@A王三猫 '  这种
                                                 # 正则 : '@' 加第一次出现 ' '
    elif state == 4:
        a1 = re.compile('[a-zA-z]+://[^\s]*' )   # 去除  'http://t.cn/z8A4ypF '  这种
                                                 # 正则 : 'http' 加第一次出现 ' '
    elif state == 5:
        a1 = re.compile(u'[\U00010000-\U0010ffff]')
                                                 # 去除  emoji 表情符号 这种
    elif state == 6:
        a1 = re.compile(u'[分享图片]|[分享视频]') # 去除  分享视频
    elif state == 7:
        a1 = re.compile(u'[\，\。\《\》]')       # 去除  分享视频
        lines[i] = a1.sub(' ',lines[i])
    try:
        lines[i] = unicode(lines[i],"utf-8")
    except TypeError as e:
        pass
    if iflog == 1:
        fpLog = open('log_fenci.txt','a')
        strMatch = a1.findall(lines[i])
        strMatch_tmp = "\n".join(strMatch)
        fpLog.write(strMatch_tmp)
        fpLog.close()
        
    lines[i] = a1.sub('',lines[i])       
    
def main(argv):
    deal = 8
    log = -1
    sourceFilePath = "./source/gugong.log"
    if len(argv) == 2 :
        sourceFilePath = argv[1]
    elif len(argv) == 3 :
        sourceFilePath = argv[1]
        deal = int(argv[2])
    elif len(argv) == 4 :
        sourceFilePath = argv[1]
        deal = int(argv[2])
        log  = int(argv[3])

    fp = open(sourceFilePath, "r")
    try:
        lines = fp.readlines()
        for i in range(len(lines)):
            for j in range(deal):
                if log-1 == j:
                    regularFunc(lines, i, j, 1)
                else:
                    regularFunc(lines, i, j, 0)
            print lines[i],
        # for line in lines:
            # print "line=",line 
       
    finally:
        fp.close()
        
if __name__ == '__main__':
    if os.path.exists("log_fenci.txt"):
        os.remove("log_fenci.txt")
    main(sys.argv)

    
    
    