@echo off
rem Mo bao cao qua Task Scheduler (dung khi can chay o session khong tuong tac)
set "SCRIPT_DIR=%~dp0"
schtasks /create /tn "OpenBriefingNow" /tr "cmd.exe /c start \"\" \"%SCRIPT_DIR%briefing.html\"" /sc once /st 00:00 /f /it
schtasks /run /tn "OpenBriefingNow"
timeout /t 3 /nobreak >nul
schtasks /delete /tn "OpenBriefingNow" /f
