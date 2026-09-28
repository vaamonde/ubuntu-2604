**Autor:** `Robson Vaamonde`<br>
**Procedimentos em TI:** http://procedimentosemti.com.br<br>
**Bora para Prática:** http://boraparapratica.com.br<br>
**Robson Vaamonde:** http://vaamonde.com.br<br>
**Facebook Procedimentos em TI:** https://www.facebook.com/ProcedimentosEmTi<br>
**Facebook Bora para Prática:** https://www.facebook.com/BoraParaPratica<br>
**Instagram Procedimentos em TI:** https://www.instagram.com/procedimentoem<br>
**YouTUBE Bora Para Prática:** https://www.youtube.com/boraparapratica<br>
**LinkedIn Robson Vaamonde:** https://www.linkedin.com/in/robson-vaamonde-0b029028/<br>
**Github Robson Vaamonde:** https://github.com/vaamonde<br>

**Data de criação:** `06/07/2026`<br>
**Data de atualização:** `28/09/2026`<br>
**Versão:** `0.08`<br>

> __`Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS`__

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO FIREWALL UFW A SEGUINTE FRASE: *Configuração do Firewall UFW On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #firewall #firewallubuntu #firewalluntuserver #firewalluntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/18-firewall.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
Site Oficial Wiki do Ubuntu UFW: https://help.ubuntu.com/community/UFW<br>
Site Oficial do Descomplicando o Ubuntu UFW: https://wiki.ubuntu.com/UncomplicatedFirewall<br>
Site Oficial do Debian UFW: https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29<br>
Site Oficial do IPTables: http://git.netfilter.org/iptables/<br>
Site Oficial do NFTables: https://wiki.nftables.org/

**Conteúdo estudado nessa configuração:**<br>
#01_ Verificando qual o Sistema de Firewall padrão do Ubuntu Server
#02_ Verificando a Versão e Status do Firewall UFW no Ubuntu Server
#03_ Habilitando (ENABLE) o Firewall UFW no Ubuntu Server
#04_ Verificando o Serviço do Firewall UFW no Ubuntu Server
#05_ Localização dos Arquivos e Diretório de Configuração do Firewall UFW no Ubuntu Server
#06_ Verificando as Regras (RULES) de Entrada (INCOMING) e Saída (OUTGOING) padrão do UFW no Ubuntu Server
#07_ Configurando a Regra (RULES) de Bloqueio (DENY) padrão (DEFAULT) de Entrada (INCOMING) do UFW no Ubuntu Server
#08_ Configurando a Regra (RULES) de Bloqueio (DENY) padrão (DEFAULT) de Saída (OUTGOING) do UFW no Ubuntu Server
#09_ Configurando a Regra (RULES) de Bloqueio (DENY) padrão (DEFAULT) de Roteamento (ROUTED) do UFW no Ubuntu Server
#10_ Configurando o Nível de Log (LOGGING) do UFW no Ubuntu Server
#11_ Testando as conexões de Entrada (INCOMING) e Saída (OUTGOING) antes da Blindagem no Ubuntu Server
#12_ Liberando (ALLOW) a Entrada (INCOMING) e Saída (OUTGOING) da Interface de Loopback do UFW no Ubuntu Server
#13_ Liberando (ALLOW) as Saídas (OUTGOING) Básicas (DNS, HTTP, HTTPS, NTP) do UFW no Ubuntu Server
#14_ Liberando (ALLOW) a Saída (OUTGOING) do Protocolo ICMP (IPv4/IPv6) do UFW no Ubuntu Server
#15_ Liberando (ALLOW) as Entradas (INCOMING) Básicas (PORTS) do UFW no Ubuntu Server
#16_ Reiniciando (RELOAD) as Regras de Firewall do UFW no Ubuntu Server
#17_ Entendendo o Log (LOGGING) do Firewall UFW no Ubuntu Server
#18_ Visualizando (SHOW) informações detalhadas (REPORT) do UFW no Ubuntu Server
#19_ Desativando (DISABLE) e Ativando (ENABLE) o UFW no Ubuntu Server


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

