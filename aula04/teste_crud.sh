#!/bin/bash
echo "=== INICIANDO TESTE CRUD ===" > crud_result.log

echo "1. Cadastrando Veiculo 1..." >> crud_result.log
curl -s -X POST http://localhost:3005/api/v1/veiculos -H "Content-Type: application/json" -d "{\"placa\":\"AAA-1111\", \"montadora\":\"Volvo\", \"modelo\":\"FH\"}" >> crud_result.log
echo -e "\n" >> crud_result.log

echo "2. Cadastrando Veiculo 2..." >> crud_result.log
curl -s -X POST http://localhost:3005/api/v1/veiculos -H "Content-Type: application/json" -d "{\"placa\":\"BBB-2222\", \"montadora\":\"Scania\", \"modelo\":\"R450\"}" >> crud_result.log
echo -e "\n" >> crud_result.log

echo "3. Atualizando Veiculo de ID 1..." >> crud_result.log
curl -s -X PATCH http://localhost:3005/api/v1/veiculos/1 -H "Content-Type: application/json" -d "{\"status\":\"EM_ROTA\"}" >> crud_result.log
echo -e "\n" >> crud_result.log

echo "4. Deletando Veiculo de ID 2..." >> crud_result.log
curl -s -X DELETE http://localhost:3005/api/v1/veiculos/2 >> crud_result.log
echo -e "\n" >> crud_result.log

echo "=== TESTE FINALIZADO ===" >> crud_result.log
