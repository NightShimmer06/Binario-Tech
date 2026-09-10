#!/bin/bash
echo "===================================================="
echo " AUDITORIA DE VALIDAÇÃO E ERROS - AULA 13"
echo "===================================================="

echo -e "\n[1] Teste 1: Envio de Payload INVÁLIDO (Esperado HTTP 422)..."
curl -s -X POST http://localhost:3005/api/v1/veiculos \
  -H "Content-Type: application/json" \
  -d '{ "placa": "ABC", "chassi": "123", "capacidadeCargaKg": 50 }' | jq .

echo -e "\n[2] Teste 2: Envio de Payload VÁLIDO (Esperado HTTP 201)..."
curl -s -X POST http://localhost:3005/api/v1/veiculos \
  -H "Content-Type: application/json" \
  -d '{ "placa": "ABC-1234", "chassi": "19BMSR450XYZ12345", "capacidadeCargaKg": 15000 }' | jq .

echo -e "\n[3] Teste 3: Simulação de Erro Interno do Servidor (Esperado HTTP 500)..."
curl -s -X POST http://localhost:3005/api/v1/veiculos \
  -H "Content-Type: application/json" \
  -d '{ "placa": "ABC-1234", "chassi": "ERRO_SIMULADO_500", "capacidadeCargaKg": 15000 }' | jq .

echo -e "\n[4] Teste 4: Rota Inexistente (Esperado HTTP 404)..."
curl -s http://localhost:3005/api/v1/rota-invalida | jq .

echo -e "\n[5] Teste EXERCÍCIO 1: Validar se a placa minúscula 'abc-1234' foi para MAIÚSCULA..."
curl -s -X POST http://localhost:3005/api/v1/veiculos \
  -H "Content-Type: application/json" \
  -d '{ "placa": "abc-1234", "chassi": "19BMSR450XYZ12345", "capacidadeCargaKg": 5000 }' | jq '.veiculo.placa'

echo -e "\n[6] Teste EXERCÍCIO 2: Envio de Ano de Fabricação INVÁLIDO (Esperado HTTP 422)..."
curl -s -X POST http://localhost:3005/api/v1/veiculos \
  -H "Content-Type: application/json" \
  -d '{ "placa": "ABC-1234", "chassi": "19BMSR450XYZ12345", "capacidadeCargaKg": 5000, "anoFabricacao": 1998 }' | jq .

echo -e "\n[7] Teste EXERCÍCIO 3: Envio SEM o cabeçalho Content-Type JSON (Esperado HTTP 400)..."
curl -s -X POST http://localhost:3005/api/v1/veiculos \
  -d '{ "placa": "ABC-1234", "chassi": "19BMSR450XYZ12345", "capacidadeCargaKg": 5000 }' | jq .

echo -e "\n[8] Teste EXERCÍCIO 4: Filtrando apenas mensagens com JQ..."
curl -s -X POST http://localhost:3005/api/v1/veiculos \
  -H "Content-Type: application/json" \
  -d '{ "placa": "123", "chassi": "curto", "capacidadeCargaKg": 10 }' | jq '.erros[].mensagem'
