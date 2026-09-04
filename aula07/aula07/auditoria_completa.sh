#!/bin/bash
LOG_FILE="auditoria.log"

# Limpa o arquivo de log anterior antes de começar
echo "=== INICIANDO AUDITORIA COMPLETA DE ROTAS ===" > $LOG_FILE
echo "Data/Hora: $(date)" >> $LOG_FILE
echo "==============================================" >> $LOG_FILE
 
# 1. Consultando Telemetria Scania (GET)
echo -e "\n Consultando Telemetria Scania (GET)..." >> $LOG_FILE
curl -s http://localhost:3000/api/v1/telemetria/scania | jq . >> $LOG_FILE
 
# 2. Consultando Telemetria Mercedes-Benz (GET)
echo -e "\n Consultando Telemetria Mercedes-Benz (GET)..." >> $LOG_FILE
curl -s http://localhost:3000/api/v1/telemetria/mercedes | jq . >> $LOG_FILE

# 3. Enviando Dado Válido de Telemetria Scania (POST)
echo -e "\n Enviando Dado Válido para Scania (POST)..." >> $LOG_FILE
curl -s -X POST http://localhost:3000/api/v1/telemetria/scania \
       -H "Content-type: application/json" \
       -d '{"modelo":"R450","vin":"9BS555444333","temperatura_motor":90}' | jq . >> $LOG_FILE
 
# 4. Testando Envio de VIN Inválido para Telemetria Scania (POST) - REMOVIDO JQ
echo -e "\n Testando Envio de VIN Inválido para Scania (POST)..." >> $LOG_FILE
curl -s -X POST http://localhost:3000/api/v1/telemetria/scania \
        -H "Content-type: application/json" \
        -d '{"modelo":"R450","vin":"12345","temperatura_motor":99}' >> $LOG_FILE
 
# 5. Testando Endpoint Inexistente (GET/POST) - REMOVIDO JQ
echo -e "\n Testando Endpoint Inexistente (404)..." >> $LOG_FILE
curl -s http://localhost:3000/api/v1/telemetria/volvo >> $LOG_FILE
 
echo -e "\n=== AUDITORIA CONCLUÍDA COM SUCESSO ===" >> $LOG_FILE
echo "Os resultados foram salvos em $LOG_FILE!"
                      # ======================================================================
                      # CONTEXTO E EXPLICAÇÕES (ENUNCIADO E RACIOCÍNIO LÓGICO)
                      # ======================================================================
                      # 
                      # ENUNCIADO DO EXERCÍCIO 05:
                      # Crie um script Bash de automação chamado 'auditoria_completa.sh' 
                      # que consulta em sequência todas as rotas ativas do servidor e 
                      # registra os resultados em 'auditoria.log'.
                      # 
                      # ----------------------------------------------------------------------
                      # COMO SE CHEGA NESSE CÓDIGO?
                      # 
                      # 1. ENVIAR RESPOSTAS PARA UM ARQUIVO:
                      #    Em scripts Bash, usamos redirecionadores para salvar saídas de comandos.
                      #    O símbolo '>' limpa o arquivo e escreve do zero.
                      #    O símbolo '>>' adiciona o conteúdo no final do arquivo sem apagar o que já está lá.
                      # 
                      # 2. DEIXAR O SCRIPT SILENCIOSO NO TERMINAL:
                      #    Usamos a flag '-s' (silent) no comando 'curl -s'. Isso impede que a barra 
                      #    de progresso do download apareça no terminal ou suje o arquivo de logs.
                      # 
                      # 3. FORMATAR O LOG PARA FICAR LEGÍVEL:
                      #    Para que as respostas em JSON não fiquem todas grudadas em uma linha só, 
                      #    passamos a saída pelo 'jq .' antes de jogar no arquivo. Isso deixa os JSONs 
                      #    bonitos e identados dentro do 'auditoria.log'.
                      # 
                      # 4. CRIAR MARCADORES DE TEXTO:
                      #    Usamos comandos 'echo -e "\n Texto..." >> $LOG_FILE' antes de cada curl. 
#    Isso serve como uma "etiqueta" para quem for ler o log depois saber exatamente 
#    qual teste gerou aquela resposta da API.
# 
# ======================================================================

