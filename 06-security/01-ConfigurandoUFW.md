Autor: Robson Vaamonde<br>
Procedimentos em TI: http://procedimentosemti.com.br<br>
Bora para Prática: http://boraparapratica.com.br<br>
Robson Vaamonde: http://vaamonde.com.br<br>
Facebook Procedimentos em TI: https://www.facebook.com/ProcedimentosEmTi<br>
Facebook Bora para Prática: https://www.facebook.com/BoraParaPratica<br>
Instagram Procedimentos em TI: https://www.instagram.com/procedimentoem<br>
YouTUBE Bora Para Prática: https://www.youtube.com/boraparapratica<br>
LinkedIn Robson Vaamonde: https://www.linkedin.com/in/robson-vaamonde-0b029028/<br>
Github Procedimentos em TI: https://github.com/vaamonde<br>
Data de criação: 30/07/2026<br>
Data de atualização: 08/09/2026<br>
Versão: 0.02<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS<br>
Testado e homologado no Oracle VirtualBOX 7.x

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Site Oficial Wiki do Ubuntu UFW: https://help.ubuntu.com/community/UFW<br>
Site Oficial do Descomplicando o Ubuntu UFW: https://wiki.ubuntu.com/UncomplicatedFirewall<br>
Site Oficial do Debian UFW: https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29<br>
Site Oficial do IPTables: http://git.netfilter.org/iptables/<br>
Site Oficial do NFTables: https://wiki.nftables.org/

Conteúdo estudado nessa implementação:<br>

| **🛡️ Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🔥 **UFW (Uncomplicated Firewall)** | Interface de linha de comando simplificada para o gerenciamento de Firewall no Ubuntu, criada para facilitar a administração do `iptables`/`nftables` sem a necessidade de escrever regras complexas manualmente. | Permite Liberar (ALLOW), Bloquear (DENY), Rejeitar (REJECT) ou Limitar (LIMIT) conexões de Entrada e Saída de forma simples, com suporte nativo a IPv4 e IPv6. |
| ⚙️ **IPTables** | Ferramenta de espaço de usuário (userspace) escrita em C, utilizada para configurar as tabelas de filtragem de pacotes do kernel Linux (Netfilter). | É o "motor" utilizado pelo UFW por trás dos panos para aplicar as regras de firewall no tráfego de rede do servidor. |
| 🧩 **Netfilter** | Framework do Kernel Linux responsável por fornecer as funcionalidades de Firewall, NAT (Network Address Translation) e Log do tráfego de rede que passa pelo sistema. | Base de todo o subsistema de filtragem de pacotes utilizado por `iptables`, `nftables` e, consequentemente, pelo `ufw`. |
| 🆕 **NFTables** | Subsistema mais recente do Kernel Linux (desde a versão 3.13) para filtragem e classificação de pacotes, criado para substituir gradualmente as partes legadas do `iptables`. | É o backend padrão (`iptables-nft`) utilizado pelo Ubuntu Server 26.04.x LTS para processar as regras criadas pelo UFW. |
| 🚫 **DENY vs REJECT** | Duas políticas distintas de bloqueio de tráfego. `DENY` descarta o pacote silenciosamente (sem resposta ao remetente). `REJECT` descarta o pacote e envia uma resposta explícita de recusa. | `DENY` é mais indicado para políticas padrão (menos informação exposta ao atacante); `REJECT` é útil para depuração ou quando o serviço precisa informar rapidamente que a porta está fechada. |
| 🧱 **Blindagem Full (IN/OUT)** | Estratégia de Hardening onde tanto a política padrão de Entrada quanto a de Saída são configuradas como `deny` (bloqueado), liberando apenas o tráfego estritamente necessário através de regras específicas. | Reduz drasticamente a superfície de ataque do servidor, dificultando tanto o acesso não autorizado (Entrada) quanto a exfiltração de dados ou comunicação com C2/Malware (Saída). |
---

