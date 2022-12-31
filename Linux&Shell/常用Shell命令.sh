########## cat：读取文件、拼接数据
### 选项：
### -n：在输出的每一行内容之前加上行号
### -b：在输出的每一行内容之前加上行号，但跳过空白行
### -s：去掉多余的空白行
### -T：将制表符标记成^I
# 打印多个文件的内容
-bash-4.2$ cat temp.txt output.txt
This is a sample text 1
This is sample text 2
newline
append line
# 将stdin和另一个文件中的数据组合在一起（-被作为stdin文本的文件名），注意文件中的数据不会改变
-bash-4.2$ echo 'cat new line' | cat - output.txt
cat new line
newline
append line


########## find：查找文件命令
-bash-4.2$ find logs # 列出给定目录下所有的文件和子目录
logs
logs/log4j.log
logs/gw_all.err
-bash-4.2$ find . # 当前目录
-bash-4.2$ find .. # 当前目录的父目录
##### 设置输出格式：-print选项使用\n（换行符）分隔输出的每个文件或目录名；-print0选项使用空字符'\0'来分隔
##### 根据通配符查找文件：-name选项指定待查找文件名的模式。-iname选项作用和-name类似，只不过在匹配名字时会忽略大小写。!选项可排除匹配到的模式
-bash-4.2$ find . -name '*.txt' -print0 # 根据文件名或正则表达式进行搜索
./region.txt./stderr.txt./err.txt./output.txt./stdout.txt./out.txt./temp.txt
##### find命令支持逻辑操作符。-a和-and选项可以执行逻辑与（AND）操作，-o和-or选项可以执行逻辑或（OR）操作。\（以及\）用于将-name '*.txt' -o -name '*.sh'视为一个整体
-bash-4.2$ find . \( -name '*.txt' -o -name '*.sh' \) -print0
./region.txt./mk_mlink.sh./stderr.txt./err.txt./output.txt./test.sh./stdout.txt./out.txt./temp.txt./debug.sh
##### 根据正则表达式查找文件：-regex选项
-bash-4.2$ find . -regex '.*\.\(txt\|sh\)$' -print0 # 匹配.txt或.sh文件
./region.txt./mk_mlink.sh./stderr.txt./err.txt./output.txt./test.sh./stdout.txt./out.txt./temp.txt./debug.sh
##### 根据文件的时间戳进行搜索：-atime、-mtime和-ctime作为find的时间选项，分别表示用户最近一次访问文件的时间、文件内容最后一次被修改的时间、文件元数据（例如权限或所有权）最后一次改变的时间。用整数值来指定天数。这些数字前面可以加上-或+，-表示小于，+表示大于。find命令还支持以“分钟”为计时单位的选项，包括-amin（访问时间）、-mmin（修改时间）和-cmin（变化时间）
-bash-4.2$ find . -type f -atime -7 -print0 # 打印出在最近7天内被访问过的所有文件
./stderr.txt./err.txt./output.txt./test.sh./stdout.txt./out.txt./temp.txt./debug.sh
##### 基于目录深度的搜索：-L选项告诉find命令跟随符号链接（默认情况下，find命令不会跟随符号链接）。-maxdepth和–mindepth选项设置find开始进行查找的最大（小）目录深度
##### 根据文件类型搜索：-type选项匹配指定类型的文件。文件类型包括普通文件（f）、符号链接（l）、目录（d）、字符设备（c）、块设备（b）、套接字（s）、FIFO（p）
-bash-4.2$ find . -type d
.
##### 根据文件的大小展开搜索：-size选项可基于文件大小搜索，单位包括b（块，512字节）、c（字节）、w（字，2字节）、k、M、G
-bash-4.2$ find . -type f -size +2k # 查找大于2KB的文件
./region.txt
./Run_RNAseq_STAR.py
./test.bed
##### 基于文件权限和所有权的匹配：-perm选项指明find应该只匹配具有特定权限值的文件。也可以根据文件的所有权进行搜索。用选项-user USER就找出由某个特定用户所拥有的文件
bash-4.2$ find . -type f ! -perm 644 -print0 # 找出那些没有设置好执行权限的文件
./test.bed
-bash-4.2$ find . -type f -user hongyuyang -print0 # 找出用户hongyuyang有权限的文件
./region.txt./Run_RNAseq_STAR.py./mk_mlink.sh./stderr.txt./err.txt./output.txt./test.sh./stdout.txt./out.txt./temp.txt./test.bed./debug.sh
##### 利用find执行相应操作：-delete选项可以删除所匹配到的文件。
-bash-4.2$ find . -type f -name "*.tmp" -delete # 删除.tmp文件
### -exec选项让find命令可以结合其他命令使用，find命令使用一对花括号{}代表文件名
-bash-4.2$ find . -type f -mtime +10 -name "*.txt" -exec cp {} old \; # 将10天前的.txt文件复制到old目录中（注意该命令结尾的\;。必须对分号进行转义，否则shell会将其视为find命令的结束，而非chown命令的结束。）
##### 让find跳过特定的目录：-prune选项可排除某些符合条件的文件
-bash-4.2$ find . -name 'target' -prune -o -type f -print # 排除target目录


