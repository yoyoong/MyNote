##### Shell特殊字符
### ''  单引号。在单引号中所有的特殊符号，如“$”和”(反引号)都没有特殊含义。单引号括起来的都是普通字符，会原样输出
### ""	双引号。在双引号中“$”，“`”（esc键下面）和“\”等具有特殊含义，拥有“调用变量的值”、“引用命令”和“转义符”的特殊含义。
### ``	反引号。反引号括起来的内容是系统命令，在Bash中会先执行它。和()作用一样,不过推荐使用()，因为反引号非常容易看错。
### $()	和反引号作用一样，用来引用系统命令。(推荐使用)
### ()	用于一串命令执行时，()中的命令会在子Shell中运行
### {}	用于一串命令执行时，{}中的命令会在当前Shell中执行。也可以用于变量变形与替换。
### []	用于变量的测试。
### $   用于调用变量的值，如需要调用变量name的值时，需要用$name的方式得到变量的值。
### \   转义符，跟在\之后的特殊符号将失去特殊含义，变为普通字符。如$将输出“$”符号，而不当做是变量引用。
-bash-4.2$ name=sc
-bash-4.2$ echo '$name' # 如果输出时使用单引号，则$name原封不动的输出
$name
-bash-4.2$ echo "$name" # 如果输出时使用双引号，则会输出变量name的值sc
sc
-bash-4.2$ echo ls # 如果命令不用反引号包含，命令不会执行，而是直接输出
ls
-bash-4.2$ echo `ls` # 只有用反引号包括命令，这个命令才会执行
code logs mHapSuite package paperRecur project R script software study
-bash-4.2$ echo $(ls) # 使用$(命令)的方式也可执行
code logs mHapSuite package paperRecur project R script software study


