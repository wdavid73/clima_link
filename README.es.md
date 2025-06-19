# ClimaLink ☀️🌧️

**ClimaLink** es tu conexión directa con el pronóstico del tiempo. Esta aplicación móvil desarrollada en Flutter proporciona información meteorológica actual y precisa para cualquier ciudad del mundo.

## 🧭 Descripción

ClimaLink permite consultar rápidamente el estado del clima, mostrando de forma clara:

- Temperatura actual
- Descripción del clima (soleado, lluvioso, nublado, etc.)
- Iconos representativos del clima
- Humedad y velocidad del viento

Todo esto en una interfaz amigable, limpia y adaptada a cualquier dispositivo.

## 🚀 Funcionalidades principales

- 🌍 Búsqueda por ciudad en tiempo real
- ⛅ Visualización de iconos y datos meteorológicos actuales
- 📍 Soporte para múltiples idiomas y ubicaciones
- 🌓 Modo claro y modo oscuro
- 🔄 Recarga manual y automática de datos
- 📱 Diseño responsive y adaptativo

## 🛠️ Tecnologías utilizadas

- **Flutter**: Framework principal para la UI
- **Dart**: Lenguaje de programación
- **OpenWeatherMap API**: Fuente de datos meteorológicos
- **Bloc/Cubit**: Gestión de estado
- **Flutter Intl**: Internacionalización con `.arb`
- **Supabase** (si aplica): Backend y autenticación

## 📦 Instalación

1. Clona el repositorio:

```bash
git clone https://github.com/wdavid73/clima_link
cd climalink
```

2. Instala las dependencias:

```bash
flutter pub get
```

3. Agrega tus variables de entorno (API Key de OpenWeatherMap, etc.) en un archivo `.env` o en `lib/env.dart`.

4. Ejecuta la app:

```bash
flutter run
```

## 🔐 API Key

Necesitas una clave de API de [OpenWeatherMap](https://openweathermap.org/api) para obtener los datos del clima. Puedes agregarla como variable de entorno o directamente en el archivo de configuración.

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

## ✨ Autor

Desarrollado por **Wilson Padilla**  
[LinkedIn](https://www.linkedin.com/in/wpadilla23/) | [GitHub](https://github.com/wdavid73)

---

> ¡Con ClimaLink, el clima está a solo un toque de distancia!
