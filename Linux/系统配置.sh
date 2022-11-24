# 将可执行文件配置到环境变量PATH中：export path=PATH，如export PATH=/usr/local/mongodb/bin:PATH

# 删除环境变量：重新赋值即可，如当前PATH为路径1:路径2:路径3，删除路径2，只需export PATH=路径1:路径3

# 设置当前用户环境变量
vi .bash_profile
vi ~/.bashrc
# 使环境变量生效
source .bash_profile

# 从bash节点到submit节点
source .profile