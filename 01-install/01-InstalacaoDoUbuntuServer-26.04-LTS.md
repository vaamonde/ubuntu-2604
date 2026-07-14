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
Data de criação: 06/07/2026<br>
Data de atualização: 13/07/2026<br>
Versão: 0.03<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

Conteúdo estudado nessa instalação:<br>
#01_ Download da ISO do Ubuntu Server 26.04.x LTS<br>
#02_ Criação da Máquina Virtual no Oracle VirtualBOX<br>
#03_ Configurações da Máquina Virtual UbuntuOnPremise<br>
#04_ Iniciando a Instalação do Ubuntu Server 26.04.x LTS (localizar a ISO)<br>
#05_ Instalação e Configuração do Ubuntu Server 26.04.x LTS<br>
#06_ Acessando o Ubuntu Server pela primeira vez<br>
#07_ Acessando a máquina virtual do Ubuntu Server remotamente via SSH<br>

[![Instalação Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Instalação Ubuntu Server")

Link da vídeo aula: 

## 01_ Download da ISO do Ubuntu Server 26.04.x LTS

Link de download do Ubuntu Server: https://releases.ubuntu.com/26.04/

01) Versão do download Ubuntu Server: ubuntu-26.04-live-server-amd64.iso (Link atualizado em 06/07/2026)<br>
02) Arquitetura do Ubuntu Server: AMD64 (64-bit)<br>
03) Tipo de instalação: DVD Image (ISO) Installer<br>

## 02_ Criação da Máquina Virtual no Oracle VirtualBOX

01) Link de download do Oracle VirtualBOX: https://www.virtualbox.org/wiki/Downloads<br>
02) Vídeo de instalação do VirtualBOX no Linux Mint: https://www.youtube.com/watch?v=yTihvAaaxpU<br>
03) Atualização do VirtualBOX no Linux Mint: https://www.youtube.com/watch?v=DU47PLFSxpA<br>

**OBSERVAÇÃO:** Utilizar o Oracle VirtualBOX Gerenciador (versão 7.x ou superior).

```bash
01) Ferramentas;
<Novo>

02) Nome e Sistema Operacional:
    Nome: UbuntuOnPremise (altere conforme a sua necessidade)
    Pasta (F): #PATH_PADRÃO\UbuntuOnPremise (altere conforme a sua necessidade)
    Imagem ISO: <não selecionado>
    Edição: (sem informação)
    Tipo: Linux
    Subtype: Ubuntu
    Versão: Ubuntu (64-bit)

03) Instalação Desassistida:
    Sem configuração

04) Hardware
    Memória Base: 4096 MB (altere conforme a sua necessidade)
    Processadores: 2 (VCPUs) (altere conforme sua necessidade)
    (OFF) Habilitar EFI (SO especiais apneas)

05) Disco Rígido
    (ON) Criar um novo disco rígido virtual agora
    Localização e Tamanho do Arquivo de Disco Virtual: #PATH_PADRÃO\UbuntuOnPremise (altere conforme a sua necessidade)
      Tamanho: 100,00 GB (altere conforme a sua necessidade)
    Tipo e Variante de Arquivo de Disco Virtual
      VDI (VirtualBox Disk Image)
      (OFF) Pré-alocar Tamanho Total
    (OFF) Utilizar um disco rígido virtual existente
    (OFF) Não acrescentar um Disco Rígido Virtual
<Finalizar>
```

## 03_ Configurações da Máquina Virtual UbuntuOnPremise no Oracle VirtualBOX

