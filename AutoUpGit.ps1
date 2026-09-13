# ===== 可自定义部分 =====
$CommitMsg = "auto update: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$Branch = "main"
# =======================

Write-Host "===== 1. 查看当前文件状态 =====" -ForegroundColor Cyan
git status

Write-Host "`n===== 2. 添加所有改动 =====" -ForegroundColor Cyan
git add -A

Write-Host "`n===== 3. 提交 =====" -ForegroundColor Cyan
git commit -m $CommitMsg

Write-Host "`n===== 4. 推送到远程 =====" -ForegroundColor Cyan
git push origin $Branch

Write-Host "`n===== 完成 =====" -ForegroundColor Green