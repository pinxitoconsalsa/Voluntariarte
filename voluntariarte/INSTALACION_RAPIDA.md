# 🚀 Guía Rápida de Instalación de Flutter

## Opción 1: Script Automático (MÁS FÁCIL) ⚡

He creado un script que hace casi todo automáticamente:

### Pasos:

1. **Abre PowerShell como Administrador:**
   - Click derecho en el menú Inicio
   - Selecciona "Windows PowerShell (Administrador)"

2. **Permite la ejecución de scripts (solo primera vez):**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

3. **Navega al directorio:**
   ```powershell
   cd C:\Users\anton\Desktop\Voluntariarte\voluntariarte
   ```

4. **Ejecuta el script:**
   ```powershell
   .\install_flutter.ps1
   ```

5. **Cierra y vuelve a abrir PowerShell**

6. **Verifica la instalación:**
   ```powershell
   flutter doctor
   ```

---

## Opción 2: Instalación Manual Paso a Paso

### 1. Descargar Flutter

```powershell
# Crear directorio
New-Item -ItemType Directory -Path "C:\src" -Force

# Clonar Flutter (requiere Git instalado)
git clone https://github.com/flutter/flutter.git -b stable C:\src\flutter
```

### 2. Agregar al PATH

**Método A - PowerShell:**
```powershell
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$userPath;C:\src\flutter\bin"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")
```

**Método B - Manual:**
1. Busca "variables de entorno" en Windows
2. Edita "Path" del usuario
3. Agrega: `C:\src\flutter\bin`
4. Click OK

### 3. Verificar

```powershell
# Cierra y vuelve a abrir PowerShell
flutter doctor
```

---

## Opción 3: Descarga Directa (Sin Git)

Si no tienes Git instalado:

1. **Descarga el ZIP:**
   - Ve a: https://docs.flutter.dev/get-started/install/windows
   - Click en "Download Flutter SDK"
   - Descarga el archivo ZIP

2. **Extrae el archivo:**
   - Extrae en `C:\src\flutter`
   - NO en `C:\Program Files`

3. **Agrega al PATH:**
   - Busca "variables de entorno"
   - Agrega `C:\src\flutter\bin` al Path

4. **Verifica:**
   ```powershell
   flutter doctor
   ```

---

## Después de Instalar Flutter

### 1. Instalar Android Studio (Opcional pero Recomendado)

```powershell
# Descarga desde:
Start-Process "https://developer.android.com/studio"
```

Durante la instalación, asegúrate de instalar:
- Android SDK
- Android SDK Platform
- Android Virtual Device

### 2. Aceptar Licencias de Android

```powershell
flutter doctor --android-licenses
# Presiona 'y' para aceptar todas
```

### 3. Instalar Dependencias de VoluntariArte

```powershell
cd C:\Users\anton\Desktop\Voluntariarte\voluntariarte
flutter pub get
```

### 4. Ejecutar la App

```powershell
# Ver dispositivos disponibles
flutter devices

# Ejecutar en emulador
flutter run

# O ejecutar en modo debug con hot reload
flutter run --debug
```

---

## Solución de Problemas

### "flutter no se reconoce como comando"

**Solución:**
1. Cierra y vuelve a abrir PowerShell
2. Verifica que `C:\src\flutter\bin` esté en el PATH
3. Reinicia tu computadora si es necesario

### "Git no está instalado"

**Solución:**
```powershell
# Descarga Git
Start-Process "https://git-scm.com/download/win"
```

Instala Git y luego ejecuta el script de instalación de Flutter nuevamente.

### "cmdline-tools component is missing"

**Solución:**
```powershell
flutter doctor --android-licenses
```

---

## Verificación Final

Ejecuta este comando para ver el estado completo:

```powershell
flutter doctor -v
```

Deberías ver algo como:

```
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain - develop for Android devices
[✓] Chrome - develop for the web
[✓] Visual Studio - develop Windows apps
[✓] Android Studio
[✓] VS Code
[✓] Connected device
```

---

## ¿Listo para Ejecutar VoluntariArte?

Una vez que `flutter doctor` muestre todo en verde (o al menos Flutter y Android toolchain):

```powershell
cd C:\Users\anton\Desktop\Voluntariarte\voluntariarte
flutter pub get
flutter run
```

¡Y listo! La app debería iniciarse en el emulador o dispositivo conectado. 🎉
