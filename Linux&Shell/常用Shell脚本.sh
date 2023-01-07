# 获取服务器IP地址
/sbin/ifconfig $1 | grep 'inet '

# 去除win编辑脚本时行末的^M
cat -v aa.txt | tr -d '^M'  > res.txt

# 简化添加环境变量操作（可在.bashrc文件中定义如下函数）
prepend() { [ -d "$2" ] && eval $1=\"$2\$\{$1:+':'\$$1\}\" && export $1 ; }
# 使用方法如下：
prepend PATH /opt/myapp/bin

### 查找并删除重复文件：内容相同的文件自然会生成相同的校验和，通过比较文件内容来识别重复文件
# ls -lS对当前目录下的所有文件按照文件大小进行排序并列出文件的详细信息。--time-style=long-iso依照ISO格式打印日期。awk读取ls -lS的输出，对行列进行比较，找出重复文件
# awk的BEGIN{}语句块使用getline读取文件列表的第一行并存储文件名和大小分别对应第8列和第5列
# awk的{}语句块后依次读取余下的行（一次一行），将从当前行中得到的文件大小与之前存储在变量size中的值进行比较。如果相等，那就意味着两个文件至少在大小上是相同的，必须再用md5sum做进一步的检查。接着将文件的md5校验和分别保存在变量csum1和csum2中。变量name1和name2保存文件列表中相邻两个文件的文件名。如果两个文件的校验和相同，那它们肯定是重复文件，其文件名会被打印出来
ls -lS --time-style=long-iso | awk 'BEGIN { 
 getline; getline; 
 name1=$8; size=$5 
} 
{ 
 name2=$8; 
 if (size==$5)
 { 
 "md5sum "name1 | getline; csum1=$1; 
 "md5sum "name2 | getline; csum2=$1; 
 if ( csum1==csum2 ) 
 { 
 print name1; print name2 
 } 
}; 
size=$5; name1=name2; 
}' | sort -u > duplicate_files 
# 我们需要从每组重复文件中找出一个文件，这样就可以删除其他副本了。计算重复文件的md5sum值并从每一组重复文件中打印出其中一个。这是通过用-w 32比较每一行的md5sum输出中的前32个字符（md5sum的输出通常由32个字符的散列值和文件名组成）来找出那些不相同的行（也就是不重复的文件）。这样，每组重复文件中的一个采样就被写入unique_files文件。
# 然后需要将duplicate_files中列出的、未包含在unique_files之内的文件全部删除。可以使用comm命令的差集操作来实现
cat duplicate_files | xargs -I {} md5sum {} | \ 
sort | uniq -w 32 | awk '{ print $2 }' | \ 
sort -u > unique_files 
echo Removing.. 
comm duplicate_files unique_files -3 | tee /dev/stderr | \ # tee可以将文件名传给rm命令并输出。tee可以将输出发送至stdout和另一个文件中
xargs rm 
echo Removed duplicates files successfully.
