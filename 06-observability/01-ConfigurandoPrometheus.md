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

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO PROMETHEUS A SEGUINTE FRASE: *Configuração do Prometheus On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #prometheus #prometheusubuntu #prometheusuntuserver #prometheusuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/15-prometheus.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
Site Oficial do Prometheus: https://prometheus.io/<br>

**Conteúdo estudado nessa configuração:**<br>
#01_ 

| **🛡️ Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| **Prometheus** | Sistema de **monitoramento e coleta de métricas** de código aberto, desenvolvido para coletar, armazenar e consultar dados de séries temporais (*time series*) de servidores, aplicações e serviços. | Serve para **monitorar a infraestrutura**, coletando métricas como CPU, memória, disco, filesystem, rede e disponibilidade dos serviços. No projeto Ubuntu Server 26.04, o Prometheus será responsável por **coletar e armazenar as métricas disponibilizadas pelo Node Exporter**, permitindo posteriormente sua análise e visualização no Grafana. |
---

[![Prometheus Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Prometheus Ubuntu Server")

Link da vídeo aula: 

## 01_ Criando o Grupo e o Usuário de Serviço do Prometheus no Ubuntu Server
```bash
#criando o grupo de serviço do Prometheus no Ubuntu Server
#opção do comando groupadd: --system (Create a system group)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/groupadd.8.html
sudo groupadd --system prometheus
```
```bash
#criando o usuário de serviço do Prometheus no Ubuntu Server
#opções do comando useradd: -s (shell), --no-create-home (Do no create the user's home directory), 
#--system (Create a system account). -g (group)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/useradd.8.html
sudo useradd -s /sbin/nologin --no-create-home --system -g prometheus prometheus
```
```bash
#verificando o grupo do Prometheus criado no Ubuntu Server
#opção do comando getent: group (show enumerate the group database)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/getent.1.html
sudo getent group prometheus
```
```bash
#verificando o usuário do Prometheus criado no Ubuntu Server
#opção do comando getent: passwd (show enumerate the passwd database)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/getent.1.html
sudo getent passwd prometheus
```

## 02_ Criando os Diretórios de Configuração do Prometheus no Ubuntu Server
```bash
#criando os diretórios de configuração e bibliotecas do Prometheus no Ubuntu Server
#opção do comando mkdir: -p (parents), -v (verbose)
#opção do bloco de agrupamento {} (chaves): Agrupa comandos em um bloco em looping
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/mkdir.1.html
sudo mkdir -pv /etc/prometheus/{targets,rules} /var/lib/prometheus
```

## 03_ Baixando o Prometheus do Github no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o executável e os arquivos de configuração do *Prometheus* sofre alteração o tempo todo, sempre acessar o projeto do `Github` para verificar a *última versão do software* no Link: https://github.com/prometheus/prometheus/releases/

```bash
#download do Prometheus do Github no Ubuntu Server (Link atualizado no dia 12/09/2026)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
wget https://github.com/prometheus/prometheus/releases/download/v3.13.3/prometheus-3.13.3.linux-amd64.tar.gz
```
```bash
#listando o download do arquivo do Prometheus no Ubuntu Server
#opção do comando ls: -l (long listing), -h (human-readable)
#opção do caractere curinga * (asterisco): Qualquer coisa e autocomplemento
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.html
ls -lh prometheus*
```

## 04_ Descompactando o arquivo do Prometheus no Ubuntu Server
```bash
#descompactando o arquivo do Prometheus no Ubuntu Server
#opção do comando tar: -z (gzip), -x (extract), -v (verbose), -f (file)
#opção do caractere curinga * (asterisco): Qualquer coisa e autocomplemento
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/tar.1.html
tar -zxvf prometheus*.tar.gz 
```

## 05_ Atualizando os arquivos executáveis do Prometheus no Ubuntu Server
```bash
#atualizando os arquivos binários do Prometheus no Ubuntu Server
#opção do comando cp: -R (recursive), -v (verbose)
#opção do caractere curinga * (asterisco): Qualquer coisa e autocomplemento
#opção do bloco de agrupamento {} (chaves): Agrupa comandos em um bloco em lopping
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -Rv prometheus*/{prometheus,promtool} /usr/local/bin/
```

## 06_ Localização dos diretórios e arquivos principais do Prometheus no Ubuntu Server 

| **📂 Caminho** | **📌 Tipo** | **📖 Descrição** | **🎯 Finalidade** |
| :------------- | :---------- | :--------------- | :---------------- |
| `/etc/prometheus/` | Diretório | Diretório principal dos **arquivos de configuração** do Prometheus. | Centralizar as configurações utilizadas pelo serviço. |
| `/etc/prometheus/prometheus.yml` | Arquivo | Principal arquivo de configuração do **Prometheus**. | Define parâmetros como **scrape jobs, targets, intervalos de coleta, regras e configurações de integração**. |
| `/etc/prometheus/rules/` | Diretório | Diretório destinado aos **arquivos de regras** do Prometheus. | Organizar regras de **alertas e gravação (recording rules)**. |
| `/etc/prometheus/rules/alertas-node-linux.yml` | Arquivo | Arquivo contendo as **regras de alertas relacionadas ao Node Exporter/Linux**. | Definir condições que, quando atendidas, podem gerar **alertas sobre CPU, memória, disco, rede e outros recursos do servidor**. |
| `/var/lib/prometheus/` | Diretório | Diretório utilizado para armazenar os **dados persistentes do Prometheus**. | Manter os dados da **TSDB (Time Series Database)** coletados pelo Prometheus. |
| `/var/lib/prometheus/*` | Dados | Arquivos e diretórios internos gerados pelo Prometheus durante sua operação. | Armazenar as **séries temporais, blocos, índices e demais dados necessários à consulta das métricas**. |
---

## 07_ Baixando e atualizando os arquivos de Configurações Customizados do Prometheus no Ubuntu Server
```bash
#download do arquivo de serviço do Prometheus no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
sudo wget -v -O /etc/systemd/system/prometheus.service https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/prometheus.service
```
```bash
#download do arquivo de configuração do Prometheus no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
sudo wget -v -O /etc/prometheus/prometheus.yml https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/prometheus.yml
```

## 08_ Alterando as permissões dos arquivos e diretórios do Prometheus no Ubuntu Server
```bash
#alterando o dono e grupo dos arquivos e diretórios do Prometheus no Ubuntu Server
#opção do comando chown: -R (recursive) -v (verbose), prometheus (user), :prometheus (group)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/chown.1.html
sudo chown -Rv prometheus:prometheus /etc/prometheus/ /var/lib/prometheus/
```
```bash
#alterando as permissões de arquivos e diretórios do Prometheus no Ubuntu Server
#opção do comando chmod: -R (recursive) -v (verbose), 775 (User: RWX, Group: RWX, Other: R-X)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/chmod.1.html
sudo chmod -Rv 775 /etc/prometheus/ /var/lib/prometheus/
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
#alterar os valores das viráveis a partir da linha: 23
external_labels:
  monitor: "prometheus-srvvaamonde"
  ambiente: "laboratorio"

#alterar os valores das viráveis a partir da linha: 58
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["172.16.1.20:9090"]
        labels:
          servico: "prometheus"
          sistema: "linux"
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

## 10_ Habilitando o Serviço do Prometheus no Ubuntu Server 
```bash
#habilitando o serviço do Prometheus no Ubuntu Server 
#opções do comando systemctl: daemon-reload (Reload the systemd manager configuration), 
#enable (Enable one or more units), start (Start (activate) one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#atualizando os serviços do Systemd no Ubuntu Server
sudo systemctl daemon-reload
```
```bash
#habilitando o serviço do Prometheus no Ubuntu Server
sudo systemctl enable prometheus
```
```bash
#iniciando o serviço do Prometheus no Ubuntu Server
sudo systemctl start prometheus
```

## 11_ Verificando o Serviço e Versão do Prometheus no Ubuntu Server 
```bash
#verificando o serviço do Prometheus no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then 
#start one or more units), stop (Stop (deactivate) one or more units), start (Start (activate) 
#one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#verificando o status do serviço do Prometheus no Ubuntu Server
sudo systemctl status prometheus
```
```bash
#reinicializando o serviço do Prometheus no Ubuntu Server
sudo systemctl restart prometheus
```
```bash
#parando o serviço do Prometheus no Ubuntu Server
sudo systemctl stop prometheus
```
```bash
#iniciando o serviço do Prometheus no Ubuntu Server
sudo systemctl start prometheus
```
```bash
#analisando os Log's e mensagens de erro do Prometheus no Ubuntu Server 
#opção do comando journalctl: -t (identifier), -x (catalog), -e (pager-end), -u (unit)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -t prometheus
sudo journalctl -xeu prometheus
```

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção

```bash
#verificando a versão do Prometheus no Ubuntu Server
#opção do comando prometheus: --version (Show application version.)
#mais informações acesse a documentação oficial em: https://prometheus.io/docs/prometheus/latest/getting_started
sudo prometheus --version
```
```bash
#verificado a versão do Promtool do Prometheus no Ubuntu Server
#opção do comando promtool: --version (Show application version.)
#mais informações acesse a documentação oficial em: https://prometheus.io/docs/prometheus/latest/getting_started
sudo promtool --version
```

## 12_ Verificando a Porta de Conexão do Prometheus no Ubuntu Server 

> **OBSERVAÇÃO IMPORTANTE:** no Ubuntu Server as Regras de Firewall utilizando o comando: __` iptables `__ ou: __` ufw `__ está desabilitado por padrão **(INACTIVE)**, caso você tenha habilitado algum recurso de Firewall é necessário fazer a liberação do *Fluxo de Entrada (INPUT), Porta (PORT) e Protocolo (PROTOCOL) TCP* do Serviço corresponde nas tabelas do firewall e testar a conexão.

```bash
#verificando a porta padrão TCP-9090 do Prometheus no Ubuntu Server
#opção do comando lsof: -n (network number), -P (port number), -i (list IP Address), -s (alone directs)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsof.8.html
sudo lsof -nP -iTCP:'9090' -sTCP:LISTEN
```

## 13_ Configurando o Prometheus via Navegador no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** Quando você acessa o Prometheus via Navegador e aparece a seguinte mensagem de aviso em vermelho: *Warning: Error fetching server time: Detected 65.21499991416931 seconds time difference between your browser and the server. Prometheus relies on accurate time and time drift might cause unexpected query results*. Esse erro está associado a falha de sincronismo da Data e Hora em relação o Servidor e Cliente, para resolver essa falha é necessário acertar a Data Hora entre os equipamentos ou utilizar o Protocolo **NTP (Network Time Protocol)** para sincronizar a data/hora de forma correta. 

```bash
#acessando o Prometheus via navegador
firefox ou google chrome: http://endereço_ipv4_ubuntuserver:9090
```
```bash
#verificando o monitoramento do Prometheus no Ubuntu Server
Status
  Targets health
    Prometheus
      Endpoint: http://172.16.1.20:9090/metrics
```

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO PROMETHEUS A SEGUINTE FRASE: *Configuração do Prometheus On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #prometheus #prometheusubuntu #prometheusuntuserver #prometheusuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/15-prometheus.png

---