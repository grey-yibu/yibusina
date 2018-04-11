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
├── Intermediate                // 该文件夹保存脚本运行的中间结果(最后一次执行的)\<br>      
│   ├── 0.txt                   // 该文件为进行第一次过滤后的中间文件            \<br> 
│   ├── a4.txt                  // 若干个以a开头的文件,代表切第n个字时的中间文件 \<br> 
│   ├── a5.txt                                                                   \<br> 
│   ├── a6.txt                                                                   \<br> 
│   ├── a7.txt                                                                   \<br> 
│   ├── a8.txt                                                                   \<br> 
│   ├── a9.txt                                                                   \<br> 
│   ├── a10.txt                                                                  \<br> 
│   └── a11.txt                                                                  \<br> 
├── ans                         // 用于保存脚本运行结果的文件夹                  \<br> 
│   ├── budalagong.log          // 结果同源文件名保持一致                        \<br> 
│   ├── emeishan.log                                                             \<br> 
│   ├── gugong.log                                                               \<br> 
│   └── lijiang.log                                                              \<br> 
├── bin                         // 用于保存运行脚本的路径                        \<br> 
│   ├── place_cut_yibu.py       // 第一步过滤脚本 去无意义词                     \<br> 
│   ├── count_dict.py           // 第二步过滤脚本 聚合重复关键词                 \<br> 
│   ├── sum_dict.py             // 第三步过滤脚本 将不同字数结果聚合到一起       \<br> 
│   ├── cut_jieba.py            // 第四步过滤脚本 词义过滤                       \<br> 
│   └── cut_top.py              // 第五步过滤脚本 top1词,切词过滤                \<br> 
│                                                                                \<br> 
├── foldeRun.sh                 // 用于对某一个文件夹里所有文件进行切词          \<br> 
├── run.sh                      // 用于对单文件进行切词                          \<br> 
│                                                                                \<br> 
├── source                      // 被切词文件保存路径                            \<br> 
│   ├── budalagong.log          // 若干个被切词文件                              \<br> 
│   ├── emeishan.log                                                             \<br> 
│   ├── gugong.log                                                               \<br> 
│   └── lijiang.log                                                              \<br> 
└── tests                       // 测试工具文件夹                                \<br> 
    ├── source                  // 测试源文件                                    \<br> 
    ├── test.py                 // 用于将某一个大文件切成随机指定大小的小文件    \<br> 
    └── test.sh                 // 用于测试本脚本对于缩小范围后的适用性          \<br> 
