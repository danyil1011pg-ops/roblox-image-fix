@echo off
chcp 65001 >nul
set "DOMAIN=tr.rbxcdn.com"
set "DNS_SERVER=9.9.9.9"

echo ===================================================
echo   ГОТОВЫЕ СТРОКИ ДЛЯ ВСТАВКИ В HOSTS
echo ===================================================
echo.
echo Скопируйте строки ниже и вставьте их в файл hosts:
echo ---------------------------------------------------

:: Запускаем nslookup и жестко фильтруем вывод, оставляя только валидные IPv4 (исключая IP самого DNS-сервера)
powershell -Command "$null, $null, @($lines = nslookup %DOMAIN% %DNS_SERVER% 2>$null); $lines | ForEach-Object { if ($_ -match '^\s*([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})') { $matches[1] } } | Where-Object { $_ -ne '%DNS_SERVER%' } | ForEach-Object { '{0} %DOMAIN%' -f $_.Trim() } | Select-Object -Unique"

echo ---------------------------------------------------
echo.
echo ИНСТРУКЦИЯ ДЛЯ WINDOWS:
echo 1. Откройте Блокнот от имени администратора.
echo 2. Откройте файл: C:\Windows\System32\drivers\etc\hosts
echo 3. Вставьте скопированные строки в самый конец.
echo 4. Сохраните (Ctrl + S) и в консоли выполните: ipconfig /flushdns
echo.
pause
