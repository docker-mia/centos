@echo off
setlocal

:: Obtener el nombre del usuario actual
set USER=%USERNAME%

:: Establecer la ruta
set "ruta=C:\Users\%USER%\Documents\Virtual Machines\MIA+PROMETHEUS"

:: Buscar archivos .lck
echo Buscando archivos .lck en %ruta%...
set "contador=0"

for /r "%ruta%" %%f in (*.lck) do (
    set /a contador+=1
    echo Eliminando: %%f
    del /f "%%f"
)

:: Si no se encontraron archivos
if %contador%==0 (
    echo Nada que hacer.
) else (
    echo Se han eliminado %contador% archivos.
)

echo Reiniciando el servicio VMwareAutostartService...

:: Detener el servicio
net stop VMwareAutostartService

:: Iniciar el servicio
net start VMwareAutostartService

:: Verificar el estado del servicio
sc query VMwareAutostartService | findstr /i "RUNNING"
if %errorlevel%==0 (
    echo El servicio se ha reiniciado correctamente.
) else (
    echo Hubo un problema al reiniciar el servicio.
)

endlocal
pause
