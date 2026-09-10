# VueloApp — Sistema de Gestión de Vuelos

Aplicación web desarrollada con **Java Servlet/JSP** como parte de la actividad de Unidad 1 de Desarrollo Web. Implementa un CRUD completo para las entidades **Usuario** y **Vuelo** (ejercicio N.º 18), con autenticación, recuperación de clave por correo y reportes parametrizados.

## Estudiante

- **Nombre:** Johann Moreno
- **Ejercicio asignado:** 18 — Vuelo

## Tecnologías utilizadas

| Tecnología | Versión |
|---|---|
| Java (JDK) | 21 |
| Apache Tomcat | 11.0.25 |
| Jakarta EE | 10.0 |
| MySQL | 8.4.3 (vía Laragon) |
| Maven | (incluido en el proyecto) |
| MySQL Connector/J | 9.1.0 |
| Jakarta Mail | 2.0.1 |

## Arquitectura del proyecto
src/main/java/com/johannmoreno/vueloapp/
├── domain/model/ -> Entidades: Usuario, Vuelo
├── infrastructure/
│ ├── database/ -> Conexión JDBC a MySQL
│ ├── persistence/ -> CRUD: UsuarioCRUD, VueloCRUD
│ └── email/ -> Envío de correos (EmailService)
└── business/
├── exceptions/ -> Excepciones de negocio
└── services/ -> Lógica de negocio: UsuarioService, VueloService

src/main/webapp/
├── index.jsp
├── Controllers/ -> UsuarioController.jsp, VueloController.jsp
└── Views/
├── Css/ -> Hoja de estilos
└── Forms/
├── Usuarios/ -> login, crear, buscar/editar/eliminar, listar, recuperar
└── Vuelos/ -> crear, buscar/editar/eliminar, listar, reportes


## Base de datos

El script de creación y datos iniciales está en `script_bd.sql` en la raíz del repositorio.

**Para configurarla localmente:**

1. Levanta MySQL (por ejemplo con Laragon).
2. Ejecuta el script:
```bash
   mysql -u root < script_bd.sql
```
O ábrelo y ejecútalo desde HeidiSQL / MySQL Workbench.
3. Esto crea la base de datos `vuelo_app` con las tablas `usuarios` y `vuelos`, más datos de prueba.

## Configuración de variables de entorno

La recuperación de clave envía correos reales mediante Gmail SMTP. Se necesitan dos variables de entorno (no se guardan en el código por seguridad):

| Variable | Descripción |
|---|---|
| `GMAIL_USER` | Correo de Gmail que envía los mensajes |
| `GMAIL_APP_PASSWORD` | Contraseña de aplicación de 16 caracteres generada en la cuenta de Google (requiere verificación en 2 pasos activa) |

**En IntelliJ IDEA:** Run > Edit Configurations > (tu configuración de Tomcat) > Environment variables.

**En el servicio de despliegue:** se configuran en la sección de variables de entorno del panel del proveedor (Render, Railway, etc.).

## Cómo ejecutar el proyecto localmente

1. Clona el repositorio:
```bash
   git clone https://github.com/johannmoreno/vuelo-app-jsp.git
```
2. Ábrelo en IntelliJ IDEA como proyecto Maven existente.
3. Verifica que tengas JDK 21 y Apache Tomcat 11 instalados y configurados como Application Server.
4. Configura las variables de entorno `GMAIL_USER` y `GMAIL_APP_PASSWORD` (ver sección anterior).
5. Ejecuta el script `script_bd.sql` en tu MySQL local.
6. Corre la configuración de Tomcat desde IntelliJ (botón ▶).
7. Abre `http://localhost:8080/vueloapp/` en el navegador.

## Usuario de prueba

| Email | Clave |
|---|---|
| admin@vueloapp.com | 1234 |

## Funcionalidades implementadas

- CRUD completo de Usuario (crear, listar, buscar, editar, eliminar)
- CRUD completo de Vuelo (crear, listar, buscar, editar, eliminar)
- Autenticación (login / logout) con manejo de sesión
- Recuperación de clave por correo electrónico (genera clave temporal y la envía por Gmail)
- Reportes parametrizados de Vuelo:
    - Por aerolínea y rango de fechas de salida
    - Por estado y valor mínimo

## Enlaces

- **Repositorio:** https://github.com/johannmoreno/vuelo-app-jsp.git
- **Video de sustentación:** *(pendiente)*
- **Aplicación desplegada:** *(pendiente)*