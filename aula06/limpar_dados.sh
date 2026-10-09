#!/bin/bash
echo "==========================================="
echo " REINICIALIZAÇÃO DE ARQUIVO - BINARIO TECH"
echo "==========================================="

echo -e "\n[1] Encerrando ocorrencias_api.js..."
# Captura o PID dinamicamente usando o utilitário pgrep
 # O QUE É O PID? 
# PID significa 'Process ID' (Identificador de Processo). Ele funciona como o CPF/RG de um programa rodando no Linux.
# Toda vez que a API inicia, ela ganha um número único do sistema (ex: 7363). O comando pgrep busca esse número pelo nome do arquivo.
PID=$(pgrep -f ocorrencias_api.js)

#Fecha o programa a força usando o PID
 sudo kill -9 $PID

 echo -e "\n[2] Excluindo arquivo..."

# Para caso precise repor o conteudo do ocorrencias_api futuramente
cat ocorrencias_api.js > .ocorrencias_backup

sleep 5

# Sobrescreve o arquivo com um array vazio para resetar a persistência
echo "[]" > ocorrencias_api.js

echo "==========================================="
echo -e "\n[3] Exclusão realizada"
cat ocorrencias_api.js
echo "==========================================="