##### 变量
### 查看所有变量：set [选项]，若选项为空，则查询系统中所有的变量，包含用户自定义变量和环境变量
### 选项:
### -u:如果设定此选项，调用未声明变量时会报错（默认无任何提示）
### -x:如果设定此选项，在命令执行之前，会把命令先输出一次
### +<参数> :取消某个set曾启动的参数。
-bash-4.2$ set -u
-bash-4.2$ echo $var
-bash: var: unbound variable
-bash-4.2$ set -x
-bash-4.2$ ls
+ ls --color=auto
code  logs  mHapSuite  package  paperRecur  project  R  script  software  study
-bash-4.2$ set +x
+ set +x
-bash-4.2$ ls
code  logs  mHapSuite  package  paperRecur  project  R  script  software  study
### 删除变量：unset 变量名
### 获取变量长度：${#var}
-bash-4.2$ var=123456
-bash-4.2$ echo ${#var}
6
-bash-4.2$ var="qwert"
-bash-4.2$ echo ${#var}
5


##### 环境变量
### 声明环境变量：export
### 查看环境变量：env，仅能查看环境变量


##### 位置参数变量：
### $n	n为数字，$0表示当前 Shell 脚本程序的名称，$1-9代表第一到第九个参数,十以上的参数需要用大括号包含，如{10}
### $*	代表命令行中所有的参数，$*将所有的参数当作单个字符串
### $@	也代表命令行中所有的参数，不过$@把每个参数区分对待。"$@"要比"$*"用得多。
### $#	代表命令行中所有参数的个数
-bash-4.2$ cat test.sh
echo "shell name: $0"
echo "the first var: $1"
echo "the second var: $2"
-bash-4.2$ . test.sh 1 2
shell name: -bash
the first var: 1
the second var: 2
-bash-4.2$ cat test.sh
echo "all shell var: $*"
-bash-4.2$ . test.sh 1 2
all shell var: 1 2


### 预定义变量
### $?	最后一次执行的命令的返回状态。如果命令成功退出，那么退出状态为0，否则为非0
### $$	当前进程的进程号（PID)
### $!	后台运行的最后一个进程的进程号(PID)


##### 获取键盘输入：read [选项][变量名]
### 选项:
### 	-a：后跟一个变量，该变量会被认为是个数组，然后给其赋值，默认是以空格为分割符。
### 	-p：提示信息。
### 	-t：秒数，指定等待时间。
### 	-n：数字，指定从输入中读取n个字符。
### 	-s：隐藏输入的数据，适用于机密信息的输入。
###     -d：定界符，作为输入行的结束。
###     -e：在输入的时候可以使用命令补全功能。
### 变量名：变量名可以自定义，如果不指定变量名，会把输入保存入默认变量REPLY。如果只提供了一个变量名，则整个输入行赋予该变量。如果提供了一个以上的变量名，则输入行分为若干字，一个接一个地赋予各个变量，而命令行上的最后一个变量取得剩余的所有字。
-bash-4.2$ read -n 3 var
abc-bash-4.2$ echo $var
abc
-bash-4.2$ read -p "Enter input:" var
Enter input:abc
-bash-4.2$ echo $var
abc
-bash-4.2$ read -d ":" var
abcde:-bash-4.2$ echo $var
abcde


##### 输出
### echo：用于终端打印的最基本命令
-bash-4.2$ echo "test!" # 双引号允许shell解释字符串中出现的特殊字符
-bash: !: event not found
-bash-4.2$ echo 'test!' # 单引号不会对其做任何解释
test!
### 默认情况下，echo会在输出文本的尾部追加一个换行符，可以使用选项-n来禁止这种行为。
### echo同样接受双包含转义序列的双引号字符串作为参数。在使用转义序列时，需要使用echo -e"包含转义序列的字符串"这种形式。
-bash-4.2$ echo -e "1\t2\t3"
1	2	3
### printf：另一个可用于终端打印的命令。printf命令接受引用文本或由空格分隔的参数。我们可以在printf中使用格式化字符串来指定字符串的宽度、左右对齐方式等。默认情况下，printf并不会自动添加换行符，我们必须在需要的时候手动指定。
-bash-4.2$ cat test.sh
printf "%-5s %-10s %-4s\n" No Name Mark 
printf "%-5s %-10s %-4.2f\n" 1 Sarath 80.3456 
printf "%-5s %-10s %-4.2f\n" 2 James 90.9989 
printf "%-5s %-10s %-4.2f\n" 3 Jeff 77.564
-bash-4.2$ . test.sh
No    Name       Mark
1     Sarath     80.35
2     James      91.00
3     Jeff       77.56
##### 将文本输出到文件中
-bash-4.2$ echo "This is a sample text 1" > temp.txt
-bash-4.2$ echo "This is sample text 2" >> temp.txt
-bash-4.2$ cat temp.txt
This is a sample text 1
This is sample text 2


########## 文件描述符与重定向
### 文件描述符：与某个打开的文件或数据流相关联的整数。文件描述符0、1以及2是系统预留的。
### 0 —— stdin （标准输入）
### 1 —— stdout（标准输出）
### 2 —— stderr（标准错误）
##### 重定向stderr：当命令产生错误信息时，该信息会被输出到stderr流
-bash-4.2$ ls + > out.txt # stderr文本会打印到屏幕上而不是文件中（因为stdout并没有输出，所以out.txt的内容为空）
ls: cannot access +: No such file or directory
-bash-4.2$ ls + 2> out.txt # 使用2>（数字2以及大于号）将stderr重定向到out.txt
-bash-4.2$ cat out.txt
ls: cannot access +: No such file or directory
-bash-4.2$ cmd 2>stderr.txt 1>stdout.txt # 将stderr和stdout分别重定向到不同的文件中
-bash-4.2$ cat output.txt # 将stderr转换成stdout，使得stderr和stdout都被重定向到同一个文件中
bash: cmd: command not found...
Similar command is: 'mcd'
-bash-4.2$ chmod 000 test.bed # 清除所有权限
-bash-4.2$ cat test* # 打印文件名以test起始的所有文件的内容
cat: test.bed: Permission denied
-bash-4.2$ cat test* 2> err.txt # stderr被重定向到err.txt
-bash-4.2$ cat err.txt
cat: test.bed: Permission denied
# 我们在处理一些命令输出的同时还想将其保存下来，以备后用。stdout作为单数据流（single stream），可以被重定向到文件或是通过管道传入其他程序，但是两者无法兼得。
# 有一种方法既可以将数据重定向到文件，还提供一份重定向数据的副本作为管道中后续命令的stdin。tee命令从stdin中读取，然后将输入数据重定向到stdout以及一个或多个文件中。
# 在下面的代码中，tee命令接收到来自stdin的数据，将stdout的一份副本写入文件out.txt，同时将另一份副本作为后续命令的stdin。命令cat -n为从stdin中接收到的每一行数据前加上行号并将其写入stdout
-bash-4.2$ cat test* | tee out.txt | cat -n
cat: test.bed: Permission denied
     1	printf "%-5s %-10s %-4s\n" No Name Mark 
     2	printf "%-5s %-10s %-4.2f\n" 1 Sarath 80.3456 
     3	printf "%-5s %-10s %-4.2f\n" 2 James 90.9989 
     4	printf "%-5s %-10s %-4.2f\n" 3 Jeff 77.564
-bash-4.2$ cat out.txt # cat: a1: Permission denied 并没有在文件内容中出现，因为这些信息被发送到了stderr，而tee只能从stdin中读取
printf "%-5s %-10s %-4s\n" No Name Mark 
printf "%-5s %-10s %-4.2f\n" 1 Sarath 80.3456 
printf "%-5s %-10s %-4.2f\n" 2 James 90.9989 
printf "%-5s %-10s %-4.2f\n" 3 Jeff 77.564
# 默认情况下，tee命令会将文件覆盖，但它提供了一个-a选项，可用于追加内容
### 自定义文件描述符：exec命令创建全新的文件描述符
# <操作符可以将文件读入stdin；>操作符用于截断模式的文件写入（数据在目标文件内容被截断之后写入）；>>操作符用于追加模式的文件写入（数据被追加到文件的现有内容之后，而且该目标文件中原有的内容不会丢失）。文件描述符可以用以上3种模式中的任意一种来创建。
-bash-4.2$ exec 3< temp.txt # 创建一个用于读取文件的文件描述符
-bash-4.2$ cat<&3
This is a sample text 1
This is sample text 2
-bash-4.2$ exec 4> output.txt # 创建一个用于写入（截断模式）的文件描述符
-bash-4.2$ echo newline >&4
-bash-4.2$ cat output.txt
newline
-bash-4.2$ exec 5>> output.txt # 创建一个用于写入（追加模式）的文件描述符
-bash-4.2$ echo append line >&5
-bash-4.2$ cat output.txt
newline
append line


##### 算术运算符：Bash shell使用let、(( ))和[]执行基本的算术操作。
-bash-4.2$ a=1
-bash-4.2$ b=2
-bash-4.2$ let c=a+b
-bash-4.2$ echo $c
3
-bash-4.2$ let c++ # 自加操作
-bash-4.2$ echo $c
4
-bash-4.2$ let c--
-bash-4.2$ echo $c
3
-bash-4.2$ let c+=2
-bash-4.2$ echo $c
5
-bash-4.2$ c=$[ a+b ] # 操作符[]的使用方法和let命令一样（在[]中也可以使用$前缀）
-bash-4.2$ echo $c
3
-bash-4.2$ c=$((a+10)) # 也可以使用操作符(())，在(())中的变量名之前需要加上$
-bash-4.2$ echo $c
11
# expr同样可以用于基本算术操作
-bash-4.2$ val=`expr 2 + 2`
-bash-4.2$ echo $val
4
-bash-4.2$ $a=10
-bash-4.2$ $b=20
-bash-4.2$ $echo 'a+b= ' `expr $a + $b`
a+b=  30
-bash-4.2$ $echo 'a-b= ' `expr $a - $b`
a-b=  -10
-bash-4.2$ $echo 'a*b= ' `expr $a \* $b`
a*b=  200
-bash-4.2$ $echo 'a/b= ' `expr $a / $b`
a/b=  0
-bash-4.2$ $echo 'a%b= ' `expr $a % $b`
a%b=  10
### 以上这些方法不支持浮点数，只能用于整数运算，可以借助bc执行浮点数运算并使用一些高级函数
-bash-4.2$ echo "4 * 0.56" | bc
2.24
# bc可以接受操作控制前缀。这些前缀之间使用分号分隔
-bash-4.2$ echo "scale=2;22/7" | bc # 设定小数精度
3.14
-bash-4.2$ echo "obase=2;100" | bc # 进制转换（十进制转换为二进制）
1100100
-bash-4.2$ echo "obase=10;ibase=2;1101" | bc # 二进制转换为十进制
13
-bash-4.2$ echo "sqrt(100)" | bc # 计算平方
10
-bash-4.2$ echo "10^2" | bc # 计算平方根
100


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
##### 字符串运算符：进行字符串比较时，最好用双中括号，因为有时候采用单个中括号会产生错误
### =	检测两个字符串是否相等，相等返回true。如[[ $str1 = $str2 ]]或[[ $str1 == $str2 ]]
### !=	检测两个字符串是否相等，不相等返回true。如[ $str1 != $str2 ]]
### >或< 检测链各个字符串的ASCII值大小。如[[ $str1 > $str2 ]]
### -z	检测字符串长度是否为0，为0返回true。如[[ -z $str1 ]]
### -n	检测字符串长度是否为0，不为0返回true。如[[ -n $str1 ]]
### str	检测字符串是否为空，不为空返回true。
# 注意，var = value不同于var=value。两边没有空格的等号是赋值操作符，加上空格的等号表示的是等量关系测试。
# test命令可以用来测试条件。用test可以避免使用过多的括号，增强代码的可读性。[]中的测试条件同样可以用于test命令。例如：if [ $var -eq 0 ]; then echo "True"; fi 也可以写成：if test $var -eq 0 ; then echo "True"; fi


##### 文件测试运算符：检测Unix/Linux文件的各种属性
### -b file	检测文件是否是块设备文件，如果是，则返回true。
### -c file	检测文件是否是字符设备文件，如果是，则返回true。
### -d file	检测文件是否是目录，如果是，则返回true。
### -f file	检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回true。
### -g file	检测文件是否设置了SGID位，如果是，则返回true。
### -k file	检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回true。
### -p file	检测文件是否是有名管道，如果是，则返回true。
### -u file	检测文件是否设置了SUID位，如果是，则返回true。
### -r file	检测文件是否可读，如果是，则返回true。
### -w file	检测文件是否可写，如果是，则返回true。
### -x file	检测文件是否可执行，如果是，则返回true。
### -s file	检测文件是否为空（文件大小是否大于0），不为空返回true。
### -e file	检测文件（包括目录）是否存在，如果是，则返回true。 


##### 字符类
### alnum：字母和数字。
### alpha：字母。
### cntrl：控制（非打印）字符。
### digit：数字。
### graph：图形字符。
### lower：小写字母。
### print：可打印字符。
### punct：标点符号。
### space：空白字符。
### upper：大写字母。
### xdigit：十六进制字符。


##### 正则表达式
### \	转义符，将特殊字符进行转义，忽略其特殊意义。实例：a.b匹配a.b，但不能匹配ajb，.被转义为特殊意义
### ^	匹配行首，awk中，^则是匹配字符串的开始。实例：^tux匹配以tux开头的行
### $	匹配行尾，awk中，$则是匹配字符串的结尾。实例：tux$匹配以tux结尾的行
### .	匹配除换行符\n之外的任意单个字符。实例：ab.匹配abc或abd，不可匹配abcd或abde，只能匹配单字符
### [ ]	匹配包含在[字符]之中的任意一个字符。实例：coo[kl]可以匹配cook或cool
### [^]	匹配[^字符]之外的任意一个字符。实例：123[^45]不可以匹配1234或1235，1236、1237都可以
### [-]	匹配[]中指定范围内的任意一个字符，要写成递增。实例：[0-9]可以匹配1、2或3等其中任意一个数字
### ?	匹配之前的项1次或者0次。实例：colou?r可以匹配color或者colour，不能匹配colouur


##### 数组
-bash-4.2$ array=("test1" "test2" "test3") # 使用数值列表来定义一个数组。还可以将数组定义成一组“索引值”，如array[0]="test1"
-bash-4.2$ echo ${array[0]} # 打印出特定索引的数组元素内容
test1
-bash-4.2$ echo ${array[*]} # 以列表形式打印出数组中的所有值
test1 test2 test3
-bash-4.2$ echo ${array[@]} # 同上
test1 test2 test3
-bash-4.2$ echo ${#array[*]} # 打印数组长度
3
##### 关联数组：使用字符串（站点名、用户名、非顺序数字等）作为索引的数组
-bash-4.2$ declare -A fruits_value # 使用声明语句将一个变量定义为关联数组
-bash-4.2$ fruits_value=([apple]='100 dollars' [orange]='150 dollars')
-bash-4.2$ echo "Apple costs ${fruits_value[apple]}"
Apple costs 100 dollars
-bash-4.2$ echo ${!fruits_value[*]} # 获取数组的索引列表
orange apple


##### 别名：使用alias命令为一长串命令创建别名
-bash-4.2$ alias install='sudo apt-get install' # 为apt-get install创建了一个别名，就可以用install来代替sudo apt-get install
# alias命令的效果只是暂时的。一旦关闭当前终端，所有设置过的别名就失效了。为了使别名在所有的shell中都可用，可以将其定义放入~/.bashrc文件中
-bash-4.2$ echo 'alias cmd="command seq"' >> ~/.bashrc
# 如果需要删除别名，只需将其对应的定义（如果有的话）从~/.bashrc中删除，或者使用unalias命令。也可以使用alias example=，这会取消别名example
-bash-4.2$ alias # 列出当前定义的所有别名
alias install='sudo apt-get install'
# 可以转义要使用的命令，忽略当前定义的别名。如\install


##### 日期与时间
-bash-4.2$ date # 获取当前日期+时间
Wed Dec 28 14:30:23 CST 2022
-bash-4.2$ date "+%Y-%B-%d" # 打印出相应格式的日期
2022-December-28
### date命令所支持的格式选项：%a和%A代表周几；%Y和%y代表年份；%B和%b代表月份；%d代表日；%D代表特定格式日期（mm/dd/yy）如12/28/22
### %I或%H代表小时；%M代表分钟；%S代表秒；%N代表纳秒；%s代表Unix纪元时（以秒为单位）
# date命令可以用于计算一组命令所花费的执行时间：
start=$(date +%s) 
commands;
end=$(date +%s)
difference=$(( end - start))
echo Time taken to execute commands is $difference seconds.


##### 调试脚本：使用选项-x启用shell脚本的跟踪调试功能
-bash-4.2$ bash -x debug.sh # 运行带有-x选项的脚本可以打印出所执行的每一行命令以及当前状态
-bash-4.2$ cat debug.sh # 使用set -x和set +x对脚本进行部分调试
for i in {1..3}
do
 set -x 
 echo $i 
 set +x 
done 
echo "Script executed"


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
##### 可以用逻辑运算符替代if语句
[ condition ] && action # 如果condition为真，则执行action
[ condition ] || action # 如果condition为假，则执行action

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
##### 给循环生成值序列
### （1）使用{}：如for count in {1..50}、for count in {a..z} {A..Z}
-bash-4.2$ echo {a..z} {A..Z}
a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
### （2）使用seq命令。如for count in `seq 0 10`，相当于for i in {0..10}
-bash-4.2$ seq 0 3 # 生成0-3的数组
0
1
2
3
### （3）使用一般方法：如for((i=0;i<10;i++))

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
函数名 () {
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
sum $num # 使用函数名就可以调用函数
-bash-4.2$ . test.sh
The sum of 1+2+3...+10 is :55
### 函数也能像环境变量一样用export导出，如此一来，函数的作用域就可以扩展到子进程中
$> function getIP() { /sbin/ifconfig $1 | grep 'inet '; } 
$> echo "getIP eth0" >test.sh 
$> sh test.sh 
 sh: getIP: No such file or directory 
$> export -f getIP # 导出函数
$> sh test.sh 
 inet addr: 192.168.1.2 Bcast: 192.168.255.255 Mask:255.255.0.0

##### 特殊流程控制语句
### break语句：结束整个当前循环
### continue语句：结束本次循环
### exit语句：直接退出脚本

########## 将一个命令的输出发送给另一个命令（管道命令）
-bash-4.2$ ls | cat -n > out.txt # ls（列出当前目录内容）的输出被传给cat -n，后者为通过stdin所接收到的输入内容加上行号，然后将输出重定向到文件out.txt
-bash-4.2$ cat out.txt
     1	debug.sh
     2	err.txt
     3	mk_mlink.sh
-bash-4.2$ cmd_output=$(ls | cat -n) # 将命令序列的输出赋给变量（也可用``）
-bash-4.2$ echo $cmd_output
1 debug.sh 2 err.txt 3 mk_mlink.sh
##### 命令分组的方法：
### （1）利用子shell生成一个独立的进程：子shell本身就是独立的进程。可以使用()操作符来定义一个子shell
-bash-4.2$ (cd script; ls)
debug.sh  err.txt  mk_mlink.sh
### （2）通过引用子shell的方式保留空格和换行符
$ cat text.txt 
1 
2 
3 
$ out=$(cat text.txt) 
$ echo $out 
1 2 3 # 丢失了1、2、3中的\n 
$ out="$(cat text.txt)" # 引用子shell
$ echo $out 
1 
2 
3


##### 字段分隔符
-bash-4.2$ data="name,gender,rollno,location"
-bash-4.2$ oldIFS=$IFS # 保存默认分隔符
-bash-4.2$ IFS=, # 指定新的分隔符为,
-bash-4.2$ for item in $data;
> do
> echo Item:$item
> done
Item:name
Item:gender
Item:rollno
Item:location
-bash-4.2$ IFS=$oldIFS # 恢复默认分隔符