###############################################################
# Author      : grey(yangyuzhou)
# lastCtime   : 2018.4.4
# call        : 18813011762    563965323@qq.com
# args        : MinSearchWord => 最短搜索词深度，
#               MaxSearchWord => 最长搜索词深度
# desc        : 主体分为三步，从若干微博内容遍历提取关键词
#               1.数据清洗(去除关键词无关内容)           place_cut_yibu.py
#               2.按深度分别生成搜索结果(./ans文件夹下)  count_dict.py
#               3.合并若干结果到finalResult              sum_dict.py
# environment : python 2.6
# charactor   : UTF-8
###############################################################

if  [  -n "$2"  ] ;then
    MaxSearchWord=$2         # 用于记录最长搜索词深度
    MinSearchWord=$1         # 用于记录最短搜索词深度
else
    MaxSearchWord=8         # 用于记录最长搜索词深度
    MinSearchWord=4         # 用于记录最短搜索词深度
fi


if [  -d "ans"  ]; then
    rm -rf ans
fi
mkdir ans

# first clear the data
python bin/place_cut_yibu.py 8 > ./source/0.txt

# second build the branch ans
for((i=$MinSearchWord; i<=$MaxSearchWord; i++));  
do   
    python bin/count_dict.py $i ./source/0.txt > ans/a$i.txt
    sort -nr ans/a$i.txt  -o ans/a$i.txt 
done 

# third give the final ans
i=$MaxSearchWord
python bin/sum_dict.py ans/a$i.txt ans/a$(($i-1)).txt 50 > tmpFinalResult$i
sort -nr tmpFinalResult$i -o tmpFinalResult$i

for((i--; i>=$MinSearchWord; i--));  
do  
    python bin/sum_dict.py tmpFinalResult$(($i+1)) ans/a$i.txt $((($MaxSearchWord-$i+1)*50)) > tmpFinalResult$i
    sort -nr tmpFinalResult$i -o tmpFinalResult$i
done

mv tmpFinalResult$MinSearchWord finalResult
rm tmpFinalResult* -rf



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