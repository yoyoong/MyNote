##### 利用并行进程加速命令执行
### 实例：运行md5sum的多个实例
PIDARRAY=() 
for file in File1.iso File2.iso 
do
 md5sum $file & # &是Bash的操作符，它使得shell将命令置于后台并继续执行脚本
 PIDARRAY+=("$!") # 获得进程的PID，在Bash中，$!保存着最近一个后台进程的PID，将这些PID放入数组
done 
wait ${PIDARRAY[@]} # 等待这些进程结束（避免着一旦循环结束，脚本就会退出，而md5sum进程仍在后台运行）
### GNU parallel命令：当计算量很大时，需要parallel命令优化资源使用，避免系统超载
# parallel命令从stdin中读取文件列表，使用类似于find命令的-exec选项来处理这些文件。符号{}代表被处理的文件，符号{.}代表无后缀的文件名。
ls *jpg | parallel convert {} -geometry 50x50 {.}Small.jpg # 使用Imagemagick的convert程序来为目录中的所有图像创建新的缩放版本

