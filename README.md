Laboratorio 5: Serverless Data Pipeline & Observability Stack
Este proyecto implementa una arquitectura 100% Serverless en AWS para el monitoreo de eventos de microservicios. Utiliza FastAPI para la lógica de negocio, Terraform para la Infraestructura como Código (IaC) y un stack de Observabilidad para el seguimiento de errores.

🚀 Arquitectura
API Gateway (HTTP API): Punto de entrada público para los eventos.

AWS Lambda: Procesa la lógica de la API ejecutando un contenedor Docker.

DynamoDB: Base de Datos NoSQL para el almacenamiento persistente de tickets.

CloudWatch & SNS: Monitoreo de errores con alertas automáticas vía email.

🛠️ Tecnologías Utilizadas
Backend: Python 3.11, FastAPI, Mangum.

Infraestructura: Terraform, AWS (Lambda, DynamoDB, ECR, S3, CloudWatch).

CI/CD: GitHub Actions & Docker.

📋 Requisitos Previos
Bucket de S3 para el Estado: Crear el bucket para el backend de Terraform:

Bash
aws s3api create-bucket --bucket TU-NOMBRE-UNICO-BUCKET --region us-east-1
Secretos en GitHub: Configurar AWS_ACCESS_KEY_ID y AWS_SECRET_ACCESS_KEY en los Secrets del repositorio.

🔧 Despliegue
El despliegue es automático mediante GitHub Actions al realizar un push a la rama main. El pipeline realiza las siguientes etapas:

Terraform Apply: Provisión de toda la infraestructura en AWS.

Docker Build & Push: Construcción de la imagen de la API y subida a Amazon ECR.

Lambda Update: Actualización de la función con la nueva versión del contenedor.

🧪 Pruebas de Funcionamiento
Una vez desplegado, puedes enviar un evento de prueba usando curl:

Bash
curl -X POST https://<TU_API_URL>/events \
     -H "Content-Type: application/json" \
     -d '{
       "service_name": "Auth_Service",
       "status": "ERROR",
       "message": "Fallo en la validación de token"
     }'
Monitoreo
Dashboard: Accede a CloudWatch -> Dashboards -> System-Health-Dashboard para ver las métricas en tiempo real.

Alertas: Si se generan más de 5 errores en un minuto, recibirás un correo electrónico a través de SNS.