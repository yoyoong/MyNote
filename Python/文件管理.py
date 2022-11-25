########## 生成JSON文件
# 构造json数据
jsonString = []
jsonComponent = {}
jsonComponent["numTracks"] = numTracks
jsonString.append(jsonComponent)
jsonFileName = path + 'data.json' # JSON文件名
json.dump(jsonString, open(jsonFileName, 'w'), indent = 4)