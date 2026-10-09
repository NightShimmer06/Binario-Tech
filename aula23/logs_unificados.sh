#!/bin/bash
echo "===================================================="
echo " Monitorando Logs Unificados: Web API e Redis Cache "
echo "===================================================="

# Exibe as últimas 20 linhas e acompanha os logs em tempo real (-f)
docker compose logs -f --tail=20

