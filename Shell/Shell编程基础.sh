##### Shell特殊字符
### ''  单引号。在单引号中所有的特殊符号，如“$”和”(反引号)都没有特殊含义。单引号括起来的都是普通字符，会原样输出
### ""	双引号。在双引号中特殊符号都没有特殊含义，但是“$”，“`”（esc键下面）和“\”是例外，拥有“调用变量的值”、“引用命令”和“转义符”的特殊含义。
### ``	反引号。反引号括起来的内容是系统命令，在Bash中会先执行它。和()作用一样,不过推荐使用()，因为反引号非常容易看错。
### $()	和反引号作用一样，用来引用系统命令。(推荐使用)
### ()	用于一串命令执行时，()中的命令会在子Shell中运行
### {}	用于一串命令执行时，{}中的命令会在当前Shell中执行。也可以用于变量变形与替换。
### []	用于变量的测试。
### $   用于调用变量的值，如需要调用变量name的值时，需要用$name的方式得到变量的值。
### \   转义符，跟在\之后的特殊符号将失去特殊含义，变为普通字符。如$将输出“$”符号，而不当做是变量引用。
submit3:~ hongyuyang$ name=sc
submit3:~ hongyuyang$ echo '$name' # 如果输出时使用单引号，则$name原封不动的输出
$name
submit3:~ hongyuyang$ echo "$name" # 如果输出时使用双引号，则会输出变量name的值sc
sc
submit3:~ hongyuyang$echo ls # 如果命令不用反引号包含，命令不会执行，而是直接输出
ls
submit3:~ hongyuyang$echo `ls` # 只有用反引号包括命令，这个命令才会执行
code logs mHapSuite package paperRecur project R script software study
submit3:~ hongyuyang$echo $(ls) # 使用$(命令)的方式也可执行
code logs mHapSuite package paperRecur project R script software study

##### 变量
### 查看所有变量：set [选项]，若选项为空，则查询系统中所有的变量，包含用户自定义变量和环境变量
### 选项:
### -u:如果设定此选项，调用未声明变量时会报错（默认无任何提示）
### -x:如果设定此选项，在命令执行之前，会把命令先输出一次
### +<参数> :取消某个set曾启动的参数。
submit3:~ hongyuyang$set -u
submit3:~ hongyuyang$echo $var
-bash: var: unbound variable
submit3:~ hongyuyang$set -x
submit3:~ hongyuyang$ls
+ ls --color=auto
code  logs  mHapSuite  package  paperRecur  project  R  script  software  study
submit3:~ hongyuyang$set +x
+ set +x
submit3:~ hongyuyang$ls
code  logs  mHapSuite  package  paperRecur  project  R  script  software  study
### 删除变量：unset 变量名

##### 环境变量
### 声明环境变量：export
### 查看环境变量：env，仅能查看环境变量

##### 位置参数变量：
### $n	n为数字，$0表示当前 Shell 脚本程序的名称，$1-9代表第一到第九个参数,十以上的参数需要用大括号包含，如{10}
### $*	这个变量代表命令行中所有的参数，$把所有的参数看成一个整体
### $@	这个变量也代表命令行中所有的参数，不过$@把每个参数区分对待
### $#	这个变量代表命令行中所有参数的个数
submit3:~/script hongyuyang$cat test.sh
echo "shell name: $0"
echo "the first var: $1"
echo "the second var: $2"
submit3:~/script hongyuyang$. test.sh 1 2
shell name: -bash
the first var: 1
the second var: 2
submit3:~/script hongyuyang$cat test.sh
echo "all shell var: $*"
submit3:~/script hongyuyang$. test.sh 1 2
all shell var: 1 2

### 预定义变量
### $?	最后一次执行的命令的返回状态。如果这个变量的值为0，证明上一个命令正确执行；如果这个变量的值为非О(具体是哪个数，由命令自己来决定），则证明上一个命令执行不正确
### $$	当前进程的进程号（PID)
### $!	后台运行的最后一个进程的进程号(PID)

