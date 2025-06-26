@echo off
title 🗂️ Mostrar y guardar estructura de LLM
setlocal EnableDelayedExpansion

:: 📅 Obtener fecha y hora
for /f "tokens=1-3 delims=/" %%a in ("%date%") do (
    set dia=%%a
    set mes=%%b
    set anio=%%c
)
for /f "tokens=1-2 delims=:" %%a in ("%time%") do (
    set hora=%%a
    set minuto=%%b
)

:: 🗂️ Mostrar lista en pantalla
dir /b

:: 💾 Guardar en arbol.txt
dir /b > arbol.txt

:: 🧾 Guardar en arbol.md con formato markdown y UTF-8 (vía redirección con BOM manual)
(
    echo.> arbol.md
    rem Agregar BOM UTF-8 manual (EF BB BF)
    > arbol_bom.md (
        rem Código Markdown con fecha, lista y formato
        echo # 🗂️ Estructura del proyecto LLM
        echo.
        echo 📅 Generado el !dia!/!mes!/!anio! a las !hora!:!minuto!
        echo.
        echo ---
        echo.
        echo Lista de archivos y carpetas:
        echo.
        for /f "usebackq delims=" %%f in ("arbol.txt") do (
            echo - %%f
        )
    )
    copy /b arbol.md+arbol_bom.md arbol.md >nul
    del arbol_bom.md
)

echo.
echo ✅ Archivos generados correctamente: arbol.txt y arbol.md
pause
