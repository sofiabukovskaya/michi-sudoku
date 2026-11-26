# Política de privacidad

**Borrador para revisión.** El responsable de los datos de MICHI es {{CONTROLLER}}, con sede en {{COUNTRY}}. Solicitudes de privacidad: [{{EMAIL}}](mailto:{{EMAIL}}).

## Qué queda en tu dispositivo

- La base de datos local guarda partidas en curso y terminadas, progreso en técnicas, retos diarios completados y tableros importados.
- Las preferencias locales incluyen nivel y fin de la introducción, idioma, recordatorio de racha, mejores marcas, días resueltos de Spot it, sellos vistos del cuaderno y tu elección sobre informes de fallos.
- Con tu permiso, el escáner lee una captura o una foto que elijas. Un modelo TensorFlow Lite integrado la procesa en tu dispositivo. MICHI no sube fotos e intenta borrar la captura temporal después de leerla. El original de la galería se conserva. Las versiones internas de diagnóstico pueden conservar archivos de escaneo locales.
- Si activas el recordatorio de racha, se programa en el dispositivo a partir de las horas locales en las que terminas tus partidas. Puedes desactivarlo en Ajustes o retirar el permiso de avisos.

## Cuenta y sincronización

Si juegas sin cuenta, tu progreso se queda en el dispositivo. Al registrarte por correo electrónico, Firebase Authentication gestiona el nombre, correo, contraseña e identificador de cuenta. Si la versión ofrece acceso con Google o Apple y lo eliges, ese proveedor te autentica y Firebase recibe credenciales y datos de perfil disponibles, como nombre y correo.

Al iniciar sesión, Cloud Firestore sincroniza partidas terminadas, retos diarios completados y progreso en técnicas, incluidas las aportaciones de cada instalación. Al terminar una partida importada, pueden sincronizarse los números del tablero inicial y final, tiempos, errores y pistas usadas. Las partidas en curso no se sincronizan. Los registros del antiguo aviso de las 8:00 pueden contener ID de instalación, plataforma, idioma, zona horaria, token de notificación y horario.

## Servicios para todas las personas

- Firebase Remote Config proporciona ajustes de contenido y funciones. Firestore entrega puzles publicados y retos diarios. Reciben datos técnicos habituales, como la IP y, según el servicio, información del SDK o la instalación.
- La aplicación sigue incluyendo el SDK de Firebase Messaging. Puede generar identificadores de instalación y registro de avisos incluso si solo usas el recordatorio local.
- Firebase App Check comprueba la aplicación y el dispositivo para evitar abusos con Play Integrity o App Attest, con DeviceCheck como alternativa.
- Firebase Crashlytics ayuda a diagnosticar fallos. Los informes pueden incluir trazas de pila, modelo, sistema operativo, versión de la aplicación y datos de instalación. **Compartir informes de fallos** está activado por defecto en versiones publicadas. Cámbialo en Ajustes → Acerca de MICHI. Al desactivarlo, Dart deja de enviar nuevos informes. Es posible que el SDK nativo aplique el cambio al volver a abrir la aplicación. Los informes enviados no se ven afectados y el SDK puede guardar datos de fallos localmente mientras no se comparten.

La recopilación de Firebase Analytics está desactivada. MICHI no muestra anuncios, no te rastrea entre aplicaciones y no vende datos. Actualmente no recoge datos de pago. Si se añaden compras de MICHI Plus, Apple o Google las procesarán con arreglo a sus propias condiciones.

## Proveedores, conservación y derechos

Google proporciona los [servicios de Firebase](https://firebase.google.com/support/privacy). Apple puede procesar datos de verificación del dispositivo e inicio de sesión opcional. Firebase puede tratar datos fuera de tu país. La función de limpieza de cuentas se ejecuta en europe-west1, lo que no determina la ubicación de todos los servicios. Firebase Authentication procesa los datos de cuenta en Estados Unidos. Si nos escribes, usamos tu correo y mensaje para responder.

Los datos locales permanecen hasta que los borres en la aplicación, vacíes su almacenamiento o la desinstales, según las copias de seguridad del sistema. Los datos sincronizados se guardan hasta que elimines la cuenta. La conservación en Firebase depende del servicio. {{RETENTION}} {{LEGAL_BASIS_TRANSFERS}}

Según la ley aplicable, puedes pedir acceso, rectificación, supresión, limitación o portabilidad, oponerte al tratamiento o reclamar ante una autoridad de protección de datos. Escribe a [{{EMAIL}}](mailto:{{EMAIL}}). Puedes cambiar los permisos de cámara, fotos y avisos en los ajustes del dispositivo.

## Comentarios

Al enviar comentarios, MICHI guarda la categoría, el mensaje, el correo opcional de respuesta y, si los incluyes, versión y compilación, plataforma, versión del sistema, modelo, idioma y estado de sesión. El correo solo se usa para responder. Usamos el ID de la instalación y, si has iniciado sesión, el de tu cuenta para limitar abusos. Si hay una sesión iniciada, guardamos también el ID de cuenta con el mensaje. El operador de MICHI puede recibir el mensaje por correo. Al activar la política de conservación, se programa el borrado de Firestore tras 24 meses. Para las copias de correo rige {{RETENTION}}. Los borradores quedan en tu dispositivo hasta que los envíes o borres el almacenamiento. No adjuntamos fotos del escáner.

## Eliminar tu cuenta

Inicia sesión y abre **Perfil → Ajustes → Cuenta → Eliminar cuenta**. Firebase elimina la cuenta e inicia el borrado de partidas, progreso y recordatorios en la nube. MICHI elimina el perfil local de esa cuenta en ese dispositivo. Los datos de invitado y las copias de otros dispositivos pueden seguir ahí. Si no puedes usar la aplicación, escribe a [{{EMAIL}}](mailto:{{EMAIL}}) desde el correo de tu cuenta y pide eliminar tu cuenta de MICHI y los datos asociados. No envíes tu contraseña. Podemos verificar la titularidad de la cuenta.
