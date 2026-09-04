#!/bin/bash
echo "==================================================="
echo " AUDITORIA DE BANCO DE DADOS SQLITE - BINARIO TECH "
echo "==================================================="

echo -e "\n[1] Cadastrando veiculos Scania..."
curl -s -X POST http://localhost:3000/api/v1/veiculos \
	-H "Content-Type: application/json" \
	-d '{"placa":"SCA-2026","montadora":"Scania","modelo":"R500"}' | jq .

echo -e "\n[2] Cadastrando veiculos Mercedes-Benz..."
curl -s -X POST http://localhost:3000/api/v1/veiculos \
        -H "Content-Type: application/json" \
        -d '{"placa":"MBB-2026","montadora":"Mercedes-Benz","modelo":"Actro 2651"}' | jq .

echo -e "\n[3] Listando todos os veiculos gravados no banco relacional..."
curl -s http://localhost:3000/api/v1/veiculos

echo -e "\n[4] Buscando o veiculo com ID 1 (Exercicio 1)..."
curl -s -X GET http://localhost:3000/api/v1/veiculos/1 | jq .

echo -e "\n[5] Atualizando o status do veiculo com ID 1 (Exercicio 2)..."
curl -s -X PATCH http://localhost:3000/api/v1/veiculos/1/status \
     -H "Content-Type: application/json" \
     -d '{"status":"manutencao"}' | jq .