Entendendo a saída do comando: __`update-alternatives --config iptables`__<br>
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
```
```bash
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
```
```bash
#verificando o status do UFW (Status após habilitar: active - ativo/ativado) no Ubuntu Server
#opção do comando ufw: status (show status of firewall and ufw managed rules)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status
```

## 04_ Verificando o Serviço do Firewall UFW no Ubuntu Server
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
```
```bash
#analisando os Log's e mensagens de erro do serviço do Firewall UFW no Ubuntu Server
#opção do comando journalctl: -x (catalog), -e (pager-end), -u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -xeu ufw
```

## 05_ Localização dos Arquivos e Diretório de Configuração do Firewall UFW no Ubuntu Server

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
#opção do comando ufw: status (show status of firewall and ufw managed rules), 
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

Entendendo a saída do comando: __`ufw status verbose`__<br>
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
```
```bash
#verificando as Regras Detalhadas padrão do UFW no Ubuntu Server
#opção do comando ufw: status (show status of firewall and ufw managed rules), 
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

## 08_ Configurando a Regra (RULES) de Bloqueio (DENY) padrão (DEFAULT) de Saída (OUTGOING) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão as regras de Firewall geralmente Bloqueiam (DENY) toda a Entrada (INCOMING) para o servidor e Permitem (ALLOW) toda a Saída (OUTGOING). Bloquear a Entrada **e** a Saída deixa a Segurança bem mais Restritiva (Rigorosa), sendo necessário criar uma regra (RULE) para **cada** serviço de rede que o próprio servidor precisa acessar (DNS, NTP, Repositórios do APT, etc.). É exatamente essa a estratégia de **Blindagem Full** adotada nesse capítulo.

```bash
#configurando a Regra (RULES) Padrão (DEFAULT) de Bloqueio (DENY) de Saída (OUTGOING) no Ubuntu Server
#opção do comando ufw: default (change the default policy for traffic going DIRECTION)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw default deny outgoing
  Default outgoing policy changed to 'outgoing'
  (be sure to update your rules accordingly)
```
```bash
#verificando as Regras Detalhadas padrão do UFW no Ubuntu Server
#opção do comando ufw: status (show status of firewall and ufw managed rules), 
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

## 09_ Configurando a Regra (RULES) de Bloqueio (DENY) padrão (DEFAULT) de Roteamento (ROUTED) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão as regras de roteamento não será utilizada nesse servidor, essas regras são utilizadas em servidores de Firewall para compartilhar a Internet ou utilização de Servidores Proxy.

```bash
#configurando a Regra (RULES) Padrão (DEFAULT) de Bloqueio (DENY) de Roteamento (ROUTED) no Ubuntu Server
#opção do comando ufw: default (change the default policy for traffic going DIRECTION)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw default deny routed
  Default routed policy changed to 'routed'
  (be sure to update your rules accordingly)
```
```bash
#verificando as Regras Detalhadas padrão do UFW no Ubuntu Server
#opção do comando ufw: status (show status of firewall and ufw managed rules), 
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

## 10_ Configurando o Nível de Log (LOGGING) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** no UFW temos basicamente **05 (cinco)** níveis de Log: `off` (desligado), `low` (baixo), `medium` (médio), `high` (alto) e `full` (completo/debug).

