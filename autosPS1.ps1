# 脚本开始处添加
[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[System.Console]::InputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

# 或者针对特定cmdlet
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$PSDefaultParameterValues['Get-Content:Encoding'] = 'utf8'


# 配置模板
$mainconfig= "D:\Software\VPN\Singbox_Gui\GUI.for.SingBox-windows-amd64\data\subscribes\mainconfig.json"

$testaaa = "D:\Software\VPN\Singbox_Gui\GUI.for.SingBox-windows-amd64\data\subscribes\ID_nin5mo9a.json"
try {
    # 读取 JSON 内容
    Write-Host "get the configuration file templates ...."
    $mainJsonRaw = [System.IO.File]::ReadAllText($testaaa, [System.Text.Encoding]::UTF8)
    $configRaw = [System.IO.File]::ReadAllText($mainconfig, [System.Text.Encoding]::UTF8)
}
catch {
    Write-Host "failed to read the configuration file: $($_.Exception.Message)"
}
try {
    # 转换为 JSON 对象
    $mainJson = $mainJsonRaw | ConvertFrom-Json -ErrorAction Stop
    $configJson = $configRaw | ConvertFrom-Json -ErrorAction Stop
}
catch {
    Write-Host "failed to parse the file. please check try agin : $($_.Exception.Message)"
}

Write-Host "printf json"$mainJson

$subsnode = $mainJson | Where-Object{
     $_.tag
}| Select-Object -ExpandProperty tag

# 添加 selector

$select = [PSCustomObject]@{
    type = "selector"
    tag = "select"
    outbounds = @("direct") + @($subsnode)
    interrupt_exist_connections = $true
}

$direct = [PSCustomObject]@{
    type = "direct"
    tag = "direct"
}

$configJson.outbounds = @($select) +@($direct) + @($mainJson)

$configJson | ConvertTo-Json -Depth 100 -Indent 4 | Out-File "D:\Software\VPN\Singbox_Gui\GUI.for.SingBox-windows-amd64\data\subscribes\subscribesmerged_formatted4.json" -Encoding utf8
Write-Host "excute over!!!"