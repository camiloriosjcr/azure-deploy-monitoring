📢 Despliegue Automatizado de Grafana, Prometheus y Loki en Azure 🚀
Este repositorio permite desplegar una máquina virtual Ubuntu Server en Azure con Grafana, Prometheus y Loki preconfigurados, lo que facilita la implementación rápida de un entorno de monitoreo sin necesidad de configuraciones manuales.

📌 ¿Qué es Grafana, Prometheus y Loki?
🔹 Grafana 📊 → Es una plataforma de visualización y análisis de datos en tiempo real. Permite crear dashboards personalizados y visualizar métricas provenientes de múltiples fuentes, incluyendo Prometheus.

🔹 Prometheus 📡 → Es un sistema de monitoreo y alertas diseñado para recopilar métricas de aplicaciones y servidores. Utiliza una base de datos de series temporales optimizada para la observabilidad.

🔹 Loki 📜 → Es una solución de gestión y análisis de logs desarrollada por Grafana Labs. Permite centralizar y consultar logs de sistemas sin necesidad de indexarlos, reduciendo el consumo de recursos.

¿Qué hace este despliegue?
✅ Crea automáticamente una máquina virtual Ubuntu Server en Azure.
✅ Instala y configura Grafana, Prometheus y Loki automáticamente.
✅ Abre los puertos necesarios para acceder a los servicios desde Internet:

SSH (22) → Para la administración remota.
Grafana (3000) → Para la interfaz web de visualización.
Prometheus (9090) → Para la recolección de métricas.
Loki (3100) → Para la gestión de logs.

🛠 ¿Cómo desplegarlo en Azure?
1️⃣ Haz clic en el botón "Deploy to Azure".
2️⃣ Sigue los pasos en el portal de Azure para seleccionar los parámetros de la VM.
3️⃣ Espera a que la instalación automática finalice.
4️⃣ Accede a Grafana desde tu navegador con la IP pública de la VM y el puerto 3000.

📌 Este despliegue automatizado simplifica la configuración de un entorno de monitoreo en Azure, ahorrando tiempo y asegurando que todo esté listo para su uso desde el primer momento.

🚀 ¡Pon en marcha tu infraestructura de observabilidad en minutos!

## 🚀 **Implementación Automática en Azure**
Haz clic en el botón de abajo para desplegar automáticamente la infraestructura en Azure:

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcamiloriosjcr%2Fazure-deploy-monitoring%2Fmain%2Fazuredeploy.json)

## 📌 **Requisitos Previos**
- Una cuenta en **Microsoft Azure**.
- Una **suscripción de Azure** con permisos para crear recursos.
- Configurar **GitHub Actions** con las credenciales de Azure.

## 📝 **Uso**

1. Haz clic en **Deploy to Azure**.
2. Selecciona una **Región**.
3. Selecciona la **Suscripción de Azure** de destino.
4. Elige un **Grupo de Recursos** existente o crea uno nuevo.
5. Opcionalmente, cambia las credenciales de la VM.
6. Confirma y lanza el despliegue.

---

¡Disfruta de la monitorización con Grafana, Prometheus y Loki en Azure! 🚀