[![Firewall UFW Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Firewall UFW Ubuntu Server")

Link da vídeo aula: 

## 01_ Verificando qual o Sistema de Firewall padrão do Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** no Ubuntu Server temos dois tipos de sistema de Firewall padrão: __`iptables-nft (nftables)`__ e __`iptables-legacy (legado)`__. O **nftables** é o subsistema de filtragem de pacotes mais moderno do Kernel Linux, introduzido para substituir o `iptables` legado e demais módulos anteriores, oferecendo uma estrutura mais flexível e eficiente para regras de Firewall, NAT e Roteamento.

```bash
#verificando qual o sistema de Firewall padrão configurado no Ubuntu Server
#opção do comando update-alternatives: --config (Shows the available alternatives for a group of links)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/update-alternatives.1.html
sudo update-alternatives --config iptables
```

Entendendo a saída do comando: __`sudo update-alternatives --config iptables`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| ⭐ **Padrão (Automático)** | `/usr/sbin/iptables-nft` | Backend **nftables**, selecionado automaticamente pelo Ubuntu Server 26.04.x LTS como padrão do sistema. |
| 🔧 **Alternativa Manual** | `/usr/sbin/iptables-legacy` | Backend legado (**iptables clássico**), mantido apenas para compatibilidade com scripts e ferramentas antigas. |
| 🔢 **Prioridade** | `20 (nft) / 10 (legacy)` | Quanto maior a prioridade, maior a preferência do sistema em modo automático. |
---

## 02_ Verificando a Versão e Status do Firewall UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção.

```bash
#verificando a versão do UFW instalada no Ubuntu Server
#opção do comando ufw: version (show program's version number and exit)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw version

#verificando o status do UFW (Status padrão de fábrica: inactive - inativo/desativado)
#opção do comando ufw: status (show status of firewall and ufw managed rules)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status
```

## 03_ Habilitando (ENABLE) o Firewall UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** CUIDADO AO HABILITAR O UFW UTILIZANDO UMA CONEXÃO REMOTA (SSH)! Após digitar o comando: __`sudo ufw enable`__ a seguinte mensagem é exibida: __`Command may disrupt existing ssh connections`__ (o comando pode interromper as conexões SSH existentes). Em alguns cenários pode acontecer a queda (desconexão) da sessão remota e você não conseguir mais acessar o servidor. **RECOMENDAÇÃO:** só habilite o `deny incoming` (item #07) DEPOIS de já ter liberado a regra do SSH (item #14), ou execute os testes com o Console/Terminal físico da máquina virtual (VirtualBOX) disponível como plano B.

```bash
#habilitando e iniciando o Firewall UFW no Ubuntu Server
#opção do comando ufw: enable (reloads firewall and enables firewall on boot)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw enable
  Command may disrupt existing ssh connections. Proceed with operation (y|n)? y <Enter>
  Firewall is active and enabled on system startup

#verificando o status do UFW (Status após habilitar: active - ativo/ativado) no Ubuntu Server
#opção do comando ufw: status (show status of firewall and ufw managed rules)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status
```

## 04_ Verificando o Serviço do UFW no Ubuntu Server
```bash
#verificando o serviço do Firewall UFW no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then start
#one or more units), stop (Stop (deactivate) one or more units), start (Start (activate) one or
#more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status ufw
sudo systemctl restart ufw
sudo systemctl stop ufw
sudo systemctl start ufw

#analisando os Log's e mensagens de erro do serviço do Firewall UFW no Ubuntu Server
#opção do comando journalctl: -x (catalog), -e (pager-end), -u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -xeu ufw
```

## 05_ Localização dos Arquivos e Diretório de Configuração do UFW no Ubuntu Server

| **📂 Caminho** | **📝 Descrição** |
| :------------- | :--------------- |
| **`/etc/default/ufw`** | Arquivo de inicialização/parâmetros padrão do UFW (política de IPv6, encadeamento de módulos do Kernel, etc.). |
| **`/etc/ufw/`** | Diretório principal das configurações e regras do UFW. |
| **`/etc/ufw/ufw.conf`** | Arquivo que controla se o serviço do UFW inicia junto com o sistema operacional (`ENABLED=yes`). |
| **`/etc/ufw/before.rules`** / **`before6.rules`** | Regras aplicadas **ANTES** das regras de usuário (IPv4 e IPv6), geralmente usadas para liberar ICMP, Loopback e regras de baixo nível. |
| **`/etc/ufw/after.rules`** / **`after6.rules`** | Regras aplicadas **DEPOIS** das regras de usuário (IPv4 e IPv6). |
| **`/etc/ufw/user.rules`** / **`user6.rules`** | Regras criadas pelo próprio usuário através dos comandos `ufw allow/deny/reject/limit` (IPv4 e IPv6). |
| **`/etc/ufw/applications.d/`** | Diretório com os perfis de aplicações (App Profiles) reconhecidos pelo comando `ufw app`. |
| **`/var/log/ufw.log`** | Arquivo de Log padrão e dedicado do Firewall UFW. |
| **`/var/log/syslog`** | Também recebe os eventos do UFW (filtrar com: `grep -i ufw`). |
| **`/var/log/kern.log`** | Log do Kernel, também recebe os eventos do UFW (filtrar com: `grep -i ufw`). |
---

## 06_ Verificando as Regras (RULES) de Entrada (INCOMING) e Saída (OUTGOING) padrão do UFW no Ubuntu Server
```bash
#verificando o status das Regras (RULES) Detalhadas (VERBOSE) do UFW no Ubuntu Server
#opção do comando ufw: status (show status of firewall and ufw managed rules), verbose
#(Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

Entendendo a saída do comando: __`sudo ufw status verbose`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| ✅ **Status** | `active` | Confirma que o Firewall UFW está habilitado e ativo. |
| 📝 **Logging** | `on (low)` | Log habilitado com nível de detalhamento **baixo (low)**, gravado em `/var/log/ufw.log`. |
| 🚦 **Default** | `deny (incoming), allow (outgoing), disabled (routed)` | Política padrão de fábrica: **bloqueia** entrada, **libera** saída e **desabilita** roteamento entre interfaces. |
| 🆕 **New profiles** | `skip` | Perfil padrão para novas aplicações (App Profiles) não é adicionado automaticamente. |
---

## 07_ Configurando a Regra (RULES) de Bloqueio (DENY) padrão (DEFAULT) de Entrada (INCOMING) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** no Firewall UFW temos basicamente **05 (cinco)** regras/políticas padrões: `allow` (liberação), `deny` (negação), `limit` (limitação), `reject` (rejeição) e `disable` (desabilitado).

```bash
#configurando a Regra (RULES) Padrão (DEFAULT) de Bloqueio (DENY) de Entrada (INCOMING) no Ubuntu Server
#opção do comando ufw: default (change the default policy for traffic going DIRECTION)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw default deny incoming
  Default incoming policy changed to 'deny'
  (be sure to update your rules accordingly)

#verificando as Regras Detalhadas padrão do UFW no Ubuntu Server
#opção do comando ufw: status (show status of firewall and ufw managed rules), verbose
#(Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

## 08_ Configurando a Regra (RULES) de Bloqueio (DENY) padrão (DEFAULT) de Saída (OUTGOING) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão as regras de Firewall geralmente Bloqueiam (DENY) toda a Entrada (INCOMING) para o servidor e Permitem (ALLOW) toda a Saída (OUTGOING). Bloquear a Entrada **e** a Saída deixa a Segurança bem mais Restritiva (Rigorosa), sendo necessário criar uma regra (RULE) para **cada** serviço de rede que o próprio servidor precisa acessar (DNS, NTP, Repositórios do APT, etc.). É exatamente essa a estratégia de **Blindagem Full** adotada nesse capítulo.

```bash
#configurando a Regra (RULES) Padrão (DEFAULT) de Bloqueio (DENY) de Saída (OUTGOING) no Ubuntu Server
#opção do comando ufw: default (change the default policy for traffic going DIRECTION)
sudo ufw default deny outgoing
  Default outgoing policy changed to 'outgoing'
  (be sure to update your rules accordingly)

#verificando as Regras Detalhadas padrão do UFW no Ubuntu Server
#opção do comando ufw: status (show status of firewall and ufw managed rules), verbose
#(Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

## 09_ Configurando o Nível de Log (LOGGING) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** no UFW temos basicamente **05 (cinco)** níveis de Log: `off` (desligado), `low` (baixo), `medium` (médio), `high` (alto) e `full` (completo/debug).

```bash
#habilitando os Logs das Regras do UFW
#opção do comando ufw: logging (Logged packets use the LOG_KERN syslog facility), on (enabled logging)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw logging on
  Logging enabled

#configurando o Nível de Log de Baixo (LOW) para Médio (MEDIUM), recomendado para servidores em Hardening
#opção do comando ufw: logging (Logged packets use the LOG_KERN syslog facility), medium (enabled medium logging)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw logging medium
  Logging enabled

#verificando as Regras Detalhadas padrão do UFW
#opção do comando ufw: status (show status of firewall and ufw managed rules), verbose
#(Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

## 10_ Testando as conexões de Entrada (INCOMING) e Saída (OUTGOING) antes da Blindagem no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** neste ponto o servidor está **totalmente bloqueado** (Entrada e Saída), inclusive o próprio Loopback (127.0.0.1/::1) e a conexão SSH remota já podem estar comprometidas. Utilize o **Console/Terminal físico** da Máquina Virtual (VirtualBOX) para os testes a seguir.

```bash
#pingando o endereço IPv4 da Loopback/Localhost (por padrão está liberado no terminal)
ping 127.0.0.1

#pingando o endereço IPv6 da Loopback/Localhost (por padrão está liberado no terminal)
ping6 ::1

#pingando o endereço IPv4 de DNS do Google (tende a falhar - saída ainda não liberada)
ping 8.8.8.8

#resolvendo o nome de DNS do Google (tende a falhar - saída ainda não liberada)
nslookup google.com

#pingando o endereço IPv4 remoto do Ubuntu Server, a partir de outro equipamento na rede (tende a falhar)
ping 172.16.1.20

#testando o acesso remoto via SSH no Ubuntu Server, a partir de outro equipamento na rede (tende a falhar)
ssh vaamonde@172.16.1.20

#verificando as portas abertas do Ubuntu Server, a partir de outro equipamento na rede
#OBSERVAÇÃO: esse processo demora um pouco, caso você não tenha o comando: nmap
#instalado no seu equipamento digite o comando: sudo apt install nmap
#opção do comando nmap: -p- (port ranges all)
sudo nmap -p- 172.16.1.20
```

## 11_ Liberando (ALLOW) a Entrada (INCOMING) e Saída (OUTGOING) da Interface de Loopback do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão, o UFW no Ubuntu Server adiciona automaticamente as regras de `IPv6` para as regras da Interface de Loopback.

```bash
#liberando (ALLOW) a Entrada (IN) da Interface (ON) Loopback (LO)
#opção do comando ufw: allow (add allow rule)
sudo ufw allow in on lo

#liberando (ALLOW) a Saída (OUT) da Interface (ON) Loopback (LO)
#opção do comando ufw: allow (add allow rule)
sudo ufw allow out on lo

#verificando as Regras Detalhadas padrão do UFW
sudo ufw status verbose

#verificando o Status das Regras (RULES) Numeradas (NUMBERED) do UFW
sudo ufw status numbered

#testando novamente o Loopback (agora deve funcionar)
ping 127.0.0.1
ping6 ::1
```

## 12_ Liberando (ALLOW) as Saídas (OUTGOING) Básicas (DNS, HTTP, HTTPS, NTP) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão, o UFW no Ubuntu Server adiciona automaticamente regras de IPv6 para regras criadas de forma simples ou básica.

> **OBSERVAÇÃO IMPORTANTE:** ao utilizar a opção: `comment` (comentário) do UFW é recomendado não utilizar acentuação e sempre dentro de Aspas Simples (não crase).

> **OBSERVAÇÃO IMPORTANTE:** o UFW segue a ordem: Primeira Regra Correspondente (de cima para baixo) → Ação da Regra (allow, deny, reject) → Regras Subsequentes (continua se não encontrar) → Regra Padrão (default). A prioridade de processamento é: Regras de Porta Específica (maior) → Regras de Protocolo e Porta → Regras de Aplicação de Serviço → Regras de Sub-rede → Regras de Interface → Regras de App Profile (menor).

```bash
#regra de liberação (ALLOW) de Saída (OUT) da Consulta do Protocolo DNS (53/udp)
sudo ufw allow out 53/udp comment 'Liberando a saida para consulta do DNS'

#regra de liberação (ALLOW) de Saída (OUT) da Consulta do Protocolo DNS Over TLS - DoT (853/tcp)
sudo ufw allow out 853/tcp comment 'Liberando a saida para consulta do DNS over TLS'

#regra de liberação (ALLOW) de Saída (OUT) da Navegação do Protocolo HTTP (80/tcp)
#OBSERVAÇÃO: necessário para os repositórios do APT/APT Update que ainda utilizam HTTP
sudo ufw allow out 80/tcp comment 'Liberando a saida para navegacao do HTTP'

#regra de liberação (ALLOW) de Saída (OUT) da Navegação do Protocolo HTTPS (443/tcp)
sudo ufw allow out 443/tcp comment 'Liberando a saida para navegacao do HTTPS'

#regra de liberação (ALLOW) de Saída (OUT) do Protocolo NTP (123/udp) - sincronismo do Chrony
sudo ufw allow out 123/udp comment 'Liberando a saida para sincronismo do NTP'

#regra de liberação (ALLOW) de Saída (OUT) do Protocolo NTS-KE (4460/tcp) - negociação TLS do NTP.br
sudo ufw allow out 4460/tcp comment 'Liberando a saida para negociacao do NTS-KE do NTP.br'

#verificando as Regras Detalhadas padrão do UFW
sudo ufw status verbose

#verificando as Regras Detalhadas padrão do UFW em modo Numerado
sudo ufw status numbered

#resolvendo o nome DNS do Google (agora deve funcionar)
nslookup google.com

#atualizando as listas do sources.list do APT (agora deve funcionar)
sudo apt update
```

## 13_ Liberando (ALLOW) a Saída (OUTGOING) do Protocolo ICMP (IPv4/IPv6) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão, a regra de ICMP de Entrada (INCOMING) já vem Liberada (ACCEPT) nos arquivos `before.rules`/`before6.rules`, caso queira Bloquear (DROP) o Ping de Entrada, basta trocar `ACCEPT` por `DROP` nas linhas correspondentes desses arquivos. Aqui vamos liberar apenas a **Saída** do ICMP, que fica bloqueada pela política `deny outgoing` configurada no item #08.

```bash
#pingando o endereço IPv4 e o nome do Google (tende a falhar - ICMP de saída ainda bloqueado)
ping 8.8.8.8

#editando o arquivo de configuração before.rules (regras de IPv4, ANTES das regras de usuário)
sudo vim /etc/ufw/before.rules

#habilitando o recurso de número de linhas no Editor VIM
ESC SHIFT :set number <Enter>

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#inserir as informações abaixo a partir da linha: 39 (liberando a saída do protocolo ICMPv4)
#opções do comando iptables usados pelo UFW: -A (append), -p (protocol), -j (jump target)
# ok icmp codes for OUTPUT
-A ufw-before-output -p icmp --icmp-type destination-unreachable -j ACCEPT
-A ufw-before-output -p icmp --icmp-type time-exceeded -j ACCEPT
-A ufw-before-output -p icmp --icmp-type parameter-problem -j ACCEPT
-A ufw-before-output -p icmp --icmp-type echo-request -j ACCEPT
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>

#reiniciar as regras de firewall do UFW
#opção do comando ufw: reload (reloads firewall rules)
sudo ufw reload
  Firewall reloaded

#pingando o endereço IPv4 e IPv6 do Google (agora deve funcionar)
ping 8.8.8.8
ping6 2001:4860:4860::8888
ping google.com
```

## 14_ Liberando (ALLOW) a Entrada (INCOMING) Básica (SSH) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão, o UFW no Ubuntu Server adiciona automaticamente regras de IPv6 para regras criadas de forma simples ou básica.

> **OBSERVAÇÃO IMPORTANTE:** mesmo com o Log do UFW habilitado (item #09), nem todos os eventos são registrados em `/var/log/ufw.log` por padrão, adicione a opção: `log` (LOGAR) ou `log-all` (LOGAR TUDO) nas regras críticas, como o SSH, para ter rastreabilidade completa das tentativas de acesso.

> **OBSERVAÇÃO IMPORTANTE:** essa é a regra **mais crítica** da Blindagem Full: sem ela, você perde o acesso remoto ao servidor. Nunca aplique o `deny incoming` (item #07) sem antes garantir essa liberação, de preferência via `ufw insert` (item #23) na primeira posição.

```bash
#regra de liberação (ALLOW) de Entrada (IN) Logando Tudo (LOG-ALL) do Protocolo SSH (22/tcp)
sudo ufw allow in log-all 22/tcp comment 'Liberando a entrada do acesso remoto via SSH'

#verificando as Regras Detalhadas padrão do UFW
sudo ufw status verbose

#verificando as Regras Detalhadas padrão do UFW em modo Numerado
sudo ufw status numbered

#testando as portas de conexões remotas do SSH via Telnet, Netcat ou NC, a partir de outro equipamento
telnet 172.16.1.20 22
netcat -v 172.16.1.20 22
nc -v 172.16.1.20 22

#acessando remotamente o Ubuntu Server via SSH (agora deve funcionar)
ssh vaamonde@172.16.1.20
```

## 16_ Removendo (DELETE) Regras (RULES) de firewall do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** você pode remover as regras do UFW de duas formas: pela sintaxe completa da regra criada, exemplo: `sudo ufw delete out 53/udp`, ou utilizando o número da regra, que é mais simples (ver item #06 e #23 para localizar o número).

```bash
#verificando as Regras Detalhadas padrão do UFW em modo Numerado
sudo ufw status numbered

#removendo (DELETE) uma Regra (RULES) de exemplo pelo número (ALTERE O NÚMERO PARA O SEU CENÁRIO)
#opção do comando ufw: delete (deletes the corresponding RULE)
sudo ufw delete 9
  Deleting:
    allow from 172.16.1.114 to 172.16.1.20 port 10000 proto tcp comment 'Liberando somente o IP para acessar o painel de gerencia'
  Proceed with operation (y|n)? y
  Rule deleted

#verificando as Regras Detalhadas padrão do UFW em modo Numerado, após a remoção
sudo ufw status numbered
```

## 17_ Reiniciando (RELOAD) as Regras de Firewall do UFW no Ubuntu Server
```bash
#reiniciando as regras de firewall do UFW
#opção do comando ufw: reload (reloads firewall rules)
sudo ufw reload
  Firewall reloaded

#verificando as Regras Detalhadas padrão do UFW
sudo ufw status verbose
```

## 18_ Entendendo o Log (LOGGING) do Firewall UFW no Ubuntu Server
```bash
#listando o conteúdo do arquivo de Log do UFW
#opção do comando cat: -n (number line)
sudo cat -n /var/log/ufw.log | less

#saída padrão dos Logs do UFW no arquivo ufw.log
1343 Jul 30 12:54:15 srvvaamonde kernel: [ 7898.809280] [UFW BLOCK] IN= OUT=enp0s3 SRC=172.16.1.20
DST=172.16.1.135 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=24251 DF PROTO=TCP SPT=54900 DPT=9100
WINDOW=64240 RES=0x00 SYN URGP=0
```

Entendendo os campos do Log do UFW:<br>
| **Campo** | **Descrição** |
| :-------- | :------------ |
| 🏷️ **[UFW BLOCK]** | Tipo de registro de evento do log do UFW (`AUDIT`, `ALLOW`, `DENY`, `INBOUND`, `LIMIT`, `OUTBOUND` e `REJECT`). |
| ➡️ **IN=** | Interface de entrada do tráfego (vazio quando o tráfego é originado no próprio servidor). |
| ⬅️ **OUT=** | Interface de saída do tráfego. |
| 🌍 **SRC=** | Endereço IPv4/IPv6 de origem do pacote. |
| 🎯 **DST=** | Endereço IPv4/IPv6 de destino do pacote. |
| 📦 **LEN=** | Tamanho do pacote em bytes. |
| ⏱️ **TTL=** | Tempo de vida do pacote (Time to Live), padrão 64. |
| 🆔 **ID=** | Identificação exclusiva do datagrama IPv4/IPv6. |
| 🔌 **PROTO=** | Protocolo utilizado (`TCP`, `UDP` ou `ICMP`). |
| 📤 **SPT=** | Porta de origem da conexão. |
| 📥 **DPT=** | Porta de destino da conexão. |
| 🤝 **SYN URGP=** | Indica handshake de três vias (three-way handshake) e urgência do pacote. |
---

```bash
#visualizando os Logs em Tempo Real do Firewall UFW
#opção do comando tail: -f (follow)
sudo tail -f /var/log/ufw.log
```

## 21_ Limitando (LIMIT) uma Conexão de Entrada (INCOMING) do UFW no Ubuntu Server (Proteção Anti Brute-Force)

> **OBSERVAÇÃO IMPORTANTE:** com essa opção, o UFW passa a Negar conexões de um Endereço IPv4/IPv6 que tentar iniciar **6 (seis) ou mais** conexões simultâneas nos últimos **30 (trinta) segundos**. É muito útil para o serviço do OpenSSH, protegendo o servidor contra ataques de Força Bruta (Brute Force), como uma **primeira camada** de defesa antes da implementação do **Fail2Ban** (próximo capítulo do curso). Para alterar os limites internos do UFW é necessário editar os arquivos: `/etc/ufw/user.rules` ou `/etc/ufw/user6.rules`, e depois digitar o comando: `sudo ufw reload`.

```bash
#verificando as Regras Detalhadas padrão do UFW em modo Numerado, para localizar a regra do SSH
sudo ufw status numbered

#removendo (DELETE) a Regra (RULES) de Acesso ao SSH em IPv4 (ALTERE O NÚMERO PARA O SEU CENÁRIO)
sudo ufw delete 6
  Deleting:
    allow log-all 22/tcp comment 'Liberando a entrada do acesso remoto via SSH'
  Proceed with operation (y|n)? y <Enter>
  Rule deleted (v4)

#verificando as Regras Detalhadas padrão do UFW em modo Numerado
sudo ufw status numbered

#removendo (DELETE) a Regra (RULES) de Acesso ao SSH em IPv6 (ALTERE O NÚMERO PARA O SEU CENÁRIO)
sudo ufw delete 16
  Deleting:
    allow log-all 22/tcp comment 'Liberando a entrada do acesso remoto via SSH'
  Proceed with operation (y|n)? y <Enter>
  Rule deleted (v6)

#verificando as Regras Detalhadas padrão do UFW em modo Numerado
sudo ufw status numbered

#limitando (LIMIT) e Logando Tudo (LOG-ALL) da Sub-rede 172.16.1.0/24 (FROM) acessar o servidor (TO)
#do OpenSSH Server na porta (PORT) 22 via protocolo TCP (PROTO TCP)
sudo ufw limit log-all from 172.16.1.0/24 to 172.16.1.20 port 22 proto tcp comment 'Limitando a sub-rede para acessar o OpenSSH Server'

#verificando as Regras Detalhadas padrão do UFW em modo Numerado
sudo ufw status numbered

#baixando o script de teste de conexão simultânea na porta do SSH
wget https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/script/openssh.sh

#testando os Limites de conexão na Porta do SSH
bash openssh.sh

#verificando o arquivo de Log do UFW filtrado pela porta do SSH
sudo cat -n /var/log/ufw.log | grep -i dpt=22
```


## 24_ Visualizando (SHOW) informações detalhadas (REPORT) do UFW no Ubuntu Server
```bash
#relatório detalhado em RAW (Raw Data)
sudo ufw show raw

#relatório detalhado com tráfego de rede das CHAINS (Regras)
sudo ufw show builtins

#relatório detalhado das regras antes (BEFORE-RULES) de serem aplicadas pelo UFW
sudo ufw show before-rules

#relatório detalhado das regras do usuário (USER-RULES) a serem aplicadas pelo UFW
sudo ufw show user-rules

#relatório detalhado das regras depois (AFTER-RULES) de serem aplicadas pelo UFW
sudo ufw show after-rules

#relatório detalhado das regras de Logs (LOGGING-RULES) a serem aplicadas pelo UFW
sudo ufw show logging-rules

#relatório detalhado das portas liberadas (LISTENING) do servidor pelo UFW
sudo ufw show listening

#relatório detalhado das regras adicionadas (ADDED) no UFW
sudo ufw show added
```

## 25_ Desativando (DISABLE) e Ativando (ENABLE) o UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** se você desabilitar o firewall UFW, as regras já criadas **NÃO** são perdidas, apenas deixam de ser aplicadas.

```bash
#desabilitando (DISABLE) o Firewall UFW
sudo ufw disable
  Firewall stopped and disabled on system startup

#verificando as Regras Detalhadas do UFW (regras permanecem salvas, mesmo desabilitado)
sudo ufw status verbose

#habilitando (ENABLE) novamente o Firewall UFW
sudo ufw enable
  Command may disrupt existing ssh connections. Proceed with operation (y|n)? y <Enter>
  Firewall is active and enabled on system startup

#verificando as Regras Detalhadas padrão do UFW em modo Numerado
sudo ufw status numbered
```

