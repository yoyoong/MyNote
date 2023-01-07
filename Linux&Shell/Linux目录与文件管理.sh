##### 文件权限管理
### 设置文件权限，u指定用户权限，g指定用户组权限，o指定其他用户权限
chmod u=rwx g=rw o=r filename
chmod o+x filename # 为已经具有权限rwx rw- r-的文件添加可执行权限
### 权限也可以使用3位八进制数来表示，读、写和执行权限都有与之对应的唯一的八进制数：r=4，w=2，x=1
chmod 764 filename # 对应权限为rwx rw- r--
### chown命令：修改文件或目录的所有权
chown user:group filename
### 粘滞位：目录有一个叫作粘滞位（sticky bit）的特殊权限。如果目录设置了粘滞位，只有创建该目录的用户才能删除目录中的文件，就算用户组和其他用户也有写权限也无法删除。粘滞位出现在其他用户权限组中的执行权限（x）位置。它使用t或T来表示。如果没有设置执行权限，但设置了粘滞位，就使用T；如果同时设置了执行权限和粘滞位，就使用t。如------rwt、------rwT。设置目录粘滞位的一个典型例子就是/tmp，任何人都可以在该目录中创建文件，但只有文件的所有者才能删除其所创建的文件。
chmod a+t directory_name # 设置粘滞位
### 以递归方式设置文件权限
chmod -R 777 /home/linux
### 以不同的身份运行可执行文件（setuid）：一些可执行文件需要以另一种身份来运行。例如，http服务器会在系统启动期间由root负责运行，但是该进程应该属于用户httpd。setuid权限允许其他用户以文件所有者的身份来执行文件。首先将文件的所有权更改为需要执行该文件的用户，然后以该用户的身份登录。运行下面的命令，无论是谁发起调用，该文件都是以root用户的身份来执行
$ chmod +s executable_file 
# chown root:root executable_file 
# chmod +s executable_file 
$ ./executable_file

##### 压缩与解压
# 解压tar.bz2
tar -jxvf xxx.tar.*bz2*
# 解压tar.gz
tar -zxvf xxx.tar.gz
# 解压.zip.gz
gunzip xxx.zip.gz
# 解压.zip
unzip xxx.zip
# 查看gzip压缩的文件
zcat file.**.gz | head -n 10