```bash
01) Selecionar a Máquina Virtual: UbuntuOnPremise
<Configurações>
    Expert

02) Sistema
    Placa-Mãe
      Recurso Estendidos
        (OFF) Relógio da máquina retorno hora UTC: (Desabilitar)
    Processador
        Recursos Estendidos: Habilitar PAE/NX
                             Habilitar VT-x/AMD-v Aninhado
        #OBSERVAÇÃO: NO LINUX MINT A VERSÃO DO ORACLE VIRTUALBOX 7.X NÃO HABILITAR O RECURSO DE
        #Habilitar VT-x/AMD-v Aninhado EM MODO GRÁFICO, SENDO NECESSÁRIO EXECUTAR NA LINHA DE
        #COMANDO (TERMINAL) O COMANDO: VBoxManage modifyvm UbuntuOnPremise --nested-hw-virt on

03) Display
    Tela (S)
      Memória de Vídeo: 256 MB
      Recursos Estendidos: (ON) Habilitar Aceleração 3D: (Habilitar)

04) Áudio
    (OFF) Habilitar Áudio: (Desabilitar)

05) Rede
    Adaptador 1 (LAN)
      (ON) Habilitar Placa de Rede: (Habilitar)
      Conectado a: Placa em modo Bridge
      Nome: Intel(R) Ethernet Connection (Placa de Rede On-Board)
      #OBSERVAÇÃO: VERIFIQUE QUAL PLACA DE REDE VOCÊ ESTÁ USANDO NO SEU EQUIPAMENTO
      #QUE ESTÁ CONECTADO NA SUA REDE LOCAL, PODE SER PLACA DE REDE CABEADA OU PLACA
      #DE REDE SEM-FIO (RECOMENDO SEMPRE PLACA DE REDE CABEADA, MELHOR DESEMPENHO).
<OK>
```

## 04_ Iniciando a Instalação do Ubuntu Server 26.04.x LTS (localizar a ISO) no Oracle VirtualBOX

```bash
01) Selecionar a Máquina Virtual: UbuntuOnPremise: 
<Iniciar>

02) VirtualBOX VM
    DVD: <Outro...>
    #LOCALIZAR E SELECIONAR A IMAGEM DA ISO DO UBUNTU SERVER 26.04.x LTS <Abrir>
<Montar e Tentar Novo Boot>
```

## 05_ Instalação e Configuração do Ubuntu Server 26.04.x LTS

Link Oficial da Documentação de Instalação do Ubuntu Server: https://ubuntu.com/server/docs/installation

**OBSERVAÇÃO IMPORTANTE:** O Boot Inicial do Ubuntu Server demora cerca de: __`30 (trinta segundos)`__ para iniciar a instalação padrão caso você não altere as opções de Boot.

**OBSERVAÇÃO:** Para parar o *Boot Inicial do Ubuntu Server* pressione: __`<Seta para Baixo>`__.

```bash
01) *Try or Install Ubuntu Server
<Enter>

02) Use UP, DOWN and ENTER keys to select your language
    English (recomendado utilizar sempre a opção em Inglês)
<Enter>

03) Keyboard configuration
    Layout:  [English (US)] ou [Portuguese (Brazil)] (altere conforme a sua necessidade)
    Variant: [English (US)] ou [Portuguese (Brazil)] (altere conforme a sua necessidade)
             [English (US) - English (US, intl., with dead keys)] (suporte americano com acentuação)
<Done>

04) Choose type of install
    (X) Ubuntu Server (DEFAULT - Selecionado por padrão)
    ( ) Ubuntu Server (minimized)
    Additional options
      [ ] Search for third-party drivers
<Done>

05) Network connections
    enp0s3 eth - (o nome lógico da placa de rede muda de equipamento para equipamento)
    DHCPv4 172.16.1.XXX/24 (altere conforme a sua necessidade)
    #OBSERVAÇÃO IMPORTANTE: VERIFICAR O ENDEREÇO IPv4 QUE VOCÊ ESTÁ USANDO NA SUA REDE 
    #INTERNA PARA ADAPTAR NO SEU CENÁRIO.
<Done>

06) Configure proxy
    Proxy address: (Default)
<Done>

07) Configure Ubuntu archive mirror
    Mirror: http://archive.ubuntu.com/ubuntu
    #OBSERVAÇÃO IMPORTANTE: CASO QUEIRA TROCAR O MIRROR DO UBUNTU DO BRASIL PARA O
    #OFICIAL NO US, SUBSTITUA A URL DE: http://br.archive.ubuntu.com/ubuntu PARA A
    #URL: http://us.archive.ubuntu.com/ubuntu
<Done>

08) Guided storage configuration
    (X) Use an entire disk (Default)
      [VBOX_HARDISK-XXXX local disk 100.000G]
        (X) Set up this disk as an LVM group (Default)
          [ ] Encrypt the LVM group with LUKS (Default - No (Não))
    ( ) Custom storage layout
<Done>

09) Storage configuration
    AVAILABLE DEVICES
      free space <Enter>
        #Criando a partição de Memória Virtual Swap do Ubuntu Server
        Create Logical Volume <Enter>
          Name: lv-swap
          Size (max 49.000G): 8.000G (alterar conforme a sua necessidade)
          Format: swap
        <Create>
        #Criando a partição do Perfil dos Usuários Home do Ubuntu Server
        Create Logical Volume <Enter>
          Name: lv-home
          Size (max 41.000G): 5.000G
          Format: ext4
          Mount: /home
        <Create>
        #Criando a partição Temporária Temp do Ubuntu Server
        Create Logical Volume <Enter>
          Name: lv-tmp
          Size (max 36.000G): 5.000G
          Format: ext4
          Mount: Other
            /tmp
        <Create>
        #Criando a partição Variável Var do Ubuntu Server
        Create Logical Volume <Enter>
          Name: lv-tmp
          Size (max 36.000G): 15.000G
          Format: ext4
          Mount: /var
        <Create>
    USER DEVICES
      #Alterando o novo do Volume Lógico da Raiz Root do Ubuntu Server
      ubuntu-lv <Enter>
        Edit <Enter>
          Name: ln-root
        <Save>
<Done>
  Confirm destructive action
<Continue>

10) Profile setup
    #OBSERVAÇÃO: ALTERAR OS DADOS DO NOME DO SERVIDOR, USUÁRIO E SENHA PARA O SEU CENÁRIO.
    Your name: Seu Nome e Sobrenome <Tab>
    Your servers name: srvseunome <Tab>
    Pick a username: seu_usuário <Tab>
    Choose a passwords: sua_senha <Tab>
    Confirm your passwords: sua_senha
<Done>

11) Upgrade to Ubuntu Pro
    ( ) Enable Ubuntu Pro
    (X) Skip Ubuntu Pro setup for now
<Continue>

12) SSH Setup
    [X] Install OpenSSH server: ON (Habilitar - pressione <Space> para selecionar)
    [X] Allow password authentication over SSH
<Done>

13) Featured Server Snaps
<Done>

14) Install complete!
<Reboot Now>

15) Please remove the installation medium, then press ENTER:
<Enter>
```

