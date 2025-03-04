# Despliegue Automatizado de Grafana, Prometheus y Loki en Azure 🚀

Este repositorio permite desplegar una máquina virtual Ubuntu Server en Azure con Grafana, Prometheus y Loki preconfigurados.

## 🚀 **Implementación Automática en Azure**
Haz clic en el botón de abajo para desplegar automáticamente la infraestructura en Azure:

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FTU-USUARIO%2Fazure-deploy-monitoring%2Fmain%2Fazuredeploy.json)

## 📌 **Requisitos Previos**
- Una cuenta en **Microsoft Azure**.
- Una **suscripción de Azure** con permisos para crear recursos.
- Configurar **GitHub Actions** con las credenciales de Azure.

## 📜 **Configuración de GitHub Actions**
Debes configurar los siguientes **secretos en GitHub**:
1. **AZURE_CREDENTIALS** → JSON de autenticación de Azure Service Principal.
2. **AZURE_SUBSCRIPTION_ID** → ID de la suscripción de Azure.
3. **AZURE_VM_IP** → Dirección IP de la VM.
4. **AZURE_VM_USER** → Usuario SSH de la VM.
5. **AZURE_VM_PASSWORD** → Contraseña SSH de la VM.

## 📝 **Uso**

1. Haz clic en **Deploy to Azure**.
2. Selecciona una **Región**.
3. Selecciona la **Suscripción de Azure** de destino.
4. Elige un **Grupo de Recursos** existente o crea uno nuevo.
5. Opcionalmente, cambia las credenciales de la VM.
6. Confirma y lanza el despliegue.

---

¡Disfruta de la monitorización con Grafana, Prometheus y Loki en Azure! 🚀
