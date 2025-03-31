# Scanner_CV
Proyecto para Proyecto Integrador 1, para el pregrado de Ingeniería de Sistemas de la Universidad EAFIT.

## Integrantes
- Luis Alejandro Castrillón Pulgarín
- Sara López Marín
- Paula Inés LLanos López
- Samuel Enrique Rivero Urribarrí

## Integración con IA

### Descripción General
El proyecto implementa una integración con AssemblyAI para la transcripción de audio a texto. Esta integración permite a los usuarios grabar audio y obtener una transcripción automática del contenido hablado.

### Archivos Principales
La integración con IA se encuentra principalmente en los siguientes archivos:

1. `lib/main.dart`
   - Contiene la implementación principal de la integración con AssemblyAI
   - Maneja la lógica de grabación de audio, procesamiento y transcripción
   - Implementa el manejo de límites de uso y costos

### Funcionalidades de IA Implementadas

#### 1. Transcripción de Audio
- Utiliza la API de AssemblyAI para convertir audio a texto
- Soporta el idioma español
- Implementa un sistema de reintentos y manejo de errores
- Incluye límites de uso mensuales (25,000 minutos)

#### 2. Procesamiento de Audio
- Grabación de audio en formato WebM
- Almacenamiento en Supabase
- Conversión y procesamiento del audio antes de la transcripción

#### 3. Gestión de Recursos
- Control de costos por minuto de transcripción
- Seguimiento de uso mensual
- Almacenamiento persistente de métricas de uso

### Configuración
La integración requiere las siguientes configuraciones:

1. API Key de AssemblyAI
   - Ubicación: `lib/main.dart`
   - Constante: `ASSEMBLY_API_KEY`

2. Límites de Uso
   - Máximo mensual: 25,000 minutos
   - Costo por minuto: $0.002

### Flujo de Trabajo
1. Grabación de audio
2. Almacenamiento en Supabase
3. Envío a AssemblyAI para transcripción
4. Procesamiento y almacenamiento del resultado
5. Actualización de la interfaz de usuario

### Consideraciones Técnicas
- La transcripción se realiza de forma asíncrona
- Implementa manejo de errores y timeouts
- Incluye sistema de reintentos para casos de fallo
- Almacena resultados en base de datos Supabase 