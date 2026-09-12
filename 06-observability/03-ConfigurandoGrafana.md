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

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO GRAFANA A SEGUINTE FRASE: *Configuração do Grafana On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #grafana #grafanaubuntu #grafanauntuserver #grafanauntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/17-grafana.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
Site Oficial do Grafana: https://grafana.com/<br>

**Conteúdo estudado nessa configuração:**<br>
#01_ 

| **🛡️ Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| **Grafana** | Plataforma de código aberto para **visualização, análise e monitoramento de dados**, capaz de consultar diferentes fontes de dados e apresentar as informações por meio de dashboards, gráficos, tabelas e indicadores. | Serve para **visualizar e analisar as métricas coletadas pelo Prometheus**, permitindo acompanhar CPU, memória, disco, filesystem, rede, uptime e outros indicadores do Ubuntu Server 26.04. Também permite criar **dashboards personalizados, consultas, painéis e alertas**, facilitando a identificação de problemas e o acompanhamento da saúde do servidor. |
---

[![Node Exporter Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Node Exporter Ubuntu Server")

Link da vídeo aula: 

## 01_ Instalando as Dependências do Grafana Server no Ubuntu Server
```bash
#atualizando as lista do Apt do sources.list no Ubuntu Server
#opção do comando apt: update (Resynchronize the package index files from their sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt update
```
```bash
#instalando as dependências do Grafana Server no Ubuntu Server
#opção do comando apt: install (install is followed by one or more package names)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt install apt-transport-https software-properties-common git vim
```

## 02_ Baixando a Chave GPG e Criando o Repositório do Grafana Server no Ubuntu Server
```bash
#baixando e instalando a Chave GPG do Grafana Server no Ubuntu Server
#opção do comando wget: -q (quiet), -O (output-document)
#opção do comando gpg: --dearmor (Pack or unpack an arbitrary input into/from an OpenPGP ASCII armor)
#opção do redirecionador | (pipe): Conecta a saída padrão com a entrada padrão de outro comando
#opção do redirecionador > (maior): Redireciona a saída padrão (STDOUT)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/gpg
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/tee.1.html
sudo wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/grafana.gpg > /dev/null
```
```bash
#criando o Repositório do Grafana Server no Ubuntu Server
#opção do comando tee: -a (append)
#opção do redirecionador | (pipe): Conecta a saída padrão com a entrada padrão de outro comando
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/tee.1.html
echo "deb [signed-by=/usr/share/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
```

## 03_ Instalando o Grafana Server no Ubuntu Server
```bash
#atualizando as listas do Apt com o novo Repositório do Grafana no Ubuntu Server
#opção do comando apt: update (Resynchronize the package index files from their sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt update
```
```bash
#instalando o Grafana Server no Ubuntu Server
#opções do comando apt: install (install is followed by one or more package names), 
#--install-recommends (Consider suggested packages as a dependency for installing)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt install --install-recommends grafana
```

## 04_ Atualizado os arquivos de configuração do Grafana Server no Ubuntu Server
```bash
#fazendo o backup do arquivo de configuração do Grafana Server no Ubuntu Server
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/default/grafana-server /etc/default/grafana-server.old
```
```bash
#fazendo o backup do arquivo de inicialização do Grafana Server no Ubuntu Server
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/grafana/grafana.ini /etc/grafana/grafana.ini.old
```
```bash
#download do arquivo de configuração customizado do Grafana Server no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
sudo wget -v -O /etc/default/grafana-server https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/grafana-server
```
```bash
#download do arquivo de inicialização customizado do Grafana Server no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/wget.1.html
sudo wget -v -O /etc/grafana/grafana.ini https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/grafana.ini
```

## 05_ Localização dos diretórios e arquivos principais do Grafana Server no Ubuntu Server

| **📂 Caminho** | **📌 Tipo** | **📖 Descrição** | **🎯 Finalidade** |
| :------------- | :---------- | :--------------- | :---------------- |
| `/etc/grafana/` | Diretório | Diretório principal dos **arquivos de configuração** do Grafana Server. | Centralizar as configurações utilizadas pelo Grafana. |
| `/etc/grafana/grafana.ini` | Arquivo | Principal arquivo de **configuração do Grafana Server**. | Definir parâmetros de inicialização, servidor Web, banco de dados, autenticação, segurança, logs e outros recursos. |
| `/etc/default/grafana-server` | Arquivo | Arquivo com **variáveis e parâmetros utilizados pelo serviço** `grafana-server`. | Complementar a configuração de inicialização e execução do serviço pelo sistema operacional. |
| `/usr/share/grafana/` | Diretório | Diretório que contém os **arquivos da aplicação Grafana**, incluindo recursos Web e arquivos necessários à execução. | Disponibilizar os componentes da **interface Web e da aplicação** do Grafana Server. |
| `/var/log/grafana/` | Diretório | Diretório destinado aos **arquivos de log** do Grafana Server. | Registrar eventos, erros, avisos e informações úteis para **monitoramento e troubleshooting**. |
| `/var/lib/grafana/` | Diretório | Diretório destinado aos **dados persistentes** utilizados pelo Grafana Server. | Armazenar dados locais da aplicação, incluindo o **banco de dados SQLite**, quando utilizado, e outros dados persistentes. |
| `/var/lib/grafana/plugins/` | Diretório | Diretório destinado aos **plugins instalados** no Grafana. | Armazenar e organizar plugins adicionais que ampliam as funcionalidades do Grafana Server. |
---

## 06_ Editando os arquivos de configuração do Grafana Server no Ubuntu Server
```bash
#editando o arquivo de configuração do Grafana Server no Ubuntu Server
sudo vim /etc/default/grafana-server
```
```bash
#habilitando o número de linhas do arquivo grafana-server
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#principais variáveis do Grafana Server (PADRÃO NÃO ALTERAR OS VALORES)
GRAFANA_USER=grafana          (usuário do serviço do Grafana Server)
GRAFANA_GROUP=grafana         (grupo do serviço do Grafana Server)
LOG_DIR=/var/log/grafana      (localização dos arquivos de Log do Grafana Server)
DATA_DIR=/var/lib/grafana     (localização do banco de dados do Grafana Server)
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>
```
```bash
#editando o arquivo de inicialização do Grafana Server no Ubuntu Server
sudo vim /etc/grafana/grafana.ini
```
```bash
#habilitando o número de linhas do arquivo grafana.ini
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#descomentar a variável protocol = na linha: 32
protocol = http

#descomentar a variável ;http_port = na linha 41
http_port = 3000

#descomentar a variável ;domain = na linha 44
#altere o nome de domínio conforme o seu cenário
domain = pti.intra
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>
```

## 07_ Habilitando o Serviço do Grafana Server no Ubuntu Server
```bash
#habilitando o serviço do Grafana Server no Ubuntu Server
#opções do comando systemctl: daemon-reload (Reload the systemd manager configuration), 
#enable (Enable one or more units), restart (Stop and then start one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#atualizando os serviços do Systemd no Ubuntu Server
sudo systemctl daemon-reload
```
```bash
#habilitando o serviço do Prometheus no Ubuntu Server
sudo systemctl enable grafana-server
```
```bash
#reinicializando o serviço do Prometheus no Ubuntu Server
sudo systemctl restart grafana-server
```

## 08_ Verificando o Serviço e Versão do Grafana Server no Ubuntu Server
```bash
#verificando o serviço do Grafana Server no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then 
#start one or more units), stop (Stop (deactivate) one or more units), start (Start (activate) 
#one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#verificando o status do serviço do Prometheus no Ubuntu Server
sudo systemctl status grafana-server
```
```bash
#reinicializando o serviço do Prometheus no Ubuntu Server
sudo systemctl restart grafana-server
```
```bash
#parando o serviço do Prometheus no Ubuntu Server
sudo systemctl stop grafana-server
```
```bash
#iniciando o serviço do Prometheus no Ubuntu Server
sudo systemctl start grafana-server
```
```bash
#analisando os Log's e mensagens de erro do Servidor do Grafana Server
#opção do comando journalctl: -t (identifier), -x (catalog), -e (pager-end), -u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -t grafana
sudo journalctl -xeu grafana-server
```

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção

```bash
#verificando a versão do Grafana Server no Ubuntu Server
#opção do comando grafana-server: -v (version)
#mais informações acesse a documentação oficial em: https://grafana.com/docs/grafana/latest/setup-grafana/start-restart-grafana/
sudo grafana-server -v
```
```bash
#verificando a versão do Grafana Cli no Ubuntu Server
#opção do comando grafana-cli: -v (version)
#mais informações acesse a documentação oficial em: https://grafana.com/docs/grafana/latest/administration/cli/
sudo grafana-cli -v
```

## 09_ Verificando a Porta de Conexão do Grafana Server no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** no Ubuntu Server as Regras de Firewall utilizando o comando: __` iptables `__ ou: __` ufw `__ está desabilitado por padrão **(INACTIVE)**, caso você tenha habilitado algum recurso de Firewall é necessário fazer a liberação do *Fluxo de Entrada (INPUT), Porta (PORT) e Protocolo (PROTOCOL) TCP* do Serviço corresponde nas tabelas do firewall e testar a conexão.

```bash
#verificando a porta padrão TCP-3000 do Grafana Server no Ubuntu Server
#opção do comando lsof: -n (network number), -P (port number), -i (list IP Address), -s (alone directs)
sudo lsof -nP -iTCP:'3000' -sTCP:LISTEN
```

## 10_ Configurando o Grafana Server via Navegador
```bash
#acessando via navegador o Grafana Server na Porta 3000
Navegadores firefox ou google chrome: http://endereço_ipv4_ubuntuserver:3000

#usuário e senha padrão de acesso do Grafana Server
Welcome to Grafana
  Email or username: admin
  Password: admin 
<Log In>

#atualização da senha do usuário Admin do Grafana Server
Update your password
  New password: SUA_SENHA_SEGURA
  Confirm new password: SUA_SENHA_SEGURA 
<Submit>
```

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO GRAFANA A SEGUINTE FRASE: *Configuração do Grafana On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #grafana #grafanaubuntu #grafanauntuserver #grafanauntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/17-grafana.png

---