########## cut：列提取命令
##### 语法：cut [选项] 文件名
### 选项:
### -f  列号: 提取第几列
### -d  分隔符: 按照指定分隔符分割列
### -n  取消分割多字节字符
### -c  字符范围: 通过字符范围（行首为0）来进行字段提取。n-表示从第n个字符到行尾；n-m从第n个字符到第m个字符；-m表示从第1个字符到第m个字符。
### --complement    补足被选择的字节、字符或字段
### --out-delimiter 指定输出内容是的字段分割符
##### 实例：
cut -f 2 student.txt # 提取第二列内容
cut -f 2,3 student.txt # 提取第二、第三列内容
cut -c 5 GSM2697488.bed # 截取文件每行的第5个字符
head -5 GSM2697488.bed | cut -c 5 # 截取出文件中前5行的第5个字符
head -5 GSM2697488.bed | cut -d ' ' -f 1-3 # 截取出文件中前5行以制表符进行分割的第1-3栏内容


########## xargs：从stdin处读取一系列参数，然后使用这些参数来执行指定命令。
# xargs命令应该紧跟在管道操作符之后。它使用标准输入作为主要的数据源，将从stdin中读取的数据作为指定命令的参数并执行该命令。
# xargs命令重新格式化stdin接收到的数据，再将其作为参数提供给指定命令。xargs默认会执行echo命令。zargs命令和find命令的-exec选项在很多方面都相似。
-bash-4.2$ ls *.sh | xargs grep for # 在一组.sh文件中搜索字符串for
debug.sh:for i in {1..3}
### xargs默认的echo命令可以用来将多行输入转换成单行输出
-bash-4.2$ cat test.sh
printf "%-5s %-10s %-4s\n" No Name Mark 
printf "%-5s %-10s %-4.2f\n" 1 Sarath 80.3456 
-bash-4.2$ cat test.sh | xargs
printf %-5s %-10s %-4s\n No Name Mark printf %-5s %-10s %-4.2f\n 1 Sarath 80.3456
### xargs的-n选项可以限制每次调用命令时用到的参数个数
-bash-4.2$ cat test.sh | xargs -n 3 # 将输入分割成多行，每行3个元素
printf %-5s %-10s %-4s\n No
Name Mark printf
%-5s %-10s %-4.2f\n 1 Sarath
80.3456 printf %-5s %-10s %-4.2f\n
2 James 90.9989
printf %-5s %-10s %-4.2f\n 3
Jeff 77.564
# xargs命令接受来自stdin的输入，将数据解析成单个元素，然后调用指定命令并将这些元素作为该命令的参数。xargs默认使用空白字符分割输入并执行/bin/echo
# 如果文件或目录名中包含空格（甚至是换行）的话，使用空白字符来分割输入就会出现问题。比如My Documents目录就会被解析成两个元素：My和Documents，而这两者均不存在
### -d选项可以为输入数据指定自定义的分隔符
-bash-4.2$ echo "splitXsplit2Xsplit3Xsplit4" | xargs -d X # 将X定义为输入分隔符
split split2 split3 split4
-bash-4.2$ echo "splitXsplit2Xsplit3Xsplit4" | xargs -d X -n 2 # 结合-n选项，可以将输入分割成多行
split split2
split3 split4
##### 结合find使用xargs
-bash-4.2$ find . -type f -name "*.tmp" -print0 | xargs -0 rm -f # 查找并删除所有的.tmp文件。注意使用print0而不是print，防止文件名中包含空格符（' '），xargs会将其误认为是分隔符。使用find命令的-print0选项生成以空字符（'\0'）作为分隔符的输出，然后将其作为xargs命令的输入
-bash-4.2$ find . -type f -name "*.sh" -print0 | xargs -0 wc -l # 统计.sh程序文件的行数
  17 ./mk_mlink.sh
   4 ./test.sh
   7 ./debug.sh
  28 total
