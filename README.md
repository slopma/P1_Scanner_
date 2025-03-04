# HU-7: Formulario de Ingreso Manual de CV

**Como** candidato  
**Quiero** poder ingresar manualmente mi información en un formulario en la aplicación  
**Para** almacenar mis datos en el sistema y postularme a empleos.  

---

## Criterios de Aceptación

### 1. Visualización de Cuestionario
- **Dado que** el candidato accede al formulario de ingreso manual de CV,  
- **Cuando** visualiza las preguntas predeterminadas y sus respectivos campos,  
- **Entonces** puede ver el cuestionario completo.

---

### 2. Crear Cajones de Preguntas
- **Dado que** el candidato accede al formulario de ingreso manual de CV,  
- **Cuando** visualiza los campos predefinidos para ingresar su información,  
- **Entonces** puede escribir su información en cada campo.

---

### 3. Persistencia de Datos
- **Dado que** el candidato ha ingresado su información en el formulario,  
- **Cuando** presiona el botón **"Guardar CV"**,  
- **Entonces** el sistema almacena la información en la base de datos  
- **Y** la información permanece disponible en futuros accesos.

---

### 4. Edición de los Campos
- **Dado que** el candidato ha guardado previamente su CV,  
- **Cuando** accede a la sección de edición de CV  
- **Y** modifica la información de los campos necesarios  
- **Y** presiona el botón **"Actualizar CV"**,  
- **Entonces** el sistema guarda los cambios  
- **Y** muestra un mensaje de confirmación.

---

### 5. Eliminación de CV
- **Dado que** el candidato accede a la lista de sus CVs almacenados,  
- **Cuando** selecciona su CV y presiona el botón **"Eliminar"**,  
- **Entonces** el sistema solicita confirmación para eliminar el CV  
- **Y** si el usuario confirma, el CV se elimina del sistema  
- **Y** muestra un mensaje de éxito.