```bash
#habilitando os registros dos Logs das Regras do UFW
#opção do comando ufw: logging (Logged packets use the LOG_KERN syslog facility), on (enabled logging)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw logging on
  Logging enabled
```
```bash
#configurando o Nível de Log de Baixo (LOW) para Médio (MEDIUM), recomendado para servidores em Hardening
#opção do comando ufw: logging (Logged packets use the LOG_KERN syslog facility), medium (enabled medium logging)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw logging medium
  Logging enabled
```
```bash
#verificando as Regras Detalhadas padrão do UFW
#opção do comando ufw: status (show status of firewall and ufw managed rules), 
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

## 11_ Testando as conexões de Entrada (INCOMING) e Saída (OUTGOING) antes da Blindagem no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** neste ponto o servidor está **totalmente bloqueado** (Entrada e Saída), inclusive o próprio Loopback (127.0.0.1/::1) e a conexão SSH remota já podem estar comprometidas. Utilize o **Console/Terminal físico** da Máquina Virtual (VirtualBOX) para os testes a seguir.

```bash
#pingando o endereço IPv4 da Loopback/Localhost (por padrão está liberado no terminal)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping
ping 127.0.0.1
```
```bash
#pingando o endereço IPv6 da Loopback/Localhost (por padrão está liberado no terminal)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping6
ping6 ::1
```
```bash
#pingando o endereço IPv4 de DNS do Google (tende a falhar - saída ainda não liberada)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping
ping 8.8.8.8
```
```bash
#resolvendo o nome de DNS do Google (tende a falhar - saída ainda não liberada)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/nslookup
nslookup google.com
```
```bash
#pingando o endereço IPv4 remoto do Ubuntu Server (por padrão está liberado o ICMP)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping
ping 172.16.1.20
```
```bash
#testando o acesso remoto via SSH no Ubuntu Server (tende a falhar - entrada ainda não liberada)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/ssh
ssh vaamonde@172.16.1.20
```
```bash
#verificando as portas abertas do Ubuntu Server, a partir de outro equipamento na rede
#OBSERVAÇÃO: esse processo demora um pouco, caso você não tenha o comando: nmap instalado
#no seu equipamento digite o comando: sudo apt update && sudo apt install nmap
#opção do comando nmap: -p- (port ranges all)
sudo nmap -p- 172.16.1.20
```

## 12_ Liberando (ALLOW) a Entrada (INCOMING) e Saída (OUTGOING) da Interface de Loopback do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão, o UFW no Ubuntu Server adiciona automaticamente as regras de `IPv6` para as regras da Interface de Loopback.

```bash
#liberando (ALLOW) a Entrada (IN) da Interface (ON) Loopback (LO)
#opção do comando ufw: allow (add allow rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw allow in on lo
  Rule added
  Rule added (v6)
```
```bash
#liberando (ALLOW) a Saída (OUT) da Interface (ON) Loopback (LO)
#opção do comando ufw: allow (add allow rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw allow out on lo
  Rule added
  Rule added (v6)