-bash-4.2$ cat out.txt
     1	debug.sh
     2	err.txt
     3	mk_mlink.sh
##### 结合stdin，巧妙运用循环
-bash-4.2$ cat out.txt | xargs -I {} cat {} # -I {}指定了替换字符串。为该命令提供的各个参数会通过stdin读取并依次替换掉字符串{}
cat: 1	debug.sh: No such file or directory
cat: 2	err.txt: No such file or directory
cat: 3	mk_mlink.sh: No such file or directory


########## tr：字符替换、字符删除以及重复字符压缩
### tr只能通过stdin（标准输入）接收输入（无法通过命令行参数接收）。其调用格式如下：tr [options] set1 set2 
### 来自stdin的输入字符会按照位置从set1映射到set2（set1中的第一个字符映射到set2中的第一个字符，以此类推），然后将输出写入stdout（标准输出）。set1和set2是字符类或字符组。如果两个字符组的长度不相等，那么set2会不断复制其最后一个字符，直到长度与set1相同。如果set2的长度大于set1，那么在set2中超出set1长度的那部分字符则全部被忽略。
-bash-4.2$ echo "HELLO WHO IS THIS" | tr 'A-Z' 'a-z'
hello who is this
### 在tr中利用集合的概念，可以轻松地将字符从一个集合映射到另一个集合中
-bash-4.2$ echo 12345 | tr '0-9' '9876543210'
87654
### tr命令可以用来加密。ROT13是一个著名的加密算法。在ROT13算法中，字符会被移动13个位置，因此文本加密和解密都使用同一个函数
-bash-4.2$  echo "tr came, tr saw, tr conquered." | tr 'a-zA-Z' 'n-za-mN-ZA-M' # 加密
ge pnzr, ge fnj, ge pbadhrerq.
-bash-4.2$ echo ge pnzr, ge fnj, ge pbadhrerq. | tr 'a-zA-Z' 'n-za-mN-ZA-M' # 解密
tr came, tr saw, tr conquered.
##### 用tr删除字符：选项-d，可以通过指定需要被删除的字符集合，将出现在stdin中的特定字符清除掉
-bash-4.2$ echo "Hello 123 world 456" | tr -d '0-9'
Hello  world
##### 字符组补集：可以利用选项-c来使用set1的补集，如果只给出了set1，那么tr会删除所有不在set1中的字符。如果也给出了set2，tr会将不在set1中的字符转换成set2中的字符。如果使用了-c选项，set1和set2必须都给出。如果-c与-d选项同时出现，你只能使用set1，其他所有的字符都会被删除。
-bash-4.2$ echo hello 1 char 2 next 4 | tr -c '0-9' '.' # 将不在set1中的字符替换成点
......1......2......4.
-bash-4.2$ echo hello 1 char 2 next 4 | tr -d -c '0-9' # 删除不在补集中的所有字符
124
##### 用tr压缩字符：-s选项可以删除字符串中重复出现的字符，如空格、换行符
124-bash-4.2$ echo "GNU is not UNIX. Recursive right ?" | tr -s ' '
GNU is not UNIX. Recursive right ?
##### 还可以用tr以一种巧妙的方式将文件中的数字列表进行相加，tr命令将'\n'替换成了'+'，得到了字符串1+2+3+，尾部多了一个操作符+，为了抵消这个多出来的操作符，再加一个0。$[ operation ]执行算术运算，因此就形成了以下命令：echo $[ 1+2+3+0 ]
-bash-4.2$ cat sum.txt
1
2
3
-bash-4.2$ cat sum.txt | echo $[ $(tr '\n' '+') 0 ] 
6
# 如果有一个包含字母和数字的文件，我们想计算其中的数字之和，需要利用tr的-d选项删除文件中的字母，然后将空格替换成+
-bash-4.2$ cat sum.txt
first 1 line
the 2 line
the 3 line
-bash-4.2$ cat sum.txt | tr -d [a-z] | echo "total:$[ $(tr ' ' '+') 0 ]"
total:6
##### tr可以将不同的字符类作为集合使用
-bash-4.2$ echo "HELLO WHO IS THIS" | tr '[:upper:]' '[:lower:]'
hello who is this





