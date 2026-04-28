# Gestión de Tareas - Frontend React

Sistema completo de gestión de usuarios y tareas con React, conectado a un backend Spring Boot. Este frontend proporciona una interfaz web moderna y responsiva para gestionar usuarios, tareas y sus asignaciones a través de una interfaz intuitiva con pestañas.

## 🚀 Características

- ✅ **Gestión de Usuarios (CRUD)**: Crear, leer, actualizar y eliminar usuarios con validación de formularios
- ✅ **Gestión de Tareas (CRUD)**: Gestión completa del ciclo de vida de tareas con seguimiento de estados
- ✅ **Integración con API REST**: Comunicación perfecta con el backend Spring Boot
- ✅ **Interfaz Moderna y Responsiva**: Construida con React y CSS3 para todos los dispositivos
- ✅ **Validación de Formularios**: Validación del lado cliente con retroalimentación en tiempo real
- ✅ **Estados de Tareas**: Soporte para estados PENDIENTE, EN_PROGRESO, COMPLETADA
- ✅ **Gestión de Asignaciones**: Asignar tareas a usuarios y gestionar relaciones
- ✅ **Actualizaciones en Tiempo Real**: Actualizaciones inmediatas de la UI después de operaciones API

## 🛠️ Stack Tecnológico

- **React 18** - Framework UI con hooks para gestión de estado
- **Vite** - Herramienta de construcción rápida y servidor de desarrollo con recarga en caliente
- **Axios** - Cliente HTTP para comunicación API con interceptores
- **CSS3** - Estilos responsivos con gradientes y animaciones
- **ESLint** - Linting de código para calidad consistente
- **Docker** - Containerización para despliegue fácil

## 📦 Instalación Local