```
```bash
#verificando as Regras Detalhadas padrão do UFW
#opção do comando ufw: status (show status of firewall and ufw managed rules),
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```
```bash
#verificando o Status das Regras (RULES) Numeradas (NUMBERED) do UFW
#opção do comando ufw: status (show status of firewall and ufw managed rules),
#numbered (To see a list of numbered rules)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status numbered
```

## 13_ Liberando (ALLOW) as Saídas (OUTGOING) Básicas (DNS, HTTP, HTTPS, NTP) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão, o UFW no Ubuntu Server adiciona automaticamente regras de IPv6 para regras criadas de forma simples ou básica.
>
> **OBSERVAÇÃO IMPORTANTE:** ao utilizar a opção: `comment` (comentário) do UFW é recomendado não utilizar acentuação e sempre dentro de Aspas Simples (não crase).
>
> **OBSERVAÇÃO IMPORTANTE:** o UFW segue a ordem: Primeira Regra Correspondente (de cima para baixo) → Ação da Regra (allow, deny, reject) → Regras Subsequentes (continua se não encontrar) → Regra Padrão (default). A prioridade de processamento é: Regras de Porta Específica (maior) → Regras de Protocolo e Porta → Regras de Aplicação de Serviço → Regras de Sub-rede → Regras de Interface → Regras de App Profile (menor).

```bash
#regra de liberação (ALLOW) de Saída (OUT) das Consultas do Protocolo DNS (853/tcp)
#opção do comando ufw: allow (add allow rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw allow out on bond0 from 172.16.1.20 to 1.1.1.1 port 853 proto tcp comment 'Liberando a saida para consulta do DNS over TLS CloudFlare v4'
sudo ufw allow out on bond0 from 172.16.1.20 to 1.0.0.1 port 853 proto tcp comment 'Liberando a saida para consulta do DNS over TLS CloudFlare v4'
sudo ufw allow out on bond0 from 2804:14c:90:8697::20 to 2606:4700:4700::1111 port 853 proto tcp comment 'Liberando a saida para consulta do DNS over TLS CloudFlare v6'
sudo ufw allow out on bond0 from 2804:14c:90:8697::20 to 2606:4700:4700::1001 port 853 proto tcp comment 'Liberando a saida para consulta do DNS over TLS CloudFlare v6'
```
```bash
#regra de liberação (ALLOW) de Saída (OUT) da Navegação do Protocolo HTTP (80/tcp)
#opção do comando ufw: allow (add allow rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw allow out on bond0 from 172.16.1.20 to any port 80 proto tcp comment 'Liberando a saida para navegacao do HTTP v4'
sudo ufw allow out on bond0 from 2804:14c:90:8697::20 to any port 80 proto tcp comment 'Liberando a saida para navegacao do HTTP v6'
```
```bash
#regra de liberação (ALLOW) de Saída (OUT) da Navegação do Protocolo HTTPS (443/tcp)
#opção do comando ufw: 
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw allow out on bond0 from 172.16.1.20 to any port 443 proto tcp comment 'Liberando a saida para navegacao do HTTPS v4'
sudo ufw allow out on bond0 from 2804:14c:90:8697::20 to any port 443 proto tcp comment 'Liberando a saida para navegacao do HTTPS v6'
```
```bash
#regra de liberação (ALLOW) de Saída (OUT) do Protocolo NTP (123/udp) - sincronismo do Chrony
#opção do comando ufw: 
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw allow out on bond0 to 200.160.7.186 port 123 proto udp comment 'Liberando a saida para sincronismo do NTP.br v4'
sudo ufw allow out on bond0 to 186.192.158.147 port 123 proto udp comment 'Liberando a saida para sincronismo do NTP.br v4'
sudo ufw allow out on bond0 to 200.160.7.196 port 123 proto udp comment 'Liberando a saida para sincronismo do NTP.br v4'
sudo ufw allow out on bond0 to 2001:12ff:0:7::186 port 123 proto udp comment 'Liberando a saida para sincronismo do NTP.br v6'
sudo ufw allow out on bond0 to 2001:129c:7002:2::147 port 123 proto udp comment 'Liberando a saida para sincronismo do NTP.br v6'
sudo ufw allow out on bond0 to 2001:12ff:0:7::196 port 123 proto udp comment 'Liberando a saida para sincronismo do NTP.br v6'
```
```bash
#regra de liberação (ALLOW) de Saída (OUT) do Protocolo NTS-KE (4460/tcp) - negociação TLS do NTP.br
#opção do comando ufw: 
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw allow out on bond0 to 200.160.7.186 port 4460 proto tcp comment 'Liberando a saida para sincronismo do NTS-KE do NTP.br v4'
sudo ufw allow out on bond0 to 186.192.158.147 port 4460 proto tcp comment 'Liberando a saida para sincronismo do NTS-KE do NTP.br v4'
sudo ufw allow out on bond0 to 200.160.7.196 port 4460 proto tcp comment 'Liberando a saida para sincronismo do NTS-KE do NTP.br v4'
sudo ufw allow out on bond0 to 2001:12ff:0:7::186 port 4460 proto tcp comment 'Liberando a saida para sincronismo do NTS-KE do NTP.br v6'
sudo ufw allow out on bond0 to 2001:129c:7002:2::147 port 4460 proto tcp comment 'Liberando a saida para sincronismo do NTS-KE do NTP.br v6'
sudo ufw allow out on bond0 to 2001:12ff:0:7::196 port 4460 proto tcp comment 'Liberando a saida para sincronismo do NTS-KE do NTP.br v6'
```
```bash
#verificando as Regras Detalhadas padrão do UFW
#opção do comando ufw: status (show status of firewall and ufw managed rules),
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```
```bash
#verificando as Regras Detalhadas padrão do UFW em modo Numerado
#opção do comando ufw: status (show status of firewall and ufw managed rules),
#numbered (To see a list of numbered rules)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status numbered
```
```bash
#resolvendo o nome DNS do Google (agora deve funcionar)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/nslookup
nslookup google.com
```
```bash
#atualizando as listas do sources.list do APT (agora deve funcionar)
#opção do comando apt: update (Resynchronize the package index files from their sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt update
```

## 14_ Liberando (ALLOW) a Saída (OUTGOING) do Protocolo ICMP (IPv4/IPv6) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão, a regra de ICMP de Entrada (INCOMING) já vem Liberada (ACCEPT) nos arquivos `before.rules`/`before6.rules`, caso queira Bloquear (DROP) o Ping de Entrada, basta trocar `ACCEPT` por `DROP` nas linhas correspondentes desses arquivos. Aqui vamos liberar apenas a **Saída** do ICMP, que fica bloqueada pela política `deny outgoing` configurada no item #08.

```bash
#pingando os endereços IPv4, IPv6 e o nome do Google (tende a falhar - ICMP de saída ainda bloqueado)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping6
ping 8.8.8.8
ping6 2001:4860:4860::8888
ping google.com
```
```bash
#editando o arquivo de configuração before.rules (regras de IPv4, ANTES das regras de usuário)
sudo vim /etc/ufw/before.rules
```
```bash
#habilitando o recurso de número de linhas no Editor VIM
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#inserir as informações abaixo a partir da linha: 38 (liberando a saída do protocolo ICMPv4)
#opções do comando iptables usados pelo UFW: -A (append), -p (protocol), -j (jump target)

