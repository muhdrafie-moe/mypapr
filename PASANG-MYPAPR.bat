@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Pasang MYPAPR 1.4.0
echo.
echo  Menyediakan pemasang MYPAPR 1.4.0 ...
echo.
if not exist "MYPAPR-Setup-1.4.0.exe.bahagian0" goto tiada
if not exist "MYPAPR-Setup-1.4.0.exe.bahagian1" goto tiada
copy /b "MYPAPR-Setup-1.4.0.exe.bahagian0"+"MYPAPR-Setup-1.4.0.exe.bahagian1" "MYPAPR-Setup-1.4.0.exe" >nul
if errorlevel 1 goto gagal
set "HASH="
for /f %%H in ('powershell -NoProfile -Command "(Get-FileHash -Algorithm SHA256 -LiteralPath 'MYPAPR-Setup-1.4.0.exe').Hash" 2^>nul') do set "HASH=%%H"
if not defined HASH goto buka
if /I not "%HASH%"=="4FD0858D00CFD7B5A7129F870341665C46C5440FE8329F97F964CDDF280ACF0F" goto rosak
:buka
echo  Pemasang sedia: MYPAPR-Setup-1.4.0.exe
echo  Membuka pemasang ...
start "" "MYPAPR-Setup-1.4.0.exe"
exit /b 0
:tiada
echo  Fail bahagian tidak dijumpai.
echo  Pastikan anda klik kanan fail ZIP dan pilih "Extract All" dahulu,
echo  kemudian jalankan PASANG-MYPAPR.bat dari folder yang telah diekstrak.
echo.
pause
exit /b 1
:gagal
echo  Gagal mencantumkan fail. Pastikan ada ruang storan yang cukup (sekurang-kurangnya 300 MB).
echo.
pause
exit /b 1
:rosak
echo  Fail rosak semasa dimuat turun. Sila muat turun semula fail ZIP dari GitHub.
del "MYPAPR-Setup-1.4.0.exe" >nul 2>&1
echo.
pause
exit /b 1
