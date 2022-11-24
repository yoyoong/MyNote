##### 允许其他电脑连接mysql数据库
mysql -u root -p # 登录数据库
use mysql;
update user set host = ‘%’ where user = ‘root’; # %表示所有地址都可访问
FLUSH PRIVILEGES # 重启MySQL