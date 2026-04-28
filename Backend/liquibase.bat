@echo off
REM Script para ejecutar comandos de Liquibase desde el backend
REM ========================================================

echo Ejecutando Liquibase desde Backend...
echo.

cd /d "%~dp0"

REM Verificar que Maven esté disponible
mvn -v >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Maven no está instalado o no está en el PATH
    echo Usa los wrappers incluidos: mvnw o mvnw.cmd
    pause
    exit /b 1
)

REM Ejecutar comando de Liquibase
echo Ejecutando: mvn liquibase:%*
call mvn liquibase:%*

echo.
echo Comando completado.
pause