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

sourceFilePath="./source/gugong.log"
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


# 只取大于总数的0.001
allLineNumber=$(sed -n '$=' $sourceFilePath)
allLineNumber=$(echo "$allLineNumber * 0.001" | bc)
allLineNumber=$(printf "%1.f\n" $allLineNumber)

if [ $allLineNumber -eq 0 ];then 
    allLineNumber=1
fi

if [ ! -d "ans"  ]; then
    mkdir ans 
fi
# mkdir ans 

if [  -d "Intermediate"  ]; then
    rm -rf Intermediate 
fi
mkdir Intermediate 

# first clear the data
python bin/place_cut_yibu.py $sourceFilePath 8 > ./Intermediate/0.txt

# second build the branch ans
for((i=$MinSearchWord; i<=$MaxSearchWord; i++));  
do   
    python bin/count_dict.py $i ./Intermediate/0.txt > Intermediate/a$i.txt
    sort -nr Intermediate/a$i.txt  -o Intermediate/a$i.txt 
done 

# third give the final Intermediate 
i=$MaxSearchWord
python bin/sum_dict.py Intermediate/a$i.txt Intermediate/a$(($i-1)).txt $allLineNumber > tmpFinalResult$i
sort -nr tmpFinalResult$i -o tmpFinalResult$i

for((i--;i>=$MinSearchWord;i--));  
do  
    python bin/sum_dict.py tmpFinalResult$(($i+1)) Intermediate/a$i.txt $allLineNumber > tmpFinalResult$i
    sort -nr tmpFinalResult$i -o tmpFinalResult$i
done

mv tmpFinalResult$MinSearchWord finalResult
rm tmpFinalResult* -rf

python bin/cut_jieba.py finalResult > finalResult0

awk  '{if($1 > int('$allLineNumber') ) print $0;else exit;}' finalResult0 > finalResult1


echo ./ans/${sourceFilePath##*/}

python bin/cut_top.py finalResult1 > ./ans/${sourceFilePath##*/}

rm finalResult0 finalResult1 -rf

# python bin/count_dict.py 4 > ans/a4.txt 
# python bin/count_dict.py 5 > ans/a5.txt 
# python bin/count_dict.py 6 > ans/a6.txt 
# python bin/count_dict.py 7 > ans/a7.txt 
# python bin/count_dict.py 8 > ans/a8.txt 

# sort -nr ans/a4.txt  -o ans/a4.txt 
# sort -nr ans/a5.txt  -o ans/a5.txt 
# sort -nr ans/a6.txt  -o ans/a6.txt 
# sort -nr ans/a7.txt  -o ans/a7.txt 
# sort -nr ans/a8.txt  -o ans/a8.txt 

# python bin/sum_dict.py ans/a8.txt ans/a7.txt 50 > finalResult
# sort -nr finalResult -o finalResult
# python bin/sum_dict.py finalResult ans/a6.txt 100 > finalResult1
# sort -nr finalResult1 -o finalResult1
# python bin/sum_dict.py finalResult1 ans/a5.txt 150 > finalResult2
# sort -nr finalResult2 -o finalResult2
# python bin/sum_dict.py finalResult2 ans/a4.txt 200 > finalResult
# sort -nr finalResult -o finalResult
# rm finalResult2 finalResult1 -rf 