@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"
set "version=2.7.1"
set "apppathname=rufus-4.11p.exe"

:: Varriable !
set "indexfile=cmdgui"
set "file=obt"

for %%l in (%*) do (
	set "arg=%%l"
)

if exist "C:\lang.txt" goto Skip1
if exist "C:\Program Files\Windows NT\TableTextService\TableTextService.dll" set "lang=FR"

if %lang%=="FR" (
    set "btnclose=Fermer"
    set "btnopen=Ouvrire"
    set "GUItitle=Recherche d'élément complété !"
    set "GUItitle2=Recherche de composent.."
    set "levelguierror=%filepath% est incompatible sur votre session Windows!"
    set "infogui1=Nous avons bloque le lancement de %filepath%"
    set "infogui2=car il pourer ne pas fonctionne correctement!"
    set"Refresh=Rafrechire"
    set "titleobtion1=Lanceur d'iso"
    set "titleobtion2=Retoure en arriere"
    set "titleobtion3=Reparer le boot"
    set "titleobtion4=Redemarer a partire du bios"
    set "namepathtext=Bienvenue dans l'assistant d'analyse"
    set "titletext=Obtion et outis disponibles :"
    set "uititle=ISOdownloader"
) else (
    set "btnclose=Close"
    set "btnopen=Open"
    set "GUItitle="
    set "GUItitle2="
    set "levelguierror=%filepath% has incompatible on your Windows session"
    set "infogui1=We have blocked the launch of %filepath%"
    set "infogui2=because it might not work properly!"
    set "titleobtion1=(X) Windows 11 ISO"
    set "titleobtion2=Windows 10 ISO"
    set "titleobtion3=Windows 8.1 ISO"
    set "titleobtion4=(X) Ubuntu ISO"
    set "namepathtext=Welcome to the analysis assistant"
    set "titletext=Options and tools available:"
    set "uititle=ISOdownloader"
)
:skip


color 08

:: Menu GUI du programme de téléchargement


if exist %indexfile%.ps1 goto skipobtiongui
:menuyesno
echo $options = @("%titleobtion1%", "%titleobtion2%", "%titleobtion3%", "%titleobtion4%","Exit") >> %indexfile%.ps1
echo $selected = 0 >> %indexfile%.ps1
echo $confirmed = $false >> %indexfile%.ps1
echo function Show-Menu { >> %indexfile%.ps1
echo     Clear-Host >> %indexfile%.ps1
echo     Write-Host "=== %uititle% ===`n" -ForegroundColor Yellow >> %indexfile%.ps1
echo     for ($i = 0; $i -lt $options.Length; $i++) { >> %indexfile%.ps1
echo         if ($i -eq $selected) { >> %indexfile%.ps1
echo             Write-Host "> $($options[$i])" -ForegroundColor Cyan >> %indexfile%.ps1
echo         } else { >> %indexfile%.ps1
echo             Write-Host "  $($options[$i])" >> %indexfile%.ps1
echo         } >> %indexfile%.ps1
echo     } >> %indexfile%.ps1
echo     Write-Host "`n<- -> pour naviguer, Entrée pour valider." >> %indexfile%.ps1
echo } >> %indexfile%.ps1
echo while (-not $confirmed) { >> %indexfile%.ps1
echo     Show-Menu >> %indexfile%.ps1
echo     $key = [System.Console]::ReadKey($true) >> %indexfile%.ps1
echo     switch ($key.Key) ^{ >> %indexfile%.ps1
echo         "LeftArrow"  {^ ^$selected = (^$selected - 1 + ^$options.Length) %% ^$options.Length }^ >> %indexfile%.ps1
echo         "RightArrow" {^ ^$selected = (^$selected + 1) %% ^$options.Length }^ >> %indexfile%.ps1
echo         "Enter"      {^ $confirmed = $true }^ >> %indexfile%.ps1
echo     } >> %indexfile%.ps1
echo } >> %indexfile%.ps1
echo # Action choisie >> %indexfile%.ps1
echo switch ($options[$selected]) { >> %indexfile%.ps1
echo     "Exit" { >> %indexfile%.ps1
echo         Set-Content -Path "%file%.txt" -Value "exite" >> %indexfile%.ps1
echo     } >> %indexfile%.ps1
echo     "%titleobtion2%" { >> %indexfile%.ps1
echo         Set-Content -Path "%file%.txt" -Value "Windows10%obtionyes%" >> %indexfile%.ps1
echo     } >> %indexfile%.ps1
echo     "%titleobtion1%" { >> %indexfile%.ps1
echo         Set-Content -Path "%file%.txt" -Value "Windows11%obtionno%" >> %indexfile%.ps1
echo     } >> %indexfile%.ps1
echo     "%titleobtion3%" { >> %indexfile%.ps1
echo         Set-Content -Path "%file%.txt" -Value "Windows8.1" >> %indexfile%.ps1
echo     } >> %indexfile%.ps1
echo     "%titleobtion4%" { >> %indexfile%.ps1
echo         Set-Content -Path "%file%.txt" -Value "Ubuntu ISO" >> %indexfile%.ps1
echo     } >> %indexfile%.ps1
echo } >> %indexfile%.ps1
echo # Fermer PowerShell proprement >> %indexfile%.ps1
echo exit >> %indexfile%.ps1
:skipobtiongui
%yesnomenu%
cls

powershell -ExecutionPolicy Bypass -File %indexfile%.ps1
set /p action=<%file%.txt
if "%action%"=="" (
    echo Aucune action detectee. Fin du script.
    pause
)
del %file%.txt
del %indexfile%.ps1
cls

set "yesnomenu=goto complete"
set "titleobtion4="
set "titleobtion3="
set "titleobtion2=YES"
set "titleobtion1=NO"
set "uititle=Voulez vous télécharger rufus & et le lencer?"
set "obtionyes=yes"
set "obtionno=no"
goto menuyesno
exit
:complete

:: Lanc créer un clé usb boutable ?
powershell -ExecutionPolicy Bypass -File %indexfile%.ps1
set /p action2=<%file%.txt
if "%action2%"=="" (
    echo Aucune action detectee. Fin du script.
    pause
    exit > nul
)

del %indexfile%.ps1
goto %action%
exit

:exite
exit

:Windows11
goto %action2%
exit
:Windows10
start https://drive.usercontent.google.com/download?id=1swtNWzSBeenMHXxpL2ApEl2itJIVK6hr&export=download&authuser=0
goto %action2%
exit
:Windows8.1
https://drive.usercontent.google.com/download?id=14tpP3Y9j0FOweF8Vcq4VMfqYLDeSlV-J&export=download&authuser=0
goto %action2%
exit

:Ubuntu ISO
goto %action2%
exit

:Windows11%obtionno%
exit > nul

:: Usb --> bootable
:Windows11%obtionyes%
:Windows10%obtionyes%
start https://drive.usercontent.google.com/download?id=19wQoN0OejzJnz2VbccIOaApYcgToyTY9&export=download&authuser=0
pause
move "C:\Users\%username%\Downloads\%apppathname%" "%~dp0"
if not exist %apppathname% goto pass
start %apppathname%
:pass
exit > nul