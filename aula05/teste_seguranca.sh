#!/bin/bash
echo "=== INICIANDO AUDITORIA ===" > audit_seguranca.log

# Faz as 3 primeiras requisições sem o cabeçalho (vão retornar erro 401)
for i in 1 2 3; do
	curl -s -X GET http://localhost:3005/api/v1/manutencoes >> audit_seguranca.log
	echo "" >> audit_seguranca.log
done

# Faz a quarta requisição com a chave correta (vai retornar sucesso)
curl -s -X GET http://localhost:3005/api/v1/manutencoes -H "X-API-KEY: binario-tech-secret-2026" >> audit_seguranca.log

echo "" >> audit_seguranca.log

