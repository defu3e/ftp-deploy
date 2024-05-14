# Подключение к FTP серверу используя WinSCP
Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"

# Параметры подключения к FTP-серверу
$ftpUrl = "192.168.1.1"
$ftpUsername = "username"
$ftpPassword = "password"
$remotePath = "/www/target-folder"

# Подключение к FTP серверу
$session = New-Object WinSCP.Session
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Ftp
    HostName = $ftpUrl
    UserName = $ftpUsername
    Password = $ftpPassword
}

# Новый билд
$localPath = "C:\Users\user\StudioProjects\myproject\build\web"

Write-Host "Connecting to server..."

try {
	# Connect
	$session.Open($sessionOptions)
	Write-Host "[OK] Connected successfully"
	
	# Переименование файла maintenance.html в index.html
	$session.MoveFile("$remotePath/maintenance.html", "$remotePath/index.html")
	Write-Host "[OK] Maintenance mode on`nRemoving old build..."
	
	# Удаление всех файлов, кроме index.html
	$directory = $session.ListDirectory("$remotePath/")
	foreach ($fileInfo in $directory.Files) {
		if ($fileInfo.Name -ne "index.html" -and $fileInfo.Name -ne "." -and $fileInfo.Name -ne ".."
		) {
			$session.RemoveFiles("$remotePath/$($fileInfo.Name)").Check()
		}
	}
	Write-Host "[OK] The old build was successfully removed`nUploading a new build..."
	
	# Копирование файлов с локальной папки на сервер
	$transferOptions = New-Object WinSCP.TransferOptions
	$transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
	$transferResult = $session.PutFiles("$localPath", "$remotePath", $False, $transferOptions)

	# Проверка результата загрузки
	$transferResult.Check()
	Write-Host "[OK] New build loaded successfully"
} catch {
	 Write-Host "Error: $($Error[0])"
}
finally {
	# Закрытие сессии
	$session.Dispose()
}