########## sort：排序命令
##### 语法：sort [-bcdfimMnr][-o<输出文件>][-t<分隔字符>][+<起始栏位>-<结束栏位>][--help][--verison][文件][-k field1[,field2]]`
### -b：忽略每行前面开始出的空格字符。
### -c：检查文件是否已经按照顺序排序，如果乱序，则输出第一个乱序的行的相关信息。
### -d：排序时，处理英文字母、数字及空格字符外，忽略其他的字符。
### -f：排序时，忽略大小写。
### -i：排序时，除了040至176之间的ASCII字符外，忽略其他的字符。
### -k：排序时，按-t（空格？）分割后的第几栏排序
###     按多栏排序时输入-k n1 -k n2 -k n3 …
###     若某行降序可在行数后面加r，按数值排序可加n
###     若按某栏中的某个字符排序可设置为n.m
### -m：将几个排序好的文件进行合并。
### -M：按月份的缩写进行排序，如JAN小于FEB。
### -n：依照数值的大小排序。
### -u：在输出行中去除重复行。
### -o <输出文件>：将排序后的结果存入指定的文件。
### -r：以相反的顺序来排序。
### -t <分隔字符>：指定排序时所用的栏位分隔字符。
### +<起始栏位>-<结束栏位>：以指定的栏位来排序，范围由起始栏位到结束栏位的前一栏位。
##### 实例：
sort -u seq.txt # 去除重复行排序
sort -r number.txt # 降序排序
sort -r number.txt -o number.txt # 将排序后的结果保存到原文件
sort -n number.txt # 按数值排序（而不是ASCII码，如10比2大）
sort -n -k 2 -t : facebook.txt # 按以“:”分割后的第2栏排序
sort -n -t ' ' -k 3r -k 2 facebook.txt # 按以空格符分割后的第2栏升序、第3行降序排序
sort -t ' ' -k 1.2 facebook.txt # 按以空格符分割后的第1栏的第2个字符排序
sort file1.txt file2.txt -o sorted.txt # 排序一组文件，或sort file1.txt file2.txt > sorted.txt
sort -m sorted1 sorted2 # 合并两个已排序过的文件
sort file1.txt | uniq # 找出已排序文件中不重复的行
if sort -c fileToCheck ; then echo sorted ; else echo unsorted ; fi # 检查文件是否已经排序过
-bash-4.2$ cat temp.txt
1 mac 2000 
2 winxp 4000 
3 bsd 1000 
4 linux 1000
-bash-4.2$ sort -k 3 temp.txt # 按第3列排序
4 linux 1000
3 bsd 1000 
1 mac 2000 
2 winxp 4000 
-bash-4.2$ sort -k 2.3,2.4 temp.txt # 按第2列中的第3到4个字符排序
1 mac 2000 
2 winxp 4000 
4 linux 1000
3 bsd 1000 
sort -bd unsorted.txt # 忽略空格以及非字母和数字字符等

