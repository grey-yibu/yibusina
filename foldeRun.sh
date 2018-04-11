###############################################################
# Author      : grey(yangyuzhou)
# lastCtime   : 2018.4.11
# call        : 18813011762    563965323@qq.com
# args        : MinSearchWord  => 最短搜索词深度，
#               MaxSearchWord  => 最长搜索词深度
#               sourceFilePath => 用于设置源文件文件夹路径
# desc        : 对设置的文件夹进行遍历，分别将需要生成的结果文件
#               保存至./ans文件夹中
# demo        : sh foldeRun.sh 4 11 ./source      # 进行对gugong.log里文件3~11字切词
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