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
echo 1. Clean user's temporary folder (%temp%)
echo 2. Clean Windows Prefetch folder (C:\Windows\Temp)
echo 3. Clean Windows temporary folder (C:\Windows\Prefetch)
echo 4. Empty Download folder
echo 5. Empty Recycle Bin
echo 6. Flush DNS Cache
echo 7. Restore Power Plan
echo 8. Activate Ultimate Performance Power Plan
echo 9. Clear Microsoft Store Cache
echo 10. Clear Windows Update Cache
echo 11. Clear Thumbnail Cache
echo 12. Repair Windows System
echo 13. Exit
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
if "%choice%"=="4" goto empty_download_folder
if "%choice%"=="5" goto empty_recycle_bin
if "%choice%"=="6" goto flush_dns
if "%choice%"=="7" goto restore_power_plan
if "%choice%"=="8" goto activate_ultimate_performance
if "%choice%"=="9" goto clear_microsoft_store_cache
if "%choice%"=="10" goto clear_windows_update_cache
if "%choice%"=="11" goto clear_thumbnail_cache
if "%choice%"=="12" goto repair_windows_system
if "%choice%"=="13" goto exit_program

:: Add handling for invalid choices
echo Enter a valid choice.
pause
goto menu

:clean_user_temp
echo Cleaning user's temporary folder...
cd /d C:\Users\%USERNAME%\AppData\Local\Temp
echo Cleaning user's temporary folder... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
for /F "delims=" %%i in ('dir /B /S /A:-D *') do (
    echo Deleted file: %%i >> "%USERPROFILE%\Desktop\program_logs.log"
    del /q /f "%%i"
)
echo Cleaning complete.
timeout /t 3 >nul
set choice=
goto menu

:clean_prefetch
echo Cleaning Windows Prefetch folder...
cd /d C:\Windows\Prefetch
echo Cleaning Windows Prefetch folder... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
for /F "delims=" %%i in ('dir /B /S /A:-D *') do (
    echo Deleted file: %%i >> "%USERPROFILE%\Desktop\program_logs.log"
    del /q /f "%%i"
)
echo Cleaning complete.
timeout /t 3 >nul
set choice=
goto menu

:clean_windows_temp
echo Cleaning Windows temporary folder...
cd /d C:\Windows\Temp
echo Cleaning Windows temporary folder... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
for /F "delims=" %%i in ('dir /B /S /A:-D *') do (
    echo Deleted file: %%i >> "%USERPROFILE%\Desktop\program_logs.log"
    del /q /f "%%i"
)
echo Cleaning complete.
timeout /t 3 >nul
set choice=
goto menu

:flush_dns
echo Flushing DNS...
ipconfig /flushdns
echo Flushing DNS... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
echo Flushing complete.
timeout /t 3 >nul
set choice=
goto menu

:activate_ultimate_performance
echo Activating Ultimate Performance Power Plan...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo Activating Ultimate Performance Power Plan... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
echo Activation complete.
timeout /t 3 >nul
set choice=
goto menu

:restore_power_plan
echo Restoring Power Plan...
powercfg -restoredefaultschemes
echo Restoring Power Plan... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
echo Power Plan restored.
timeout /t 3 >nul
set choice=
goto menu

:clear_microsoft_store_cache
echo Clearing Microsoft Store Cache...
WSReset.exe
echo Clearing Microsoft Store Cache... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
echo Cache cleared.
timeout /t 3 >nul
set choice=
goto menu

:clear_windows_update_cache
echo Clearing Windows Update Cache...
net stop wuauserv
cd /d %Windir%\SoftwareDistribution
echo Clearing Windows Update Cache... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
for /F "delims=" %%i in ('dir /B /S /A:-D *') do (
    echo Deleted file: %%i >> "%USERPROFILE%\Desktop\program_logs.log"
    del /q /f "%%i"
)
echo Cache cleared.
net start wuauserv 
timeout /t 3 >nul
set choice=
goto menu

:empty_recycle_bin
echo Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin
echo Emptying Recycle Bin... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
echo Emptying complete.
timeout /t 3 >nul
set choice=
goto menu

:clear_thumbnail_cache
echo Clearing Thumbnail Cache...
del /s /q "%LocalAppData%\Microsoft\Windows\Explorer\*.db"
echo Clearing Thumbnail Cache... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
echo Thumbnail Cache cleared.
timeout /t 3 >nul
set choice=
goto menu


:empty_download_folder
echo Emptying Download folder...
cd /d C:\Users\%USERNAME%\Downloads
echo Emptying Download folder... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
for /F "delims=" %%i in ('dir /B /S /A:-D *') do (
    echo Deleted file: %%i >> "%USERPROFILE%\Desktop\program_logs.log"
    del /q /f "%%i"
)
echo Emptying complete.
timeout /t 3 >nul
set choice=
goto menu

:repair_windows_system
echo Repairing Windows System...
sfc /scannow
echo Repairing Windows System... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
echo SFC scan complete. >> "%USERPROFILE%\Desktop\program_logs.log"
DISM /Online /Cleanup-Image /RestoreHealth
echo DISM Repairing Windows System... >> "%USERPROFILE%\Desktop\program_logs.log"
echo %DATE% %TIME:~0,5% >> "%USERPROFILE%\Desktop\program_logs.log"
echo DISM Repair complete. >> "%USERPROFILE%\Desktop\program_logs.log"
echo Repair complete.
timeout /t 3 >nul
set choice=
goto menu


:exit_program
echo Thank you for using the program! Exiting the program.

:: Show notification using PowerShell for both Windows versions
powershell -Command "[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null; [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null; $xml = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText01); $text = $xml.CreateTextNode('Thank you for using the program!'); $xml.GetElementsByTagName('text').AppendChild($text); $toast = [Windows.UI.Notifications.ToastNotification]::new($xml); [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Temporary Cleaning Program').Show($toast);"

exit /B
