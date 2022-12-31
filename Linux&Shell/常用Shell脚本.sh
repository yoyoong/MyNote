# 获取服务器IP地址
/sbin/ifconfig $1 | grep 'inet '

# 去除win编辑脚本时行末的^M
cat -v aa.txt | tr -d '^M'  > res.txt

# 简化添加环境变量操作（可在.bashrc文件中定义如下函数）
prepend() { [ -d "$2" ] && eval $1=\"$2\$\{$1:+':'\$$1\}\" && export $1 ; }
# 使用方法如下：
prepend PATH /opt/myapp/bin