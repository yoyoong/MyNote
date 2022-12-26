# 去除win编辑脚本时行末的^M
cat -v aa.txt | tr -d '^M'  > res.txt