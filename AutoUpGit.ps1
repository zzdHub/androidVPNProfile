# ===== 可自定义部分 =====
$CommitMsg = "auto update: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
# =======================

Write-Host "===== 1. git status =====" -ForegroundColor Cyan
git status

Write-Host "`n===== 2. git add . =====" -ForegroundColor Cyan
git add .

Write-Host "`n===== 3. commit  =====" -ForegroundColor Cyan
git commit -m $CommitMsg

Write-Host "`n===== 4. push =====" -ForegroundColor Cyan
git push 
Write-Host "`n===== 5.complate =====" -ForegroundColor Green