-A ufw-before-input -p icmp --icmp-type echo-request -j ACCEPT
-A ufw-before-input -s 172.16.1.20/24 -p icmp --icmp-type echo-request -j ACCEPT

# ok icmp codes for OUTPUT
-A ufw-before-output -p icmp --icmp-type destination-unreachable -j ACCEPT
-A ufw-before-output -p icmp --icmp-type time-exceeded -j ACCEPT
-A ufw-before-output -p icmp --icmp-type parameter-problem -j ACCEPT
-A ufw-before-output -p icmp --icmp-type echo-request -j ACCEPT
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```
```bash
#editando o arquivo de configuração before6.rules (regras de IPv6, ANTES das regras de usuário)
sudo vim /etc/ufw/before6.rules
```
```bash
#habilitando o recurso de número de linhas no Editor VIM
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#inserir as informações abaixo a partir da linha: 112 (liberando a saída do protocolo ICMPv4)
#opções do comando iptables usados pelo UFW: -A (append), -p (protocol), -j (jump target)

# ok icmp codes for OUTPUT
-A ufw6-before-output -p icmpv6 --icmpv6-type destination-unreachable -j ACCEPT
-A ufw6-before-output -p icmpv6 --icmpv6-type packet-too-big -j ACCEPT
-A ufw6-before-output -p icmpv6 --icmpv6-type time-exceeded -j ACCEPT
-A ufw6-before-output -p icmpv6 --icmpv6-type parameter-problem -j ACCEPT
-A ufw6-before-output -p icmpv6 --icmpv6-type echo-request -j ACCEPT
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```
```bash
#reiniciar as regras de firewall do UFW
#opção do comando ufw: reload (reloads firewall rules)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw reload
  Firewall reloaded
