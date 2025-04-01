# Etapa 08 - Taller 3 - Integración con IA

Este proyecto integra tres funcionalidades que utilizan servicios de inteligencia artificial para generar contenido de forma automática. Todos los archivos se encuentran en la ruta `lib/AI` y se describen a continuación:

---

## Archivos y Funcionalidades

### AI.dart
>> Este código envía datos de un usuario a una API de IA ubicada en [OpenRouter](https://openrouter.ai/deepseek/deepseek-chat-v3-0324:free/) para generar un currículum vitae (CV) automáticamente.  
>> - **Funcionalidad:** Prepara y envía una solicitud HTTP con la información del usuario y, una vez procesada la respuesta, imprime el CV generado.

---

### AImage.dart
>> Este código es una aplicación en Flutter que permite al usuario seleccionar una imagen desde su dispositivo y extraer el texto contenido en ella utilizando OCR.  
>> - **Funcionalidad:** Envía la imagen a la API de OCR en [OCR.Space](https://ocr.space/OCRAPI/), procesa la respuesta y muestra el texto extraído en la interfaz de usuario.

---

### MokeyAI.dart
>> Este código envía una solicitud HTTP POST a la API de [PDFMonkey](https://pdfmonkey.io/) para generar un documento (currículum) basado en una plantilla predefinida.  
>> - **Funcionalidad:** Configura y envía la solicitud con los datos del usuario y la plantilla, procesando la respuesta para mostrar el estado y el enlace al documento generado.
