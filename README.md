# ftp-deploy
Powershell-скрипт для загрузки файлов по ftp с использованием WinSCP

# Требования к установке
ОС Windows
Установленный WinSCP

# Что делает скрипт?
1) Подключается к удаленному серверу по FTP
2) На удаленном сервере включается режим обслуживания путем замены файла index.html на maintenance.html
3) Из целевого каталога на удаленном сервере удаляются все файлы, кроме index.html
4) Копирование всех файлов из каталога на локальном компьютере в целевой каталог на удаленном сервере

# Ярлык для запуска скрипта
Создать ярлык с командой:
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -noexit "& ""D:\my-app-deploy\deploy-script.ps1"""
