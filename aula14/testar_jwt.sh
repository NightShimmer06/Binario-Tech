echo "=============================================="
echo " AUDITORIA DE AUTENTICAÇÃO JWT - BINARIO TECH "
echo "=============================================="

echo -e "\n[1] Teste Exercício 3: Registrando usuário com senha curta (Esperado HTTP 400)..."
curl -s -X POST http://localhost:3000/api/v1/auth/register \
	  -H "Content-Type: application/json" \
	    -d '{ "email": "curto@binariotech.com.br", "senha": "123", "perfil": "OPERADOR" }' | jq .

echo -e "\n[2] Registrando novo Usuário ADMIN com senha válida..."
curl -s -X POST http://localhost:3000/api/v1/auth/register \
	  -H "Content-Type: application/json" \
	    -d '{ "email": "admin@binariotech.com.br", "senha": "SenhaSegura123!", "perfil": "ADMIN" }' | jq .

echo -e "\n[3] Realizando Login e obtendo JWT de 15 segundos..."
LOGIN_RESP=$(curl -s -X POST http://localhost:3000/api/v1/auth/login \
	  -H "Content-Type: application/json" \
	    -d '{ "email": "admin@binariotech.com.br", "senha": "SenhaSegura123!" }')
echo $LOGIN_RESP | jq .

TOKEN=$(echo $LOGIN_RESP | jq -r '.token')

echo -e "\n[4] Acessando Rota Protegida com Token Válido de imediato (Esperado HTTP 200)..."
curl -s http://localhost:3000/api/v1/auth/perfil \
	  -H "Authorization: Bearer $TOKEN" | jq .

echo -e "\n[5] Teste Exercício 4: Enviando Token Corrompido manualmente (Esperado HTTP 403)..."
curl -s http://localhost:3000/api/v1/auth/perfil \
	  -H "Authorization: Bearer ${TOKEN}REDE_INVALIDA" | jq .

echo -e "\n[6] Teste Exercício 2: Aguardando 16 segundos para expirar o Token..."
for i in {16..1}; do
	  echo -ne "Aguardando expiração em: $i segundos... \r"
	    sleep 1
    done
    echo -e "\nTentando acessar após expiração (Esperado HTTP 403 por expiração)..."
    curl -s http://localhost:3000/api/v1/auth/perfil \
	      -H "Authorization: Bearer $TOKEN" | jq .

