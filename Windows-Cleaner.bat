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
echo 4. Empty Recycle Bin
echo 5. Empty Download folder
echo 6. Flush DNS Cache
echo 7. Activate Ultimate Performance Power Plan
echo 8. Clear Microsoft Store Cache
echo 9. Clear Thumbnail Cache
echo 10. Clear Windows Update Cache
echo 11. Restore Power Plan
echo ========================================
echo For Expert Users
echo ========================================
echo 12. Disable services SysMain and Bits
echo 13. Stop Superfetch (only windows 10)
echo 14. Repair Windows System
echo 15. Exit
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
if "%choice%"=="4" goto empty_recycle_bin
if "%choice%"=="5" goto empty_download_folder
if "%choice%"=="6" goto flush_dns
if "%choice%"=="7" goto activate_ultimate_performance
if "%choice%"=="8" goto clear_microsoft_store_cache
if "%choice%"=="9" goto clear_thumbnail_cache
if "%choice%"=="10" goto clear_windows_update_cache
if "%choice%"=="11" goto restore_power_plan
if "%choice%"=="12" goto disable_services_sysmain_bits
if "%choice%"=="13" goto stop_superfetch
if "%choice%"=="14" goto repair_windows_system
if "%choice%"=="15" goto exit_program

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
echo Resetting IPv4 DNS to DHCP for all interfaces...
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
for /d %%i in (*) do (
    rd "%%i" 2>nul
)
echo Emptying complete.
timeout /t 3 >nul
set choice=
goto menu

:clear_microsoft_store_cache
echo Clearing Microsoft Store Cache...
WSReset.exe
echo Cache cleared successfully.
timeout /t 3 >nul
set choice=
goto menu

:clear_thumbnail_cache
echo Clearing Thumbnail Cache...
del /s /q "%LocalAppData%\Microsoft\Windows\Explorer\*.db"
echo Thumbnail Cache cleared.
timeout /t 3 >nul
set choice=
goto menu

:clear_windows_update_cache
echo Clearing Windows Update Cache...
net stop wuauserv
cd /d %Windir%\SoftwareDistribution
echo Cache cleared.
net start wuauserv 
timeout /t 3 >nul
set choice=
goto menu

:restore_power_plan
echo Restoring Power Plan...
powercfg -restoredefaultschemes
echo Power Plan restored.
timeout /t 3 >nul
set choice=
goto menu

:disable_services_sysmain_bits
echo Disabling services SysMain and Bits...
sc stop bits
sc config bits start=disabled
sc stop SysMain
sc config SysMain start=disabled
echo Services disabled successfully.
timeout /t 5 >nul
set choice=
goto menu

:stop_superfetch
echo Stopping Superfetch...
net.exe stop Superfetch
echo Superfetch stopped successfully.
timeout /t 3 >nul
set choice=
goto menu

:repair_windows_system
echo Repairing Windows System...
sfc /scannow
echo SFC scan complete.
echo Repairing Windows System...
DISM /Online /Cleanup-Image /RestoreHealth
echo DISM Repairing Windows System...
echo DISM Repair complete...
echo Repair complete.
timeout /t 5 >nul
set choice=
goto menu

:exit_program
echo Thank you for using the program! Exiting the program.

:: Show notification using PowerShell for both Windows versions
powershell -Command "[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null; [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null; $xml = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText01); $text = $xml.CreateTextNode('Thank you for using the program!'); $xml.GetElementsByTagName('text').AppendChild($text); $toast = [Windows.UI.Notifications.ToastNotification]::new($xml); [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Temporary Cleaning Program').Show($toast);"

exit /B