## 06_ Acessando o Ubuntu Server pela primeira vez via Terminal

**OBSERVAÇÃO:** AGUARDAR A INICIALIZAÇÃO TOTAL DO UBUNTU SERVER, NO FINAL SERÁ GERADO VÁRIAS CHAVES DE AUTENTICAÇÃO DO SSH SERVER, PRESSIONE <ENTER> PARA APARECER A TELA DE LOGIN.

```bash
01) Tela de Login do Ubuntu Server
    Ubuntu 26.04 LTS srvseunome tty1
      srvseunome login: seu_usuário <Enter> (altere para o seu usuário)
      Password: sua_senha <Enter> (altere para a sua senha)
    seu_usuário@srvseunome:~$ (primeiro acesso ao Terminal do Ubuntu Server)

02) Verificando o endereço IPv4 do Ubuntu Server
    seu_usuário@srvseunome:~$ sudo ip address show
```

## 07_ Acessando a máquina virtual do Ubuntu Server remotamente via SSH

**DICA:** Você pode usar os softwares: __`Bash/Shell`__ (GNU/Linux), __`Powershell`__ (Microsoft Windows), __`PuTTY`__ (GNU/Linux ou Microsoft Windows) e __`Git Bash`__ (Microsoft Windows - RECOMENDADO SE ESTIVER USANDO O WINDOWS).

```bash
#testando a conexão com o Ubuntu Server (alterar o Endereço IPv4 para o seu cenário)
ping SEU_ENDEREÇO_IPV4_UBUNTU_SERVER

#acessando remotamente o Ubuntu Server (alterar o Usuário e Endereço IPv4 para o seu cenário)
ssh seu_usuário@SEU_ENDEREÇO_IPV4_UBUNTU_SERVER

#confirmando a troca das chaves públicas e do fingerprint do SSH (alterar sua senha para o seu cenário)
The authenticity of host 'SEU_ENDEREÇO_IPV4_UBUNTU_SERVER' can't be established.
ECDSA key fingerprint is SHA256:5yoVsKHMrn3FP/LBW1fyPTtVlt3og9jmyXPPkki/BY0.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes <Enter>

seu_usuário@SEU_ENDEREÇO_IPV4's password: sua_senha <Enter> (Por motivo de segurança a senha não aparece no Terminal)

seu_usuário@srvseunome:~$ (Acesso ao Terminal Remoto (Bash/Shell) via SSH)
```