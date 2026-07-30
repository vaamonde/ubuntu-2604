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
Data de criação: 28/07/2026<br>
Data de atualização: 30/07/2026<br>
Versão: 0.03<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS<br>
Testado e homologado no Oracle VirtualBOX 7.x

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Netplan Bonding (Documentação Oficial): https://netplan.readthedocs.io/en/stable/netplan-yaml/#properties-for-device-type-bonds<br>
Linux Bonding Driver (Kernel.org): https://www.kernel.org/doc/Documentation/networking/bonding.txt<br>
Oracle VirtualBOX Networking (Documentação Oficial): https://www.virtualbox.org/manual/ch06.html

Conteúdo estudado nessa configuração:<br>
#01_ Entendendo as limitações do Oracle VirtualBOX para o Bonding<br>
#02_ Adicionando a Segunda Placa de Rede na Máquina Virtual UbuntuOnPremise<br>
#03_ Habilitando o Modo Promíscuo nos Adaptadores de Rede via VBoxManage<br>
#04_ Verificando as duas Interfaces de Rede reconhecidas no Ubuntu Server<br>
#05_ Instalando o módulo do Kernel de Bonding no Ubuntu Server<br>
#06_ Atualizando o arquivo de configuração do Netplan com Bonding<br>
#07_ Aplicando as configurações do Netplan e verificando a Interface bond0<br>
#08_ Testando a Redundância (Failover) do Bonding no Ubuntu Server<br>

| **🔗 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🔀 **Bonding (Link Aggregation)** | Recurso do Kernel Linux que agrupa **duas ou mais Placas de Rede físicas** em uma única interface lógica (`bond0`), gerenciado pelo driver **bonding** do Kernel. | Fornece **Redundância (Alta Disponibilidade)** e/ou **Balanceamento de Carga**, dependendo do modo escolhido, aumentando a resiliência da conexão de rede do servidor. |
| ⚙️ **Modo active-backup (mode 1)** | Apenas uma interface física fica **ativa** por vez; a segunda interface fica em modo de espera (**standby**) e assume automaticamente em caso de falha da interface ativa. | É o **único modo recomendado para laboratório no Oracle VirtualBOX**, pois não depende de nenhuma negociação com um Switch físico. |
| 🌐 **LACP / 802.3ad (mode 4)** | Protocolo padrão **IEEE 802.3ad**, que negocia dinamicamente a agregação de links entre o servidor e um **Switch gerenciável** compatível com LACP. | Fornece balanceamento de carga real entre os links, mas **exige um Switch físico com suporte a LACP**, por isso **NÃO funciona de forma confiável no VirtualBOX em modo Bridge**. |
| 🖧 **Modo Bridge (VirtualBOX)** | Modo de rede do VirtualBOX que conecta o Adaptador Virtual diretamente à Placa de Rede física do Host, fazendo a Máquina Virtual aparecer como um dispositivo independente na rede local. | Permite que a Máquina Virtual receba um Endereço IP da mesma rede do Host, mas **não simula um Switch físico**, por isso não há negociação de protocolos de agregação entre os adaptadores. |
| 👁️ **Modo Promíscuo (Promiscuous Mode)** | Configuração do Adaptador de Rede que permite receber **todos os quadros (frames) Ethernet** que passam pelo Switch/Rede, mesmo que o endereço MAC de destino não seja o da própria interface. | É **obrigatório habilitar no VirtualBOX** (`Allow All`) nos dois Adaptadores em modo Bridge, pois a interface `bond0` utiliza MAC Address próprio e precisa repassar quadros entre as interfaces físicas do VirtualBOX. |
---

