###############################################################
# Author      : grey(yangyuzhou)
# lastCtime   : 2018.4.10
# call        : 18813011762    563965323@qq.com
# args        : MinSearchWord  => 最短搜索词深度，
#               MaxSearchWord  => 最长搜索词深度
#               sourceFilePath => 用于设置源文件路径
# desc        : 主体分为三步，从若干微博内容遍历提取关键词
#               1.数据清洗(去除关键词无关内容)           place_cut_yibu.py
#               2.按深度分别生成搜索结果(./ans文件夹下)  count_dict.py
#               3.合并若干结果到finalResult              sum_dict.py
#               4.进行语义过滤，去除断句                 cut_jieba.py
#               5.去除top1词频内涵内容                   cut_top.py
# demo        : sh run.sh 3 11 gugong.log      # 进行对gugong.log里文件3~11字切词
# environment : python 2.6
# charactor   : UTF-8
###############################################################

sourceFilePath="./source/*"
if  [  -n "$3"  ] ;then
    MinSearchWord=$1         # 用于记录最短搜索词深度
    MaxSearchWord=$2         # 用于记录最长搜索词深度
    sourceFilePath=$3        # 用于设置源文件路径
elif  [  -n "$2"  ] ;then
    MinSearchWord=$1         # 用于记录最短搜索词深度
    MaxSearchWord=$2         # 用于记录最长搜索词深度
else
    MinSearchWord=4          # 用于记录最短搜索词深度
    MaxSearchWord=11         # 用于记录最长搜索词深度
fi

for file in $sourceFilePath
do
    sh run.sh $MinSearchWord $MaxSearchWord $file
done

#sh run.sh $MinSearchWord $MaxSearchWord $sourceFilePath