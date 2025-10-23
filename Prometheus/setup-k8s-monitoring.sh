#!/bin/bash
# Script per setup ambiente Kubernetes con Prometheus e Grafana

set -e

echo "🚀 Setup ambiente Kubernetes con monitoring..."

# Colori per output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Crea namespace
echo -e "${BLUE}📦 Creazione namespaces...${NC}"
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace demo-app --dry-run=client -o yaml | kubectl apply -f -

# Installa Prometheus usando Helm
echo -e "${BLUE}📊 Installazione Prometheus...${NC}"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
  --set grafana.adminPassword=admin123 \
  --wait

# Applica le applicazioni demo
echo -e "${BLUE}🎯 Deploy applicazioni demo...${NC}"
kubectl apply -f demo-app-deployment.yaml
kubectl apply -f demo-app-service.yaml
kubectl apply -f demo-app-servicemonitor.yaml

# Attendi che i pod siano pronti
echo -e "${BLUE}⏳ Attendo che i pod siano pronti...${NC}"
kubectl wait --for=condition=ready pod -l app=demo-app -n demo-app --timeout=120s
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=prometheus -n monitoring --timeout=180s
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=grafana -n monitoring --timeout=180s

# Port forwarding
echo -e "${GREEN}✅ Setup completato!${NC}"
echo ""
echo "Per accedere ai servizi, esegui questi comandi in terminali separati:"
echo ""
echo "Prometheus:"
echo "  kubectl port-forward --address 0.0.0.0 -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090"
echo "  URL: http://localhost:9090"
echo ""
echo "Grafana:"
echo "  kubectl port-forward --address 0.0.0.0 -n monitoring svc/prometheus-grafana 3000:80"
echo "  URL: http://localhost:3000"
echo "  Username: admin"
echo "  Password: admin123"
echo ""
echo "Demo App:"
echo "  kubectl port-forward --address 0.0.0.0 -n demo-app svc/demo-app 8080:80"
echo "  URL: http://localhost:8080"
echo ""
echo "Per generare traffico:"
echo "  ./generate-traffic.sh"