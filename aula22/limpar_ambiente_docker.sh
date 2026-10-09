#!/bin/bash
echo "=================================================="
echo "    LIMPEZA DE AMBIENTE DOCKER - BINÁRIO TECH     "
echo "=================================================="

echo "Parando e removendo todos os containers inativos..."

docker container prune -f

sleep 2

echo -e "\nRemovendo imagens pendentes (dangling images)..."

docker image prune -f

echo "=================================================="
echo "Limpeza concluída com sucesso!"

