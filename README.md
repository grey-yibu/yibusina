# 地点关键词提取-脚本

本脚本有两个运行入口：
run.sh         // 用于对单文件进行切词
foldeRun.sh    // 用于对某一个文件夹里所有文件进行切词

有一个测试工具文件夹
tests
用于将某一个大文件切成随机指定大小的小文件
用于测试本脚本对于缩小范围后的适用性

本项目全部文件树如下所示

.
├── Intermediate                // 该文件夹保存脚本运行的中间结果(最后一次执行的)
│   ├── 0.txt                   // 该文件为进行第一次过滤后的中间文件
│   ├── a4.txt                  // 若干个以a开头的文件,代表切第n个字时的中间文件
│   ├── a5.txt
│   ├── a6.txt
│   ├── a7.txt
│   ├── a8.txt
│   ├── a9.txt
│   ├── a10.txt
│   └── a11.txt
├── ans                         // 用于保存脚本运行结果的文件夹
│   ├── budalagong.log          // 结果同源文件名保持一致
│   ├── emeishan.log
│   ├── gugong.log
│   └── lijiang.log
├── bin                         // 用于保存运行脚本的路径
│   ├── place_cut_yibu.py       // 第一步过滤脚本 去无意义词
│   ├── count_dict.py           // 第二步过滤脚本 聚合重复关键词
│   ├── sum_dict.py             // 第三步过滤脚本 将不同字数结果聚合到一起
│   ├── cut_jieba.py            // 第四步过滤脚本 词义过滤
│   └── cut_top.py              // 第五步过滤脚本 top1词,切词过滤
│ 
├── foldeRun.sh                 // 用于对某一个文件夹里所有文件进行切词
├── run.sh                      // 用于对单文件进行切词
│ 
├── source                      // 被切词文件保存路径
│   ├── budalagong.log          // 若干个被切词文件
│   ├── emeishan.log
│   ├── gugong.log
│   └── lijiang.log
└── tests                       // 测试工具文件夹
    ├── source                  // 测试源文件
    ├── test.py                 // 用于将某一个大文件切成随机指定大小的小文件
    └── test.sh                 // 用于测试本脚本对于缩小范围后的适用性
