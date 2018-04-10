###############################################################
# Author      : grey(yangyuzhou)
# lastCtime   : 2018.4.10
# call        : 18813011762    563965323@qq.com
# args        : filePath     => 被抽取文件，
#               extractCount => 抽取行数
# desc        : 用于测试本项目对于数量小的分词结果
#               对一个大文件进行随机抽取生成小文件
# demo        : sh test.sh source 1100       
#                   对 source 文件进行随机抽取1100行数据
#                   并写覆盖到  ./../source/gugong.log
# environment : python 2.6
# charactor   : UTF-8
###############################################################

if  [  -n "$2"  ] ;then
    filePath=$1         # 用于记录最短搜索词深度
    extractCount=$2         # 用于记录最长搜索词深度
elif  [  -n "$1"  ] ;then
    filePath="source"         # 用于记录最短搜索词深度
    extractCount=$1         # 用于记录最长搜索词深度
else
    filePath="source"         # 用于记录最短搜索词深度
    extractCount=1000         # 用于记录最长搜索词深度
fi

python test.py $filePath $extractCount > ./../source/gugong.log

cd ./..
sh run.sh 
