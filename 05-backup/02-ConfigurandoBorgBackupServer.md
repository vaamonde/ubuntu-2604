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
Data de criação: 29/07/2026<br>
Data de atualização: 03/08/2026<br>
Versão: 0.03<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS<br>
Testado e homologado no Oracle VirtualBOX 7.x

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
BorgBackup (Software Base): https://www.borgbackup.org/<br>
BorgBackup Server / BBS (Projeto): https://github.com/marcpope/borgbackupserver<br>
BorgBackup Server / BBS (Documentação Oficial - Wiki): https://github.com/marcpope/borgbackupserver/wiki<br>
BorgBackup Server / BBS (Site Oficial): https://www.borgbackupserver.com/<br>

Conteúdo estudado nessa configuração:<br>

[![BorgBackupServer Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "BorgBackupServer Ubuntu Server")

Link da vídeo aula: 

> **OBSERVAÇÃO IMPORTANTE:** este procedimento assume o **Cenário de Servidor Único (All-in-One)**, ou seja, o **Painel Web do BBS** (Backend PHP + Banco de Dados MySQL) e o **Agente Local (Linux Agent)** serão instalados na **MESMA** Máquina Virtual `UbuntuOnPremise`, junto com a partição de Dados (LVM) e a partição de Backup (Particionamento Tradicional) criadas nos procedimentos anteriores. Em um cenário de Produção On-Premises real, o recomendado é instalar o Painel do BBS em um servidor dedicado, separado dos servidores que ele protege.

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

Entendendo a saída do arquivo: __`sudo df -h /dados`__<br>
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
#verificando se a partição de Backup (Particionamento Tradicional) está montada e disponível
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /backup
```

Entendendo a saída do arquivo: __`sudo df -h /dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💾 **Comando** | `sudo df -h /backup` | Exibe informações sobre a utilização do sistema de arquivos montado no diretório `/backup`, apresentando os valores em formato legível (*Human Readable*). |
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
| 🖥️ **Backend** | PHP 8.1 (ou superior) | Linguagem responsável pela lógica da Aplicação Web e pela comunicação com os Agentes. |
| 🗄️ **Banco de Dados** | MySQL 8.0 | Armazena metadados de Clientes, Planos de Backup, Histórico de Jobs e Usuários do Painel. |
| 🌐 **Servidor Web** | Apache HTTP Server + SSL | Serve a Interface Web do BBS, com certificado TLS emitido automaticamente pelo instalador. |
| ⏱️ **Agendador** | Cron | Dispara a fila de tarefas (Jobs) conforme os Planos de Backup configurados. |
| 🦫 **Motor de Backup** | BorgBackup | Instalado como dependência, é o software que efetivamente executa o Backup/Restore no Repositório. |
---

```bash
#Habilitando os repositórios Multiverso e Universo do Ubuntu Server (dependências para a instalação).
#opção do comando add-apt-repository: --remove (Remove the specified repository)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/jammy/man1/add-apt-repository.1.html
#Habilitando o repositório Multiverso
sudo add-apt-repository --enable-source multiverse
  Removing component(s) 'multiverse' from all repositories.
  Press [ENTER] to continue or Ctrl-c to cancel.
#Habilitando o repositório Universo
sudo add-apt-repository --enable-source universe
  Removing component(s) 'multiverse' from all repositories.
  Press [ENTER] to continue or Ctrl-c to cancel.

#atualizando as listas do Apt do sources.list no Ubuntu Server (garantindo pacotes atualizados)
#opção do comando apt: update (Resynchronize the package index files from their sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt update

#atualizando todos os software instalado no Ubuntu Server (garantindo versões atualizadas)
#opção do comando apt: upgrade (Install the newest versions of all packages currently installed
#on the system from the sources enumerated in /etc/apt/sources.list.)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt upgrade
  Continue? [Y/n] y <Enter>
```

## 03_ Instalando o BorgBackupServer (BBS) no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o instalador oficial é um único Script Bash, publicado pelo mantenedor do projeto no repositório oficial do GitHub. Ele instala e configura automaticamente: pacotes de sistema, Apache, MySQL, Certificado SSL e o serviço de Cron.

```bash
#efetuando o download do script oficial de instalação do BorgBackupServer no Ubuntu Server
#opção do comando curl: -s (silent mode), -O (Write output to a local file named like the remote file)
#mais informações acesse a documentação oficial em: https://curl.se/docs/manpage.html
curl -sO https://raw.githubusercontent.com/marcpope/borgbackupserver/main/bin/bbs-install

#executando o instalador do BBS informando o Hostname/FQDN configurado no procedimento de Settings
#opções do script bbs-install: --hostname (Sets the server's Fully Qualified Domain Name (FQDN) 
#used by BorgBackupServer during installation.), --no-ssl (Disables HTTPS/SSL configuration, allowing 
#the installation to use HTTP only)
#OBSERVAÇÃO IMPORTANTE: ALTERAR O HOSTNAME PARA O FQDN DO SEU CENÁRIO
sudo bash bbs-install --hostname srvvaamonde.pti.intra --no-ssl

MySQL setup: BBS needs a database.
  Auto-generate a 'bbs' database user with random password? [Y/n] y <Enter>
```

Entendendo o comando: __`sudo bash bbs-install --hostname srvvaamonde.pti.intra --no-ssl`__<br>
| **Etapa Interna do Instalador** | **Descrição** |
| :------------------------------- | :------------ |
| 📦 **Instalação de Pacotes** | Instala automaticamente PHP, MySQL, Apache, Cron e o próprio BorgBackup via repositórios do Ubuntu. |
| 🗄️ **Configuração do Banco de Dados** | Cria o banco de dados MySQL, o usuário de aplicação e as tabelas iniciais utilizadas pelo Painel do BBS. |
| 🌐 **Configuração do Apache + SSL** | Cria o VirtualHost do Apache para o Hostname informado e emite um certificado SSL para o Painel Web. |
| ⏱️ **Configuração do Cron** | Registra a tarefa agendada responsável por processar a fila de Jobs (Backups, Restores, Prunes) do BBS. |
| ✅ **Finalização** | Exibe no terminal a URL de acesso ao Painel Web para a conclusão do Assistente de Configuração Inicial. |
---

## 04_ Verificando os Serviços Instalados pelo BBS no Ubuntu Server

```bash
#verificando o status do serviço do Apache (Painel Web do BBS) no Ubuntu Server
#opções do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status apache2

#verificando o status do serviço do MySQL (Banco de Dados do BBS) no Ubuntu Server
#opções do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status mysql

#verificando o status do serviço do Cron (Agendador de Tarefas do BBS) no Ubuntu Server
#opções do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status cron

#verificando a versão do BorgBackup instalada como dependência do BBS no Ubuntu Server
#opção do comando borg: --version (Print version and exit)
#mais informações acesse a documentação oficial em: https://borgbackup.readthedocs.io/
sudo borg --version

#verificando se as Portas 80/TCP (HTTP), 443/TCP (HTTPS) e 3306 (MySQL) do Painel Web está em escuta no Ubuntu Server
#opção do comando lsof: -n (network number), -P (port number), -i (list IP Address), -s (alone directs)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsof.8.html
sudo lsof -nP -iTCP:'80,443,3306' -sTCP:LISTEN
```

## 05_ Assistente de Configuração Inicial (Setup Wizard) do BBS no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** a partir desta etapa, a configuração ocorre pela **Interface Web** do BBS, acessada de um navegador na mesma rede do Ubuntu Server. Utilize o Endereço IPv4 ou o FQDN configurado no procedimento de Settings.

```bash
01) Abrir o navegador e acessar o Painel Web do BBS
    URL: https://srvvaamonde.pti.intra (ou https://SEU_ENDEREÇO_IPv4 ou https://SEU_ENDEREÇO_IPv6)
    #OBSERVAÇÃO: como o certificado SSL é autoassinado ou emitido localmente, o navegador
    #pode exibir um aviso de segurança, sendo necessário aceitar/prosseguir manualmente.

02) Step 1 of 5 - Welcome
  Welcome
    System Requirements
    PHP >= 8.1                  8.5.4
    PDO MySQL extension         Installed
    Mbstring extensions         Installed
    OpenSSL extensions          Installed
    Config directory writable   Writable
<Begin Setup>

03) Step 2 of 5 - Database
  Database
    Database Host: localhost
    Database Name: bbs
    Database User: bbs
    Database Password: <COPIAR E COLOCAR A SENHA CRIPTOGRAFA DO SCRIPT DE INSTALAÇÃO>
<Test Connections & Continue>

04) Step 3 of 5 - Admin Account
  Admin Account
    Email: seu_usuário@seu_domínio.local
    Username: seu_usuário
    Password: sua_senha
    Confirm Password: repetir_sua_senha
<Continue>

05) Step 4 of 5 - Storage & Server
  Storage & Server
    Storage: Default storage: /var/bbs/home
    Server Hostname / IP: seu_endereço_ipv4 ou nome_servidor
    (OFF) Enable SSL (HTTPS) - Disable
<Continue>

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

07) Setup Complete
<Go to Dashboard>
```

> **OBSERVAÇÃO IMPORTANTE:** por se tratar da porta de entrada de toda a estrutura de Backup do ambiente, a Senha da Conta de Administrador do BBS deve seguir uma Política de Senha Forte, e o recurso de **Autenticação de Dois Fatores (2FA)** (abordado na seção #11 deste procedimento) deve ser habilitado assim que possível.

## 06_ Instalando e Registrando o Agente Local (Linux Agent Client) no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** mesmo no Cenário de Servidor Único (Painel e Cliente na mesma VM), o BBS exige a instalação do **Agente**, pois toda a comunicação de tarefas (Jobs) entre o Painel e a execução real do `borg` acontece através dele, inclusive em modo Localhost.

```bash
01) No Painel Web do BBS, acessar o menu:
    Clients (Managing Clients) <Add Client>
      Client Name: seu_hostname
      Assign User : admin
    <Create Client>
      #o Painel exibe um comando único de instalação, já contendo o Token de Registro
      #do Cliente, semelhante ao modelo abaixo:
```
```bash
#efetuando o download e a instalação do Agente Linux do BBS no Ubuntu Server
#OBSERVAÇÃO IMPORTANTE: SUBSTITUIR A URL E O TOKEN PELOS VALORES GERADOS NO SEU PAINEL
curl -s http://seu_endereço_ipv4/get-agent | sudo bash -s -- --server http://seu_endereço_ipv4 --key SEU_TOKEN_DE_REGISTRO

#verificando o status do serviço do Agente do BBS no Ubuntu Server
#opções do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status bbs-agent

#analisando os Log's e mensagens de erro do serviço do Agente do BBS
#opção do comando journalctl: u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u bbs-agent
```

Entendendo a Arquitetura de Comunicação do Agente:<br>
| **Camada** | **Protocolo** | **Descrição** |
| :--------- | :------------ | :------------ |
| 🎛️ **Plano de Controle (Control Plane)** | HTTPS | O Agente consulta periodicamente (Polling) o Painel do BBS em busca de novas tarefas, progresso e status; **nenhuma Porta de Entrada precisa ser aberta no Cliente**. |
| 📦 **Plano de Dados (Data Plane)** | SSH (`borg serve`) | Quando uma tarefa é disparada, a transferência real dos dados do Backup ocorre via SSH, utilizando o modo **Append-Only** do BorgBackup no Repositório. |
---

## 07_ Criando o Armazenamento Local (Storage) do BBS no Ubuntu Server

```bash
01) No Painel Web do BBS, acessar o menu:
    Storage (Armazenamento) <Add Location>
      Label: repo-dados-onpremise
      Patch: /backup/repository/lv-dados
      (ON) Default (Enable)
<Create>
```

## 08_ Criando o Modelo (Template) de Backup do BBS no Ubuntu Server

```bash
01) No Painel Web do BBS, acessar o menu:
    Settings (Configurações)
      Templates (Modelos)
        Add Template
          Name: backup-dados
          Description: Model de Backup da Partição Dados
          Directories: /dados
          Excludes: lost+found/, *.tmp, *.log
          Borg Options
            (ON) Compression
            (ON) Exclude caches
            (OFF) One file system
            (ON) No atime
            (OFF) Numeric IDs
            (OFF) Skip xattrs
            (OFF) SkipACLs
          Compression spec: lz4
          Custom options: --compression lz4 --exclude-caches --noatime
<Add Template>
```

## 09_ Criando o Repositório do BBS apontando para a Partição de Backup no Ubuntu Server

```bash
01) No Painel Web do BBS, acessar o menu:
    Clients (Clientes)
      Name: srvvaamonde

02) Repos
    <Add Repository>


03) Repositories
    Create New Repository
      Description: backup-dados
      Storage: Local (this server)
      Location: repo-dados-onpremise (/backup/repository/lv-dados)
      Encryption: repokey-blake2 (Recommended)
      Repo Password: SUA_SENHA_DO_REPOSITÓRIO (COPIAR E GUARDAR)
<Create Repo>
```

# 10_ Criando o Plano de Backup dp BBS no Ubuntu Server

```bash
01) No Painel Web do BBS, acessar o menu:
    Clients (Clientes)
      Name: srvvaamonde

02) Plans
    <Add Add Backup Plan>


02) Backup Schedules
    Create New Backup Plan
      Plan Name: backup-diario-dados
      Frequency: Every Day (Diariamente)
      Run Hours: PM 1
        @ 0 min past the hour
      Repository: backup-dados (#!)
      Template: backup-dados - Modelo de Backup da Partição Dados
      Prune Retention: Default
<Create Backup Plan>
```

## 11_ Executando e Monitorando o Primeiro Backup no BBS

```bash
01) No Painel Web do BBS, acessar o Plano de Backup criado: backup-lv-dados
<Executar Agora (Run Now)>

02) Acessar o menu: Fila e Jobs (Queue and Jobs)
    Acompanhar em Tempo Real:
      Status: Em Execução (Running)
      Progresso: Barra de Progresso + Taxa de Transferência
      Log: Streaming de Log em Tempo Real
```

```bash
#acompanhando o processo do Borg em execução diretamente no Ubuntu Server (validação cruzada)
#opção do comando ps: aux (mostra todos os processos em execução no sistema)
#opção do comando grep: -i (ignore-case)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/ps.1.html
sudo ps aux | grep -i borg

#verificando o consumo de I/O do disco durante o Backup no Ubuntu Server
#opção do comando iostat: -x (extended statistics), 2 (intervalo de atualização em segundos)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/iostat.1.html
sudo iostat -x 2
```

```bash
01) Após a conclusão, verificar no Painel Web do BBS:
    Status do Job: Concluído (Completed)
    Arquivo (Archive) gerado: srvvaamonde-2026-07-29T02:00:00
    Tamanho Original x Tamanho Deduplicado (economia de espaço)
```

## 12_ Testando a Restauração (Restore) de Arquivos no BBS

> **OBSERVAÇÃO IMPORTANTE:** um Backup só tem valor real depois de **testado**. Nunca considere uma rotina de Backup confiável sem antes validar o processo completo de Restauração (Restore).

```bash
01) No Painel Web do BBS, acessar o menu:
    Repositórios (Repositories) <repo-dados-onpremise>
      Selecionar o Arquivo (Archive): srvvaamonde-2026-07-29T02:00:00
      <Navegar pelos Arquivos (Browse Files)>

02) Localizar o arquivo/diretório de teste dentro de: /dados
    Selecionar o(s) arquivo(s) desejado(s)

03) Escolher o método de Restauração:
    ( ) Restaurar Diretamente no Cliente (caminho original ou alternativo)
    (X) Fazer Download como .tar.gz (recomendado para teste inicial)
<Restaurar>
```

```bash
#validando a integridade do arquivo restaurado no Ubuntu Server (checksum)
#opção do comando sha256sum: (calcula o hash SHA-256 do arquivo)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/sha256sum.1.html
sha256sum /dados/arquivo_de_teste.txt
```

## 13_ Habilitando Notificações e Autenticação de Dois Fatores (2FA) no BBS

```bash
01) No Painel Web do BBS, acessar o menu:
    Configurações (Settings) <Notificações (Notifications)>
      Canal: E-mail (SMTP) ou Webhook
      Eventos: Falha de Backup, Sucesso de Backup, Repositório quase cheio
<Salvar>

02) Acessar o menu:
    Configurações (Settings) <Usuários (User Management)> <Seu Usuário Admin>
      <Habilitar Autenticação de Dois Fatores (2FA)>
        Escanear o QRCode com um Aplicativo Autenticador (TOTP)
        Confirmar o Código de 6 dígitos gerado
<Ativar 2FA>
```

> **OBSERVAÇÃO IMPORTANTE:** habilitar **Notificações de Falha de Backup** é essencial: um Backup que falha silenciosamente, sem ninguém perceber, é tão perigoso quanto não ter Backup nenhum. O 2FA no Painel Administrativo também será revisitado com mais detalhes no procedimento de **Hardening PAM/2FA** (`13_Hardening OpenSSH + Certificado + 2FA` do Workflow).

## 14_ Localização dos Arquivos de Configuração e Logs do BBS no Ubuntu Server

| **📂 Caminho** | **📝 Descrição** |
| :------------- | :--------------- |
| **`/backup/repository/lv-dados`** | Repositório Borg propriamente dito, contendo os dados deduplicados, comprimidos e criptografados do Backup da partição `/dados`. |
| **`/etc/apache2/sites-available/`** | Diretório de configuração do VirtualHost do Apache criado pelo instalador do BBS para o Painel Web. |
| **`/etc/cron.d/`** ou **crontab do usuário do BBS** | Local onde o instalador registra a tarefa agendada responsável por processar a fila de Jobs (Backups, Restores, Prunes). |
| **`/var/log/apache2/`** | Logs de acesso e erro do Painel Web (Apache), úteis para diagnosticar problemas de acesso via navegador. |
| **`/var/log/mysql/`** | Logs do Banco de Dados MySQL utilizado pelo BBS para armazenar Clientes, Planos de Backup e Histórico de Jobs. |
| **Painel Web → Fila e Jobs (Queue and Jobs)** | Histórico detalhado e Logs de cada execução de Backup/Restore, disponível diretamente na Interface Web do BBS. |
---

```bash
#analisando os Log's do Kernel referente à partição de Backup durante a execução do Borg
#opção do comando journalctl: k (kernel messages, equivalente ao comando dmesg)
#opção do comando grep: -i (Ignore case distinctions in patterns and input data)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/grep.1.html
sudo journalctl -k | grep -i sdd
```