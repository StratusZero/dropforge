@echo off
SETLOCAL EnableDelayedExpansion
cls
SET installpath=!cd!

REM *************************
REM Edit vars below if needed
REM *************************

REM Override JSON selection (random if .\configs already exists with multiple cfgs) with file below.
REM Include the subdir and JSON extension, i.e. configname=".\configs\foobar.json"
SET configname=""



REM ****************************
REM ****************************
REM Do not edit below this point
REM ****************************
REM ****************************
ECHO     ____                   ____                    
ECHO    / __ \_________  ____  / __/___  _________ ____ 
ECHO   / / / / ___/ __ \/ __ \/ /_/ __ \/ ___/ __ `/ _ \
ECHO  / /_/ / /  / /_/ / /_/ / __/ /_/ / /  / /_/ /  __/
ECHO /_____/_/   \____/ .___/_/  \____/_/   \__, /\___/ 
ECHO                 /_/                   /____/       
ECHO.
ECHO (C) Stratus Zero 2022 - discord.srzo.xyz
ECHO [INFO] Starting update process...


IF NOT EXIST ".\_steam" MKDIR ".\_steam" && ECHO [INFO] Steam dir created at .\_steam
CD _steam

curl "https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip" -o "steamcmd.zip" && (
    ECHO [INFO] Downloaded SteamCMD zip
) || (
    ECHO [ERROR] Steamcmd unable to download! Program will exit.
    pause
    EXIT /b 1
)

powershell Expand-Archive steamcmd.zip -DestinationPath . -Force && (
    ECHO [INFO] Expanded archive
    DEL "steamcmd.zip" && ECHO [INFO] Archived deleted; no longer needed
) || (
    ECHO [ERROR] Could not expand archive! Program will exit.
    pause
    EXIT /b 1
)

(
    ECHO @ShutdownOnFailedCommand 1
    ECHO @NoPromptForPassword 1
    ECHO force_install_dir !installpath!
    ECHO login anonymous 
    ECHO app_update 1874900 -validate
    ECHO quit
)>"_update_script.txt" && ECHO [INFO] Update script generated

steamcmd.exe +runscript _update_script.txt && ECHO [INFO] Server successfully installed
CD ..
IF EXIST ".\configs" (
    ECHO [INFO] Configs directory already exists
) ELSE (
    MKDIR ".\configs" && ECHO [INFO] Created configs directory || [ERROR] Couldn't create configs dir!
)

IF NOT EXIST ".\configs\*.json" (
    CHOICE /M "Generate default config? [Y/n]" /D Y /T 10 /N
    IF !ERRORLEVEL! == 0 SET _defcfg=1
    IF !ERRORLEVEL! == 1 SET _defcfg=1
    IF !_defcfg! == 1 (
	    SET autoconfig="true"
        (
            ECHO {
            ECHO 	"dedicatedServerId": "df-!RANDOM!",
            ECHO 	"region": "US",
            ECHO 	"gameHostBindAddress": "",
            ECHO 	"gameHostBindPort": 2001,
            ECHO 	"gameHostRegisterBindAddress": "",
            ECHO 	"gameHostRegisterPort": 2001,
            ECHO 	"game": {
            ECHO 		"name": "Dropforge - Info @ discord.szro.xyz",
            ECHO 		"scenarioId": "{ECC61978EDCC2B5A}Missions/23_Campaign.conf",
            ECHO 		"password": "",
            ECHO 		"playerCountLimit": 32,
            ECHO 		"autoJoinable": true,
            ECHO 		"visible": true,
            ECHO 		"gameProperties": {
            ECHO 			"fastValidation": true,
            ECHO 			"battlEye": true
            ECHO 		}
            ECHO 	},
            ECHO 	"mods": []
            ECHO }
        )>".\configs\default.json" && (
            ECHO [INFO] default.json config generated
            ECHO [INFO] Feel free to edit the config, more info at https://community.bistudio.com/wiki/Arma_Reforger:Server_Hosting#Dedicated_Server
        ) || (
            ECHO [ERROR] Couldn't generate default json! Program will exit.
            EXIT /b 1
        )
    ) ELSE (
        ECHO [INFO] Config detected!
	    SET autoconfig=false
    )
)
ECHO [INFO] ArmA Reforger Server installed and ready!

CHOICE /M "Run now? [Y/n]" /D Y /T 10 /N
IF !ERRORLEVEL! == 0 SET _runvar=1
IF !ERRORLEVEL! == 1 SET _runvar=1
IF !_runvar! == 1 (
    IF !autoconfig! == "true" (
	    ECHO [INFO] Running server with default config
        GOTO start
    ) ELSE IF !configname! == "" (
	    FOR %%F IN (.\configs\*.json) DO (
            SET filename=%%F
		    ECHO [INFO] Running server with autodetected config ^(!filename!^)
            GOTO start
        )
    ) ELSE (
        SET filename=!configname!
	    ECHO [INFO] Running server with overriden config from set variable
    )
    
) ELSE (
    ECHO [INFO] Server not auto-started. Dropforge will now exit.
    PAUSE
    EXIT
)

:start
ECHO Starting server...

ArmaReforgerServer.exe +config "!filename!" +profile ArmaReforgerServer +maxFPS 30 +logStats 10000

ECHO.
ECHO Restarting server...
ECHO.
GOTO start