##### 获取键盘输入：read [选项][变量名]
### 选项:
### 	-a：后跟一个变量，该变量会被认为是个数组，然后给其赋值，默认是以空格为分割符。
### 	-p：“提示信息”：在等待read输入时，输出提示信息。
### 	-t：秒数：read命令会一直等待用户输入，使用此选项可以指定等待时间。
### 	-n：数字：read命令只接受指定的字符数，就会执行。
### 	-s：隐藏输入的数据，适用于机密信息的输入。
###     -d：后面跟一个标志符，其实只有其后的第一个字符有用，作为结束的标志。
###     -e：在输入的时候可以使用命令补全功能。
### 变量名:
### 变量名可以自定义，如果不指定变量名，会把输入保存入默认变量REPLY。
### 如果只提供了一个变量名，则整个输入行赋予该变量。
### 如果提供了一个以上的变量名，则输入行分为若干字，一个接一个地赋予各个变量，而命令行上的最后一个变量取得剩余的所有字。

##### 算术运算符：原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如awk和expr，expr最常用。
submit3:~/script hongyuyang$val=`expr 2 + 2`
submit3:~/script hongyuyang$echo $val
4
submit2:~ hongyuyang$a=10
submit2:~ hongyuyang$b=20
submit2:~ hongyuyang$echo 'a+b= ' `expr $a + $b`
a+b=  30
submit2:~ hongyuyang$echo 'a-b= ' `expr $a - $b`
a-b=  -10
submit2:~ hongyuyang$echo 'a*b= ' `expr $a \* $b`
a*b=  200
submit2:~ hongyuyang$echo 'a/b= ' `expr $a / $b`
a/b=  0
submit2:~ hongyuyang$echo 'a%b= ' `expr $a % $b`
a%b=  10

##### 关系运算符
### -eq equal	检测两个数是否相等，相等返回 true。
### -ne	not equal	检测两个数是否相等，不相等返回 true。
### -gt	great than	检测左边的数是否大于右边的，如果是，则返回 true。
### -lt	less than	检测左边的数是否小于右边的，如果是，则返回 true。
### -ge	great than or equal	检测左边的数是否大于等于右边的，如果是，则返回 true。
### -le	less than or equal	检测左边的数是否小于等于右边的，如果是，则返回 true。

##### 逻辑运算符
### !	非运算，表达式为 true 则返回 false，否则返回 true。
### -o	或（或者）运算，有一个表达式为 true 则返回 true。
### -a	与（并且）运算，两个表达式都为 true 才返回 true。

##### 字符串运算符
### =	检测两个字符串是否相等，相等返回true。
### !=	检测两个字符串是否相等，不相等返回true。
### -z	检测字符串长度是否为0，为0返回true。
### -n	检测字符串长度是否为0，不为0返回true。
### str	检测字符串是否为空，不为空返回true。

##### 文件测试运算符：检测Unix/Linux文件的各种属性
### -b file	检测文件是否是块设备文件，如果是，则返回true。
### -c file	检测文件是否是字符设备文件，如果是，则返回true。
### -d file	检测文件是否是目录，如果是，则返回true。
### -f file	检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回true。
### -g file	检测文件是否设置了 SGID 位，如果是，则返回true。
### -k file	检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回true。
### -p file	检测文件是否是有名管道，如果是，则返回true。
### -u file	检测文件是否设置了 SUID 位，如果是，则返回true。
### -r file	检测文件是否可读，如果是，则返回true。
### -w file	检测文件是否可写，如果是，则返回true。
### -x file	检测文件是否可执行，如果是，则返回true。
### -s file	检测文件是否为空（文件大小是否大于0），不为空返回true。
### -e file	检测文件（包括目录）是否存在，如果是，则返回true。 

########## 流程控制
##### 单分支if条件判断：
if [ 条件判断式 ]
then
	程序
fi
##### 双分支if条件判断：
if [ 条件判断式 ]
then
	条件成立时，执行的程序
else
	条件不成立时，执行的另一个程序
fi
##### 多分支if条件语句：
if [ 条件判断式1 ]
	then
		当条件判断式1成立时，执行程序1
