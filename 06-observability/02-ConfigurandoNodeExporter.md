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
**Data de atualização:** `10/09/2026`<br>
**Versão:** `0.07`<br>

> __`Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS`__

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO NODE EXPORTER A SEGUINTE FRASE: *Configuração do Node Exporter On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #nodeexporter #nodeexporterubuntu #nodeexporteruntuserver #nodeexporteruntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/16-nodeexporter.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
Site Oficial do Prometheus: https://prometheus.io/<br>
Site Oficial do Node Exporter: https://github.com/prometheus/node_exporter<br>

**Conteúdo estudado nessa configuração:**<br>
#01_ 

| **🛡️ Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| **Node Exporter** | Componente de código aberto do ecossistema **Prometheus**, responsável por coletar e disponibilizar métricas do sistema operacional Linux, expondo essas informações em um formato que o Prometheus consegue consultar. | Serve para **coletar métricas do Ubuntu Server 26.04**, como uso de CPU, memória RAM, disco, filesystem, I/O, interfaces de rede, carga do sistema, processos, uptime e informações do kernel. O Node Exporter **não armazena nem apresenta os dados**; ele disponibiliza as métricas para que o **Prometheus** faça a coleta e o **Grafana** realize a visualização. |
---

[![Node Exporter Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Node Exporter Ubuntu Server")

Link da vídeo aula: 

## 01_ Criando o Grupo e o Usuário de Serviço do Node Exporter no Ubuntu Server
```bash
#criando o grupo de serviço do Node Exporter no Ubuntu Server
#opção do comando groupadd: --system (Create a system group)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/groupadd.8.html
sudo groupadd --system node_exporter
```
```bash
#criando o usuário de serviço do Node Exporter no Ubuntu Server
#opções do comando useradd: -s (shell), --no-create-home (Do no create the user's home directory), 
#--system (Create a system account). -g (group)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/useradd.8.html
sudo useradd -s /sbin/nologin --no-create-home --system -g node_exporter node_exporter
```
```bash
#verificando o grupo do Node Exporter criado no Ubuntu Server
#opção do comando getent: group (show enumerate the group database)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/getent.1.html
sudo getent group node_exporter
```
```bash
#verificando o usuário do Node Exporter criado no Ubuntu Server
#opção do comando getent: passwd (show enumerate the passwd database)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/getent.1.html
sudo getent passwd node_exporter
```

## 02_ Baixando o Coletor de Métricas Node Exporter do Github no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o executável do *Node Exporter do Prometheus* sofre alteração o tempo todo, sempre acessar o projeto do Github para verificar a última versão do software no Link: https://github.com/prometheus/node_exporter/releases/

```bash
#download do Node Exporter do Github no Ubuntu Server (Link atualizado no dia 12/09/2026)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
wget https://github.com/prometheus/node_exporter/releases/download/v1.12.1/node_exporter-1.12.1.linux-amd64.tar.gz
```
```bash
#listando o download do arquivo do Node Exporter no Ubuntu Server
#opção do comando ls: -l (long listing), -h (human-readable)
#opção do caractere curinga * (asterisco):Qualquer coisa e autocomplemento
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.html
ls -lh node_exporter*
```

## 03_ Descompactando o arquivo do Node Exporter no Ubuntu Server
```bash
#descompactando o arquivo do Node Exporter no Ubuntu Server
#opção do comando tar: -z (gzip), -x (extract), -v (verbose), -f (file)
#opção do caractere curinga * (asterisco): Qualquer coisa e autocomplemento
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/tar.1.html
tar -zxvf node_exporter*.tar.gz 
```

## 04_ Atualizando os arquivos de executáveis do Node Exporter no Ubuntu Server
```bash
#atualizando os arquivos de configurações do Node Exporter no Ubuntu Server
#opção do comando cp: -R (recursive), -v (verbose)
#opção do caractere curinga * (asterisco): Qualquer coisa e autocomplemento
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -Rv node_exporter*/node_exporter /usr/local/bin/
```

## 05_ Localização dos diretórios e arquivos principais do Prometheus no Ubuntu Server 

| **📂 Caminho** | **📌 Tipo** | **📖 Descrição** | **🎯 Finalidade** |
| :------------- | :---------- | :--------------- | :---------------- |
| `/etc/prometheus/` | Diretório | Diretório principal dos **arquivos de configuração** do Prometheus. | Centralizar as configurações utilizadas pelo serviço. |
| `/etc/prometheus/node_exporter.conf` | Arquivo | Principal arquivo de configuração do **Node Exporter**. | Define parâmetros de inicialização do serviço do Node Exporter e seus recursos de monitoramento. |
| `/etc/prometheus/rules/alertas-node-linux.yml` | Arquivo | Arquivo contendo as **regras de alertas relacionadas ao Node Exporter/Linux**. | Definir condições que, quando atendidas, podem gerar **alertas sobre CPU, memória, disco, rede e outros recursos do servidor**. |
---

## 06_ Baixando e atualizando os arquivos customizados do Node Exporter no Ubuntu Server
```bash
#download do arquivo de serviço do Node Exporter no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
sudo wget -v -O /etc/systemd/system/node_exporter.service https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/node_exporter.service
```
```bash
#download do arquivo de configuração do Node Exporter no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
sudo wget -v -O /etc/prometheus/node_exporter.conf https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/node_exporter.conf
```
```bash
#download do arquivo de configuração dos alertas periódicos do Node Exporter no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
sudo wget -v -O /etc/prometheus/rules/alertas-node-linux.yml https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/alertas-node-linux.yml
```

## 07_ Alterando as permissões do executável do Node Exporter no Ubuntu Server
```bash
#alterando o dono e grupo do arquivo do Node Exporter no Ubuntu Server
#opção do comando chown: -R (recursive) -v (verbose), node_exporter (user), :node_exporter (group)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/chown.1.html
sudo chown -Rv node_exporter:node_exporter /usr/local/bin/node_exporter
```
```bash
#alterando o dono e grupo do arquivo do Node Exporter no Ubuntu Server
#opção do comando chown: -R (recursive) -v (verbose), node_exporter (user), :node_exporter (group)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/chown.1.html
sudo chown -Rv node_exporter:node_exporter /etc/prometheus/node_exporter.conf
```
```bash
#alterando as permissões do arquivo do Node Exporter no Ubuntu Server
#opção do comando chmod: -R (recursive) -v (verbose), 775 (User: RWX, Group: RWX, Other: R-X)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/chmod.1.html
sudo chmod -Rv 775 /usr/local/bin/node_exporter
```

## 08_ Editando o arquivo de configuração do Node Exporter no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o arquivo de configuração do `Node Exporter` e baseado no formato de Serialização de Dados Legíveis *YAML (Yet Another Markup Language)* utilizado pela linguagem de programação Python, muito cuidado com o uso de espaços e tabulação e principalmente sua indentação.

```bash
#editando arquivo de configuração dos Alertas do Node Exporter no Ubuntu Server
sudo vim /etc/prometheus/rules/alertas-node-linux.yml
```
```bash
#habilitando o número de linhas do arquivo alertas-node-linux.yml
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```yaml
# Configuração dos grupos de alertas do Node Exporter na linha 26
# Configuração do alerta de: Node Exporter Inativo (Sonda Fora do Ar) na linha 31
# Configuração do alerta de: Uso elevado de CPU na linha 43
# Configuração do alerta de: Uso elevado de Memória RAM na linha 53
# Configuração do alerta de: Uso elevado de Memória Swap na linha 63
# Configuração do alerta de: Hard Disk (Partição/Volume Lógico) quase cheio na linha 73
# Configuração do alerta de: Previsão de Esgotamento de Disco (Antecipação de Falha) na linha 86
# Configuração do alerta de: Load Average (Média de Carga de Processamento) elevado na linha 96
# Configuração do alerta de: Uso elevado de I/O (Entrada e Saída) de Disco na linha 106
# Configuração do alerta de: Relógio do Sistema Dessincronizado (NTP/Chrony) na linha 116
# Configuração do alerta de: Desvio (Offset) de Relógio elevado na linha 128
# Configuração do alerta de: Unidade do Systemd em Estado de Falha (Failed) na linha 138
# Configuração do alerta de: Reinicialização Recente do Servidor na linha 150
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>
```

## 09_ Editando o arquivo de configuração do Prometheus no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o arquivo de configuração do `Prometheus` e baseado no formato de Serialização de Dados Legíveis *YAML (Yet Another Markup Language)* utilizado pela linguagem de programação Python, muito cuidado com o uso de espaços e tabulação e principalmente sua indentação.

```bash
#editando arquivo de configuração do Prometheus no Ubuntu Server
sudo vim /etc/prometheus/prometheus.yml
```
```bash
#habilitando o número de linhas do arquivo prometheus.yml
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```yaml
#Descomentar as linhas de configuração do Node Exporter a partir da linha 71
# Configurações dos Serviços de Monitoramento de Métricas do Prometheus utilizando
# o recurso de Exportação do Node Remoto para sistemas operacionais Linux ou Windows
  - job_name: "srvvaamonde"
    static_configs:
      - targets: ["172.16.1.20:9100"]
        labels:
          host: "srvvaamonde"
          sistema: "linux"
          funcao: "servidor"
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>
```
```bash
#testando o arquivo de configuração do Prometheus no Ubuntu Server
#opção do comando sudo: -u (Run the command as a user other than the default target user)
#opções do comando promtool: check config (Check if the config files are valid or not) 
#mais informações acesse a documentação oficial em: https://prometheus.io/docs/prometheus/latest/getting_started/
sudo -u prometheus promtool check config /etc/prometheus/prometheus.yml
```

## 10_ Habilitando o Serviço do Node Exporter no Ubuntu Server
```bash
#habilitando o serviço do Node Exporter no Ubuntu Server
#opções do comando systemctl: daemon-reload (Reload the systemd manager configuration), 
#enable (Enable one or more units), start (Start (activate) one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#atualizando os serviços do Systemd no Ubuntu Server
sudo systemctl daemon-reload
```
```bash
#habilitando o serviço do Node Exporter no Ubuntu Server
sudo systemctl enable node_exporter
```
```bash
#reiniciando o serviço do Node Exporter no Ubuntu Server
sudo systemctl restart node_exporter
```
```bash
#reiniciando o serviço do Prometheus no Ubuntu Server
sudo systemctl restart prometheus
```

## 11_ Verificando o Serviço e Versão do Node Exporter no Ubuntu Server
```bash
#verificando o serviço do Node Exporter no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then 
#start one or more units), stop (Stop (deactivate) one or more units), start (Start (activate) 
#one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#verificando o status do serviço do Node Exporter no Ubuntu Server
sudo systemctl status node_exporter
```
```bash
#reinicializando o serviço do Node Exporter no Ubuntu Server
sudo systemctl restart node_exporter
```
```bash
#parando o serviço do Node Exporter no Ubuntu Server
sudo systemctl stop node_exporter
```
```bash
#iniciando o serviço do Node Exporter no Ubuntu Server
sudo systemctl start node_exporter
```
```bash
#analisando os Log's e mensagens de erro do Node Exporter no Ubuntu Server
#opção do comando journalctl: -t (identifier), -x (catalog), -e (pager-end), -u (unit)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -t node_exporter
sudo journalctl -xeu node_exporter
```

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção.

```bash
#verificando a versão do Node Exporter no Ubuntu Server
#mais informações acesse a documentação oficial em: https://prometheus.io/docs/guides/node-exporter/
sudo node_exporter --version
```

## 12_ Verificando a Porta de Conexão do Node Exporter no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** no Ubuntu Server as Regras de Firewall utilizando o comando: __` iptables `__ ou: __` ufw `__ está desabilitado por padrão **(INACTIVE)**, caso você tenha habilitado algum recurso de Firewall é necessário fazer a liberação do *Fluxo de Entrada (INPUT), Porta (PORT) e Protocolo (PROTOCOL) TCP* do Serviço corresponde nas tabelas do firewall e testar a conexão.

```bash
#verificando a porta padrão TCP-9100 do Node Exporter no Ubuntu Server
#opção do comando lsof: -n (network number), -P (port number), -i (list IP Address), -s (alone directs)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsof.8.html
sudo lsof -nP -iTCP:'9100' -sTCP:LISTEN
```

## 13_ Verificando as Métrica do Node Exporter no Prometheus via Navegador no Ubuntu Server

```bash
#acessando o Prometheus via navegador
firefox ou google chrome: http://endereço_ipv4_ubuntuserver:9090
```
```bash
#verificando o monitoramento do Prometheus no Ubuntu Server
Status
  Targets health
    #Monitoramento do Prometheus na porta 9090
    Prometheus
      Endpoint: http://172.16.1.20:9090/metrics
    #Monitoramento do Node Exporter na porta 9100
    srvvaamonde
      Endpoint: http://172.16.1.20:9100/metrics
```

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO NODE EXPORTER A SEGUINTE FRASE: *Configuração do Node Exporter On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #nodeexporter #nodeexporterubuntu #nodeexporteruntuserver #nodeexporteruntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/16-nodeexporter.png

---