##### 根据扩展名切分文件名
### 提取文件名：使用${VAR%.*}从$VAR中删除位于%右侧的通配符（如.*）所匹配的字符串，通配符从右向左进行匹配。
-bash-4.2$ filename="sum.txt.gz"
-bash-4.2$ name=${filename%%.*} # %属于非贪婪匹配，从右向左找出匹配通配符的最短结果。
-bash-4.2$ echo $name
sum
-bash-4.2$ name=${filename%.*} # %%是贪婪匹配，匹配符合通配符的最长结果
-bash-4.2$ echo $name
sum.txt
# 提取后缀名：使用${VAR#*.}从$VAR中删除位于#右侧的通配符（如*.）从左向右所匹配到的字符串。
-bash-4.2$ name=${filename#*.} # 非贪婪匹配
-bash-4.2$ echo $name
txt.gz
-bash-4.2$ name=${filename##*.} # 贪婪匹配
-bash-4.2$ echo $name
gz

##### 多个文件的重命名与移动
### 实例：利用find查找PNG和JPEG文件，然后使用##操作符和mv将查找到的文件重命名为image-1.EXT、image-2.EXT等
count=1; 
for img in `find . -iname '*.png' -o -iname '*.jpg' -type f -maxdepth 1` 
do 
 new=image-$count.${img##*.} 
 echo "Renaming $img to $new" 
 mv "$img" "$new" 
 let count++ 
done
### 常用重命名文件的方法
rename *.JPG *.jpg # 将*.JPG更名为*.jpg
rename 's/ /_/g' * # 将文件名中的空格替换成字符"_"
rename 'y/A-Z/a-z/' * # 转换文件名的大小写
find path -type f -name "*.mp3" -exec mv {} target_dir \ # 将所有的.mp3文件移入给定的目录
find path -type f -exec rename 's/ /_/g' {} \ # 以递归的方式将所有文件名中的空格替换为字符"_"


##### 检查目录以及其中的文件与子目录
### 生成目录的树状视图
-bash-4.2$ find . -exec sh -c 'echo -n {} | tr -d "[:alnum:]_.\-" |  tr "/" " "; basename {}' \;
.
 region.txt
 Run_RNAseq_STAR.py
 mk_mlink.sh
 stderr.txt
### 生成文件及子目录的汇总信息
-bash-4.2$ for d in `find . -type d`;
> do
> echo `find $d -type f | wc -l` files in $d;
> done
15 files in .


##### 分割文件与数据：split命令可以用来分割文件。该命令接受文件名作为参数，然后创建出一系列体积更小的文件，其中依据字母序排在首位的那个文件对应于原始文件的第一部分，排在次位的文件对应于原始文件的第二部分，以此类推。
$ split -b 10k data.file # 将100KB的文件分成一系列10KB的小文件
$ ls 
data.file xaa xab xac xad xae xaf xag xah xai xaj
# 在split命令中，除了k（KB），我们还可以使用M（MB）、G（GB）、c（byte）和w（word）。
# split默认使用字母后缀。如果想使用数字后缀，需要使用-d选项。此外，-a length可以指定后缀长度
$ split -b 10k data.file -d -a 4 
$ ls 
data.file x0009 x0019 x0029 x0039 x0049 x0059 x0069 x0079
### 为分割后的文件指定文件名前缀：默认分割后的文件名都是以x作为前缀，可以通过提供一个前缀作为最后一个参数为分割后的文件指定文件名前缀
$ split -b 10k data.file -d -a 4 split_file 
$ ls 
data.file split_file0002 split_file0005 split_file0008
split_file0000 split_file0003 split_file0006 split_file0009 
split_file0001 split_file0004 split_file0007
### 根据行数来分割文件：使用 -l（no_of_lines）
$ split -l 10 data.file # 分割成多个文件，每个文件包含10行
##### csplit命令能够基于上下文来分隔文件。它依据的是行计数或正则表达式。这个命令对于日志文件分割尤为有用。
$ cat server.log # 日志实例
SERVER-1 
[connection] 192.168.0.1 success 
[connection] 192.168.0.2 failed 
[disconnect] 192.168.0.3 pending 
[connection] 192.168.0.4 success 
SERVER-2 
[connection] 192.168.0.1 failed 
[connection] 192.168.0.2 failed 
[disconnect] 192.168.0.3 success 
[connection] 192.168.0.4 failed 
SERVER-3 
[connection] 192.168.0.1 pending 
[connection] 192.168.0.2 pending 
[disconnect] 192.168.0.3 pending 
[connection] 192.168.0.4 failed
$ csplit server.log /SERVER/ -n 2 -s {*} -f server -b "%02d.log" 
$ rm server00.log # 分割后得到的第一个文件没有任何内容（匹配的单词就位于文件的第一行中），所以删除server00.log
$ ls 
server01.log server02.log server03.log server.log
### 上述命令的详细说明：
# /SERVER/：用来匹配特定行，分割过程即从此处开始。
# /[REGEX]/：用于描述文本模式。它从当前行（第一行）一直复制到（但不包括）包含SERVER的匹配行。
# {*}：表示根据匹配重复执行分割操作，直到文件末尾为止。可以用{整数}的形式来指定分割执行的次数。
# -s：使命令进入静默模式，不打印其他信息。
# -n：指定分割后的文件名后缀的数字个数，例如01、02、03等。
# -f：指定分割后的文件名前缀（在上面的例子中，server就是前缀）。
# -b：指定后缀格式。例如%02d.log，类似于C语言中printf的参数格式。在这里：文件名 = 前缀 + 后缀，也就是server + %02d.log。


##### 校验和与核实：校验和（checksum）程序用来从文件中生成相对较小的唯一密钥。我们可以重新计算该密钥，用以检查文件是否发生改变。通过比对下载文件和原始文件的校验和，就能够核实接收到的文件是否正确。如果源位置上的原始文件的校验和与目的地上接收文件的校验和相等，就意味着我们接收到的文件没有问题。Unix和Linux支持多种校验和程序，但强健性最好且使用最为广泛的校验和算法是MD5和SHA-1。md5sum和sha1sum程序可以对数据应用对应的算法来生成校验和。
-bash-4.2$ md5sum test.sh temp.txt # 计算md5sum
4d29f1e430addcafed5a53c0ef8a125b  test.sh
8085003714535bc003d0242586a5f0a9  temp.txt
-bash-4.2$ sha1sum test.sh temp.txt # 计算sha1sum
1c857421d5a85207e3520e94eb627f3e120155c1  test.sh
080514cb63e951b48ffe68bc5f7f2b6d365b2b03  temp.txt
-bash-4.2$ md5sum test.sh > test.md5 # 可以将输出的校验和重定向到一个文件中，以备后用
-bash-4.2$ md5sum -c test.md5 # 用生成的文件核实数据完整性
test.sh: OK
-bash-4.2$ vim test.sh
-bash-4.2$ md5sum -c test.md5 # 源文件已修改，校验不通过
test.sh: FAILED
md5sum: WARNING: 1 computed checksum did NOT match
### 对目录进行校验：校验和是从文件中计算得来的。对目录计算校验和意味着需要对目录中的所有文件以递归的方式进行计算。md5deep或sha1deep命令可以遍历目录树，计算其中所有文件的校验和（系统不一定有，需要安装），-r选项允许md5deep递归遍历子目录。-l选项允许显示相对路径径，不再使用默认的绝对路径。或者也可以结合find来递归计算校验和：find directory_path -type f –print0 | xargs -0 md5sum >> directory.md5

##### 加密工具与散列：加密技术主要用于防止数据遭受未经授权的访问。与校验和算法不同，加密算法可以无损地重构原始数据，可用的加密算法包括crypt、gpg和base64等
### crypt命令通常并没有安装在Linux系统中。该命令从stdin接受输入，要求用户创建口令，然后将加密数据输出到stdout
$ crypt <input_file >output_file 
Enter passphrase: 
$ crypt PASSPHRASE <input_file >encrypted_file # 在命令行上提供口令
$ crypt PASSPHRASE -d <encrypted_file >output_file # 解密文件
### gpg（GNU privacy guard）是一种应用广泛的工具，它使用加密技术来保护文件，以确保数据在送达目的地之前无法被读取
$ gpg -c filename # 用gpg加密文件，命令会采用交互方式读取口令并生成filename.gpg
$ gpg filename.gpg # 解密gpg文件
### Base64是一组相似的编码方案，它将二进制数据转换成以64为基数的形式（radix-64 representation），以可读的ASCII字符串进行描述。这类编码程序可用于通过E-mail传输二进制数据。base64命令能够编码/解码Base64字符串。
$ base64 filename > outputfile # 将文件编码为Base64格式，或者cat file | base64 > outputfile 
$ base64 -d file > outputfile # 解码Base64数据，或者cat base64_file | base64 -d > outputfile

##### 临时文件：mktemp命令可以为临时文件或目录创建唯一的名字
-bash-4.2$ mktemp #  创建临时文件
/tmp/tmp.yEoUPWwEZw
-bash-4.2$ mktemp -d # 创建临时目录
/tmp/tmp.hEthBMVYC1
-bash-4.2$ mktemp tmp.XXXXXX # 基于模板创建临时文件名，X会被随机的字符（字母或数字）替换
tmp.ZsS5Ds

##### 生成任意大小的文件：dd命令可克隆给定的输入内容，然后将一样的副本写入到输出。stdin、设备文件、普通文件等都可作为输入，stdout、设备文件、普通文件等也可作为输出
-bash-4.2$ ll
total 1000
-rw-r--r-- 1 hongyuyang bioinformatics   3955 Nov  8 15:23 region.txt
-bash-4.2$ dd if=region.txt of=dd.txt bs=1K count=1 # if表示输入文件，of表示输出文件，bs指定了以字节为单位的块大小，count表示需要被复制的块数
1+0 records in
1+0 records out
1024 bytes (1.0 kB) copied, 0.0204683 s, 50.0 kB/s
-bash-4.2$ ll
total 1001
-rw-r--r-- 1 hongyuyang bioinformatics   1024 Jan  7 20:37 dd.txt
-rw-r--r-- 1 hongyuyang bioinformatics   3955 Nov  8 15:23 region.txt
# 如果不指定输入参数（if），dd会从stdin中读取输入。如果不指定输出参数（of），则dd会使用stdout作为输出

##### 文本文件的交集与差集：comm命令可用于比较两个已排序的文件。它可以显示第一个文件和第二个文件所独有的行以及这两个文件所共有的行。该命令有一些选项可以禁止显示指定的列，以便于执行交集和求差操作
-bash-4.2$ cat comm1.txt
one
two
three
-bash-4.2$ cat comm2.txt
one
two
four
-bash-4.2$ sort comm1.txt -o comm1.txt; sort comm2.txt -o comm2.txt # 对文件进行排序
-bash-4.2$ comm comm1.txt comm2.txt # 不带任何选项的comm
	four
		one
three
		two
# 第一列包含只在comm1.txt中出现的行，第二列包含只在comm2.txt中出现的行，第三列包含A.txt和B.txt中共有的行。各列之间以制表符（\t）作为分隔符
-bash-4.2$ comm comm1.txt comm2.txt -1 -2 # 删除前两列，只打印出第三列，获得两个文件的交集
one
two
-bash-4.2$ comm comm1.txt comm2.txt -3 # 删除第三列，获得两个文件中互不相同的那些行
	four
three
-bash-4.2$ comm comm1.txt comm2.txt -3 | tr -d '\t' # 使用tr删除制表符来合并两列
four
three
-bash-4.2$ comm comm1.txt comm2.txt -2 -3 # 获得comm1.txt的差集
three
-bash-4.2$ comm comm1.txt comm2.txt -1 -3 # 获得comm2.txt的差集
four
