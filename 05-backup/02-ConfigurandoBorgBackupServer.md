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

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO BORG BACKUP SERVER A SEGUINTE FRASE: *Configuração do Borg Backup Server On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #bbs #bbsubuntu #bbsuntuserver #bbsuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/14-borgbackup.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
BorgBackup (Software Base): https://www.borgbackup.org/<br>
BorgBackup Server / BBS (Projeto): https://github.com/marcpope/borgbackupserver<br>
BorgBackup Server / BBS (Documentação Oficial - Wiki): https://github.com/marcpope/borgbackupserver/wiki<br>
BorgBackup Server / BBS (Site Oficial): https://www.borgbackupserver.com/<br>

**Conteúdo estudado nessa configuração:**<br>
[#01_ Verificando os Pré-requisitos do Ambiente para o BorgBackupServer no Ubuntu Server](#01_-verificando-os-pré-requisitos-do-ambiente-para-o-borgbackupserver-no-ubuntu-server)<br>
[#02_ Verificando os Requisitos de Sistema (Software Base) do BBS no Ubuntu Server](#02_-verificando-os-requisitos-de-sistema-software-base-do-bbs-no-ubuntu-server)<br>
[#03_ Instalando o BorgBackupServer (BBS) no Ubuntu Server](#03_-instalando-o-borgbackupserver-bbs-no-ubuntu-server)<br>
[#04_ Verificando os Serviços Instalados pelo BBS no Ubuntu Server](#04_-verificando-os-serviços-instalados-pelo-bbs-no-ubuntu-server)<br>
[#05_ Assistente de Configuração Inicial (Setup Wizard) do BBS no Ubuntu Server](#05_-assistente-de-configuração-inicial-setup-wizard-do-bbs-no-ubuntu-server)<br>
[#06_ Instalando e Registrando o Agente Local (Linux Agent Client) no Ubuntu Server](#06_-instalando-e-registrando-o-agente-local-linux-agent-client-no-ubuntu-server)<br>
[#07_ Criando o Armazenamento Local (Storage) do BBS no Ubuntu Server](#07_-criando-o-armazenamento-local-storage-do-bbs-no-ubuntu-server)<br>
[#08_ Criando o Modelo (Template) de Backup do BBS no Ubuntu Server](#08_-criando-o-modelo-template-de-backup-do-bbs-no-ubuntu-server)<br>
[#09_ Criando o Repositório do BBS apontando para a Partição de Backup no Ubuntu Server](#09_-configurando-o-repositório-do-bbs-para-a-partição-de-backup-no-ubuntu-server)<br>
[#10_ Criando o Plano de Backup dp BBS no Ubuntu Server](#10_-criando-o-plano-de-backup-dp-bbs-no-ubuntu-server)<br>
[#11_ Criando a Estrutura de Informações na Partição Dados do Ubuntu Server](#11_-criando-a-estrutura-de-informações-na-partição-dados-do-ubuntu-server)<br>
[#12_ Executando e Monitorando o Primeiro Backup do BBS no Ubuntu Server](#12_-executando-e-monitorando-o-primeiro-backup-do-bbs-no-ubuntu-server)<br>
[#13_ Testando a Restauração (Restore) de Arquivos do BBS no Ubuntu Server](#13_-testando-a-restauração-restore-de-arquivos-do-bbs-no-ubuntu-server)<br>
[#14_ Localização dos Arquivos de Configuração e Logs do BBS no Ubuntu Server](#14_-localização-dos-arquivos-de-configuração-e-logs-do-bbs-no-ubuntu-server)<br>

[![BorgBackupServer Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "BorgBackupServer Ubuntu Server")

Link da vídeo aula: 

> **OBSERVAÇÃO IMPORTANTE:** este procedimento assume o **Cenário de Servidor Único (All-in-One)**, ou seja, o **Painel Web do BBS** (Backend PHP + Banco de Dados MySQL) e o **Agente Local (Linux Agent)** serão instalados na **MESMA** Máquina Virtual `UbuntuOnPremises`, junto com a partição de Dados (LVM) e a partição de Backup (Particionamento Tradicional) criadas nos procedimentos anteriores. Em um cenário de Produção On-Premises real, é recomendado instalar o Painel do BBS em um servidor dedicado, separado dos servidores que ele protege.

| **💾 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🦫 **BorgBackup** | Software de Backup de linha de comando, com **Deduplicação**, **Compressão** e **Criptografia** nativas, mantido pela comunidade *Borg Collective*. | Motor (Engine) responsável por gravar os dados de forma eficiente no Repositório, armazenando apenas os blocos (chunks) únicos e reduzindo drasticamente o espaço utilizado em Backups incrementais. |
| 🖥️ **BBS (Borg Backup Server)** | Plataforma Web (Backend em PHP, Banco de Dados MySQL) que gerencia múltiplos endpoints do BorgBackup de forma centralizada. | Adiciona ao BorgBackup uma Interface Gráfica (GUI), Agendamento de Tarefas, Monitoramento em Tempo Real, Restauração de Arquivos individuais e Controle de Acesso, eliminando a necessidade de configurar o Borg manualmente via linha de comando em cada servidor. |
| 🤖 **Agente (Agent)** | Componente leve instalado em cada máquina protegida (Linux, macOS ou Windows), responsável por se comunicar com o Painel do BBS. | Consulta (via **Polling HTTPS**) o Painel do BBS periodicamente em busca de novas tarefas de Backup, **sem a necessidade de abrir Portas de Entrada (Inbound)** no Firewall da máquina protegida. |
| 🔐 **Append-Only** | Modo de operação do Repositório Borg em que os Agentes possuem permissão apenas para **Adicionar** novos dados, nunca para **Apagar ou Sobrescrever** Backups já existentes. | Protege os Backups contra ataques de **Ransomware**: mesmo que o servidor de origem seja comprometido, o invasor não consegue apagar o histórico de Backups já armazenado no Repositório. |
| 📦 **Repositório (Repository)** | Estrutura de diretórios do Borg onde os dados deduplicados, comprimidos e criptografados ficam efetivamente armazenados. | Neste cenário, aponta diretamente para a partição dedicada de Backup (`/backup`) criada no procedimento anterior de **Particionamento**. |
| 🗓️ **Plano de Backup (Backup Plan)** | Configuração que define **Origem dos Dados**, **Repositório de Destino**, **Agendamento (Cron)** e **Política de Retenção** de um Backup. | Automatiza a rotina de Backup da partição de Dados (`/dados`, LVM), sem a necessidade de scripts manuais ou tarefas agendadas separadas. |
---

## 01_ Verificando os Pré-requisitos do Ambiente para o BorgBackupServer no Ubuntu Server
```bash
#verificando se a partição de Dados (LVM) está montada e disponível no Ubuntu Server
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /dados
```

Entendendo a saída do comando: __`df -h /dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Filesystem** | `/dev/mapper/vg_dados-lv_dados` | Sistema de arquivos armazenado no **Logical Volume `lv_dados`**, pertencente ao **Volume Group `vg_dados`**, gerenciado pelo **LVM (Logical Volume Manager)**. |
| 📦 **Capacidade Total (Size)** | `30 GiB` | Capacidade total disponível no sistema de arquivos após a expansão do Logical Volume. |
| 📂 **Espaço Utilizado (Used)** | `2,1 MiB` | Espaço atualmente ocupado por arquivos e estruturas do sistema de arquivos EXT4. |
| 💿 **Espaço Disponível (Avail)** | `28 GiB` | Espaço livre disponível para armazenamento de novos arquivos. |
| 📊 **Utilização (Use%)** | `1%` | Percentual do sistema de arquivos atualmente utilizado. |
| 📍 **Ponto de Montagem (Mounted on)** | `/dados` | Diretório onde o sistema de arquivos está montado e acessível aos usuários e aplicações. |
---

```bash
#verificando se a partição de Backup (Particionamento Tradicional) está montada e disponível no Ubuntu Server
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /backup
```

Entendendo a saída do comando: __`df -h /backup`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Filesystem** | `/dev/sdd1` | Primeira partição do disco `/dev/sdd`, utilizada como volume dedicado para armazenamento de backups. |
| 📦 **Capacidade Total (Size)** | `49 GiB` | Capacidade total disponível no sistema de arquivos da partição `/dev/sdd1`. |
| 📂 **Espaço Utilizado (Used)** | `2,1 MiB` | Espaço atualmente utilizado pelo sistema de arquivos EXT4 e seus metadados. |
| 💿 **Espaço Disponível (Avail)** | `47 GiB` | Espaço livre disponível para armazenamento de backups e outros arquivos. |
| 📊 **Utilização (Use%)** | `1%` | Percentual de utilização do sistema de arquivos. O volume está praticamente vazio. |
| 📍 **Ponto de Montagem (Mounted on)** | `/backup` | Diretório onde a partição `/dev/sdd1` está montada e disponível para uso pelo sistema e aplicações de backup. |
---

## 02_ Verificando os Requisitos de Sistema (Software Base) do BBS no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o instalador oficial do BBS (`bbs-install`) resolve automaticamente a maior parte das dependências abaixo. Esta etapa é apenas para **conferência prévia**, evitando surpresas durante a instalação.

| **Camada** | **Tecnologia Utilizada pelo BBS** | **Descrição** |
| :--------- | :--------------------------------- | :------------ |
| 🖥️ **Backend** | `PHP 8.1 (ou superior)` | Linguagem responsável pela lógica da Aplicação Web e pela comunicação com os Agentes. |
| 🗄️ **Banco de Dados** | `MySQL 8.0 Server` | Armazena metadados de Clientes, Planos de Backup, Histórico de Jobs e Usuários do Painel. |
| 🌐 **Servidor Web** | `Apache2 HTTP Server + SSL` | Serve a Interface Web do BBS, com certificado TLS emitido automaticamente pelo instalador. |
| ⏱️ **Agendador** | `Cron` | Dispara a fila de tarefas (Jobs) conforme os Planos de Backup configurados. |
| 🦫 **Motor de Backup** | `BorgBackup` | Instalado como dependência, é o software que efetivamente executa o Backup/Restore no Repositório. |
---

```bash
#Habilitando os repositórios Multiverso e Universo do Ubuntu Server (dependências para a instalação).
#opção do comando add-apt-repository: --enable-source (Enable the specified repository)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/jammy/man1/add-apt-repository.1.html
```
```bash
#Habilitando o repositório Multiverso (Recomendado para instalar as dependências) no Ubuntu Server
sudo add-apt-repository --enable-source multiverse
  Removing component(s) 'multiverse' from all repositories.
  Press [ENTER] to continue or Ctrl-c to cancel. <Enter>
```
```bash
#Habilitando o repositório Universo (Recomendado para instalar as dependências) no Ubuntu Server
sudo add-apt-repository --enable-source universe
  Removing component(s) 'multiverse' from all repositories.
  Press [ENTER] to continue or Ctrl-c to cancel. <Enter>
```
```bash
#atualizando as listas do Apt do sources.list no Ubuntu Server (garantindo pacotes atualizados)
#opção do comando apt: update (Resynchronize the package index files from their sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt update
```
```bash
#atualizando todos os software instalado no Ubuntu Server (garantindo versões atualizadas)
#opção do comando apt: upgrade (Install the newest versions of all packages currently installed
#on the system from the sources enumerated in /etc/apt/sources.list.)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt upgrade
  Continue? [Y/n] y <Enter>
```

## 03_ Instalando o BorgBackupServer (BBS) no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o instalador oficial é um único `Script Bash`, publicado pelo mantenedor do projeto no repositório oficial do GitHub. Ele instala e configura automaticamente: **pacotes de sistema, Apache2 Server, MySQL Server, Certificado SSL e o serviço de Cron**.

```bash
#efetuando o download do script oficial de instalação do BorgBackupServer no Ubuntu Server
#opção do comando curl: -s (silent mode), -O (Write output to a local file named like the remote file)
#mais informações acesse a documentação oficial em: https://curl.se/docs/manpage.html
curl -sO https://raw.githubusercontent.com/marcpope/borgbackupserver/main/bin/bbs-install
```
```bash
#executando o instalador do BBS informando o Hostname/FQDN configurado no procedimento de Settings no Ubuntu Server
#opções do script bbs-install: --hostname (Sets the server's Fully Qualified Domain Name (FQDN) 
#used by BorgBackupServer during installation.), --no-ssl (Disables HTTPS/SSL configuration, allowing 
#the installation to use HTTP only)
#OBSERVAÇÃO IMPORTANTE: ALTERAR O HOSTNAME PARA O FQDN DO SEU CENÁRIO, NESSE CENÁRIO NÃO SERÁ INSTALADO
#O CERTIFICADO DIGITAL COM A OPÇÃO: --no-ssl
sudo bash bbs-install --hostname nome_do_seu_servidor.seu.domínio --no-ssl
```
```bash
#confirmando a criação da Base de Dados do BBS no MySQL Server no Ubuntu Server
MySQL setup: BBS needs a database.
  Auto-generate a 'bbs' database user with random password? [Y/n] y <Enter>
```

Entendendo o comando: __`bbs-install --hostname nome_do_seu_servidor.seu.domínio --no-ssl`__<br>
| **Etapa Interna do Instalador** | **Descrição** |
| :------------------------------- | :------------ |
| 📦 **Instalação de Pacotes** | Instala automaticamente PHP, MySQL, Apache, Cron e o próprio BorgBackup via repositórios do Ubuntu. |
| 🗄️ **Configuração do Banco de Dados** | Cria o banco de dados MySQL, o usuário de aplicação e as tabelas iniciais utilizadas pelo Painel do BBS. |
| 🌐 **Configuração do Apache + SSL** | Cria o VirtualHost do Apache para o Hostname informado e emite um certificado SSL para o Painel Web. |
| ⏱️ **Configuração do Cron** | Registra a tarefa agendada responsável por processar a fila de Jobs (Backups, Restores, Prunes) do BBS. |
| ✅ **Finalização** | Exibe no terminal a URL de acesso ao Painel Web para a conclusão do Assistente de Configuração Inicial. |
---

> **OBSERVAÇÃO IMPORTANTE:** Após o término da instalação do BBS anotar as informações no final da tela de: **Database Credentials (save these):** - `Host`, `Database`, `User` e  principalmente `Password`que serão utilizados na etapa de configuração via **WebGUI do BBS**.

## 04_ Verificando os Serviços Instalados pelo BBS no Ubuntu Server
```bash
#verificando o status do serviço do Apache2 Server (Painel Web do BBS) no Ubuntu Server
#opções do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status apache2
```
```bash
#verificando o status do serviço do MySQL Server (Banco de Dados do BBS) no Ubuntu Server
#opções do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status mysql
```
```bash
#verificando o status do serviço do Cron (Agendador de Tarefas do BBS) no Ubuntu Server
#opções do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status cron
```

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção

```bash
#verificando a versão do Borg Backup instalado como dependência do BBS no Ubuntu Server
#opção do comando borg: --version (Print version and exit)
#mais informações acesse a documentação oficial em: https://borgbackup.readthedocs.io/
sudo borg --version
```

> **OBSERVAÇÃO IMPORTANTE:** no Ubuntu Server as Regras de Firewall utilizando o comando: __` iptables `__ ou: __` ufw `__ está desabilitado por padrão **(INACTIVE)**, caso você tenha habilitado algum recurso de Firewall é necessário fazer a liberação do *Fluxo de Entrada (INPUT), Porta (PORT) e Protocolo (PROTOCOL) TCP* do Serviço corresponde nas tabelas do firewall e testar a conexão.

```bash
#verificando as Portas TCP-80 (HTTP), TCP-443 (HTTPS) e TCP-3306 (MySQL) no Ubuntu Server
#opção do comando lsof: -n (network number), -P (port number), -i (list IP Address), -s (alone directs)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsof.8.html
sudo lsof -nP -iTCP:'80,443,3306' -sTCP:LISTEN
```

## 05_ Assistente de Configuração Inicial (Setup Wizard) do BBS no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** a partir desta etapa, a configuração ocorre pela **Interface Web** do `BBS`, acessada de um navegador na mesma rede do `Ubuntu Server`. Utilize o Endereço `IPv4 ou o FQDN` configurado no procedimento de Settings.
>
> **OBSERVAÇÃO IMPORTANTE:** por se tratar da porta de entrada de toda a estrutura de Backup do ambiente, a `Senha da Conta de Administrador do BBS` deve seguir uma Política de Senha Forte, e o recurso de **Autenticação de Dois Fatores (2FA)** deve ser habilitado assim que possível.

```bash
#Acessando o navegador para fazer as primeiras configurações do BBS
01) Abrir o navegador e acessar o Painel Web do BBS
    URL: https://srvvaamonde.pti.intra (ou https://SEU_ENDEREÇO_IPv4 ou https://SEU_ENDEREÇO_IPv6)
    #OBSERVAÇÃO: como o certificado SSL é autoassinado ou emitido localmente, o navegador
    #pode exibir um aviso de segurança, sendo necessário aceitar/prosseguir manualmente.
```
```bash
#Tela de Bem-Vindo e verificação do sistema BBS
02) Step 1 of 5 - Welcome
  Welcome
    System Requirements
    PHP >= 8.1                  8.5.4
    PDO MySQL extension         Installed
    Mbstring extensions         Installed
    OpenSSL extensions          Installed
    Config directory writable   Writable
<Begin Setup>
```
```bash
#Configuração do Banco de Dados do BBS
03) Step 2 of 5 - Database
  Database
    Database Host: localhost
    Database Name: bbs
    Database User: bbs
    Database Password: <COPIAR E COLOCAR A SENHA CRIPTOGRAFADA DO SCRIPT DE INSTALAÇÃO>
<Test Connections & Continue>
```
```bash
#Configuração do Usuários Administrador do BBS
04) Step 3 of 5 - Admin Account
  Admin Account
    Email: seu_usuário@seu_domínio.local
    Username: seu_usuário
    Password: sua_senha
    Confirm Password: repetir_sua_senha
<Continue>
```
```bash
#Configuração do Armazenamento do BBS
05) Step 4 of 5 - Storage & Server
  Storage & Server
    Storage: Default storage: /var/bbs/home
    Server Hostname / IP: seu_endereço_ipv4 ou nome_servidor
    (OFF) Enable SSL (HTTPS) - (Disable)
<Continue>
```
```bash
#Tela resumo da Instalação do BBS
06) Step 5 of 5 - Install
  Review & Install
    Database Host: localhost
    Database Name: bbs
    Database User: bbs
    Admin Username: admin
    Admin Email: seu_usuário@seu_domínio.local
    Storage Path: /var/bbs/home
    Server Host: seu_endereço_ipv4 ou nome_servidor
    SSH Helper: Installed
<Install>
```
```bash
#Finalização da Instalação do BBS
07) Setup Complete
<Go to Dashboard>
```

## 06_ Instalando e Registrando o Agente Local (Linux Agent Client) no Ubuntu Server

Entendendo a Arquitetura de Comunicação do Agente:<br>
| **Camada** | **Protocolo** | **Descrição** |
| :--------- | :------------ | :------------ |
| 🎛️ **Plano de Controle (Control Plane)** | `HTTPS` OU `HTTP` | O Agente consulta periodicamente (Polling) o Painel do BBS em busca de novas tarefas, progresso e status; **nenhuma Porta de Entrada precisa ser aberta no Cliente**. |
| 📦 **Plano de Dados (Data Plane)** | `SSH (borg serve)` | Quando uma tarefa é disparada, a transferência real dos dados do Backup ocorre via SSH, utilizando o modo **Append-Only** do BorgBackup no Repositório. |
---

> **OBSERVAÇÃO IMPORTANTE:** mesmo no `Cenário de Servidor Único` (Painel e Cliente na mesma VM), o BBS exige a instalação do **Agente**, pois toda a comunicação de **tarefas (Jobs)** entre o Painel e a execução real do `borg` acontece através dele, inclusive em modo Localhost.

```bash
#Acessando o Painel de Clientes do BBS
01) No Painel Web do BBS, acessar o menu:
    Clients (Clientes) <Add Client>
      Add New Client
        Client Name: seu_hostname
        Client Profile: Default - Every client starts here until it is given a profile of its own
        Assign to User : admin
      <Create Client>
```
```bash
#Copiando o comando de Instalação do Agente Linux do BBS no Ubuntu Server
#OBSERVAÇÃO IMPORTANTE: SUBSTITUIR A URL E O TOKEN PELOS VALORES GERADOS NO SEU PAINEL
02) Nas configurações do Cliente, acessar o menu:
    Install (Instalar)
      Install Agent (Linux / macOS) <Copy>
        curl -s http://seu_endereço_ipv4/get-agent | sudo bash -s --server http://seu_endereço_ipv4 --key SEU_TOKEN_DE_REGISTRO
```
```bash
#verificando o status do serviço do Agente do BBS no Ubuntu Server
#opções do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status bbs-agent
```
```bash
#analisando os Log's e mensagens de erro do serviço do Agente do BBS no Ubuntu Server
#opção do comando journalctl: u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u bbs-agent
```
```bash
#adicionando o usuário de serviço do Apache2 Server no grupo de Backup no Ubuntu Server
#opções do comando usermod: -a (append), -G (groups)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/usermod.8.html
sudo usermod -a -G backupadm www-data
```
```bash
#adicionando o usuário de serviço do Agente do BBS no grupo de Backup no Ubuntu Server
#opções do comando usermod: -a (append), -G (groups)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/usermod.8.html
sudo usermod -a -G backupadm bbs-seu_nome_de_servidor
```
```bash
#consultando os usuários nos grupos adicionados no Ubuntu Server
#opção do comando getent: group (show to enumerate the group database)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/getent.1.html
sudo getent group backupadm
sudp getent group www-data
```

## 07_ Criando o Armazenamento Local (Storage) do BBS no Ubuntu Server
```bash
#Configurando o Armazenamento Local do Diretório de Backup do BBS
01) No Painel Web do BBS, acessar o menu:
    Storage (Armazenamento) <Add Location>
      Label (Rótulo): repo-dados-on-premises
      Path (Caminho): /backup/repository/lv-dados
      Capacity (Capacidade): auto
      Default (Padrão): on
<Create>
```

## 08_ Criando o Modelo (Template) de Backup do BBS no Ubuntu Server
```bash
#Criando o Modelo de Backup do BBS
01) No Painel Web do BBS, acessar o menu:
    Management (Gerenciamento)
      Settings (Configurações)
        Templates (Modelos)
          Add Template (Adicionar Modelo)
            Name (Nome): backup-dados
            Description (Descrição): Modelo de Backup da Partição Dados
            Directories (Diretório): /dados
            Excludes (Exclusões): lost+found/, *.tmp, *.log
            Borg Options (Opções do Borg)
              (ON) Compression (Compressão)
              (ON) Exclude caches (Excluir arquivos em cache)
              (OFF) One file system (Um arquivo por sistema)
              (ON) No atime (Sem tempo de acesso)
              (OFF) Numeric IDs (Identificação numérica)
              (OFF) Skip xattrs (Ignorar xattrs = atributos estendidos)
              (OFF) Skip ACLs (Ignorar acls = lista de controle de acesso)
            Compression spec (Especificar a Compressão): lz4
            Custom options (Opções Customizadas): --compression lz4 --exclude-caches --noatime
<Add Template>
```

## 09_ Configurando o Repositório do BBS para a Partição de Backup no Ubuntu Server
```bash
#Acessando o Painel de Clientes do BBS
01) No Painel Web do BBS, acessar o menu:
    Clients (Clientes)
      Name: srvvaamonde (Servidor Ubuntu)
```
```bash
#Adicionando um Novo Repositório no Cliente do BBS
02) Repos (Repositório)
    <Add Repository>
```
```bash
#Configurando o Repositório de Backup do BBS
03) Repositories (Repositórios)
    Create New Repository (Criando um novo repositório)
      Description (Descrição): backup-dados
      Storage (Armazenamento): Local (this server)
      Location (Localização): repo-dados-onpremises (/backup/repository/lv-dados)
      Encryption (Criptografia): repokey-blake2 (Recommended)
      Repo Password (Senha do Repositório): SUA_SENHA_DO_REPOSITÓRIO (COPIAR E GUARDAR)
<Create Repo>
```

## 10_ Criando o Plano de Agendamento de Backup do BBS no Ubuntu Server
```bash
#Acessando o Painel de Clientes do BBS
01) No Painel Web do BBS, acessar o menu:
    Clients (Clientes)
      Name: srvvaamonde (Servidor Ubuntu)
