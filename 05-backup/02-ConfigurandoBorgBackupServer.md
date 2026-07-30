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
Data de atualização: 29/07/2026<br>
Versão: 0.01<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS<br>
Testado e homologado no Oracle VirtualBOX 7.x

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
BorgBackup (Software Base): https://www.borgbackup.org/<br>
BorgBackup Server / BBS (Projeto): https://github.com/marcpope/borgbackupserver<br>
BorgBackup Server / BBS (Documentação Oficial - Wiki): https://github.com/marcpope/borgbackupserver/wiki<br>
BorgBackup Server / BBS (Site Oficial): https://www.borgbackupserver.com/<br>
Relax-and-Recover: https://relax-and-recover.org/

Conteúdo estudado nessa configuração:<br>
#01_ Verificando os Pré-requisitos do Ambiente para o BorgBackupServer<br>
#02_ Verificando os Requisitos de Sistema (Software Base) do BBS no Ubuntu Server<br>
#03_ Instalando o BorgBackupServer (BBS) no Ubuntu Server<br>
#04_ Verificando os Serviços Instalados pelo BBS no Ubuntu Server<br>
#05_ Assistente de Configuração Inicial (Setup Wizard) do BBS<br>
#06_ Instalando e Registrando o Agente Local (Linux Agent) no Ubuntu Server<br>
#07_ Criando o Repositório Borg apontando para a Partição de Backup no BBS<br>
#08_ Criando o Plano de Backup (Backup Plan) da Partição de Dados LVM<br>
#09_ Executando e Monitorando o Primeiro Backup no BBS<br>
#10_ Testando a Restauração (Restore) de Arquivos no BBS<br>
#11_ Habilitando Notificações e Autenticação de Dois Fatores (2FA) no BBS<br>
#12_ Localização dos Arquivos de Configuração e Logs do BBS no Ubuntu Server<br>

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

## 01_ Verificando os Pré-requisitos do Ambiente para o BorgBackupServer

> **OBSERVAÇÃO IMPORTANTE:** este procedimento é a **continuação direta** dos capítulos anteriores do Workflow. Antes de prosseguir, confirme que os itens abaixo já estão configurados no Ubuntu Server.

```bash
#verificando se a partição de Dados (LVM) está montada e disponível no Ubuntu Server
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /dados

#verificando se a partição de Backup (Particionamento Tradicional) está montada e disponível
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /backup

#verificando a resolução de nome (Hostname/FQDN) configurada no procedimento de Settings
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man5/hostname.5.html
sudo hostname
sudo hostname -A
```

Entendendo os Pré-requisitos deste procedimento:<br>
| **Item** | **Origem (Procedimento Anterior)** | **Descrição** |
| :------- | :---------------------------------- | :------------ |
| 📂 **`/dados`** | `04-harddisk/03-ConfigurandoLVM.md` | Volume Lógico (LVM) sobre o Array **RAID-1**, contendo os dados de produção que serão protegidos pelo Backup. |
| 💾 **`/backup`** | `04-harddisk/04-ConfigurandoParticionamento.md` | Partição dedicada (Particionamento Tradicional, EXT4), destino do Repositório Borg, com o subdiretório `/backup/repository/lv-dados` já preparado. |
| 🌐 **FQDN** | `03-settings/02-ConfiguracaoHostnameHosts.md` | Nome de domínio totalmente qualificado do servidor, necessário para a emissão do certificado **SSL/TLS** durante a instalação do BBS. |
| 🔥 **Firewall/UFW** | `05-security` *(procedimento de Hardening, ainda a ser aplicado)* | Caso o UFW já esteja habilitado, é necessário liberar as portas **80/TCP** e **443/TCP** (Painel Web) antes da instalação. |
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
#atualizando as listas do Apt do sources.list no Ubuntu Server (garantindo pacotes atualizados)
#opção do comando apt: update (Resynchronize the package index files from their sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt update

