@echo off
chcp 65001 >nul
title Activando entorno Python 3.10 (env310)

echo 🔧 Activando entorno virtual env310...
call C:\www\LLM\env310\Scripts\activate.bat

echo 🧩 Instalando (o actualizando) dependencias desde requirements.txt...
pip install --upgrade pip >nul
pip install -r requirements.txt

echo 🟢 Entorno activado e instalaciones completadas. Ya podés usar Python 3.10.
