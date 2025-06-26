@echo off
chcp 65001 >nul
title Crear y activar entorno Python 3.10 - Julio

echo 🧹 Cerrando procesos de Python si están abiertos...
taskkill /f /im python.exe >nul 2>&1

echo.
echo 🧼 Borrando entorno virtual anterior si existe...
rmdir /s /q env310

echo.
echo 🧱 Creando nuevo entorno virtual con Python 3.10...
C:\Python310\python.exe -m venv env310

echo.
echo ▶ Activando entorno virtual...
call env310\Scripts\activate.bat

echo.
echo 📦 Instalando dependencias desde requirements.txt...
pip install --upgrade pip
pip install -r requirements.txt

echo.
echo 🚀 Ejecutando es.py...
python es.py

pause
