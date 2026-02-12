# Script de instalacion automatica de Flutter para Windows
# Ejecuta este script en PowerShell como Administrador

Write-Host "=== Instalador Automatico de Flutter ===" -ForegroundColor Green
Write-Host ""

# Verificar si ya esta instalado
if (Get-Command flutter -ErrorAction SilentlyContinue) {
    Write-Host "Flutter ya esta instalado!" -ForegroundColor Green
    flutter --version
    exit 0
}

Write-Host "Paso 1: Verificando Git..." -ForegroundColor Yellow
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git no esta instalado. Descargando Git..." -ForegroundColor Red
    Write-Host "Por favor, instala Git desde: https://git-scm.com/download/win" -ForegroundColor Cyan
    Start-Process "https://git-scm.com/download/win"
    Write-Host "Despues de instalar Git, ejecuta este script nuevamente." -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "Git esta instalado" -ForegroundColor Green
}

Write-Host ""
Write-Host "Paso 2: Creando directorio de instalacion..." -ForegroundColor Yellow
$flutterPath = "C:\src\flutter"
if (-not (Test-Path "C:\src")) {
    New-Item -ItemType Directory -Path "C:\src" -Force | Out-Null
    Write-Host "Directorio C:\src creado" -ForegroundColor Green
}

Write-Host ""
Write-Host "Paso 3: Clonando Flutter desde GitHub..." -ForegroundColor Yellow
Write-Host "Esto puede tardar varios minutos dependiendo de tu conexion..." -ForegroundColor Cyan

if (Test-Path $flutterPath) {
    Write-Host "Flutter ya existe en $flutterPath" -ForegroundColor Green
    Write-Host "Actualizando Flutter..." -ForegroundColor Yellow
    Set-Location $flutterPath
    git pull
} else {
    git clone https://github.com/flutter/flutter.git -b stable $flutterPath
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Flutter clonado exitosamente" -ForegroundColor Green
    } else {
        Write-Host "Error al clonar Flutter" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Paso 4: Agregando Flutter al PATH..." -ForegroundColor Yellow

# Obtener PATH actual del usuario
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$flutterBinPath = "$flutterPath\bin"

if ($userPath -notlike "*$flutterBinPath*") {
    # Agregar Flutter al PATH
    $newPath = $userPath + ";" + $flutterBinPath
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "Flutter agregado al PATH" -ForegroundColor Green
    
    # Actualizar PATH en la sesion actual
    $env:Path = $env:Path + ";" + $flutterBinPath
} else {
    Write-Host "Flutter ya esta en el PATH" -ForegroundColor Green
}

Write-Host ""
Write-Host "Paso 5: Ejecutando flutter doctor..." -ForegroundColor Yellow
Write-Host ""

& "$flutterBinPath\flutter.bat" doctor

Write-Host ""
Write-Host "=== Instalacion Completada ===" -ForegroundColor Green
Write-Host ""
Write-Host "Proximos pasos:" -ForegroundColor Cyan
Write-Host "1. Cierra y vuelve a abrir PowerShell para que los cambios surtan efecto" -ForegroundColor White
Write-Host "2. Ejecuta: flutter doctor" -ForegroundColor White
Write-Host "3. Si necesitas Android Studio, descargalo de: https://developer.android.com/studio" -ForegroundColor White
Write-Host "4. Acepta las licencias de Android: flutter doctor --android-licenses" -ForegroundColor White
Write-Host ""
Write-Host "Para ejecutar VoluntariArte:" -ForegroundColor Cyan
Write-Host "cd C:\Users\anton\Desktop\Voluntariarte\voluntariarte" -ForegroundColor White
Write-Host "flutter pub get" -ForegroundColor White
Write-Host "flutter run" -ForegroundColor White
Write-Host ""