```
```bash
#Criando o Plano de Agendamento de Backup do BBS
02) Plans (Planos)
    <Add Backup Plan>
```
```bash
#Configurando o Plano de Agendamento de Backup do BBS
02) Backup Schedules
    Create New Backup Plan (Criando um novo plano de backup)
      Plan Name (Nome do Plano): backup-diario-dados
      Frequency (Frequência): Every Day (Diariamente)
      Run Hours (Hora para Rodar): PM 1 (Pós Meio Dia às 13hs)
        @ 0 min past the hour (Minutos depois da hora)
      Repository (Repositório): backup-dados (#1)
      Template (Modelo): backup-dados - Modelo de Backup da Partição Dados
      Backup Directories (Diretório de Backup): /dados
      Exclude Patterns (Padrões de Exclusão): lost+found/, *.tmp, *.log
      Options (Opções)
        (ON) Compression (Compressão)
        (ON) Exclude caches (Excluir arquivos em cache)
        (OFF) One file system (Um arquivo por sistema)
        (ON) No atime (Sem tempo de acesso)
        (OFF) Numeric IDs (Identificação numérica)
        (OFF) Skip xattrs (Ignorar xattrs = atributos estendidos)
        (OFF) Skip ACLs (Ignorar acls = lista de controle de acesso)
        (OFF) Back up from a snapshot (Restaurar a partir de um snapshot)
      Priority (Prioridade): Normal
      Compression spec (Especificar a Compressão): lz4
      Custom options (Opções Customizadas): --compression lz4 --exclude-caches --noatime
      Prune Retention (Tempo de Retenção): Default
        Minutes (Minutos): 0
        Hours (Horas): 0
        Days (Dias): 7
        Weeks (Semanas): 4
        Months (Meses): 6
        Years (Anos): 0
<Create Backup Plan>
```

## 11_ Criando a Estrutura de Informações na Partição Dados do Ubuntu Server
```bash
#baixando o script para a criação dos diretórios e arquivos na partição Dados do Ubuntu Server
#opção do comando curl: -s (silent mode), -O (Write output to a local file named like the remote file)
#mais informações acesse a documentação oficial em: https://curl.se/docs/manpage.html
curl -sO https://raw.githubusercontent.com/vaamonde/ubuntu-2604/refs/heads/main/scripts/01-criar-estrutura-empresa.sh
```
```bash
#baixando o script para modificar os diretórios e arquivos na partição Dados do Ubuntu Server
#opção do comando curl: -s (silent mode), -O (Write output to a local file named like the remote file)
#mais informações acesse a documentação oficial em: https://curl.se/docs/manpage.html
curl -sO https://raw.githubusercontent.com/vaamonde/ubuntu-2604/refs/heads/main/scripts/02-simular-alteracoes.sh
```
```bash
#executando o script para a criação dos diretórios e arquivos na partição Dados do Ubuntu Server
sudo bash 01-criar-estrutura-empresa.sh
```
```bash
#verificando a árvore de diretórios da partição Dados do Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/tree
sudo tree /dados
```

## 12_ Executando e Monitorando o Primeiro Backup do BBS no Ubuntu Server
```bash
#Acessando o Painel de Clientes do BBS
01) No Painel Web do BBS, acessar o menu:
    Clients (Clientes)
      Name: srvvaamonde (Servidor Ubuntu)
