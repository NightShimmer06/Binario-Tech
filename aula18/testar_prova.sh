echo "=============================================================="
echo " AUDITORIA DE AUTENTICAÇÃO JWT - BINARIO TECH - PROVA AULA 18 "
echo "=============================================================="

echo -e "\n[1] Registrando usuário com senha curta (Esperado HTTP 400)..."
curl -s -X POST http://localhost:3005/api/v1/prova/register \
	  -H "Content-Type: application/json" \
	    -d '{ "email": "curto@binariotech.com.br", "senha": "123", "perfil": "OPERADOR" }' | jq .

echo -e "\n[2] Registrando novo Usuário ADMIN com senha válida..."
curl -s -X POST http://localhost:3005/api/v1/prova/register \
	  -H "Content-Type: application/json" \
	    -d '{ "email": "admin@binariotech.com.br", "senha": "SenhaSegura123!", "perfil": "ADMIN" }' | jq .

echo -e "\n[3] Realizando Login e obtendo JWT de 30 minutos..."
LOGIN_RESP=$(curl -s -X POST http://localhost:3005/api/v1/prova/login \
	  -H "Content-Type: application/json" \
	    -d '{ "email": "admin@binariotech.com.br", "senha": "SenhaSegura123!" }')
echo $LOGIN_RESP | jq .

TOKEN=$(echo $LOGIN_RESP | jq -r '.token')

echo -e "\n[4] Acessando Rota Protegida com Token Válido de imediato (Esperado HTTP 200)..."
curl -s http://localhost:3005/api/v1/prova/perfil \
	  -H "Authorization: Bearer $TOKEN" | jq .

echo -e "\n[5] Enviando Token Corrompido manualmente (Esperado HTTP 403)..."
curl -s http://localhost:3005/api/v1/prova/perfil \
	  -H "Authorization: Bearer ${TOKEN}REDE_INVALIDA" | jq .

echo -e "\n[6] Aguardando 1800 segundos para expirar o Token..."
for i in {1800..1}; do
	  echo -ne "Aguardando expiração em: $i segundos... \r"
	    sleep 1
    done
    echo -e "\n[7]Tentando acessar após expiração (Esperado erro por expiração)..."
    curl -s http://localhost:3005/api/v1/prova/perfil \
	      -H "Authorization: Bearer $TOKEN" | jq .