```
```bash
#pingando o endereço IPv4 e IPv6 do Google (agora deve funcionar)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping6
ping 8.8.8.8
ping6 2001:4860:4860::8888
ping google.com
```

## 15_ Liberando (ALLOW) a Entrada (INCOMING) Básicas (PORTS) do UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** por padrão, o UFW no Ubuntu Server adiciona automaticamente regras de IPv6 para regras criadas de forma simples ou básica.
>
> **OBSERVAÇÃO IMPORTANTE:** mesmo com o Log do UFW habilitado (item #09), nem todos os eventos são registrados em `/var/log/ufw.log` por padrão, adicione a opção: `log` (LOGAR) ou `log-all` (LOGAR TUDO) nas regras críticas, como o SSH, para ter rastreabilidade completa das tentativas de acesso.
>
> **OBSERVAÇÃO IMPORTANTE:** essa é a regra **mais crítica** da Blindagem Full: sem ela, você perde o acesso remoto ao servidor. Nunca aplique o `deny incoming` (item #07) sem antes garantir essa liberação, de preferência via `ufw insert` (item #23) na primeira posição.

```bash
#regra de liberação (ALLOW) de Entrada (IN) Logando Tudo (LOG-ALL) do Protocolo SSH (22/tcp)
#opção do comando ufw: limit (add limit rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw limit in on bond0 log-all from 172.16.1.0/24 to 172.16.1.20 port 22 proto tcp comment 'Liberando a entrada do acesso remoto via SSH v4'
sudo ufw limit in on bond0 log-all from 2804:14c:90:8697::/64 to 2804:14c:90:8697::20 port 22 proto tcp comment 'Liberando a entrada do acesso remoto via SSH v4'
```
```bash
#regra de liberação (ALLOW) de Entrada (IN) Logando Tudo (LOG-ALL) do Protocolo SpeedTest (8080/tcp)
#opção do comando ufw: limit (add limit rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw limit in on bond0 log-all from 172.16.1.0/24 to 172.16.1.20 port 8080 proto tcp comment 'Liberando a entrada do acesso remoto via SpeedTest v4'
sudo ufw limit in on bond0 log-all from 2804:14c:90:8697::/64 to 2804:14c:90:8697::20 port 8080 proto tcp comment 'Liberando a entrada do acesso remoto via SpeedTest v6'
```
```bash
#regra de liberação (ALLOW) de Entrada (IN) Logando Tudo (LOG-ALL) do Protocolo IPerf3 (5201/tcp)
#opção do comando ufw: limit (add limit rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw limit in on bond0 log-all from 172.16.1.0/24 to 172.16.1.20 port 5201 proto tcp comment 'Liberando a entrada do acesso remoto via IPerf3 v4'
sudo ufw limit in on bond0 log-all from 2804:14c:90:8697::/64 to 2804:14c:90:8697::20 port 5201 proto tcp comment 'Liberando a entrada do acesso remoto via IPerf3 v6'
```
```bash
#regra de liberação (ALLOW) de Entrada (IN) Logando Tudo (LOG-ALL) do Protocolo BBS (80/tcp)
#opção do comando ufw: limit (add limit rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw limit in on bond0 log-all from 172.16.1.0/24 to 172.16.1.20 port 80 proto tcp comment 'Liberando a entrada do acesso remoto via BBS v4'
sudo ufw limit in on bond0 log-all from 2804:14c:90:8697::/64 to 2804:14c:90:8697::20 port 80 proto tcp comment 'Liberando a entrada do acesso remoto via BBS v6'
```
```bash
#regra de liberação (ALLOW) de Entrada (IN) Logando Tudo (LOG-ALL) do Protocolo Grafana (3000/tcp)
#opção do comando ufw: limit (add limit rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw limit in on bond0 log-all from 172.16.1.0/24 to 172.16.1.20 port 3000 proto tcp comment 'Liberando a entrada do acesso remoto via Grafana v4'
sudo ufw limit in on bond0 log-all from 2804:14c:90:8697::/64 to 2804:14c:90:8697::20 port 3000 proto tcp comment 'Liberando a entrada do acesso remoto via Grafana v6'
```
```bash
#regra de liberação (ALLOW) de Entrada (IN) Logando Tudo (LOG-ALL) do Protocolo Prometheus (9090/tcp)
#opção do comando ufw: limit (add limit rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw limit in on bond0 log-all from 172.16.1.0/24 to 172.16.1.20 port 9090 proto tcp comment 'Liberando a entrada do acesso remoto via Prometheus v4'
sudo ufw limit in on bond0 log-all from 2804:14c:90:8697::/64 to 2804:14c:90:8697::20 port 9090 proto tcp comment 'Liberando a entrada do acesso remoto via Prometheus v6'
```
```bash
#regra de liberação (ALLOW) de Entrada (IN) Logando Tudo (LOG-ALL) do Protocolo Netronome (7575/tcp)
#opção do comando ufw: limit (add limit rule)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw limit in on bond0 log-all from 172.16.1.0/24 to 172.16.1.20 port 7575 proto tcp comment 'Liberando a entrada do acesso remoto via Netronome v4'
sudo ufw limit in on bond0 log-all from 2804:14c:90:8697::/64 to 2804:14c:90:8697::20 port 7575 proto tcp comment 'Liberando a entrada do acesso remoto via Netronome v6'
```
```bash
#verificando as Regras Detalhadas padrão do UFW
#opção do comando ufw: status (show status of firewall and ufw managed rules),
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```
```bash
#verificando as Regras Detalhadas padrão do UFW em modo Numerado
#opção do comando ufw: status (show status of firewall and ufw managed rules),
#numbered (To see a list of numbered rules)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status numbered
```
```bash
#testando a porta de conexão remota do SSH via Telnet a partir de outro equipamento
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/telnet
telnet 172.16.1.20 22
```
```bash
#acessando remotamente o Ubuntu Server via SSH (agora deve funcionar)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/ssh
ssh vaamonde@172.16.1.20
```

## 16_ Reiniciando (RELOAD) as Regras de Firewall do UFW no Ubuntu Server
```bash
#reiniciando as regras de firewall do UFW
#opção do comando ufw: reload (reloads firewall rules)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw reload
  Firewall reloaded
