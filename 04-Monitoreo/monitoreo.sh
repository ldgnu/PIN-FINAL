#!/bin/bash
# Instalar Prometheus y Grafana usando Helm (Manejador de paquetes para Kubernetes) con LoadBalancer

# Agregar repositorios de Helm
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Crear el namespace prometheus
kubectl create namespace prometheus

# Desplegar Prometheus en EKS
helm install prometheus prometheus-community/prometheus \
  --namespace prometheus \
  --set alertmanager.persistentVolume.storageClass="gp2" \
  --set server.persistentVolume.storageClass="gp2" \
  --set service.type=LoadBalancer

# Verificar la instalación de Prometheus
kubectl get all -n prometheus

# Exponer Prometheus en el LoadBalancer asignado
PROMETHEUS_LOADBALANCER=$(kubectl get svc -n prometheus prometheus-server -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Instalar Grafana en EKS
helm install grafana grafana/grafana \
  --namespace prometheus \
  --set persistence.storageClassName="gp2" \
  --set service.type=LoadBalancer

# Obtener la contraseña generada automáticamente para Grafana
GF_SECURITY_ADMIN_PASSWORD=$(kubectl get secret --namespace prometheus grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)

# Exponer Grafana en el LoadBalancer asignado
GRAFANA_LOADBALANCER=$(kubectl get svc -n prometheus grafana -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "Prometheus y Grafana se han instalado exitosamente."
echo "Prometheus está disponible en: http://$PROMETHEUS_LOADBALANCER"
echo "Grafana está disponible en: http://$GRAFANA_LOADBALANCER"
echo "Usuario de Grafana: admin"
echo "Contraseña de Grafana: $GF_SECURITY_ADMIN_PASSWORD"