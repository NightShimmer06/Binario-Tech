#!/bin/bash
echo "=== INICIANDO AUDITORIA ===" > audit_seguranca.log
for i in {1..3}; do
    curl -s -X GET http://localhost:3005/api/v1/manutencoes >> audit_seguranca.log
    echo "" >> audit_seguranca.log
done
curl -s -X GET http://localhost:3005/api/v1/manutencoes -H "X-API-KEY: valida123" >> audit_seguranca.log
echo "" >> audit_seguranca.log