### Prerequisitos
- Node.js 16+ (LTS recomendado)
- npm 7+ o yarn 1.22+
- API del backend ejecutándose (por defecto: http://localhost:8080)

### Pasos

1. **Clonar y navegar al directorio frontend:**
   ```bash
   cd Frontend
   ```

2. **Instalar dependencias:**
   ```bash
   npm install
   # o
   yarn install
   ```

3. **Configurar entorno (opcional):**
   Crear archivo `.env.local`:
   ```env
   VITE_API_URL=http://localhost:8080
   ```

4. **Iniciar servidor de desarrollo:**
   ```bash
   npm run dev
   # o
   yarn dev
   ```

La aplicación se abrirá en `http://localhost:5173` con recarga en caliente habilitada.

## 🐳 Ejecución con Docker

### Desde Docker Compose (Recomendado)

Esta es la forma más fácil de ejecutar todo el stack:

```bash
cd ..
docker compose up -d --build
```

Esto iniciará:
- 🌐 **Frontend**: http://localhost:3000
- 📡 **Backend**: http://localhost:8080
- 🗄️ **Base de Datos**: PostgreSQL en puerto 5432
- 📚 **Swagger**: http://localhost:8080/swagger-ui.html

### Construcción Manual de Docker

Si quieres construir el frontend por separado:

```bash
# Construir la imagen
docker build -t task-management-frontend .

# Ejecutar el contenedor
docker run -p 3000:80 -e VITE_API_URL=http://host.docker.internal:8080 task-management-frontend
```

## 📁 Estructura del Proyecto

```
Frontend/
├── public/
│   ├── favicon.ico          # Favicon de la app
│   └── index.html           # Plantilla HTML
├── src/
│   ├── components/
│   │   ├── AsignacionesTab.jsx    # Componente de gestión de asignaciones
│   │   ├── AsignacionesTab.css    # Estilos de asignaciones
│   │   ├── TareasTab.jsx          # Componente de gestión de tareas
│   │   ├── TareasTab.css          # Estilos de tareas
│   │   ├── UsuariosTab.jsx        # Componente de gestión de usuarios
│   │   └── UsuariosTab.css        # Estilos de usuarios
│   ├── services/
│   │   └── api.js                 # Configuración de Axios y llamadas API
│   ├── App.jsx                    # Componente principal con navegación
│   ├── App.css                    # Estilos globales
│   ├── main.jsx                   # Punto de entrada de la app
│   └── index.css                  # Estilos base
├── package.json                   # Dependencias y scripts
├── vite.config.js                 # Configuración de Vite
├── Dockerfile                     # Configuración de construcción Docker
├── README.md                      # Este archivo
└── index.html                     # Plantilla HTML de desarrollo
```

## 🔌 Integración con API

La aplicación se comunica con el backend usando Axios con configuración centralizada.

### Configuración

```javascript
// src/services/api.js
const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8080/api';

// Instancia de Axios con interceptores para manejo de errores
const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000,
});
```

### Endpoints de API

**Usuarios:**
- `GET /usuarios` - Obtener todos los usuarios
- `GET /usuarios/{id}` - Obtener usuario por ID
- `POST /usuarios` - Crear nuevo usuario
- `PUT /usuarios/{id}` - Actualizar usuario
- `DELETE /usuarios/{id}` - Eliminar usuario

**Tareas:**
- `GET /tareas` - Obtener todas las tareas
- `GET /tareas/{id}` - Obtener tarea por ID
- `POST /tareas` - Crear nueva tarea
- `PUT /tareas/{id}` - Actualizar tarea
- `DELETE /tareas/{id}` - Eliminar tarea

**Asignaciones:**
- `POST /asignaciones` - Asignar tarea a usuario
- `DELETE /asignaciones` - Desasignar tarea de usuario
- `GET /asignaciones/usuario/{userId}` - Obtener tareas del usuario
- `GET /asignaciones/tarea/{taskId}` - Obtener usuarios de la tarea
- `GET /asignaciones/existe` - Verificar si existe asignación

### Manejo de Errores

La app incluye manejo completo de errores:
- Errores de red con lógica de reintento
- Errores de validación con retroalimentación al usuario
- Estados de carga para mejor UX
- Notificaciones toast para operaciones

## 🎨 Estilos y UI

### Sistema de Diseño
- **Paleta de Colores**: Gradiente púrpura (#667eea a #764ba2)
- **Tipografía**: Fuentes limpias y legibles con jerarquía apropiada
- **Espaciado**: Sistema consistente de cuadrícula de 8px
- **Componentes**: Botones, formularios y componentes de tarjeta reutilizables

### Diseño Responsivo
- **Enfoque mobile-first** con puntos de quiebre:
  - Móvil: < 768px
  - Tablet: 768px - 1024px
  - Desktop: > 1024px
- **Layouts flexibles** usando CSS Grid y Flexbox
- **Botones amigables al tacto** e interacciones

### Animaciones
- Transiciones suaves entre pestañas
- Spinners de carga durante llamadas API
- Efectos hover en elementos interactivos
- Animaciones de retroalimentación de validación de formularios

## 📱 Arquitectura de Componentes

### App.jsx
Componente principal que gestiona:
- Estado de navegación de pestañas
- Layout global
- Renderizado de componentes basado en pestaña activa

### Componentes de Pestañas
Cada pestaña es un componente autocontenido con:
- Gestión de estado local
- Integración con API
- Manejo de formularios
- Visualización de errores

### Capa de Servicios
Llamadas API centralizadas en `api.js`:
- Configuración de Axios
- Interceptores de solicitud/respuesta
- Utilidades de manejo de errores

## 🚀 Flujo de Desarrollo

### Modo Desarrollo
```bash
npm run dev
```
- Recarga en caliente habilitada
- Mapas de fuente para depuración
- Integración con ESLint

### Construcción de Producción
```bash
npm run build
```
- Bundle optimizado con división de código
- CSS y JS minificados
- Optimización de activos estáticos

### Vista Previa de Construcción de Producción
```bash
npm run preview
```
- Probar construcción de producción localmente antes del despliegue

## 🔄 Flujo de Datos

### Gestión de Estado
- **Estado Local**: useState para estado de componentes
- **Estado Global**: Context API para estado compartido
- **Estado de Servidor**: Sincronización con backend

### Operaciones CRUD
1. **Crear**: Formulario → Validación → API POST → Actualizar estado
2. **Leer**: Componente monta → API GET → Renderizar datos
3. **Actualizar**: Editar formulario → Validación → API PUT → Actualizar estado
4. **Eliminar**: Confirmación → API DELETE → Remover del estado

### Sincronización
- Actualización automática de listas después de operaciones
- Manejo de conflictos de concurrencia
- Estado de carga durante operaciones asíncronas

## 🧪 Pruebas

### Pruebas Unitarias (Futuro)
```bash
npm run test
```

### Pruebas E2E (Futuro)
```bash
npm run test:e2e
```

### Estrategia de Pruebas
- **Componentes**: Pruebas de renderizado y comportamiento
- **Servicios API**: Pruebas de llamadas HTTP y manejo de errores
- **Integración**: Flujo completo de usuario
- **Cobertura**: Objetivo del 80% de cobertura de código

## 🚀 Despliegue

### Despliegue con Docker
```bash
# Construir y subir a registro
docker build -t myregistry/task-frontend .
docker push myregistry/task-frontend

# Ejecutar en producción
docker run -d -p 80:80 myregistry/task-frontend
```

### Hosting Estático
La app puede desplegarse en cualquier servicio de hosting estático:
- Vercel
- Netlify
- GitHub Pages

## ✨ Mejoras Futuras

 **Sistema de Autenticación**: Autenticación de usuarios basada en JWT
 **Filtrado Avanzado**: Búsqueda y filtrado de tareas por estado, fecha, usuario
 **Tema Oscuro/Claro**: Preferencia de usuario para cambio de tema
 **Multi-idioma**: Soporte i18n para múltiples idiomas
 **Dashboard de Analytics**: Gráficos y estadísticas
 **Acceso Basado en Roles**: Diferentes permisos para usuarios

## 📊 Rendimiento

- **Tamaño del Bundle**: Optimizado con división de código
- **Tiempos de Carga**: Carga diferida para componentes
- **Optimización de Imágenes**: Implementación futura para archivos multimedia


## 📝 Contribución

1. Haz un fork del repositorio
2. Crea una rama de funcionalidad
3. Realiza tus cambios
4. Agrega pruebas si corresponde
5. Envía una solicitud de pull

## 📄 Licencia

Proyecto personal para gestión de tareas.

## 👥 Autor

Kevin Andrey Culma Gomez

---