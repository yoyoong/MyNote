##### 常用路径操作、进程管理、环境参数配置等：os库
# 创建新路径（需先判断路径是否存在）
if not os.path.exists(path):
    os.mkdir(path)
# 获取路径下得所有文件/文件夹
paths = os.listdir(dir)