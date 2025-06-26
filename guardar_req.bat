@echo off
chcp 65001 >nul
title Guardando dependencias en requirements.txt

echo 💾 Guardando dependencias actuales en requirements.txt...
pip freeze > requirements.txt

echo ✅ Listo. El archivo se actualizó.