#verificando o espaço livre disponível na partição raiz antes da instalação do BBS
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /
```

## 03_ Instalando o BorgBackupServer (BBS) no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o instalador oficial é um único Script Bash, publicado pelo mantenedor do projeto no repositório oficial do GitHub. Ele instala e configura automaticamente: pacotes de sistema, Apache, MySQL, Certificado SSL e o serviço de Cron.

```bash
#efetuando o download do script oficial de instalação do BorgBackupServer no Ubuntu Server
#opção do comando curl: -s (silent mode), -O (Write output to a local file named like the remote file)
#mais informações acesse a documentação oficial em: https://curl.se/docs/manpage.html
curl -sO https://raw.githubusercontent.com/marcpope/borgbackupserver/main/bin/bbs-install

#verificando o conteúdo do script antes de executar (boa prática de segurança)
#opção do comando less: (visualizador de texto com paginação)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/less.1.html
less bbs-install

#executando o instalador do BBS informando o Hostname/FQDN configurado no procedimento de Settings
#OBSERVAÇÃO IMPORTANTE: ALTERAR O HOSTNAME PARA O FQDN DO SEU CENÁRIO
sudo bash bbs-install --hostname srvvaamonde.pti.intra
```

Entendendo o comando: __`sudo bash bbs-install --hostname srvvaamonde.pti.intra`__<br>
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

#verificando a versão do BorgBackup instalada como dependência do BBS
#opção do comando borg: --version (Print version and exit)
#mais informações acesse a documentação oficial em: https://borgbackup.readthedocs.io/
sudo borg --version

#verificando se a Porta 443/TCP (HTTPS) do Painel Web está em escuta no Ubuntu Server
#opção do comando ss: -tuln (tcp, udp, listening, numeric)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/ss.8.html
sudo ss -tuln | grep -i '443\|80'
```

## 05_ Assistente de Configuração Inicial (Setup Wizard) do BBS

> **OBSERVAÇÃO IMPORTANTE:** a partir desta etapa, a configuração ocorre pela **Interface Web** do BBS, acessada de um navegador na mesma rede do Ubuntu Server. Utilize o Endereço IPv4 ou o FQDN configurado no procedimento de Settings.

```bash
01) Abrir o navegador e acessar o Painel Web do BBS
    URL: https://srvvaamonde.pti.intra (ou https://SEU_ENDEREÇO_IPv4)
    #OBSERVAÇÃO: como o certificado SSL é autoassinado ou emitido localmente, o navegador
    #pode exibir um aviso de segurança, sendo necessário aceitar/prosseguir manualmente.

02) Assistente de Configuração Inicial (Setup Wizard)
    Criar Conta de Administrador
      Nome: Seu Nome Completo
      E-mail: seu_email@seu.domínio
      Usuário: admin
      Senha: sua_senha_forte
      Confirmar Senha: sua_senha_forte
    <Concluir Configuração>

03) Login no Painel do BBS
    Usuário: admin
    Senha: sua_senha_forte
<Entrar>
```

> **OBSERVAÇÃO IMPORTANTE:** por se tratar da porta de entrada de toda a estrutura de Backup do ambiente, a Senha da Conta de Administrador do BBS deve seguir uma Política de Senha Forte, e o recurso de **Autenticação de Dois Fatores (2FA)** (abordado na seção #11 deste procedimento) deve ser habilitado assim que possível.

## 06_ Instalando e Registrando o Agente Local (Linux Agent) no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** mesmo no Cenário de Servidor Único (Painel e Cliente na mesma VM), o BBS exige a instalação do **Agente**, pois toda a comunicação de tarefas (Jobs) entre o Painel e a execução real do `borg` acontece através dele, inclusive em modo Localhost.

```bash
01) No Painel Web do BBS, acessar o menu:
    Clientes (Managing Clients) <Adicionar Cliente>
      Nome do Cliente: srvvaamonde
      Sistema Operacional: Linux
    <Gerar Comando de Instalação do Agente>
      #o Painel exibe um comando único de instalação, já contendo o Token de Registro
      #do Cliente, semelhante ao modelo abaixo:
```
```bash
#efetuando o download e a instalação do Agente Linux do BBS no Ubuntu Server
#OBSERVAÇÃO IMPORTANTE: SUBSTITUIR A URL E O TOKEN PELOS VALORES GERADOS NO SEU PAINEL
curl -sO https://srvvaamonde.pti.intra/agent/bbs-agent-install
sudo bash bbs-agent-install --server https://srvvaamonde.pti.intra --token SEU_TOKEN_DE_REGISTRO

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

## 07_ Criando o Repositório Borg apontando para a Partição de Backup no BBS

```bash
01) No Painel Web do BBS, acessar o menu:
    Repositórios (Repositories) <Adicionar Repositório>
      Nome do Repositório: repo-dados-onpremise
      Tipo de Armazenamento: Local (Storage Setup)
      Caminho do Repositório: /backup/repository/lv-dados
      Modo de Criptografia: Repokey-Blake2 (recomendado)
      Senha de Criptografia: sua_senha_forte_do_repositorio