########## uniq：检查及删除文本文件中重复出现的行列，一般与sort命令结合使用
##### 语法：uniq [-cdu][-f<栏位>][-s<字符位置>][-w<字符位置>][输入文件][输出文件]
### -c：在每列旁边显示该行重复出现的次数。
### -u：仅显示出一次的行列。
### -d：仅显示重复出现的行列。
### -f<栏位>：忽略比较指定的栏位。
### -s<字符位置>：忽略比较指定的字符。
### -w<字符位置>：指定要比较的字符。
##### 实例：
uniq testfile # 删除重复行，或uniq -u testfile
cat 6.txt | sort | uniq # 当重复的行不相邻时，uniq命令不起作用，因此需要先使用sort排好序
uniq -u sorted.txt # 显示唯一的行，或sort unsorted.txt | uniq -u
sort unsorted.txt | uniq -d # 找出文件中重复的行
sort unsorted.txt | uniq -c # 统计各行在文件中出现的次数
uniq -z file.txt # -z选项可以生成由0值字节终止的输出
uniq -z file.txt | xargs -0 rm # 删除所有指定的文件，这些文件的名字是从files.txt中读取的（如果某个文件名出现多次，uniq命令只会将这个文件名写入stdout一次）


########## tr：替换或删除文件中的字符
##### 语法：`tr [-cdst][SET1][SET2]`
### c, --complement：反选设定字符。也就是符合 SET1 的部份不做处理，不符合的剩余部份才进行转换
### d, --delete：删除指令字符
### s, --squeeze-repeats：缩减连续重复的字符成指定的单个字符
### t, --truncate-set1：削减 SET1 指定范围，使之与 SET2 设定长度相等
##### 实例：
cat testfile |tr a-z A-Z # 将文件中的小写字母全部转换成大写字母，或cat testfile |tr [:lower:] [:upper:]
echo 'abc1d4e5f' | tr -d [0-9] # 删除字符中的数字


########## split：将大文件分割成较小的文件，在默认情况下将按照每1000行切割成一个小文件
###### 语法：`split [-<行数>][-b <字节>][-C <字节>][-l <行数>][要切割的文件][输出文件名]`
### <行数>：指定每多少行切成一个小文件
### b<字节>：指定每多少字节切成一个小文件
### C<字节>：与参数"-b"相似，但是在切 割时将尽量维持每行的完整性
### [输出文件名]：设置切割后文件的前置文件名， split会自动在前置文件名后再加上编号
##### 实例：
split -b 20k v.txt # 每20k切成一个小文件
split -100000 GSM2697488.bed # 每100000行切成一个小文件


########## wc：显示文件的统计信息
##### 语法：`wc [-clw][文件1,文件2...]`
### c或--bytes或--chars：只显示Bytes数。
### l或--lines：显示行数。
### w或--words：只显示字数。
-bash-4.2$ wc test.sh # 在默认的情况下，wc将计算指定文件的行数、字数，以及字节数
 11  28 158 test.sh


########## tee：将命令结果通过管道输出到多个文件中
##### - 语法：`tee [-ai][文件...]`
### a或--append：附加到既有文件的后面，而非覆盖它．
### i或--ignore-interrupts：忽略中断信号。
##### 实例：
cat 6.txt | sort | uniq -c | tee a.txt b.txt c.txt # 将去重后的文件保存在多个文件中