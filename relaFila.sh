#!/bin/bash
dia=$(date +%d/%m/%Y)
agora=$(date +%H:%M:%S)
server=$(hostname -A)
msgs=$(/opt/zimbra/postfix/sbin/postqueue -p | /usr/bin/tail -n 1 | /usr/bin/cut -d' ' -f5)
overquota=$(/usr/sbin/sendmail -bp | grep "Over quota" | wc -l)
filaNova=$(/usr/sbin/sendmail -bp | grep "*" | wc -l)
texto="Subject: Relatorio de Fila - $server\n$msgs mansagens totais na fila. \n$overquota mensagens com destinatarios com caixa cheia. \n$filaNova mensagens sendo processadas no momento.\n\n Gerado em $dia as $agora"
echo -e $texto | /usr/sbin/sendmail admin@example.com