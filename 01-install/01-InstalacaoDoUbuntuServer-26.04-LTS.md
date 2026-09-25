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
**Data de atualização:** `25/09/2026`<br>
**Versão:** `0.09`<br>

> __`Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS`__

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE INSTALAÇÃO DO UBUNTU SERVER 26.04 A SEGUINTE FRASE: *Instalação do Ubuntu Server 26.04.x LTS On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #install #installubuntu #installubuntuserver #installubuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/01-install.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

**Conteúdo estudado nessa instalação:**<br>
[#01_ Download da ISO do Ubuntu Server 26.04.x LTS](#01_-download-da-iso-do-ubuntu-server-2604x-lts)<br>
[#02_ Criação da Máquina Virtual do Ubuntu Server no Oracle VirtualBOX](#02_-criação-da-máquina-virtual-do-ubuntu-server-no-oracle-virtualbox)<br>
[#03_ Configurações da Máquina Virtual do Ubuntu Server no Oracle VirtualBOX](#03_-configurações-da-máquina-virtual-do-ubuntu-server-no-oracle-virtualbox)<br>
[#04_ Iniciando a Instalação do Ubuntu Server 26.04.x LTS (localizar a ISO) no Oracle VirtualBOX](#04_-iniciando-a-instalação-do-ubuntu-server-2604x-lts-localizar-a-iso-no-oracle-virtualbox)<br>
[#05_ Instalação e Configuração do Ubuntu Server 26.04.x LTS](#05_-instalação-e-configuração-do-ubuntu-server-2604x-lts)<br>
[#06_ Particionamento do Hard Disk do Ubuntu Server 26.04.x LTS](#06_-particionamento-do-hard-disk-do-ubuntu-server-2604x-lts)<br>
[#07_ Finalização da Instalação do Ubuntu Server 26.04.x LTS](#07_-finalização-da-instalação-do-ubuntu-server-2604x-lts)<br>
[#08_ Acessando o Ubuntu Server pela primeira vez via Terminal (TTY)](#08_-acessando-o-ubuntu-server-pela-primeira-vez-via-terminal-tty)<br>
[#09_ Acessando a máquina virtual do Ubuntu Server remotamente via SSH](#09_-acessando-a-máquina-virtual-do-ubuntu-server-remotamente-via-ssh)<br>

[![Instalação Ubuntu Server 26.04](http://img.youtube.com/vi//0.jpg)]( "Instalação Ubuntu Server 26.04")

Link da vídeo aula: 

## 01_ Download da ISO do Ubuntu Server 26.04.x LTS

Link de download do Ubuntu Server: https://releases.ubuntu.com/26.04/

01) Versão do download Ubuntu Server: ubuntu-26.04.1-live-server-amd64.iso (Link atualizado em 10/09/2026)<br>
02) Arquitetura do Ubuntu Server: AMD64 (64-bit)<br>
03) Tipo de instalação: DVD Image (ISO) Installer<br>

## 02_ Criação da Máquina Virtual do Ubuntu Server no Oracle VirtualBOX

01) Link de download do Oracle VirtualBOX: https://www.virtualbox.org/wiki/Downloads<br>
02) Vídeo de instalação do VirtualBOX no Linux Mint: https://www.youtube.com/watch?v=yTihvAaaxpU<br>
03) Atualização do VirtualBOX no Linux Mint: https://www.youtube.com/watch?v=DU47PLFSxpA<br>

> **OBSERVAÇÃO:** Utilizar o Virtualizador Oracle VirtualBOX versão 7.x ou superior.

| **🧩 Recurso** | **📚 Cenário Acadêmico / Pequeno Porte** | **📈 Projeção para Médio Porte** | **🎯 Observação** |
| :------------- | :--------------------------------------: | :------------------------------: | :---------------- |
| 🧠 **CPU** | `2 vCPU` | `4–8 vCPU` | Aumentar conforme serviços, usuários e carga simultânea. |
| 💾 **RAM** | `4 GB` | `8–16 GB` | Serviços como banco de dados, monitoramento e aplicações podem exigir mais memória. |
| 💽 **Disco** | `40–60 GB` | `80–160 GB+` | Preferencialmente **SSD/NVMe**; prever expansão para logs, atualizações e dados. |
| 🌐 **Rede** | `1 vNIC` | `2+ vNICs` | Uma interface atende cenários básicos; múltiplas interfaces permitem segmentação, redundância e laboratórios de **Bonding**. |
| 🖥️ **Firmware/Virtualização** | `BIOS/UEFI` + <br> `VT-x/AMD-V` | `UEFI + VT-x/AMD-V` | Ativar suporte à virtualização por hardware no host. |
| 🔄 **Expansão de armazenamento** | `1 disco virtual` | `2+ discos virtuais` | Permite trabalhar com **RAID, LVM, `/dados`, `/backup` e snapshots** conforme o crescimento. |
| 📊 **Recursos do host** | `Reserva para a VM` | `Reserva dedicada/ajustável` | O host deve possuir recursos suficientes para a VM **sem comprometer as demais máquinas virtuais**. |
---

```bash
#Criando a Máquina Virtual do Ubuntu Server 26.04.x LTS no Oracle VirtualBOX
01) Ferramentas;
      <Novo>
```
```bash
#Personalizando a criação da Máquina Virtual do Ubuntu Server
02) Nome e Sistema Operacional:
      Nome: UbuntuOnPremises (altere conforme a sua necessidade)
      Pasta (F): #PATH_PADRÃO\UbuntuOnPremises (altere conforme a sua necessidade)
      Imagem ISO: <não selecionado>
      Edição: (sem informação)
      Tipo: Linux
      Subtype: Ubuntu
      Versão: Ubuntu (64-bit)
      (OFF) Pular Instalação Desassistida (não selecionado)
```
```bash
#Desabilitando o recursos de Instalação Desassistida (Automática)
03) Instalação Desassistida:
      Sem configuração para esse cenário
```
```bash
#Configuração da Memória RAM Virtual (vRAM) e dos Processadores Virtuais (vCPU)
04) Hardware
      Memória Base: 4096 MB (altere conforme a sua necessidade)
      Processadores: 2 (vCPUs) (altere conforme sua necessidade)
      (OFF) Habilitar EFI (SOs especiais apenas)
```
```bash
#Criando o Hard Disk Virtual (vHD) para a instalação do Ubuntu Server
05) Disco Rígido
      (ON) Criar um novo disco rígido virtual agora
        Localização e Tamanho do Arquivo de Disco Virtual: 
          #PATH_PADRÃO\UbuntuOnPremises (altere conforme a sua necessidade)
          Tamanho: 100,00 GB (altere conforme a sua necessidade)
        Tipo e Variante de Arquivo de Disco Virtual
          VDI (VirtualBox Disk Image)
            (OFF) Pré-alocar Tamanho Total (não selecionado)
            (OFF) Split into 2GB Parts (não selecionado)
        (OFF) Utilizar um disco rígido virtual existente
        (OFF) Não acrescentar um Disco Rígido Virtual
      <Finalizar>
  ```

## 03_ Configurações da Máquina Virtual do Ubuntu Server no Oracle VirtualBOX
```bash
#Configurando a Máquina Virtual do Ubuntu Server
01) Selecionar a Máquina Virtual: UbuntuOnPremises
      <Configurações>
        Expert
```
```bash
#Configurando o Processador, Memória e Recursos de Virtualização
02) Sistema
      Placa-Mãe
        Recurso Estendidos
          (OFF) Relógio da máquina retorno hora UTC: (Desabilitar)
      Processador
          Recursos Estendidos: Habilitar PAE/NX
                               Habilitar VT-x/AMD-v Aninhado
          #OBSERVAÇÃO: NO LINUX MINT A VERSÃO DO ORACLE VIRTUALBOX 7.X NÃO HABILITA O RECURSO DE:
          #Habilitar VT-x/AMD-v Aninhado EM MODO GRÁFICO, SENDO NECESSÁRIO EXECUTAR NO TERMINAL O
          #COMANDO: VBoxManage modifyvm UbuntuOnPremises --nested-hw-virt on
```
```bash
#Configuração da Placa de Vídeo (vGPU) e Resolução do Monitor
03) Display
      Tela (S)
        Memória de Vídeo: 256 MB
        Recursos Estendidos: (ON) Habilitar Aceleração 3D: (Habilitar)
```
```bash
#Desabilitando os Recursos de Audio do Servidor
04) Áudio
      (OFF) Habilitar Áudio: (Desabilitar)
```
```bash
#Configuração da Placa de Rede em Modo Bridge (Ponte)
05) Rede
      Adaptador 1 (LAN)
        (ON) Habilitar Placa de Rede: (Habilitar)
          Conectado a: Placa em modo Bridge
          Nome: Intel(R) Ethernet Connection (Placa de Rede On-Board)
          #OBSERVAÇÃO: VERIFIQUE QUAL PLACA DE REDE VOCÊ ESTÁ USANDO NO SEU COMPUTADOR QUE ESTÁ 
          #CONECTADO NA SUA REDE LOCAL, PODE SER PLACA DE REDE CABEADA OU PLACA DE REDE SEM-FIO 
          #RECOMENDADO SEMPRE UTILIZAR PLACA DE REDE CABEADA, MELHOR DESEMPENHO E MAIS CONFIÁVEL.
          Tipo de Placa: Intel PRO/1000 MT Desktop (82540EM)
          Modo Promiscuo: Permitir Tudo (Selecionar)
          Endereço MAC: <Gerado Automaticamente>
          (ON) Cabo conectado (Habilitado)
    <OK>
```

## 04_ Iniciando a Instalação do Ubuntu Server 26.04.x LTS (localizar a ISO) no Oracle VirtualBOX
```bash
#Iniciando a Máquina Virtual do Ubuntu Server
01) Selecionar a Máquina Virtual: UbuntuOnPremises: 
      <Iniciar>
```
```bash
#Localizando a ISO da Instalação do Ubuntu Server
02) VirtualBOX VM
      DVD: <Outro...>
      #LOCALIZAR E SELECIONAR A IMAGEM DA ISO DO UBUNTU SERVER 26.04.x LTS <Abrir>
    <Montar e Tentar Novo Boot>
```

## 05_ Instalação e Configuração do Ubuntu Server 26.04.x LTS

Link Oficial da Documentação de Instalação do Ubuntu Server: https://ubuntu.com/server/docs/installation

> **OBSERVAÇÃO IMPORTANTE:** O Boot Inicial do Ubuntu Server demora cerca de: __`30 (trinta segundos)`__ para iniciar a instalação padrão caso você não altere as opções de Boot.
>
> **OBSERVAÇÃO:** Para parar o *Boot Inicial do Ubuntu Server* pressione: __`<Seta para Baixo>`__.

```bash
#Selecione *Try or Install Ubuntu Server para iniciar o processo de instalação
01) *Try or Install Ubuntu Server
      <Enter>
```
```bash
#Recomendado utilizar sempre a opção em Inglês para instalar o Ubuntu Server
02) Willkommen! Bienvenue! Welcome! Welkom! 
      Use UP, DOWN and ENTER keys to select your language
        English 
    <Enter>
```
```bash
#Configuração do Teclado e Acentuação do Terminal do Ubuntu Server
03) Keyboard configuration
      Please select your keyboard layout below, or select 'Identify keyboard' to detect your layout automatically.
        Layout:  [English (US)] ou [Portuguese (Brazil)] (altere conforme a sua necessidade)
        Variant: [English (US)] ou [Portuguese (Brazil)] (altere conforme a sua necessidade)
                 [English (US) - English (US, intl., with dead keys)] (suporte americano com acentuação)
    <Done>
```
```bash
#Tipo de instalação do Ubuntu Server (Sistema Completo)
04) Choose the type of installation
      Choose the base for the installation
        (X) Ubuntu Server (Default - Selecionado por padrão)
        ( ) Ubuntu Server (minimized)
        Additional options
          [ ] Search for third-party drivers
    <Done>
```
```bash
#Configuração da Placa de Rede do Ubuntu Server
05) Network configuration
      Configure at least one interface this server can use to talk to other machines and which preferably
      provides sufficient access for updates
        enp0s3 eth - (o nome lógico da placa de rede muda de equipamento para equipamento)
        DHCPv4 172.16.1.XXX/24 (verifique se obteve o endereço IPv4 da sua rede corretamente)
        DHCPv6 2894:14c:90:8697::/64 (verifique se obteve o endereço IPv6 da sua rede corretamente)
        DHCPv6 2894:14c:90:8697::/128 (verifique se obteve o endereço IPv6 da sua rede corretamente)
        #OBSERVAÇÃO IMPORTANTE: VERIFIQUE O ENDEREÇO IPv4 e IPv6 QUE VOCÊ ESTÁ USANDO NA SUA REDE 
        #LOCAL (INTERNA) PARA ADAPTAR NO SEU CENÁRIO, A CONFIGURAÇÃO DA PLACA DE REDE SERÁ FEITA 
        #MANUALMENTE NAS PRÓXIMAS AULAS (NETPLAN E BONDING).
    <Done>
```
```bash
#Configuração do Proxy Server do Ubuntu Server
06) Proxy configuration
      If this system requires a proxy to connect to the internet, enter its details here
        Proxy address: (Default)
    <Done>
```
```bash
#Configuração dos Espelhos dos Repositórios do Ubuntu Server
07) Ubuntu archive mirror configuration
      If you use an alternative mirror for ubuntu, enter its details here
        Mirror address: http://archive.ubuntu.com/ubuntu (padrão da distribuição)
        #OBSERVAÇÃO IMPORTANTE: CASO QUEIRA TROCAR O MIRROR DO UBUNTU DO BRASIL PARA O
        #OFICIAL DO US, SUBSTITUA A URL DE: http://br.archive.ubuntu.com/ubuntu PARA A
        #URL: http://us.archive.ubuntu.com/ubuntu
    <Done>
```
```bash
#Configuração do Hard Disk e Particionamento do Ubuntu Server
08) Guided storage configuration
      Configure a guided storage layout, or create a custom one
        (X) Use an entire disk (Default)
          [VBOX_HARDISK-XXXX local disk 100.000G]
            (X) Set up this disk as an LVM group (Default)
              [ ] Encrypt the LVM group with LUKS (Default - No (Não))
        ( ) Custom storage layout (Default - No (Não))
    <Done>
```

## 06_ Particionamento do Hard Disk do Ubuntu Server 26.04.x LTS

| **📂 Partição** | **📝 Descrição** |
| :-------------- | :--------------- |
| **🖥️ `/` (Root)** | Contém o sistema operacional, bibliotecas, executáveis, configurações e diretórios essenciais para o funcionamento do Ubuntu Server. Separar a partição raiz facilita o gerenciamento do espaço em disco e evita que outros diretórios consumam todo o armazenamento disponível. |
| **💾 `swap`** | Área utilizada como memória virtual quando a memória RAM é insuficiente. Também é utilizada para operações como hibernação (quando suportada) e auxilia o kernel no gerenciamento da memória, reduzindo a possibilidade de encerramento inesperado de processos por falta de RAM (*Out Of Memory - OOM*). |
| **👤 `/home`** | Armazena os diretórios pessoais dos usuários, incluindo arquivos, configurações e perfis individuais. Mantê-la separada facilita reinstalações do sistema operacional, preserva os dados dos usuários e melhora a organização do servidor. |
| **📁 `/tmp`** | Diretório destinado ao armazenamento de arquivos temporários criados pelo sistema e pelas aplicações durante sua execução. Sua separação aumenta a segurança, facilita a limpeza automática e evita que arquivos temporários ocupem espaço da partição principal do sistema. |
| **📊 `/var`** | Contém arquivos de crescimento dinâmico, como logs do sistema, filas de impressão, cache, bancos de dados, arquivos de e-mail e informações de aplicações. Mantê-la em uma partição dedicada impede que o crescimento desses arquivos comprometa o funcionamento da partição raiz (`/`). |
---

```bash
#Customização o Particionamento do Ubuntu Server
09) Storage configuration
      AVAILABLE DEVICES
        free space 49.000G <Enter>

          #Criando a partição de Memória Virtual Swap do Ubuntu Server
          Create Logical Volume <Enter>
            Name: lv-swap
            Size (max 49.000G): 8.000G #Alterar conforme a sua necessidade
            Format: swap
            Mount: (Disable)
          <Create>

          #Criando a partição do Perfil dos Usuários (/home) do Ubuntu Server
          Create Logical Volume <Enter>
            Name: lv-home
            Size (max 41.000G): 5.000G
            Format: ext4
            Mount: /home
          <Create>

          #Criando a partição Temporária (/tmp) do Ubuntu Server
          Create Logical Volume <Enter>
            Name: lv-tmp
            Size (max 36.000G): 5.000G
            Format: ext4
            Mount: Other
              /tmp
          <Create>

          #Criando a partição Variável (/var) do Ubuntu Server
          Create Logical Volume <Enter>
            Name: lv-var
            Size (max 36.000G): 15.000G
            Format: ext4
            Mount: /var
          <Create>
```
```bash
#Alterando o nome do Volume Lógico da Raiz (/ - Root) do Ubuntu Server
10) Storage configuration
      USER DEVICES

        #Alterando o nome do Volume Lógico da Raiz (/ - Root) do Ubuntu Server
        ubuntu-lv 48.996G <Enter>
          Edit <Enter>
            Name: lv-root
          <Save>
```
```bash
#Confirmando as alterações do Hard Disk do Ubuntu Server
11) Storage configuration
    <Done>
      Confirm destructive action: Are you sure you want to continue?
    <Continue>
```

## 07_ Finalização da Instalação do Ubuntu Server 26.04.x LTS
```bash
#Configuração do Usuário e Senha de acesso do Ubuntu Server
12) Profile configuration
      Enter the username and password you will use to log into the system.
        #OBSERVAÇÃO: ALTERAR OS DADOS DO NOME DO SERVIDOR, USUÁRIO E SENHA PARA O SEU CENÁRIO.
        Your name: Seu Nome e Sobrenome <Tab>
        Your servers name: srvseunome <Tab>
        Pick a username: seu_usuário <Tab>
        Choose a password: sua_senha <Tab>
        Confirm your password: confirmar_sua_senha
    <Done>
```
```bash
#Configuração do suporte ao Ubuntu Pro do Ubuntu Server
13) Upgrade to Ubuntu Pro
      Upgrade this machine to Ubuntu Pro for security updates on a much wider range of packages, until 2036.
        ( ) Enable Ubuntu Pro
        (X) Skip Ubuntu Pro setup for now (Default - Selecionado por padrão)
    <Continue>
```
```bash
#Configuração do acesso remoto via SSH do Ubuntu Server
14) SSH Configuration
      You can choose to install the OpenSSH server package to enable secure remote access to your server
        [X] Install OpenSSH server: ON (Habilitar - pressione <Space> para selecionar)
        [X] Allow password authentication over SSH: ON (Default - Habilitado por padrão)
    <Done>
```
```bash
#Configuração do recursos via SNAP's do Ubuntu Server
15) Featured Server Snaps
      These are popular snaps in server environments.
    <Done>
```
```bash
#Instalação do Ubuntu Server
16) Installer system
    #Demora cerca de 10/15 minutos o procedimento de instalação
```
```bash
#Atualização do Ubuntu Server
17) Updating system
    #Demora cerca de 10/15 minutos o procedimento de atualização
```
```bash
#Finalização da instalação do Ubuntu Server
18) Installation complete!
    <Reboot Now>
```
```bash
#Remoção da média de instalação do Ubuntu Server
19) Please remove the installation medium, then press ENTER:
    <Enter>
```

## 08_ Acessando o Ubuntu Server pela primeira vez via Terminal (TTY)

> **OBSERVAÇÃO:** AGUARDAR A INICIALIZAÇÃO TOTAL DO UBUNTU SERVER, NO FINAL SERÁ GERADO VÁRIAS CHAVES DE AUTENTICAÇÃO DO **OPENSSH SERVER**, PRESSIONE `<ENTER>` PARA APARECER A TELA DE LOGIN.

```bash
#Primeiro acesso via terminal do Ubuntu Server
01) Tela de Login do Ubuntu Server
    Ubuntu 26.04 LTS srvseunome tty1
      srvseunome login: seu_usuário <Enter> (altere para o nome do seu usuário)
      Password: sua_senha <Enter> (altere para a sua senha)
    seu_usuário@srvseunome:~$ (primeiro acesso ao Terminal do Ubuntu Server)
```
```bash
#Verificando os endereços IPv4/IPv6 obtidos via DHCP do Ubuntu Server
02) Verificando o endereço IPv4/IPv6 do Ubuntu Server
    seu_usuário@srvseunome:~$ sudo ip address show
```

## 09_ Acessando a máquina virtual do Ubuntu Server remotamente via SSH

> **DICA:** Você pode usar os softwares: __`Bash/Shell`__ (GNU/Linux), __`Zsh`__ (MacOS), __`Powershell`__ (Microsoft Windows), __`PuTTY`__ (GNU/Linux ou Microsoft Windows) e __`Git Bash`__ (Microsoft Windows - RECOMENDADO SE ESTIVER USANDO O WINDOWS).

```bash
#testando a conexão com o Ubuntu Server (alterar o Endereço IPv4 para o seu cenário)
ping SEU_ENDEREÇO_IPV4_UBUNTU_SERVER
```
```bash
#acessando remotamente o Ubuntu Server (alterar o Usuário e Endereço IPv4 para o seu cenário)
ssh seu_usuário@SEU_ENDEREÇO_IPV4_UBUNTU_SERVER
```
```bash
#confirmando a troca das chaves públicas e do fingerprint (hash) do SSH (alterar sua senha para o seu cenário)
The authenticity of host 'SEU_ENDEREÇO_IPV4_UBUNTU_SERVER' can t be established.
ECDSA key fingerprint is SHA256:5yoVsKHMrn3FP/LBW1fyPTtVlt3og9jmyXPPkki/BY0.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes <Enter>
```
```bash
#digitando a senha do seu usuário, por motivos de segurança a senha não aparece no terminal
seu_usuário@SEU_ENDEREÇO_IPV4_UBUNTU_SERVER password: sua_senha <Enter>
```
```bash
#acesso ao terminal remoto feito com sucesso, etapa concluída
seu_usuário@srvseunome:~$ (Acesso ao Terminal Remoto (Bash/Shell) via SSH)
```
```bash
#verificando os usuários logados no TTY (Físico) e PTS (Remoto) do Ubuntu Server
w
```

Entendendo a saída do comando: __`w`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🕒 **Current Time** | `12:22:16` | Hora em que o comando `w` foi executado. |
| ⏱️ **System Uptime** | `14 min` | Tempo decorrido desde a inicialização do servidor. |
| 👥 **Logged-in Users** | `2 users` | Quantidade de usuários atualmente conectados ao sistema. |
| 📊 **Load Average (1 min)** | `1,23` | Carga média absoluta do sistema nos últimos 1 minuto em relação ao vCPU. |
| 📊 **Load Average (5 min)** | `1,62` | Carga média absoluta do sistema nos últimos 5 minutos em relação ao vCPU. |
| 📊 **Load Average (15 min)** | `1,10` | Carga média absoluta do sistema nos últimos 15 minutos em relação ao vCPU. |
| 👤 **USER** | `vaamonde` | Usuário atualmente conectado à sessão. |
| 🖥️ **TTY** | `pts/0` | Terminal virtual utilizado pela sessão SSH ou terminal remoto. |
| 🌐 **FROM** | `172.16.1.113` | Endereço IP de origem da conexão do usuário. |
| 🕐 **LOGIN@** | `12:21` | Horário em que o usuário iniciou a sessão. |
| ⏸️ **IDLE** | `0.00s` | Tempo desde a última atividade no terminal. |
| ⚙️ **JCPU** | `0.09s` | Tempo de CPU utilizado por todos os processos associados à sessão. |
| ⚙️ **PCPU** | `0.04s` | Tempo de CPU utilizado pelo processo atualmente em execução. |
| 💻 **WHAT** | `w` | Comando/processo atualmente executado pelo usuário. |
| 🖥️ **TTY** | `tty1` | Terminal físico/virtual local utilizado pela segunda sessão. |
| 🏠 **FROM** | `-` | Indica que a sessão é local e não possui endereço IP remoto. |
| 🕐 **LOGIN@** | `12:21` | Horário em que a segunda sessão foi iniciada. |
| ⏸️ **IDLE** | `1:18` | Tempo decorrido desde a última atividade nessa sessão. |
| ⚙️ **JCPU** | `0.15s` | Tempo de CPU utilizado pelos processos associados à sessão. |
| ⚙️ **PCPU** | `0.15s` | Tempo de CPU utilizado pelo processo atualmente associado à sessão. |
| 💻 **WHAT** | `-bash` | Shell Bash em execução na sessão local. |
---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE INSTALAÇÃO DO UBUNTU SERVER 26.04 A SEGUINTE FRASE: *Instalação do Ubuntu Server 26.04.x LTS On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #install #installubuntu #installubuntuserver #installubuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/01-install.png

---