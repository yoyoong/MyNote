# 克隆远程版本库到本地
git clone https://github.com/yoyoong/mHapDx /sibcb2/bioinformatics2/hongyuyang/code/mHapDx

# 将master分支合并到main分支
git switch main # 切换到main分支
git merge --no-ff master # 将master分支合并到main分支上
git commit -m "合并master" # 提供commit
git push # 推送到远程main分支
git push -d origin master # 删除远程分支