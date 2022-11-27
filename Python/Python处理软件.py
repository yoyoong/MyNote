######################################################################################## 操作WPS ########################################################################################################
##### 操作ppt
# 进入ppt处理进程
wpsPPT = win32.gencache.EnsureDispatch("kwpp.Application")
wpsPPT.Visible = 1
# 新建ppt文件
mergedFile = wpsPPT.Presentations.Add()
# 打开一个文件
nextFile = wpsPPT.Presentations.Open(abs_path)
# 获取文件的页数
page_num = nextFile.Slides.Count
# 关闭打开的文件
nextFile.Close()
# 在文件后面插入另外一个文件
mergedFile.Slides.InsertFromFile(abs_path, mergedFile.Slides.Count, 1, page_num)

##### 操作word
# 进入word处理进程
wpsWORD = win32.gencache.EnsureDispatch("kwps.Application")
wpsWORD.Visible = 1
# 新建ppt文件
mergedFile = wpsWORD.Documents.Add()
# 在文件后面插入另外一个文件
mergedFile.Application.Selection.InsertFile(abs_path)
# 在文件后面插入分页符
mergedFile.Application.Selection.InsertBreak(win32.constants.wdPageBreak)

### 文件另存为
file.SaveAs(fileName + r'.pptx')
### 退出wps
wpsPPT.Quit()
#########################################################################################################################################################################################################