```
```bash
#Acessando os Planos de Agendamento de Backup do BBS
02) Plans (Planos)
    Backup Schedules (Agendamento de Backup)
      backup-diario-ados
        Clicar nos 3 (três) pontinhos no canto superior
        Selecionar a opção: Run Now (Rodar Agora)
```
```bash
#Verificando os Trabalhos de Backup e Filas do BBS
03) No Painel Web do BBS, acessar o menu:
    Queue (Fila)
      Acompanhar em Tempo Real:
        Status (Status): Running (Em Execução)
        In Progress (Em progresso): Barra de Progresso + Taxa de Transferência
        Recently Completed (Completos recentemente): Streaming de Log em Tempo Real
```
```bash
#Verificando os Logs de Backup do BBS
04) No Painel Web do BBS, acessar o menu:
    Log (Logs)
      Analisar os logs dos backup:
```
```bash
#Verificando a Execução do Plano de Backup do BBS
05) No Painel Web do BBS, acessar o menu:
    Clients (Clientes)
      Name: srvvaamonde (Servidor Ubuntu)
        Repos (Repositório)
          Clicar em: backup-dados
            Recovery Points (1) (Pontos de Recuperação)
              Clicar em: backup-diario-dados
```
```bash
#executando o script para modificar os diretórios e arquivos na partição Dados do Ubuntu Server
#opção do script 02-simular-alteracoes.sh: incremental (simula uma alteração no diretório de incremento)
#opção do script 02-simular-alteracoes.sh: diferencial (simula uma alteração no diretório de diferença)
#opção do script 02-simular-alteracoes.sh: completo (simula uma alteração no diretório completa)
sudo bash 02-simular-alteracoes.sh incremental
sudo bash 02-simular-alteracoes.sh diferencial
```
```bash
#verificando a árvore de diretórios da partição Dados do Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/tree
sudo tree /dados
```
```bash
#verificando a árvore de diretórios da partição Backup do Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/tree
sudo tree /backup
```

## 13_ Testando a Restauração (Restore) de Arquivos do BBS no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** um Backup só tem valor real depois de **testado**. Nunca considere uma rotina de Backup `confiável` sem antes validar o processo completo de Restauração (Restore).

```bash
#Acessando o Painel de Repositórios do BBS
01) No Painel Web do BBS, acessar o menu:
    Clients (Clientes)
      Name: srvvaamonde (Servidor Ubuntu)
        Restore (Restaurar)
