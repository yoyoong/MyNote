############################################################ 使用pymysql链接MySQL数据库 ##############################################################
##### 连接数据库，并创建一个游标对象
db = pymysql.connect(host='localhost', user='root', password='hongyuyang090402', database='mHapBrowser')
cursor = db.cursor()
# 执行sql增删查改
sql = 'select * from ' + genome
cursor.execute(sql)
# 获取所有表名
cursor.execute('SHOW TABLES')
tableNames = cursor.fetchall()
# 获取列名
cursor.execute('show columns from ' + genome)
columns = cursor.fetchall()
# 关闭数据库连接
db.close()
######################################################################################################################################################