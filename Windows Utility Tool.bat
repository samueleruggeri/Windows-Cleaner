@echo off
:: Check for administrator privileges
NET SESSION >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%0' -Verb RunAs"
    exit /B
)

:menu
cls
echo ========================================
echo Temporary Cleaning Program
echo ========================================
echo 1. Clean user's temporary folder
echo 2. Clean Windows Prefetch folder
echo 3. Clean Windows temporary folder
echo 4. Flush DNS (Network with name "Ethernet")
echo 5. Activate Ultimate Performance Power Plan
echo 6. Empty Recycle Bin
echo 7. Empty Download folder
echo 8. Exit
echo.

set /p choice="Enter the number of the desired option: "

:: Add check if the variable %choice% is a number
for /f "tokens=1-9" %%a in ("%choice%") do set isNumber=%%a
if not defined isNumber (
    echo Enter a valid choice.
    pause
    goto menu
)

if "%choice%"=="1" goto clean_user_temp
if "%choice%"=="2" goto clean_prefetch
if "%choice%"=="3" goto clean_windows_temp
if "%choice%"=="4" goto flush_dns
if "%choice%"=="5" goto activate_ultimate_performance
if "%choice%"=="6" goto empty_recycle_bin
if "%choice%"=="7" goto empty_download_folder
if "%choice%"=="8" goto exit_program

:: Add handling for invalid choices
echo Enter a valid choice.
pause
goto menu

:clean_user_temp
echo Cleaning user's temporary folder...
cd /d C:\Users\%USERNAME%\AppData\Local\Temp
for /D %%i in (*) do rd /s /q "%%i"
del /q /f /s *
echo Cleaning complete.
timeout /t 3 >nul
set choice=
goto menu

:clean_prefetch
echo Cleaning Windows Prefetch folder...
cd /d C:\Windows\Prefetch
del /q /f /s *
echo Cleaning complete.
timeout /t 3 >nul
set choice=
goto menu

:clean_windows_temp
echo Cleaning Windows temporary folder...
cd /d C:\Windows\Temp
del /q /f /s *
echo Cleaning complete.
timeout /t 3 >nul
set choice=
goto menu

:flush_dns
echo Flushing DNS...
ipconfig /flushdns
netsh interface ip delete arpcache
netsh winsock reset
echo Resetting IPv4 DNS to DHCP for all interfaces...
for /f "tokens=2 delims=: " %%a in ('ipconfig ^| find "Ethernet"') do (
    netsh interface ip set dns name="%%a" source=dhcp
)
echo Flushing complete.
timeout /t 3 >nul
set choice=
goto menu

:activate_ultimate_performance
echo Activating Ultimate Performance Power Plan...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo Activation complete.
timeout /t 3 >nul
set choice=
goto menu

:empty_recycle_bin
echo Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin
echo Emptying complete.
timeout /t 3 >nul
set choice=
goto menu

:empty_download_folder
echo Emptying Download folder...
cd /d C:\Users\%USERNAME%\Downloads
del /q /f /s *
echo Emptying complete.
timeout /t 3 >nul
set choice=
goto menu

:exit_program
echo Thank you for using the program! Exiting the program.

:: Show notification using PowerShell for both Windows versions
powershell -Command "[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null; [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null; $xml = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText01); $text = $xml.CreateTextNode('Thank you for using the program!'); $xml.GetElementsByTagName('text').AppendChild($text); $toast = [Windows.UI.Notifications.ToastNotification]::new($xml); [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Temporary Cleaning Program').Show($toast);"

exit /B