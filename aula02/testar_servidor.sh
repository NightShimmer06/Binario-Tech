#!/bin/bash
echo "========================================"
echo "  TESTES - BINARIO TECH "
echo "	Data/Hora: $(date)"
echo "========================================"

echo -e "\n[1] Testando Status da binario Tech..."
curl -s http://localhost:3005/status | jq .
echo -e "Teste realizado em: $(date)"

sleep 2

echo -e "\n[2] Testando Rota Scania..."
curl -s http://localhost:3005/scania/info | jq .
echo -e "Teste realizado em: $(date)"

sleep 2

echo -e "\n[3] Testando Rota Volkswagen..."
curl -s http://localhost:3005/vw/info | jq .
echo -e "Teste realizado em: $(date)"

sleep 2

echo -e "\n----------------------------------------"
echo "Testes finalizado com sucesso!"
