while IFS= read -r line # 逐行读取test文件
do
frontCol=`echo "$line" | awk '{print $1"\t"$2"\t"$3"}'` # 提取每行的第1列到第3列
splitCol=`echo "$line" | awk '{print $4}' | tr "," "\n"` # 提取每行的第4列并转为多行
num=`echo "$splitCol" | wc | awk '{print $1}'` # 统计splitCol变量共有多少行
multiLine=`for (( c=1; c<=num; c++)) ; do echo "$frontCol" ; done` # 重复打印frontCol变量num次
echo "$multiLine" >> frontColFile 
echo "$splitCol" >> splitColFile
done < test.bed
paste frontColFile splitColFile > result # 合并