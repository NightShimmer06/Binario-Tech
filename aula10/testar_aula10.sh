#!/bin/bash
echo "=================================================="
echo " AUDITORIA DE SEEDS E TRATAMENTO DE ERROS - AULA 10 "
echo "=================================================="

echo -e "\n[1] Consultando dados pré-populados pelo Seed..."
curl -s http://localhost:3000/api/v1/frota/veiculo | jq .

echo -e "\n[2] Consultando leituras de telemetria por ID de veículo..."
curl -s http://localhost:3000/api/v1/telemetria/veiculo/1 | jq .

echo -e "\n[3] Testando erro de placa duplicada (Conflito - Status 409)..."
curl -s -X POST http://localhost:3000/api/v1/frota/veiculo \
  -H "Content-Type: application/json" \
  -d '{"placa":"VOL_1010","montadora":"Volvo","modelo":"FH 540"}' | jq .

echo -e "\n[4] Testando cadastro de telemetria com veículo inexistente (Exercício 2 - Status 404)..."
curl -s -X POST http://localhost:3000/api/v1/telemetria/cadastrar \
  -H "Content-Type: application/json" \
  -d '{"veiculo_id": 999, "velocidade": 82.5, "temperatura_motor": 90.3}' | jq .

echo -e "\n[5] Cadastrando o veículo Volkswagen Delivery (Exercício 4)..."
curl -s -X POST http://localhost:3000/api/v1/frota/veiculo \
  -H "Content-Type: application/json" \
  -d '{"placa": "VW_DEL_2026", "montadora": "Volkswagen", "modelo": "Delivery"}' | jq .

echo -e "\n[6] Cadastrando primeira telemetria para o novo veículo (Exercício 4)..."
curl -s -X POST http://localhost:3000/api/v1/telemetria/cadastrar \
  -H "Content-Type: application/json" \
  -d '{"veiculo_id": 2, "velocidade": 60.5, "temperatura_motor": 85.0}' | jq .

echo -e "\n[7] Cadastrando segunda telemetria com temperatura alta (Exercício 4)..."
curl -s -X POST http://localhost:3000/api/v1/telemetria/cadastrar \
  -H "Content-Type: application/json" \
  -d '{"veiculo_id": 2, "velocidade": 45.2, "temperatura_motor": 98.5}' | jq .

echo -e "\n[8] Testando relatório completo com filtro de alerta (Exercício 3)..."
curl -s "http://localhost:3000/api/v1/telemetria/relatorio?alerta=true" | jq .

