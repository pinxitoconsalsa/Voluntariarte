# VoluntariArte - Guía de Instalación de Flutter

## 📋 Requisitos del Sistema

- **Windows 10 o superior** (64-bit)
- **Espacio en disco**: 2.5 GB (sin incluir IDE/herramientas)
- **Git para Windows**
- **PowerShell 5.0 o superior**

## 🚀 Instalación Paso a Paso

### 1. Instalar Git

Si no tienes Git instalado:

1. Descarga Git desde [git-scm.com](https://git-scm.com/download/win)
2. Ejecuta el instalador con las opciones por defecto
3. Verifica la instalación:
   ```powershell
   git --version
   ```

### 2. Descargar Flutter SDK

1. Descarga el Flutter SDK desde:
   [https://docs.flutter.dev/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows)

2. Extrae el archivo ZIP en una ubicación permanente (por ejemplo: `C:\src\flutter`)
   
   > ⚠️ **IMPORTANTE**: NO instales Flutter en directorios que requieran privilegios elevados (como `C:\Program Files`)

### 3. Actualizar la Variable PATH

1. Abre el menú Inicio y busca "variables de entorno"
2. Selecciona "Editar las variables de entorno del sistema"
3. Click en "Variables de entorno..."
4. En "Variables de usuario", busca `Path` y haz click en "Editar"
5. Agrega una nueva entrada: `C:\src\flutter\bin` (o la ruta donde instalaste Flutter)
6. Click en "Aceptar" en todas las ventanas

### 4. Verificar Instalación

Abre una **nueva** ventana de PowerShell y ejecuta:

```powershell
flutter doctor
```

Este comando verificará tu instalación y mostrará qué componentes faltan.

### 5. Instalar Android Studio (Opcional pero Recomendado)

1. Descarga Android Studio desde [developer.android.com/studio](https://developer.android.com/studio)
2. Durante la instalación, asegúrate de instalar:
   - Android SDK
   - Android SDK Platform
   - Android Virtual Device (AVD)

3. Abre Android Studio y completa la configuración inicial

4. Instala los plugins de Flutter y Dart:
   - File → Settings → Plugins
   - Busca "Flutter" e instálalo (esto también instalará Dart)

### 6. Configurar Android SDK

Ejecuta en PowerShell:

```powershell
flutter doctor --android-licenses
```

Acepta todas las licencias escribiendo `y` cuando se te solicite.

### 7. Crear un Emulador Android

1. Abre Android Studio
2. Tools → Device Manager
3. Click en "Create Device"
4. Selecciona un dispositivo (recomendado: Pixel 5)
5. Selecciona una imagen del sistema (recomendado: API 33 - Android 13)
6. Click en "Finish"

## 🎯 Ejecutar VoluntariArte

### Opción 1: Desde la Terminal

1. Navega al directorio del proyecto:
   ```powershell
   cd C:\Users\anton\Desktop\Voluntariarte\voluntariarte
   ```

2. Instala las dependencias:
   ```powershell
   flutter pub get
   ```

3. Inicia el emulador Android desde Android Studio o ejecuta:
   ```powershell
   flutter emulators --launch <emulator_id>
   ```

4. Ejecuta la aplicación:
   ```powershell
   flutter run
   ```

### Opción 2: Desde Android Studio

1. Abre Android Studio
2. File → Open → Selecciona la carpeta `voluntariarte`
3. Espera a que se indexe el proyecto
4. Selecciona un dispositivo/emulador en la barra superior
5. Click en el botón "Run" (▶️) o presiona `Shift + F10`

### Opción 3: Desde VS Code

1. Instala VS Code desde [code.visualstudio.com](https://code.visualstudio.com/)
2. Instala las extensiones:
   - Flutter
   - Dart
3. Abre la carpeta del proyecto
4. Presiona `F5` o usa el menú Run → Start Debugging

## 🔍 Verificación Final

Ejecuta estos comandos para asegurarte de que todo está correcto:

```powershell
# Verificar Flutter
flutter doctor -v

# Verificar dispositivos disponibles
flutter devices

# Analizar el proyecto
cd C:\Users\anton\Desktop\Voluntariarte\voluntariarte
flutter analyze
```

## ⚠️ Solución de Problemas Comunes

### "flutter no se reconoce como comando"

- Verifica que agregaste Flutter al PATH correctamente
- Cierra y vuelve a abrir PowerShell
- Reinicia tu computadora si es necesario

### "Android licenses not accepted"

```powershell
flutter doctor --android-licenses
```

### "No devices found"

- Asegúrate de que el emulador esté ejecutándose
- Verifica con: `flutter devices`
- Reinicia el emulador si es necesario

### Errores de dependencias

```powershell
flutter clean
flutter pub get
```

## 📱 Ejecutar en Dispositivo Físico

1. Activa las opciones de desarrollador en tu dispositivo Android:
   - Settings → About phone → Toca "Build number" 7 veces

2. Activa "USB debugging":
   - Settings → Developer options → USB debugging

3. Conecta tu dispositivo por USB

4. Verifica que Flutter detecte el dispositivo:
   ```powershell
   flutter devices
   ```

5. Ejecuta la app:
   ```powershell
   flutter run
   ```

## 🎨 Hot Reload

Mientras la app está ejecutándose:

- Presiona `r` en la terminal para hot reload (recarga rápida)
- Presiona `R` para hot restart (reinicio completo)
- Presiona `q` para salir

## 📚 Recursos Adicionales

- [Documentación oficial de Flutter](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design Guidelines](https://material.io/design)

---

¡Listo! Ahora puedes ejecutar VoluntariArte en tu dispositivo. 🎉
