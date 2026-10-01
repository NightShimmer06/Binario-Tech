#!/bin/bash
URL="http://127.0.0.1:3005"

echo "===================================================="
echo "   AUDITORIA DE API INTEGRADA E JWT - AULA 17"
echo "===================================================="

echo -e "\n Teste 1: Rota Pública de Healthcheck (Esperado HTTP 200)..."
curl -s "$URL/api/v1/health" | jq .
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL/api/v1/health")
echo "[$(date +'%Y-%m-%d %H:%M:%S')] HTTP Status: $STATUS_CODE" > health_check.log
echo "-> Conteúdo salvo no arquivo health_check.log:"
cat health_check.log

echo -e "\n Teste 2: Geração de Token JWT de Teste (Esperado HTTP 200)..."
curl -s -X POST "$URL/api/v1/auth/token-teste" | jq .
TOKEN=$(curl -s -X POST "$URL/api/v1/auth/token-teste" | jq -r .token)

echo -e "\n Teste 3: Acesso à Rota Privada SEM Token (Esperado HTTP 401)..."
curl -s "$URL/api/v1/simulado/status" | jq .

echo -e "\n Teste 4: Acesso à Rota Privada COM Token Válido (Esperado HTTP 200)..."
curl -s -H "Authorization: Bearer $TOKEN" "$URL/api/v1/simulado/status" | jq .

echo -e "\n Teste 5: Extração do Nome do Usuário Autenticado..."
if [ "$TOKEN" != "null" ] && [ ! -z "$TOKEN" ]; then
  echo -n "-> Usuário obtido via jq: "
  curl -s -H "Authorization: Bearer $TOKEN" "$URL/api/v1/simulado/status" | jq -r .usuario.nome
else
  echo "-> [ERRO] Token não foi gerado no Teste 2."
fi

echo -e "\n===================================================="
echo "                TESTES CONCLUÍDOS"
echo "===================================================="

