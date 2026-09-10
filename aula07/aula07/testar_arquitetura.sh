#!/bin/bash
echo "=============================="
echo " TESTE INTEGRADO DE ARQUITETURA - BINARIO TECH"
echo "================================================"
echo -e "\n[1] Consultando Telemetria Scania..."
curl -s http://localhost:3005/api/v1/telemetria/scania | jq .

echo -e "\n[2] Consultando Telemetria Mercedes-Benz..."
curl -s http://localhost:3005/api/v1/telemetria/mercedes | jq .

echo -e "\n[3] Enviando Dado de Telemetria com Alerta de Aquecimento..."
curl -s -X POST http://localhost:3005/api/v1/telemetria/scania \
	-H "Content-type: application/json" \
	-d '{"modelo":"R450","vin":"9BS555444333","temperatura_motor":99}' | jq .
curl -s -X POST http://localhost:3005/api/v1/telemetria/mercedes \
        -H "Content-type: application/json" \
        -d '{"modelo":"Atego","vin":"9CT555444333","temperatura_motor":99}' | jq .

echo -e "\n [4] Testando Envio de VIN Inválido para Telemetria Scania..."
curl -X POST http://localhost:3005/api/v1/telemetria/scania \
	-H "Content-Type: application/json" \
	-d '{"modelo": "R450", "vin": "12345", "temperatura_motor": 99}'

echo -e "\n[5] Testando Endpoint Inexistente (404)..."
curl -s http://localhost:3005/api/v1/telemetria/volvo | jq .
