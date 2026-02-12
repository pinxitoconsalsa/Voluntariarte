# VoluntariArte

Plataforma móvil de voluntariado que conecta jóvenes voluntarios con organizaciones ambientales y sociales.

## 🌟 Características

- **Búsqueda de Eventos**: Encuentra oportunidades de voluntariado cercanas con filtros por categoría y distancia
- **Gamificación**: Sistema de medallas y logros para motivar la participación
- **Dashboard de Impacto**: Visualiza tu impacto personal con estadísticas y progreso
- **Certificados Automáticos**: Genera certificados de participación para compartir
- **Diseño Moderno**: Interfaz oscura con acentos verde neón siguiendo las mejores prácticas de UX

## 🚀 Comenzando

### Prerrequisitos

- Flutter SDK (3.0.0 o superior)
- Dart SDK
- Android Studio / VS Code
- Emulador Android o dispositivo físico

### Instalación

1. **Instalar Flutter**
   
   Descarga Flutter desde [flutter.dev](https://flutter.dev/docs/get-started/install)
   
   Para Windows:
   ```powershell
   # Descargar Flutter SDK
   # Extraer en C:\src\flutter
   # Agregar C:\src\flutter\bin al PATH del sistema
   ```

2. **Verificar instalación**
   ```bash
   flutter doctor
   ```

3. **Instalar dependencias del proyecto**
   ```bash
   cd voluntariarte
   flutter pub get
   ```

4. **Ejecutar la aplicación**
   ```bash
   # En emulador
   flutter run
   
   # En dispositivo físico
   flutter run -d <device-id>
   ```

## 📱 Estructura del Proyecto

```
lib/
├── core/
│   ├── theme/          # Colores, tipografía, tema
│   ├── constants/      # Constantes de la app
│   └── utils/          # Utilidades
├── features/
│   ├── auth/           # Autenticación
│   ├── volunteer/      # Funciones de voluntario
│   ├── organization/   # Funciones de organización
│   └── shared/         # Componentes compartidos
├── models/             # Modelos de datos
├── services/           # Servicios y APIs
└── main.dart           # Punto de entrada
```

## 🎨 Diseño

La aplicación sigue un sistema de diseño específico:

- **Colores Principales**:
  - Verde Neón: #13EC5B
  - Verde Oscuro: #102216
  - Verde Claro: #AFAFB0

- **Tipografía**: Inter (Bold para títulos, Regular para cuerpo)

- **Accesibilidad**: Todos los colores cumplen con WCAG 2.1

## 🔧 Configuración Backend

Actualmente la app usa datos mock. Para conectar con un backend:

1. **Firebase** (Recomendado):
   - Crear proyecto en Firebase Console
   - Agregar configuración en `google-services.json` (Android) y `GoogleService-Info.plist` (iOS)
   - Actualizar servicios para usar Firebase

2. **API REST**:
   - Crear servicio de API en `lib/services/api_service.dart`
   - Reemplazar `MockDataService` con llamadas reales

## 📦 Dependencias Principales

- `flutter_riverpod`: State management
- `go_router`: Navegación
- `google_fonts`: Tipografía Inter
- `google_maps_flutter`: Mapas y ubicación
- `intl`: Internacionalización

## 🧪 Testing

```bash
# Ejecutar tests
flutter test

# Análisis de código
flutter analyze
```

## 📱 Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 👥 Tipos de Usuario

### Voluntario
- Buscar eventos cercanos
- Registrarse en actividades
- Ver impacto personal
- Ganar medallas y logros
- Generar certificados

### Organización
- Publicar eventos
- Gestionar voluntarios
- Filtrar por habilidades
- Dashboard de eventos

## 📄 Licencia

Este proyecto es privado y confidencial.

## 🤝 Contribuir

Para contribuir al proyecto:

1. Fork el repositorio
2. Crea una rama (`git checkout -b feature/AmazingFeature`)
3. Commit cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Contacto

VoluntariArte - [@voluntariarte](https://twitter.com/voluntariarte)

---

Hecho con ❤️ y Flutter
