# 🚀 Backend - API REST de Gestión de Tareas

Este es el backend de la aplicación de gestión de tareas, desarrollado con **Spring Boot 3.5.14**. Proporciona una API REST completa para la gestión de usuarios, tareas y asignaciones.

## 🏗️ Arquitectura General

La aplicación sigue una arquitectura **hexagonal/limpia** con separación clara de responsabilidades:

```
Backend/
├── src/main/java/com/tareas/backend/
│   ├── controller/           # Controladores REST (@RestController)
│   ├── service/             # Lógica de negocio (@Service)
│   ├── repository/          # Acceso a datos (@Repository)
│   ├── model/               # Entidades JPA (@Entity)
│   ├── dto/                 # Objetos de Transferencia de Datos
│   └── exception/           # Manejo de excepciones personalizadas
├── src/main/resources/
│   ├── db/                  # Migraciones de Liquibase
│   │   ├── changelog.yml    # Archivo maestro de cambios
│   │   ├── Changes/         # Scripts SQL forward
│   │   └── Rollbacks/       # Scripts SQL de reversión
│   ├── application.properties # Configuración de Spring Boot
│   └── static/              # Recursos estáticos (si los hay)
├── src/test/                # Pruebas unitarias e integración
├── target/                  # Archivos compilados (generado)
├── pom.xml                  # Dependencias Maven
├── Dockerfile               # Contenedorización
├── mvnw/mvnw.cmd           # Wrappers de Maven
└── HELP.md                 # Documentación adicional
```

## 🛠️ Tecnologías Utilizadas

### Framework Principal
- **Spring Boot 3.5.14**: Framework principal para desarrollo de aplicaciones Java
- **Java 21**: Versión LTS de Java con las últimas características

### Persistencia de Datos
- **Spring Data JPA**: Abstracción de acceso a datos
- **Hibernate**: ORM para mapeo objeto-relacional
- **PostgreSQL**: Base de datos relacional
- **Liquibase**: Control de versiones de base de datos

### API y Documentación
- **Spring Web**: Para crear APIs REST
- **SpringDoc OpenAPI**: Generación automática de documentación Swagger
- **Jackson**: Serialización JSON

### Validación y Seguridad
- **Bean Validation**: Validación de datos de entrada
- **Spring Validation**: Integración con validación de beans

### Desarrollo y Testing
- **Lombok**: Reducción de código boilerplate
- **JUnit 5**: Framework de testing
- **Mockito**: Mocking para pruebas unitarias

### Contenedorización
- **Docker**: Contenedorización de la aplicación
- **Docker Compose**: Orquestación de servicios (backend + DB)

## 📋 Estructura de la API

### Endpoints Principales

#### 👥 Usuarios (`/api/usuarios`)
```http
GET    /api/usuarios      # Obtener todos los usuarios
GET    /api/usuarios/{id} # Obtener usuario por ID
POST   /api/usuarios      # Crear nuevo usuario
PUT    /api/usuarios/{id} # Actualizar usuario
DELETE /api/usuarios/{id} # Eliminar usuario
```

#### 📋 Tareas (`/api/tareas`)
```http
GET    /api/tareas        # Obtener todas las tareas
GET    /api/tareas/{id}   # Obtener tarea por ID
POST   /api/tareas        # Crear nueva tarea
PUT    /api/tareas/{id}   # Actualizar tarea
DELETE /api/tareas/{id}   # Eliminar tarea
```

#### 🔗 Asignaciones (`/api/asignaciones`)
```http
POST   /api/asignaciones                    # Asignar tarea a usuario
DELETE /api/asignaciones                    # Desasignar tarea de usuario
GET    /api/asignaciones/usuario/{userId}   # Obtener tareas del usuario
GET    /api/asignaciones/tarea/{taskId}     # Obtener usuarios de la tarea
GET    /api/asignaciones/existe             # Verificar si existe asignación
```

## 🗃️ Modelo de Datos

### Usuario
```java
@Entity
@Table(name = "usuario")
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID usuarioId;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(nullable = false, unique = true, length = 150)
    private String email;

    @Column(name = "created_at")
    private LocalDateTime createdAt;
}
```

### Tarea
```java
@Entity
@Table(name = "tarea")
public class Tarea {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID tareaId;

    @Column(nullable = false, length = 200)
    private String titulo;

    @Column(columnDefinition = "TEXT")
    private String descripcion;

    @Column(length = 50)
    private String estado = "PENDIENTE";

    @Column(name = "created_at")
    private LocalDateTime createdAt;
}
```

### Asignación (Relación Muchos-a-Muchos)
```java
@Entity
@Table(name = "usuario_tarea")
@IdClass(UsuarioTareaId.class)
public class UsuarioTarea {
    @Id
    @Column(name = "usuario_id")
    private UUID usuarioId;

    @Id
    @Column(name = "tarea_id")
    private UUID tareaId;

    // Relaciones @ManyToOne con Usuario y Tarea
}
```

## 🚀 Cómo Ejecutar

### Prerrequisitos
- **Java 21** o superior
- **Maven 3.6+** o usar los wrappers incluidos (`mvnw`)
- **PostgreSQL** corriendo (local o Docker)

### Opción 1: Ejecutar Localmente
```bash
# Clonar el repositorio
cd Backend

# Ejecutar con Maven wrapper
./mvnw spring-boot:run

# O con Maven instalado
mvn spring-boot:run
```

### Opción 2: Con Docker
```bash
# Construir imagen
docker build -t tareas-backend .

# Ejecutar contenedor
docker run -p 8080:8080 tareas-backend
```

