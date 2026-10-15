#!/bin/bash

echo "========================================" >> crud_result.log
echo " INICIANDO TESTE CRUD                   " >> crud_result.log
echo " Data/Hora:$(date)                      " >> crud_result.log
echo "========================================" >> crud_result.log

echo "1. Cadastrando Veiculo 1..." >> crud_result.log
curl -s -X POST http://localhost:3005/api/v1/veiculos -H "Content-Type: application/json" -d "{\"placa\":\"AAA-1111\", \"montadora\":\"Volvo\", \"modelo\":\"FH\"}" >> crud_result.log
echo -e "\n" >> crud_result.log

echo "2. Cadastrando Veiculo 2..." >> crud_result.log
curl -s -X POST http://localhost:3005/api/v1/veiculos -H "Content-Type: application/json" -d "{\"placa\":\"BBB-2222\", \"montadora\":\"Scania\", \"modelo\":\"R450\"}" >> crud_result.log
echo -e "\n" >> crud_result.log

echo "3. Atualizando Veiculo de ID 1..." >> crud_result.log
curl -s -X PATCH http://localhost:3005/api/v1/veiculos/1 -H "Content-Type: application/json" -d "{\"status\":\"EM_ROTA\"}" >> crud_result.log
echo -e "\n" >> crud_result.log

echo "4. Substituindo Veiculo de ID 1..." >> crud_result.log
curl -s -X PUT http://localhost:3005/api/v1/veiculos/1 -H "Content-Type: application/json" -d '{"placa":"NEW-0000","montadora":"Scania Nova","modelo":"R500","status":"DISPONIVEL"}' | jq . >> crud_result.log
echo -e "\n" >> crud_result.log

echo "5. Deletando Veiculo de ID 1..." >> crud_result.log
curl -s -X DELETE http://localhost:3005/api/v1/veiculos/1 >> crud_result.log
echo -e "\n" >> crud_result.log

#para caso ter problemas para apagar IDs
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/13
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/12
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/11
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/10
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/9
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/8
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/7
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/6
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/5
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/4
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/3
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/2
#curl -s -X DELETE http://localhost:3005/api/v1/veiculos/1

echo "=========== TESTE FINALIZADO ===========" >> crud_result.log