elif [ 条件判断式2 ]
	then
		当条件判断式2成立时，执行程序2
…省略更多条件…
else
	当所有条件都不成立时，最后执行此程序
fi
##### 多分支case条件语句：
case $变量名 in
	"值1")
	如果变量的值等于值1，则执行程序1
	;;
	"值2")
	如果变量的值等于值2，则执行程序2
	;;
	…省略其他分支…
	*)
	如果变量的值都不是以上的值，则执行此程序
	;;
esac
##### for循环
### 语法一
for 变量 in 值1 值2 值3 …(可以是一个文件等)
	do
		程序
	done
### 语法二
for (( 初始值;循环控制条件;变量变化 ))
	do
		程序
	done
##### while循环
while [ 条件判断式 ]
	do
		程序
	done

##### 函数
### 语法：
function 函数名 () {
	程序
}
### 实例
-bash-4.2$ cat test.sh
function sum () { # 定义函数sum
	s=0
	for (( i=0; i<=$num;i=i+1 ))
		do
			s=$(( $i+$s ))
		done
	echo "The sum of 1+2+3...+$1 is :$s"
}
num=10
sum $num
-bash-4.2$ . test.sh
The sum of 1+2+3...+10 is :55

##### 特殊流程控制语句
### break语句：结束整个当前循环
### continue语句：结束本次循环
### exit语句：直接退出脚本

##### 正则表达式
### \	转义符，将特殊字符进行转义，忽略其特殊意义。实例：a.b匹配a.b，但不能匹配ajb，.被转义为特殊意义
### ^	匹配行首，awk中，^则是匹配字符串的开始。实例：^tux匹配以tux开头的行
### $	匹配行尾，awk中，$则是匹配字符串的结尾。实例：tux$匹配以tux结尾的行
### .	匹配除换行符\n之外的任意单个字符。实例：ab.匹配abc或abd，不可匹配abcd或abde，只能匹配单字符
### [ ]	匹配包含在[字符]之中的任意一个字符。实例：coo[kl]可以匹配cook或cool
### [^]	匹配[^字符]之外的任意一个字符。实例：123[^45]不可以匹配1234或1235，1236、1237都可以
### [-]	匹配[]中指定范围内的任意一个字符，要写成递增。实例：[0-9]可以匹配1、2或3等其中任意一个数字
### ?	匹配之前的项1次或者0次。实例：colou?r可以匹配color或者colour，不能匹配colouur


######################################################################### 常用命令 ###########################################################################
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

########## sort：排序命令
##### 语法：sort [-bcdfimMnr][-o<输出文件>][-t<分隔字符>][+<起始栏位>-<结束栏位>][--help][--verison][文件][-k field1[,field2]]`
### -b：忽略每行前面开始出的空格字符。
### -c：检查文件是否已经按照顺序排序，如果乱序，则输出第一个乱序的行的相关信息。
### -d：排序时，处理英文字母、数字及空格字符外，忽略其他的字符。
### -f：排序时，忽略大小写。
### -i：排序时，除了040至176之间的ASCII字符外，忽略其他的字符。
### -k：排序时，按-t分割后的第几栏排序
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

########## uniq：检查及删除文本文件中重复出现的行列，一般与sort命令结合使用
##### 语法：`uniq [-cdu][-f<栏位>][-s<字符位置>][-w<字符位置>][输入文件][输出文件]`
### c或--count：在每列旁边显示该行重复出现的次数。
### d或--repeated：仅显示重复出现的行列。
### f<栏位>或--skip-fields=<栏位>：忽略比较指定的栏位。
### s<字符位置>或--skip-chars=<字符位置>：忽略比较指定的字符。
### u或--unique：仅显示出一次的行列。
### w<字符位置>或--check-chars=<字符位置>：指定要比较的字符。
##### 实例：
uniq testfile # 删除重复行，或uniq -u testfile
cat 6.txt | sort | uniq # 当重复的行不相邻时，uniq命令不起作用，因此需要先使用sort排好序

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

######################################################################### 常用命令 ###########################################################################
