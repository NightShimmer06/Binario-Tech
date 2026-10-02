#!/bin/bash
echo "=================================================="
echo "  PIPELINE DE DEPLOY AUTOMATIZADO - BINARIO TECH  "
echo "=================================================="

REPO_DIR="$HOME/curso-pbe1/binario_tech"
APP_NAME="api-cicd"
PORT=3005

echo "[1/4] Atualizando código-fonte do repositório remoto..."
cd $REPO_DIR
git pull origin main

echo "[2/4] Verificando e instalando novas dependências..."
cd $REPO_DIR/aula21
npm install --production

echo "[3/4] Reiniciando aplicação no PM2..."
pm2 delete $APP_NAME 2>/dev/null || true
pm2 start server.js --name "$APP_NAME"

echo "[4/4] Executando Smoke Test na API (Porta $PORT)..."
sleep 2
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/api/v1/versao)

if [ "$HTTP_STATUS" -eq 200 ]; then
	echo -e "\n[SUCESSO] Deploy realizado e verificado com sucesso! HTTP Status 200."
	pm2 list | grep $APP_NAME
	
	HASH_COMMIT=$(git rev-parse --short HEAD)
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Deploy realizado com sucesso. Commit Hash: $HASH_COMMIT" >> deploy_history.log

	sleep 5
	cat deploy_history.log

else
	echo -e "\n[FALHA] Smoke Test falhou com status $HTTP_STATUS! HTTP Status 200."
	pm2 logs $APP_NAME --lines 20
	exit 1
fi
echo "=================================================="