```
```bash
#Localizando o Arquivo de Backup para Restaurar do BBS
02) No Painel Web do BBS, acessar as opções
    Archive (Arquivos)
      backup-dados
        Data e Hora - backup-diario-dados
          Browse Archive (Navegação dos Arquivos)
            Selecione os arquivos para serem restaurados
```
```bash
#Escolhendo o Método de Restauração dos Dados do BBS
03) Escolher o método de Restauração:
    Destination optional (Destino opcional): /backup/restore
    <Restore to client> (Usando o caminho opcional melhor para testar)
    <Download .tar.gz>  (Melhor para testar o backup)
<Restaurar>
```

## 14_ Localização dos Arquivos de Configuração e Logs do BBS no Ubuntu Server

| **📂 Caminho** | **📝 Descrição** |
| :------------- | :--------------- |
| **`/backup/repository/lv-dados`** | Repositório Borg propriamente dito, contendo os dados deduplicados, comprimidos e criptografados do Backup da partição `/dados`. |
| **`/etc/apache2/sites-available/`** | Diretório de configuração do VirtualHost do Apache criado pelo instalador do BBS para o Painel Web. |
| **`/etc/cron.d/`** ou **crontab do usuário do BBS** | Local onde o instalador registra a tarefa agendada responsável por processar a fila de Jobs (Backups, Restores, Prunes). |
| **`/var/log/apache2/`** | Logs de acesso e erro do Painel Web (Apache), úteis para diagnosticar problemas de acesso via navegador. |
| **`/var/log/mysql/`** | Logs do Banco de Dados MySQL utilizado pelo BBS para armazenar Clientes, Planos de Backup e Histórico de Jobs. |
| **`/var/www/bbs`** | Localização dos arquivos de configuração, binários e site principal do Borg |
| **`/etc/bbs`** | Localização do diretório e arquivos de configuração do Borg Agent |
| **Painel Web → Fila e Jobs (Queue and Jobs)** | Histórico detalhado e Logs de cada execução de Backup/Restore, disponível diretamente na Interface Web do BBS. |
---

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO BORG BACKUP SERVER A SEGUINTE FRASE: *Configuração do Borg Backup Server On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #bbs #bbsubuntu #bbsuntuserver #bbsuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/14-borgbackup.png

---