<Criar Repositório>

02) Aguardar a inicialização (borg init) do Repositório pelo BBS
    Status do Repositório: Ativo
```

> **OBSERVAÇÃO IMPORTANTE:** GUARDE A **SENHA DE CRIPTOGRAFIA DO REPOSITÓRIO** EM UM LOCAL SEGURO (Gerenciador de Senhas ou Cofre Físico), FORA DO PRÓPRIO SERVIDOR. Sem essa senha, **NÃO é possível restaurar** nenhum arquivo do Repositório, mesmo com acesso total ao Ubuntu Server e à partição `/backup`.

```bash
#verificando a estrutura de diretórios criada pelo BBS/Borg dentro da partição de Backup
#opção do comando ls: -lh (long listing, human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.html
sudo ls -lh /backup/repository/lv-dados

#verificando o espaço em disco utilizado pelo Repositório recém-criado
#opção do comando du: -sh (summarize, human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/du.1.html
sudo du -sh /backup/repository/lv-dados
```

## 08_ Criando o Plano de Backup (Backup Plan) da Partição de Dados LVM

```bash
01) No Painel Web do BBS, acessar o menu:
    Planos de Backup (Backup Plans) <Adicionar Plano de Backup>
      Nome do Plano: backup-lv-dados
      Cliente (Agente): srvvaamonde
      Repositório de Destino: repo-dados-onpremise
      Origem dos Dados (Source Path): /dados
      Exclusões (Excludes): /dados/lost+found (opcional)

02) Agendamento (Schedule)
      Frequência: Diária
      Horário: 02:00 (fora do horário comercial)

03) Política de Retenção (Retention Policy)
      Manter Diários (Keep Daily): 7
      Manter Semanais (Keep Weekly): 4
      Manter Mensais (Keep Monthly): 6
<Salvar Plano de Backup>
```

Entendendo a Política de Retenção configurada:<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📅 **Keep Daily** | `7` | Mantém os últimos **7 Backups Diários**, cobrindo uma semana completa de pontos de restauração granulares. |
| 🗓️ **Keep Weekly** | `4` | Mantém **4 Backups Semanais**, cobrindo um mês de retenção intermediária. |
| 📆 **Keep Monthly** | `6` | Mantém **6 Backups Mensais**, cobrindo meio ano de retenção de longo prazo. |
| 🦫 **Prune Automático** | *(executado pelo BBS)* | Após cada novo Backup bem-sucedido, o BBS aciona automaticamente o `borg prune`, removendo Snapshots antigos fora da Política de Retenção, controlando o crescimento do Repositório. |
---

## 09_ Executando e Monitorando o Primeiro Backup no BBS

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

## 10_ Testando a Restauração (Restore) de Arquivos no BBS

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

## 11_ Habilitando Notificações e Autenticação de Dois Fatores (2FA) no BBS

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

## 12_ Localização dos Arquivos de Configuração e Logs do BBS no Ubuntu Server

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

> **PRÓXIMO PASSO DO WORKFLOW:** com o **BorgBackupServer** instalado, o Repositório apontando para `/backup/repository/lv-dados`, o Plano de Backup automatizado protegendo a partição `/dados` (RAID-1 + LVM) e a Restauração já validada, o ambiente de armazenamento e proteção de dados está concluído. O Workflow segue agora para o procedimento __`12. Configuração do Bonding`__, já documentado em `05-security/01-ConfiguracaoBondingNetplan.md`, avançando para a camada de **Alta Disponibilidade de Rede**.
