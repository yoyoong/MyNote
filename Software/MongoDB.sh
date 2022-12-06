# 启动MongoDB数据库
./mongod --config /sibcb1/bioinformatics/hongyuyang/mongodb/etc/mongodb.conf

## 关闭MongoDB数据库
# 获取MongoDB的进程pid
pgrep mong
# 杀死进程
kill -15 pid
