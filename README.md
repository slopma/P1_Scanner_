## Historia de Usuario (Cargar la CV)


### Escenario 1: Tomar una foto del CV
_Dado_ que el usuario está en la sección de escaneo de CV,  
_Cuando_ seleccione la opción de "Tomar foto",  
_Y_ capture la imagen con la cámara,  
_Entonces_ la aplicación debe permitir revisar la foto y confirmar el escaneo.

### Escenario 2: Subir un archivo digital
_Dado_ que el usuario está en la sección de escaneo de CV,  
_Cuando_ seleccione la opción de "Subir archivo",  
_Y_ elija un archivo válido (PDF, DOCX, JPG, PNG),  
_Entonces_ la aplicación debe procesar el archivo y extraer la información.

### Escenario 3: Crear la hoja de vida mediante formulario
_Dado_ que el usuario está en la sección de escaneo de CV,  
_Cuando_ seleccione la opción de "Crear CV manualmente",  
_Y_ complete los campos requeridos (nombre, experiencia, educación, etc.),  
_Entonces_ la aplicación debe guardar la información y generar el CV en formato digital.