[![Bonding Ubuntu Server VirtualBOX](http://img.youtube.com/vi//0.jpg)]( "Bonding Ubuntu Server VirtualBOX")

Link da vídeo aula: 

## 01_ Entendendo as limitações do Oracle VirtualBOX para o Bonding

> **OBSERVAÇÃO IMPORTANTE:** o Oracle VirtualBOX, mesmo utilizando o Adaptador em modo **Bridge**, **NÃO possui um Switch Físico** fazendo a negociação de protocolos entre as placas de rede virtuais. Por esse motivo, **NEM TODOS os modos de Bonding do Kernel Linux funcionam corretamente em ambiente de Laboratório/VirtualBOX**.

| **🎚️ Modo do Bonding** | **🔢 Número** | **✅ Funciona no VirtualBOX Bridge?** | **📖 Motivo** |
| :---------------------- | :-----------: | :------------------------------------: | :------------- |
| **active-backup** | mode 1 | ✅ **Recomendado** | Não depende de negociação externa, apenas monitora o Link (MII) das interfaces. |
| **balance-rr** | mode 0 | ⚠️ Parcial (somente Testes) | Pode gerar reordenação de pacotes (*out-of-order*), pois o VirtualBOX não distribui os quadros como um Switch real faria. |
| **balance-xor** | mode 2 | ❌ Não recomendado | Depende de um Switch com suporte a Balanceamento por Hash (Etherchannel estático), inexistente no VirtualBOX. |
| **broadcast** | mode 3 | ⚠️ Parcial (somente Testes) | Envia o mesmo quadro pelas duas interfaces, gera tráfego duplicado desnecessário. |
| **802.3ad (LACP)** | mode 4 | ❌ **Não funciona** | Exige negociação **LACPDU** com um Switch físico gerenciável, recurso que o VirtualBOX Bridge não simula. |
| **balance-tlb** | mode 5 | ❌ Não recomendado | Depende do driver da placa de rede física do Host suportar o recurso, resultado inconsistente em ambiente virtualizado. |
| **balance-alb** | mode 6 | ❌ Não recomendado | Utiliza **ARP Negotiation** para balancear o tráfego de entrada, o que gera instabilidade em redes Bridged do VirtualBOX. |
---

> **CONCLUSÃO:** para fins didáticos de **Alta Disponibilidade (Redundância)** em Laboratório com Oracle VirtualBOX, utilize sempre o modo: __`active-backup (mode 1)`__. Em um ambiente de Produção On-Premises com Switches físicos gerenciáveis, o modo __`802.3ad (LACP)`__ passa a ser o mais indicado.

## 02_ Adicionando a Segunda Placa de Rede na Máquina Virtual UbuntuOnPremise

```bash
01) Selecionar a Máquina Virtual: UbuntuOnPremise
<Configurações>
    Expert

02) Rede
    Adaptador 1 (LAN)
      (ON) Habilitar Placa de Rede: (Habilitar)
      Conectado a: Placa em modo Bridge
      Nome: Intel(R) Ethernet Connection (Placa de Rede On-Board)
      #OBSERVAÇÃO IMPORTANTE: RECOMENDA-SE UTILIZAR A MESMA PLACA DE REDE FÍSICA DO HOST
      #NOS DOIS ADAPTADORES, SIMULANDO ASSIM DUAS CONEXÕES INDEPENDENTES NA MESMA REDE.
      Avançado
        Tipo de Placa: Intel PRO/1000 MT Desktop (82540EM)
        Modo Promíscuo: Permitir Tudo (Allow All)

    Adaptador 2 (LAN)
      (ON) Habilitar Placa de Rede: (Habilitar)
      Conectado a: Placa em modo Bridge
      Nome: Intel(R) Ethernet Connection (Placa de Rede On-Board)
      #OBSERVAÇÃO IMPORTANTE: RECOMENDA-SE UTILIZAR A MESMA PLACA DE REDE FÍSICA DO HOST
      #NOS DOIS ADAPTADORES, SIMULANDO ASSIM DUAS CONEXÕES INDEPENDENTES NA MESMA REDE.
      Avançado
        Tipo de Placa: Intel PRO/1000 MT Desktop (82540EM)
        Modo Promíscuo: Permitir Tudo (Allow All)
<OK>
```

## 03_ Habilitando o Modo Promíscuo nos Adaptadores de Rede via VBoxManage

> **OBSERVAÇÃO IMPORTANTE:** o Modo Promíscuo também pode ser habilitado via linha de comando no Host (fora da Máquina Virtual), sendo útil para automação e Scripts de criação de Laboratório.

```bash
#listando as Máquinas Virtuais cadastradas no Oracle VirtualBOX (executar no Host)
#opção do comando VBoxManage: list vms (List all registered virtual machines)
#mais informações acesse a documentação oficial em: https://www.virtualbox.org/manual/ch08.html
VBoxManage list vms

#habilitando o Modo Promíscuo (Allow-All) nos dois Adaptadores de Rede da Máquina Virtual
#opção do comando VBoxManage: modifyvm --nicpromiscN (Set the promiscuous mode policy of the network card)
#mais informações acesse a documentação oficial em: https://www.virtualbox.org/manual/ch08.html
VBoxManage modifyvm "UbuntuOnPremise" --nicpromisc1 allow-all
VBoxManage modifyvm "UbuntuOnPremise" --nicpromisc2 allow-all

#verificando as configurações de rede aplicadas na Máquina Virtual
#opção do comando VBoxManage: showvminfo (Show information about a particular virtual machine)
#mais informações acesse a documentação oficial em: https://www.virtualbox.org/manual/ch08.html
VBoxManage showvminfo "UbuntuOnPremise" | grep -i "NIC\|Promisc"
```

## 04_ Verificando as duas Interfaces de Rede reconhecidas no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** anote o Endereço **MAC Address** das duas interfaces (exemplo: `enp0s3` e `enp0s8`), esses valores serão utilizados no bloco: __`match: macaddress:`__ do arquivo de configuração do Netplan.

```bash
#verificando os dispositivos PCI de Placa de Rede instalados no Ubuntu Server
#opções do comando lspci: -v (verbose)
#opção do comando grep: -i (ignore-case)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lspci.8.html
sudo lspci -v | grep -i ethernet

#verificando os detalhes das duas Placas de Rede (Nome Lógico e Endereço MAC)
#opção do comando lshw: -class (Only show the given class of hardware)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/lshw.1.html
sudo lshw -class network

#verificando o Nome Lógico e o Endereço MAC de cada Interface de Rede
#opções do comando ip: address (Protocol (IP or IPv6) address on a device)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/ip.8.html
sudo ip address show
```

## 05_ Instalando o módulo do Kernel de Bonding no Ubuntu Server

```bash
#verificando se o módulo de Bonding do Kernel já está carregado no Ubuntu Server
#opção do comando lsmod: (Show the status of modules in the Linux Kernel)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsmod.8.html
sudo lsmod | grep bonding

#carregando manualmente o módulo de Bonding do Kernel no Ubuntu Server
#opção do comando modprobe: (Add and remove modules from the Linux Kernel)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/modprobe.8.html
sudo modprobe bonding

#garantindo que o módulo de Bonding seja carregado automaticamente no Boot do Ubuntu Server
#opção do comando tee: -a (append)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/tee.1.html
echo "bonding" | sudo tee -a /etc/modules-load.d/bonding.conf
```

## 06_ Atualizando o arquivo de configuração do Netplan com Bonding no Ubuntu Server

```bash
#listando o conteúdo do diretório de configuração do Netplan
#opção do comando ls: -l (long listing), -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.html
ls -lh /etc/netplan/

#fazendo o backup do arquivo de configuração original do Netplan
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bkp00

#download do arquivo de configuração do Netplan com Bonding
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/00-installer-config-bond.yaml

#editando o arquivo de configuração do Netplan
sudo vim /etc/netplan/00-installer-config.yaml

#entrando no modo de edição do editor de texto VIM
INSERT
```
```yaml
# Bloco inicial das configurações da Rede no Netplan (BLOCO COM BONDING PARA O VIRTUALBOX)
network:
  version: 2
  ethernets:
    # Primeira Interface Física (Adaptador 1 do VirtualBOX em modo Bridge)
    enp0s3:
      match:
        macaddress: SEU_MAC_ADDRESS_ADAPTADOR_1
      set-name: enp0s3
      dhcp4: false
      dhcp6: false
    # Segunda Interface Física (Adaptador 2 do VirtualBOX em modo Bridge)
    enp0s8:
      match:
        macaddress: SEU_MAC_ADDRESS_ADAPTADOR_2
      set-name: enp0s8
      dhcp4: false
      dhcp6: false
  # Bloco de configuração do Bonding (Agregação/Redundância de Placas de Rede)
  bonds:
    bond0:
      interfaces:
        - enp0s3
        - enp0s8
      addresses:
        - SEU_ENDEREÇO_IPv4/CIDR
        - SEU_ENDEREÇO_IPv6_UNICAST_GLOBAL/CIDR
        - SEU_ENDEREÇO_IPv6_LINK_LOCAL/CIDR
      routes:
        - to: default
          via: SEU_ENDEREÇO_DE_GATEWAY_IPv4
        - to: default
          via: SEU_ENDEREÇO_DE_GATEWAY_IPV6_LINK_LOCAL
      nameservers:
        addresses:
          - 1.1.1.1
          - 1.0.0.1
          - 2606:4700:4700::1111
          - 2606:4700:4700::1001
        search: [seu.domínio]
      # Parâmetros do Bonding (RECOMENDADO PARA VIRTUALBOX: active-backup)
      parameters:
        mode: active-backup
        primary: enp0s3
        mii-monitor-interval: 100
        up-delay: 200
        down-delay: 200
        fail-over-mac-policy: active
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```

## 07_ Aplicando as configurações do Netplan e verificando a Interface bond0

```bash
#fazendo o backup do arquivo de configuração modificado do Netplan
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bkp01

#verificando as configurações do arquivo do Netplan no Ubuntu Server
#opções do comando netplan: --debug (enable debug messages), get (get a settings config netplan)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan --debug get

#validando a sintaxe e gerando os arquivos do backend do Netplan em modo Debug (detalhado)
#opções do comando netplan: --debug (enable debug messages), generate (generate backend specific configuration)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan --debug generate

#testando a configuração com possibilidade de reversão do Netplan em modo Debug (detalhado)
#OBSERVAÇÃO IMPORTANTE: a opção try reverte automaticamente a configuração caso ocorra falha
#opções do comando netplan: --debug (enable debug messages), try (try to apply a new netplan config)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan --debug try

#aplicando as mudanças definitivas do Netplan em modo Debug (detalhado)
#opções do comando netplan: --debug (enable debug messages), apply (apply current netplan config)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan --debug apply

#verificando o status das configurações do Netplan e a Interface bond0 no Ubuntu Server
#opções do comando netplan: status (Query networking state of the running system)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan status

#verificando o Endereço IPv4/IPv6 da Interface Lógica bond0 e das Interfaces Escravas
#opções do comando ip: address (Protocol (IP or IPv6) address on a device)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/ip.8.html
sudo ip address show

#verificando o status detalhado do Bonding (Interface Ativa, Escravas e Modo de Operação)
#opção do comando cat: /proc/net/bonding/bond0 (arquivo virtual do Kernel com o status do Bonding)
#mais informações acesse a documentação oficial em: https://www.kernel.org/doc/Documentation/networking/bonding.txt
sudo cat -n /proc/net/bonding/bond0
```

Entendendo a saída do arquivo: __`/proc/net/bonding/bond0`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| ⚙️ **Bonding Mode** | `fault-tolerance (active-backup)` | Confirma que o modo de operação configurado é o **active-backup**, recomendado para o VirtualBOX. |
| 🔄 **Primary Slave** | `enp0s3 (primary_reselect always)` | Interface definida como Primária, sempre preferida quando estiver disponível. |
| ✅ **Currently Active Slave** | `enp0s3` | Interface física atualmente ativa e responsável pelo tráfego de rede da `bond0`. |
| 📡 **MII Status** | `up` | Indica que o Link físico da interface escrava está ativo e operacional. |
| ⏱️ **MII Polling Interval** | `100` | Intervalo (em milissegundos) de verificação do Link das interfaces escravas. |
| 🆔 **Slave Interface** | `enp0s3`, `enp0s8` | Interfaces físicas que fazem parte do Bonding. |
---

## 08_ Testando a Redundância (Failover) do Bonding no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** para simular a falha de um Link físico no Oracle VirtualBOX, você pode Desabilitar o Adaptador de Rede diretamente na tela: __`Dispositivos > Rede > Desconectar Cabo de Rede`__ da Máquina Virtual em execução, ou utilizar o comando abaixo diretamente no Host.

> **OBSERVAÇÃO IMPORTANTE:** durante o teste de Failover, o campo __`Currently Active Slave`__ do arquivo `/proc/net/bonding/bond0` deve mudar automaticamente de `enp0s3` para `enp0s8`, confirmando que a Redundância do Bonding está funcionando corretamente, mesmo em ambiente virtualizado no Oracle VirtualBOX.


```bash
#simulando a falha de um Link de Rede desconectando o Cabo Virtual do Adaptador (executar no Host)
#opção do comando VBoxManage: controlvm setlinkstateN (Sets the link state)
#mais informações acesse a documentação oficial em: https://www.virtualbox.org/manual/ch08.html
VBoxManage controlvm "UbuntuOnPremise" setlinkstate1 off

#verificando dentro do Ubuntu Server se o Bonding assumiu a interface escrava (enp0s8)
#opção do comando watch: -n (Specify  update  interval), 1 (second)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/watch
sudo watch -n 1 /proc/net/bonding/bond0

#verificando o Endereço IPv4/IPv6 da Interface Lógica bond0 e das Interfaces Escravas
#opções do comando ip: address (Protocol (IP or IPv6) address on a device)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/ip.8.html
sudo ip address show bond0

#reconectando o Cabo Virtual do Adaptador para restaurar a interface Primária (executar no Host)
#opção do comando VBoxManage: controlvm setlinkstateN (Sets the link state)
#mais informações acesse a documentação oficial em: https://www.virtualbox.org/manual/ch08.html
VBoxManage controlvm "UbuntuOnPremise" setlinkstate1 on

#analisando os Log's e mensagens de erro do serviço do Netplan no Ubuntu Server
#opção do comando journalctl: u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u systemd-networkd
```