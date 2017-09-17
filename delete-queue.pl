#!/usr/bin/perl
# Fonte: https://wiki.zimbra.com/wiki/Managing-The-Postfix-Queues
# Deleta todas as mensagens na fila do domínio “iamspammer.com”
#./delete-queue iamspammer.com
# Deleta todas as mensagens para o usuário “bogususer@mydomain.com”:
#./delete-queue bogususer@mydomain.com
# Deleta todas as mensagens com endereço iniciado com "bush":
#./delete-queue bush*\@whateverdomain.com
# Deleta todas as mensagend que contenham “biz” no endereço:
#./delete-queue biz

$REGEXP = shift || die “Nenhum endereco de email passado (regexp-style, p.ex. bl.*\@yahoo.com)!”;

@data = qx;
for (@data) {
	if (/^(\w+)(\*|\!)?\s/) {
		$queue_id = $1;
	}
	if($queue_id) {
		if (/$REGEXP/i) {
			$Q{$queue_id} = 1;
			$queue_id = “”;
		}
	}
}

open(POSTSUPER,”|/opt/zimbra/postfix/sbin/postsuper -d -”) || die “Impossivel abrir postsuper”;

foreach (keys %Q) {
	print POSTSUPER “$_\n”;
};
close(POSTSUPER);