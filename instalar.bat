@echo off
chcp 65001 >nul
title Instalando dependencias desde requirements.txt

echo 🧠 Activando entorno virtual env310...
call env310\Scripts\activate.bat

echo 📦 Instalando paquetes desde requirements.txt...
pip install --upgrade pip
pip install -r requirements.txt

echo ✅ Dependencias instaladas.
pause
