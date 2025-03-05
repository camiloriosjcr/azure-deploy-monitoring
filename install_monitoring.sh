#!/bin/bash
set -e

# Actualizar sistema
echo "Actualizando paquetes..."
sudo apt update && sudo apt upgrade -y

# Instalar dependencias
echo "Instalando dependencias..."
sudo apt install -y curl wget unzip libfontconfig1 musl

# Instalar Prometheus (última versión)
echo "Instalando Prometheus..."
PROM_LATEST_RELEASE=$(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
PROM_VERSION="${PROM_LATEST_RELEASE#v}"  # Elimina el prefijo 'v' de la versión
PROM_URL="https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz"

wget $PROM_URL
tar xvf prometheus-${PROM_VERSION}.linux-amd64.tar.gz

# Eliminar el directorio de Prometheus si ya existe
if [ -d "/usr/local/prometheus" ]; then
    echo "Eliminando directorio existente de Prometheus..."
    sudo rm -rf /usr/local/prometheus
fi

# Mover los archivos de Prometheus
sudo mv prometheus-${PROM_VERSION}.linux-amd64 /usr/local/prometheus

# Crear usuario y servicio para Prometheus (solo si el usuario no existe)
if ! id -u prometheus > /dev/null 2>&1; then
    echo "Creando usuario prometheus..."
    sudo useradd -M -r -s /bin/false prometheus
else
    echo "El usuario prometheus ya existe, omitiendo creación..."
fi

sudo chown -R prometheus:prometheus /usr/local/prometheus

sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
Description=Prometheus Monitoring
After=network.target

[Service]
User=prometheus
ExecStart=/usr/local/prometheus/prometheus --config.file=/usr/local/prometheus/prometheus.yml --storage.tsdb.path=/usr/local/prometheus/data
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Instalar Grafana (última versión)
echo "Instalando Grafana..."
GRAFANA_LATEST_VERSION=$(curl -s https://api.github.com/repos/grafana/grafana/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
GRAFANA_VERSION="${GRAFANA_LATEST_VERSION#v}"  # Elimina el prefijo 'v' de la versión
GRAFANA_DEB_URL="https://dl.grafana.com/oss/release/grafana_${GRAFANA_VERSION}_amd64.deb"

wget $GRAFANA_DEB_URL
sudo dpkg -i grafana_${GRAFANA_VERSION}_amd64.deb || sudo apt-get install -f -y  # Corregir dependencias faltantes
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

# Instalar Loki (última versión)
echo "Instalando Loki..."
LOKI_LATEST_RELEASE=$(curl -s https://api.github.com/repos/grafana/loki/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
LOKI_VERSION="${LOKI_LATEST_RELEASE#v}"  # Elimina el prefijo 'v' de la versión
LOKI_URL="https://github.com/grafana/loki/releases/download/v${LOKI_VERSION}/loki-linux-amd64.zip"

wget $LOKI_URL
unzip loki-linux-amd64.zip
sudo mv loki-linux-amd64 /usr/local/bin/loki
chmod +x /usr/local/bin/loki

sudo tee /etc/systemd/system/loki.service > /dev/null <<EOF
[Unit]
Description=Loki log aggregation system
After=network.target

[Service]
ExecStart=/usr/local/bin/loki -config.file=/usr/local/bin/loki-config.yml
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable loki
sudo systemctl start loki

echo "Instalación completada. Prometheus, Grafana y Loki están en ejecución."