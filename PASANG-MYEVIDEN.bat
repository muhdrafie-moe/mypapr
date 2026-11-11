@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Pasang MyEviden 1.5.0
echo.
echo  Menyediakan pemasang MyEviden 1.5.0 ...
echo.
if not exist "MyEviden-Setup-1.5.0.exe.bahagian0" goto tiada
if not exist "MyEviden-Setup-1.5.0.exe.bahagian1" goto tiada
copy /b "MyEviden-Setup-1.5.0.exe.bahagian0"+"MyEviden-Setup-1.5.0.exe.bahagian1" "MyEviden-Setup-1.5.0.exe" >nul
if errorlevel 1 goto gagal
set "HASH="
for /f %%H in ('powershell -NoProfile -Command "(Get-FileHash -Algorithm SHA256 -LiteralPath 'MyEviden-Setup-1.5.0.exe').Hash" 2^>nul') do set "HASH=%%H"
if not defined HASH goto buka
if /I not "%HASH%"=="EBB68E99C01E3D6E4318D51EBB0BEB0FA947B76F66D97A5490B4E113F9ADB205" goto rosak
:buka
echo  Pemasang sedia: MyEviden-Setup-1.5.0.exe
echo  Membuka pemasang ...
start "" "MyEviden-Setup-1.5.0.exe"
exit /b 0
:tiada
echo  Fail bahagian tidak dijumpai.
echo  Pastikan anda klik kanan fail ZIP dan pilih "Extract All" dahulu,
echo  kemudian jalankan PASANG-MYEVIDEN.bat dari folder yang telah diekstrak.
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
del "MyEviden-Setup-1.5.0.exe" >nul 2>&1
echo.
pause
exit /b 1
