#!/bin/bash
set -e

# Actualizar sistema
echo "Actualizando paquetes..."
sudo apt update && sudo apt upgrade -y

# Instalar dependencias
echo "Instalando dependencias..."
sudo apt install -y curl wget unzip libfontconfig1 musl

# Instalar Prometheus
echo "Instalando Prometheus..."
PROM_VERSION="2.47.2"
wget https://github.com/prometheus/prometheus/releases/download/v$PROM_VERSION/prometheus-$PROM_VERSION.linux-amd64.tar.gz

tar xvf prometheus-$PROM_VERSION.linux-amd64.tar.gz
sudo mv prometheus-$PROM_VERSION.linux-amd64 /usr/local/prometheus

# Crear usuario y servicio para Prometheus
sudo useradd -M -r -s /bin/false prometheus
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

# Instalar Grafana
echo "Instalando Grafana..."
wget https://dl.grafana.com/oss/release/grafana_10.3.1_amd64.deb
sudo dpkg -i grafana_10.3.1_amd64.deb || sudo apt-get install -f -y  # Corregir dependencias faltantes
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

# Instalar Loki
echo "Instalando Loki..."
LOKI_VERSION="2.9.1"
wget https://github.com/grafana/loki/releases/download/v$LOKI_VERSION/loki-linux-amd64.zip
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