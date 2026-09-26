# 脚本开始处添加
[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[System.Console]::InputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

# 或者针对特定cmdlet
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$PSDefaultParameterValues['Get-Content:Encoding'] = 'utf8'


# 配置模板
$mainconfig= "D:\Software\VPN\Singbox_Gui\GUI.for.SingBox-windows-amd64\data\subscribes\mainconfig.json"

$data1 = "D:\Software\VPN\Singbox_Gui\GUI.for.SingBox-windows-amd64\data\subscribes\ID_nin5mo9a.json"

$data2 = "D:\Software\VPN\Singbox_Gui\GUI.for.SingBox-windows-amd64\data\subscribes\ID_uswy6aw9.json"
try {
    # 读取 JSON 内容
    Write-Host "get the configuration file template -1 ...."
    $mainJsonRaw = [System.IO.File]::ReadAllText($data1, [System.Text.Encoding]::UTF8)
    $configRaw1 = [System.IO.File]::ReadAllText($mainconfig, [System.Text.Encoding]::UTF8)

     Write-Host "get the configuration file template -2 ...."
    $mainJsonRaw2 = [System.IO.File]::ReadAllText($data2, [System.Text.Encoding]::UTF8)
    $configRaw2 = [System.IO.File]::ReadAllText($mainconfig, [System.Text.Encoding]::UTF8)
}
catch {
    Write-Host "failed to read the configuration file: $($_.Exception.Message)"
}
try {
    # 转换为 JSON 对象
    $mainJson1 = $mainJsonRaw | ConvertFrom-Json -ErrorAction Stop
    $configJson1 = $configRaw1 | ConvertFrom-Json -ErrorAction Stop
    #转换为 JSON 对象  2
    $mainJson2 = $mainJsonRaw2 | ConvertFrom-Json -ErrorAction Stop
    $configJson2 = $configRaw2| ConvertFrom-Json -ErrorAction Stop
}
catch {
    Write-Host "failed to parse the file. please check try agin : $($_.Exception.Message)"
}

$subsnode1 = $mainJson | Where-Object{
     $_.tag
}| Select-Object -ExpandProperty tag

# 添加 selector

$select = [PSCustomObject]@{
    type = "selector"
    tag = "select"
    outbounds = @("direct") + @($subsnode1)
    interrupt_exist_connections = $true
}

$direct = [PSCustomObject]@{
    type = "direct"
    tag = "direct"
}

$configJson1.outbounds = @($select) +@($direct) + @($mainJson1)

$configJson1 | ConvertTo-Json -Depth 100  | Out-File "D:\Software\VPN\Singbox_Gui\GUI.for.SingBox-windows-amd64\data\subscribes\subscribesmerged_formatted4.json" -Encoding utf8
Write-Host "excute over -1"


# sub2 ==================================
$subsnode2 = $mainJson2 | Where-Object{
     $_.tag
}| Select-Object -ExpandProperty tag

# 添加 selector

$select = [PSCustomObject]@{
    type = "selector"
    tag = "select"
    outbounds = @("direct") + @($subsnode2)
    interrupt_exist_connections = $true
}

$direct = [PSCustomObject]@{
    type = "direct"
    tag = "direct"
}

$configJson2.outbounds = @($select) +@($direct) + @($mainJson2)

$configJson2 | ConvertTo-Json -Depth 100  | Out-File "D:\Software\VPN\Singbox_Gui\GUI.for.SingBox-windows-amd64\data\subscribes\subscribesmerged_formatted5.json" -Encoding utf8
Write-Host "excute over -2"
