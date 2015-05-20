# Доменное имя WSUS сервера (константа).
$ServerWSUS = "DNS name of your WSUS server"
# Порт WSUS сервера (константа).
$PortNumber = "WSUS server port number"
# Получаем сервер WSUS как объект.
$wsus = Get-WsusServer -Name $ServerWSUS -PortNumber $PortNumber
# Получаем объектами компьютеры с ошибками установки обновлений.
$ComputerNameTarget = $wsus | Get-WsusComputer -IncludedInstallationStates Failed -ComputerUpdateStatus Failed
# Из объектов берем доменные имена.
$ComputerName = $ComputerNameTarget.FullDomainName
# Получение на вход конвеера файлов и папок БД обновлений на найденных рабочих станциях и, соответственно, удаление.
$Scriptblock = { Get-ChildItem -Path C:\Windows\SoftwareDistribution | Remove-Item -Recurse -Force }
Invoke-Command -Computer $ComputerName -ScriptBlock $Scriptblock