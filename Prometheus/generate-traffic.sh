#!/bin/bash
# Script per generare traffico verso l'applicazione demo

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚦 Generatore di traffico per Demo App${NC}"
echo ""

# Verifica che il port-forward sia attivo
if ! curl -s http://localhost:8080 > /dev/null 2>&1; then
    echo -e "${RED}❌ Errore: Demo app non raggiungibile su localhost:8080${NC}"
    echo "Esegui prima: kubectl port-forward -n demo-app svc/demo-app 8080:80"
    exit 1
fi

echo -e "${GREEN}✅ Demo app raggiungibile${NC}"
echo ""
echo "Generazione traffico in corso... (CTRL+C per fermare)"
echo ""

REQUEST_COUNT=0
SUCCESS_COUNT=0
ERROR_COUNT=0

# Funzione per generare richieste
generate_request() {
    local endpoint=$1
    local expected_status=$2
    
    response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080${endpoint} 2>&1)
    
    if [ "$response" == "$expected_status" ]; then
        ((SUCCESS_COUNT++))
        echo -e "${GREEN}✓${NC} GET $endpoint - $response"
    else
        ((ERROR_COUNT++))
        echo -e "${RED}✗${NC} GET $endpoint - $response"
    fi
    ((REQUEST_COUNT++))
}

# Loop principale
while true; do
    # Richieste normali
    generate_request "/" "200"
    sleep $(awk -v min=0.5 -v max=2 'BEGIN{srand(); print min+rand()*(max-min)}')
    
    generate_request "/health" "404"
    sleep $(awk -v min=0.5 -v max=2 'BEGIN{srand(); print min+rand()*(max-min)}')
    
    generate_request "/api/data" "404"
    sleep $(awk -v min=0.5 -v max=2 'BEGIN{srand(); print min+rand()*(max-min)}')
    
    # Ogni 20 richieste, mostra statistiche
    if [ $((REQUEST_COUNT % 20)) -eq 0 ]; then
        echo ""
        echo -e "${BLUE}📊 Statistiche:${NC}"
        echo "   Totale richieste: $REQUEST_COUNT"
        echo "   Successi: $SUCCESS_COUNT"
        echo "   Errori: $ERROR_COUNT"
        echo ""
    fi
    
    # Simula burst di traffico ogni 50 richieste
    if [ $((REQUEST_COUNT % 50)) -eq 0 ]; then
        echo -e "${BLUE}🔥 Burst di traffico...${NC}"
        for i in {1..10}; do
            generate_request "/" "200" &
        done
        wait
    fi
done