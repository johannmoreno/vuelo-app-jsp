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
| MySQL | 8.4.3 (vía Laragon en local / Railway en producción) |
| Maven | (incluido en el proyecto) |
| MySQL Connector/J | 9.1.0 |
| Brevo API | v3 (envío de correos transaccionales vía HTTPS) |
| Docker | Imagen base Tomcat + Maven multi-stage build |

## Arquitectura del proyecto
src/main/java/com/johannmoreno/vueloapp/
├── domain/model/ -> Entidades: Usuario, Vuelo
├── infrastructure/
│ ├── database/ -> Conexión JDBC a MySQL
│ ├── persistence/ -> CRUD: UsuarioCRUD, VueloCRUD
│ └── email/ -> Envío de correos vía API de Brevo (EmailService)
└── business/
├── exceptions/ -> Excepciones de negocio
└── services/ -> Lógica de negocio: UsuarioService, VueloService

src/main/webapp/
├── index.jsp
├── Controllers/ -> UsuarioController.jsp, VueloController.jsp
└── Views/
├── Css/ -> Hoja de estilos
└── Forms/
├── Usuarios/ -> login, crear, buscar/editar/eliminar, listar, recuperar, reportes
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

**En producción (Railway):** la base de datos MySQL corre como un servicio independiente dentro del mismo proyecto de Railway, con conexión pública vía proxy TCP.

## Configuración de variables de entorno

La aplicación lee toda su configuración sensible desde variables de entorno, tanto en local como en producción, para no exponer credenciales en el código fuente (el repositorio es público).

| Variable | Descripción |
|---|---|
| `MYSQLHOST` | Host del servidor MySQL |
| `MYSQLPORT` | Puerto del servidor MySQL |
| `MYSQLDATABASE` | Nombre de la base de datos |
| `MYSQLUSER` | Usuario de MySQL |
| `MYSQLPASSWORD` | Contraseña de MySQL |
| `BREVO_API_KEY` | API Key de Brevo (brevo.com) para el envío de correos transaccionales |
| `REMITENTE_EMAIL` | Correo verificado en Brevo desde el cual se envían los correos de recuperación de clave |

Si estas variables no están definidas (como ocurre en desarrollo local si no se configuran explícitamente), la conexión a base de datos usa valores por defecto para trabajar contra un MySQL local (`localhost:3306`, base `vuelo_app`, usuario `root` sin contraseña).

**En IntelliJ IDEA:** Run > Edit Configurations > (tu configuración de Tomcat) > Environment variables.

**En Railway:** se configuran en la pestaña "Variables" del servicio web, dentro del panel del proyecto.

### Nota sobre el envío de correo

Inicialmente se intentó usar SMTP directo contra Gmail (puertos 587 y 465), pero **Railway bloquea las conexiones SMTP salientes** en su plan gratuito. Por eso el envío de correos se migró a la **API HTTPS de Brevo** (antes Sendinblue), que funciona sobre el puerto 443 sin restricciones. Brevo requiere verificar el correo remitente y ofrece 300 correos gratuitos por día, suficiente para este proyecto.

## Cómo ejecutar el proyecto localmente

1. Clona el repositorio:
```bash
   git clone https://github.com/johannmoreno/vuelo-app-jsp.git
```
2. Ábrelo en IntelliJ IDEA como proyecto Maven existente.
3. Verifica que tengas JDK 21 y Apache Tomcat 11 instalados y configurados como Application Server.
4. Configura las variables de entorno `BREVO_API_KEY` y `REMITENTE_EMAIL` (ver sección anterior). Si usas MySQL local con la configuración por defecto (Laragon, root sin contraseña), no necesitas configurar las variables `MYSQLHOST`, etc.
5. Ejecuta el script `script_bd.sql` en tu MySQL local.
6. Corre la configuración de Tomcat desde IntelliJ (botón ▶).
7. Abre `http://localhost:8080/vueloapp/` en el navegador (ajusta el context path según tu configuración local).

## Usuario de prueba

| Email | Clave |
|---|---|
| jdmoreno159@gmail.com | (clave configurada en el script, o la más reciente tras usar recuperación de clave) |

## Funcionalidades implementadas

- CRUD completo de Usuario (crear, listar, buscar, editar, eliminar)
- CRUD completo de Vuelo (crear, listar, buscar, editar, eliminar)
- Autenticación (login / logout) con manejo de sesión
- Recuperación de clave por correo electrónico (genera clave temporal y la envía vía Brevo)
- Reportes parametrizados de Usuario:
    - Por rol
    - Por dominio de correo electrónico
- Reportes parametrizados de Vuelo:
    - Por aerolínea y rango de fechas de salida
    - Por estado y valor mínimo
- Despliegue en contenedor Docker sobre Railway, con base de datos MySQL como servicio independiente

## Enlaces

- **Repositorio:** https://github.com/johannmoreno/vuelo-app-jsp
- **Aplicación desplegada:** https://vuelo-app-jsp-production.up.railway.app