```
```bash
#verificando as Regras Detalhadas padrão do UFW
#opção do comando ufw: status (show status of firewall and ufw managed rules),
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
```

## 17_ Entendendo o Log (LOGGING) do Firewall UFW no Ubuntu Server
```bash
#listando o conteúdo do arquivo de Log do UFW
#opção do comando cat: -n (number line)
#opção do redirecionador | (pipe): Conecta a saída padrão com a entrada padrão de outro comando
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cat.1.html
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/less.1.html
sudo cat -n /var/log/ufw.log | less
```
```bash
#saída padrão dos Logs do UFW no arquivo ufw.log
1343 Jul 30 12:54:15 srvvaamonde kernel: [ 7898.809280] [UFW BLOCK] IN= OUT=enp0s3 SRC=172.16.1.20
DST=172.16.1.135 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=24251 DF PROTO=TCP SPT=54900 DPT=9100
WINDOW=64240 RES=0x00 SYN URGP=0
```

Entendendo os campos do Log do arquivo do UFW:__`/var/log/ufw.log`__<br>
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
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/tail.1.html
sudo tail -f /var/log/ufw.log
```

## 18_ Visualizando (SHOW) informações detalhadas (REPORT) do UFW no Ubuntu Server
```bash
#relatório detalhado em RAW (Raw Data)
#opção do comando ufw: show (display information about the running firewall)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw show raw
```
```bash
#relatório detalhado com tráfego de rede das CHAINS (Regras)
#opção do comando ufw: show (display information about the running firewall)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw show builtins
```
```bash
#relatório detalhado das regras antes (BEFORE-RULES) de serem aplicadas pelo UFW
#opção do comando ufw: show (display information about the running firewall)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw show before-rules
```
```bash
#relatório detalhado das regras do usuário (USER-RULES) a serem aplicadas pelo UFW
#opção do comando ufw: show (display information about the running firewall)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw show user-rules
```
```bash
#relatório detalhado das regras depois (AFTER-RULES) de serem aplicadas pelo UFW
#opção do comando ufw: show (display information about the running firewall)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw show after-rules
```
```bash
#relatório detalhado das regras de Logs (LOGGING-RULES) a serem aplicadas pelo UFW
#opção do comando ufw: show (display information about the running firewall)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw show logging-rules
```
```bash
#relatório detalhado das portas liberadas (LISTENING) do servidor pelo UFW
#opção do comando ufw: show (display information about the running firewall)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw show listening
```
```bash
#relatório detalhado das regras adicionadas (ADDED) no UFW
#opção do comando ufw: show (display information about the running firewall)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw show added
```

## 19_ Desativando (DISABLE) e Ativando (ENABLE) o UFW no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** se você desabilitar o firewall UFW, as regras já criadas **NÃO** são perdidas, apenas deixam de ser aplicadas.

```bash
#desabilitando (DISABLE) o Firewall UFW
#opção do comando ufw: disable (unloads firewall and disables firewall on boot)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw disable
  Firewall stopped and disabled on system startup
```
```bash
#verificando as Regras Detalhadas do UFW (regras permanecem salvas, mesmo desabilitado)
#opção do comando ufw: status (show status of firewall and ufw managed rules),
#verbose (Use status verbose for extra information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status verbose
  Status: inactive
```
```bash
#habilitando (ENABLE) novamente o Firewall UFW
#opção do comando ufw: enable (reloads firewall and enables firewall on boot)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw enable
  Command may disrupt existing ssh connections. Proceed with operation (y|n)? y <Enter>
  Firewall is active and enabled on system startup
```
```bash
#verificando as Regras Detalhadas padrão do UFW em modo Numerado
#opção do comando ufw: status (show status of firewall and ufw managed rules),
#numbered (To see a list of numbered rules)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/ufw.8.html
sudo ufw status numbered
```

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO FIREWALL UFW A SEGUINTE FRASE: *Configuração do Firewall UFW On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #firewall #firewallubuntu #firewalluntuserver #firewalluntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/18-firewall.png

---