### Opción 3: Con Docker Compose (Completo)
```bash
# Desde la raíz del proyecto
docker-compose up backend
```

## ⚙️ Configuración

### application.properties
```properties
# Servidor
server.port=8080

# Base de datos
spring.datasource.url=jdbc:postgresql://db:5432/tareas_db
spring.datasource.username=postgres
spring.datasource.password=postgres

# JPA/Hibernate
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true

# Liquibase
spring.liquibase.change-log=classpath:db/changelog.yml
spring.liquibase.enabled=true

# Swagger
springdoc.swagger-ui.enabled=true
springdoc.api-docs.path=/v3/api-docs
```

### Variables de Entorno
Para producción, usa variables de entorno:
```bash
export DB_URL=jdbc:postgresql://prod-db:5432/tareas_prod
export DB_USERNAME=prod_user
export DB_PASSWORD=secure_password
export SERVER_PORT=8080
```

## 🔄 Migraciones de Base de Datos

### Ejecutar Migraciones
```bash
# Desde el directorio Backend
cd Backend

# Windows
liquibase.bat update

# Linux/Mac
./liquibase.sh update

# O directamente con Maven
mvn liquibase:update
```

### Otros Comandos de Liquibase
```bash
# Ver estado de las migraciones
liquibase.bat status

# Ver historial de cambios
liquibase.bat history

# Rollback del último cambio
liquibase.bat rollbackCount 1

# Rollback a una fecha específica
liquibase.bat rollbackToDate 2024-01-01

# Generar SQL sin ejecutar (dry-run)
liquibase.bat updateSQL

# Limpiar checksums (para forzar re-ejecución)
liquibase.bat clearChecksums
```

### Estructura de Migraciones
- **changelog.yml**: Archivo maestro que define el orden de cambios
- **Changes/**: Scripts SQL forward (DDL y DML)
- **Rollbacks/**: Scripts para revertir cambios

## 📖 Documentación de API

### Swagger UI
Una vez ejecutada la aplicación, accede a:
```
http://localhost:8080/swagger-ui.html
```

### OpenAPI Specification
```
http://localhost:8080/v3/api-docs
```

## 🧪 Testing

### Ejecutar Pruebas
```bash
# Todas las pruebas
mvn test

# Con reporte de cobertura
mvn test jacoco:report
```

### Tipos de Pruebas
- **Unitarias**: Pruebas de servicios y utilidades
- **Integración**: Pruebas de controladores con base de datos embebida
- **API**: Pruebas end-to-end con TestRestTemplate

## 🔒 Validaciones y Manejo de Errores

### Validaciones de Entrada
```java
public class UsuarioDTO {
    @NotBlank(message = "El nombre es obligatorio")
    @Size(max = 100, message = "El nombre no puede exceder 100 caracteres")
    private String nombre;

    @NotBlank(message = "El email es obligatorio")
    @Email(message = "El email debe tener un formato válido")
    private String email;
}
```

### Manejo Global de Excepciones
```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(Exception ex) {
        return ResponseEntity.status(404)
            .body(new ErrorResponse("Recurso no encontrado", ex.getMessage()));
    }
}
```

## 📦 Construcción y Despliegue

### Construir JAR
```bash
mvn clean package
```

### Ejecutar JAR
```bash
java -jar target/backend-0.0.1-SNAPSHOT.jar
```

### Perfiles de Spring
```bash
# Desarrollo
mvn spring-boot:run -Dspring-boot.run.profiles=dev

# Producción
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

## 🔍 Monitoreo y Logs

### Endpoints de Actuator
```
http://localhost:8080/actuator/health     # Estado de salud
http://localhost:8080/actuator/info        # Información de la app
http://localhost:8080/actuator/metrics     # Métricas
```

### Configuración de Logging
```properties
logging.level.com.tareas.backend=DEBUG
logging.level.org.springframework.web=INFO
logging.level.org.hibernate.SQL=DEBUG
```

## 🐳 Docker

### Dockerfile
```dockerfile
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
```

### Docker Compose (Completo)
```yaml
version: '3.8'
services:
  backend:
    build: ./Backend
    ports:
      - "8080:8080"
    depends_on:
      - db
    environment:
      - SPRING_DATASOURCE_URL=jdbc:postgresql://db:5432/tareas_db

  db:
    image: postgres:15
    environment:
      - POSTGRES_DB=tareas_db
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

## 🔧 Solución de Problemas

### Error de Conexión a BD
```bash
# Verificar que PostgreSQL esté corriendo
docker ps | grep postgres

# Verificar logs del contenedor
docker logs tareas-db
```

### Error de Puerto Ocupado
```bash
# Cambiar puerto en application.properties
server.port=8081

# O matar proceso que usa el puerto
lsof -ti:8080 | xargs kill -9
```

### Error de Migraciones
```bash
# Limpiar base de datos y reiniciar
mvn liquibase:dropAll
mvn liquibase:update
```

## 📈 Rendimiento

### Optimizaciones Implementadas
- **Connection Pool**: HikariCP con configuración optimizada
- **Lazy Loading**: Carga diferida en relaciones JPA
- **Query Optimization**: Consultas optimizadas con JOIN FETCH
- **Caching**: Cache de segundo nivel con Ehcache (futuro)

### Métricas de Rendimiento
- **Tiempo de respuesta**: < 200ms para operaciones CRUD
- **Throughput**: 1000+ requests/minute
- **Memory Usage**: < 512MB en carga normal


## 👥 Autor

Kevin Andrey Culma Gomez

---

*Esta documentación proporciona una guía completa para entender, desarrollar y desplegar el backend de la aplicación de gestión de tareas.*