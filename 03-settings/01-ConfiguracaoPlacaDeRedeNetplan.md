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
Data de atualização: 16/07/2026<br>
Versão: 0.04<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

Conteúdo estudado nessa configuração:<br>
#01_ Instalando os principais software de Rede (Network) no Ubuntu Server<br>
#02_ Verificando as informações do Hardware de Rede (Placa de Rede) no Ubuntu Server<br>
#03_ Verificando as informações de Endereços IPv4 e IPv6 no Ubuntu Server<br>
#04_ Alterando as configurações da Placa de Rede do Ubuntu Server<br>
#05_ Aplicando as configurações do Netplan e verificando as informações de Rede do Ubuntu Server<br>
#06_ Habilitando o suporte ao DNS Over TLS (DoT) e DNSSEC no Ubuntu Server<br>
#07_ Reinicializar o serviço do Systemd Resolved (Resolução de Nomes) no Ubuntu Server<br>
#08_ Verificando as informações da Placa de Rede depois de alterada no Ubuntu Server<br>
#09_ Acessando a máquina virtual do Ubuntu Server remotamente via SSH

| **🌐 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🌍 **IPv4 (Internet Protocol version 4)** | Quarta versão do Protocolo de Internet (IP), responsável pelo endereçamento e roteamento de dispositivos em redes TCP/IP. Utiliza endereços de **32 bits**, como `192.168.0.1`. | Permite identificar dispositivos e encaminhar pacotes de dados entre computadores, servidores, roteadores e demais equipamentos em redes locais (LAN) e na Internet. É o protocolo IP mais difundido atualmente. |
| 🌎 **IPv6 (Internet Protocol version 6)** | Evolução do IPv4, criada para superar a limitação de endereços IP disponíveis. Utiliza endereços de **128 bits**, como `2001:db8::1`. | Fornece um espaço praticamente ilimitado de endereços IP, melhora o desempenho do roteamento, oferece suporte nativo ao **IPsec**, autoconfiguração de endereços (SLAAC) e elimina a necessidade de NAT em muitos cenários. |
| ⚙️ **Netplan** | Ferramenta de configuração de rede utilizada nas versões modernas do Ubuntu. Utiliza arquivos no formato **YAML** para definir interfaces, endereçamento IP, gateways, DNS, VLANs, Bridges, Bonds e outras configurações. | Simplifica a administração da rede no Linux, gerando automaticamente as configurações para os renderizadores **systemd-networkd** ou **NetworkManager**, reduzindo a complexidade da configuração manual. |
| 🔐 **DNSSEC (Domain Name System Security Extensions)** | Conjunto de extensões do protocolo DNS que adiciona autenticação criptográfica às respostas das consultas DNS por meio de assinaturas digitais. | Garante a autenticidade e a integridade das respostas DNS, protegendo contra ataques como **DNS Spoofing**, **DNS Cache Poisoning** e falsificação de registros DNS. |
| 🔒 **DoT (DNS over TLS)** | Protocolo que criptografa consultas e respostas DNS utilizando **TLS (Transport Layer Security)**, o mesmo protocolo empregado pelo HTTPS. | Protege a privacidade das consultas DNS, impedindo que terceiros monitorem ou alterem as requisições durante o tráfego na rede. É amplamente utilizado em ambientes que exigem maior segurança e confidencialidade. |
---

[![Endereço IPv4/IPv6 Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Endereço IPv4/IPv6 Ubuntu Server")

Link da vídeo aula: 

## 01_ Instalando os principais software de Rede (Network) no Ubuntu Server
```bash
#atualizando as lista do Apt do sources.list no Ubuntu Server
#opção do comando apt: update (Resynchronize the package index files from their sources)
sudo apt update

#instalando os pacotes e ferramentas de rede no Ubuntu Server
#opção do comando apt: install (install is followed by one or more package names)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt install bridge-utils net-tools
```

## 02_ Verificando as informações do Hardware de Rede (Placa de Rede) no Ubuntu Server
```bash
#verificando os dispositivos PCI de Placa de Rede instalados no Ubuntu Server
#opções do comando lspci: -v (verbose)
#opção do comando grep: -i (ignore-case)
#opção do comando cat: -n (number line)
#opção do redirecionador | (pipe): Conecta a saída padrão com a entrada padrão de outro comando
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lspci.8.html
sudo lspci -v | grep -i ethernet | cat -n
```

Entendendo a saída do comando: __`lspci`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌐 **Barramento PCI** | `00:03.0` | Endereço do dispositivo no barramento **PCI/PCI Express**, indicando o barramento, dispositivo e função (`Bus:Device.Function`). |
| 🖧 **Classe do Dispositivo** | `Ethernet controller` | Identifica o hardware como uma controladora de rede Ethernet responsável pela comunicação em redes cabeadas. |
| 🏢 **Fabricante** | `Intel Corporation` | Empresa responsável pelo desenvolvimento e fabricação da controladora de rede. |
| 💻 **Modelo** | `82540EM Gigabit Ethernet Controller` | Modelo da interface de rede Ethernet. Trata-se de uma controladora Gigabit amplamente utilizada em ambientes virtuais (como VMware e VirtualBox) e também compatível com diversos servidores e sistemas Linux. |
| 🔄 **Revisão (Revision)** | `rev 02` | Revisão de hardware do dispositivo, utilizada para identificar pequenas alterações ou melhorias implementadas pelo fabricante. |
---

```bash
#verificando os detalhes do hardware de Placa de Rede instalada no Ubuntu Server
#opção do comando lshw: -class (Only show the given class of hardware)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/lshw.1.html
sudo lshw -class network
```

Entendendo a saída do comando: __`lshw`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌐 **Descrição** | `Ethernet interface` | Tipo do dispositivo de rede detectado pelo sistema operacional. |
| 💻 **Modelo** | `82540EM Gigabit Ethernet Controller` | Modelo da controladora de rede Ethernet. |
| 🏢 **Fabricante** | `Intel Corporation` | Fabricante da placa de rede. |
| 🔢 **Physical ID** | `3` | Identificador interno do dispositivo na árvore de hardware do `lshw`. |
| 🚌 **Bus Info** | `pci@0000:00:03.0` | Localização física da interface no barramento PCI. |
| 🔗 **Nome da Interface** | `enp0s3` | Nome lógico da interface de rede no Linux, seguindo o padrão **Predictable Network Interface Names**. |
| 🔄 **Versão** | `02` | Revisão (hardware revision) da placa de rede. |
| 🆔 **Endereço MAC** | `08:00:27:45:05:cd` | Endereço físico (MAC Address) único da interface Ethernet. |
| 🚀 **Velocidade Atual** | `1 Gbit/s` | Velocidade negociada atualmente entre a interface de rede e o equipamento conectado (switch ou roteador). |
| 📈 **Capacidade Máxima** | `1 Gbit/s` | Velocidade máxima suportada pela interface de rede. |
| 📏 **Largura do Barramento** | `32 bits` | Largura do barramento utilizada pela controladora de rede para comunicação com o sistema. |
| ⏱️ **Clock** | `66 MHz` | Frequência de operação do barramento PCI da interface. |
| ⚙️ **Capacidades** | `pm, pcix, bus_master, ethernet, tp, 10/100/1000 Mb/s, autonegotiation` | Recursos suportados pela placa, como gerenciamento de energia (**PM**), **Bus Master**, negociação automática de velocidade (**Auto-Negotiation**) e operação em redes Fast Ethernet e Gigabit Ethernet. |
| 🔧 **Auto-Negociação** | `on` | Indica que a velocidade e o modo duplex são negociados automaticamente com o equipamento remoto. |
| 📢 **Broadcast** | `yes` | A interface aceita e transmite pacotes de broadcast. |
| 🖥️ **Driver** | `e1000` | Driver do kernel responsável pelo funcionamento da placa Intel 82540EM. |
| 🐧 **Versão do Driver** | `7.0.0-27-generic` | Versão do kernel que fornece o driver utilizado pela interface. |
| 🔄 **Duplex** | `full` | Modo de operação **Full Duplex**, permitindo transmissão e recepção simultâneas. |
| 🌍 **Endereço IP** | `172.16.1.157` | Endereço IPv4 atualmente configurado na interface de rede. |
| 🔌 **Status do Link** | `yes` | Indica que a interface possui conexão física ativa com o equipamento remoto. |
| 📡 **Multicast** | `yes` | Suporte ao envio e recebimento de tráfego multicast. |
| 🔗 **Tipo de Conector** | `twisted pair` | Meio físico utilizado: cabo de par trançado (UTP/STP) com conector RJ-45. |
| 🚀 **Velocidade do Link** | `1 Gbit/s` | Velocidade efetiva da conexão estabelecida. |
| ⚡ **IRQ** | `19` | Linha de interrupção (Interrupt Request) utilizada pela placa de rede para comunicação com a CPU. |
| 💾 **Memória** | `f0200000-f021ffff` | Faixa de endereços de memória reservada para o dispositivo PCI. |
| 🔌 **Porta de E/S (I/O Port)** | `d020 (size=8)` | Intervalo de portas de entrada e saída (I/O) utilizado pela interface de rede para comunicação com o sistema operacional. |
---

## 03_ Verificando as informações de Endereços IPv4 e IPv6 no Ubuntu Server
```bash
#verificando as configurações de endereçamento IP da Placa de Rede instalada
#opções do comando ip: address (Protocol (IP or IPv6) address on a device)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/ip.8.html
sudo ip address show
```

Entendendo a saída do comando: __`ip address show`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🔗 **Interface** | `lo` | Interface de loopback utilizada para comunicação interna do próprio sistema operacional. |
| 📌 **Flags** | `LOOPBACK, UP, LOWER_UP` | Indica que a interface é de loopback, está habilitada e operacional. |
| 📦 **MTU** | `65536` | Tamanho máximo do pacote (Maximum Transmission Unit) para a interface de loopback. |
| ⚙️ **Fila (qdisc)** | `noqueue` | Não utiliza fila de transmissão, pois o tráfego permanece no próprio kernel. |
| 📊 **Estado** | `UNKNOWN` | Estado típico da interface de loopback, sempre considerada operacional quando está ativa. |
| 👥 **Grupo** | `default` | Grupo padrão das interfaces de rede. |
| 📥 **Queue Length** | `1000` | Quantidade máxima de pacotes que podem permanecer na fila de transmissão. |
| 🆔 **Endereço MAC** | `00:00:00:00:00:00` | Endereço físico da interface de loopback (valor simbólico). |
| 🌍 **IPv4** | `127.0.0.1/8` | Endereço IPv4 reservado para comunicação local (*localhost*). |
| 🌐 **IPv6** | `::1/128` | Endereço IPv6 reservado para comunicação local (*localhost*). |
| ⏳ **Tempo de Validade** | `forever` | Os endereços IP nunca expiram. |
---

Entendendo a saída do comando: __`ip address show`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🔗 **Interface** | `enp0s3` | Nome da interface de rede seguindo o padrão **Predictable Network Interface Names**.  |
| 📌 **Flags** | `BROADCAST, MULTICAST, UP, LOWER_UP` | Interface habilitada, conectada fisicamente e com suporte a tráfego Broadcast e Multicast. |
| 📦 **MTU** | `1500` | Tamanho máximo do pacote Ethernet transmitido sem fragmentação. |
| ⚙️ **Fila (qdisc)** | `pfifo_fast` | Algoritmo de enfileiramento utilizado pelo kernel para transmissão dos pacotes. |
| 📊 **Estado** | `UP` | Interface ativa e operacional. |
| 👥 **Grupo** | `default` | Grupo padrão das interfaces de rede. |
| 📥 **Queue Length** | `1000` | Número máximo de pacotes na fila de transmissão. |
| 🆔 **Endereço MAC** | `08:00:27:45:05:cd` | Endereço físico (MAC Address) da interface Ethernet. |
| 🏷️ **Nome Alternativo** | `enx0800274505cd` | Nome alternativo da interface baseado no endereço MAC. |
| 🌍 **Endereço IPv4** | `172.16.1.157/24` | Endereço IPv4 atribuído à interface. |
| 🎯 **Broadcast IPv4** | `172.16.1.255` | Endereço de broadcast da rede IPv4. |
| 📍 **Escopo IPv4** | `global` | O endereço IPv4 é válido para comunicação na rede. |
| 🔄 **Tipo de Configuração** | `dynamic` | Endereço IPv4 obtido dinamicamente (normalmente via DHCP). |
| 📈 **Métrica** | `100` | Prioridade da rota associada à interface. Valores menores possuem maior prioridade. |
| ⏳ **Validade IPv4** | `52847 segundos` | Tempo restante de validade da concessão DHCP (*lease*). |
| ⭐ **Tempo Preferencial IPv4** | `52847 segundos` | Tempo durante o qual o endereço é considerado preferencial para novas conexões. |
| 🌐 **IPv6 Global** | `2804:14c:90:8697:a00:27ff:fe45:5cd/64` | Endereço IPv6 global atribuído automaticamente à interface. |
| 🌐 **IPv6 Global (/128)** | `2804:14c:90:8697::79/128` | Endereço IPv6 adicional utilizado pelo sistema. |
| 🔗 **IPv6 Link-Local** | `fe80::a00:27ff:fe45:5cd/64` | Endereço IPv6 válido apenas para comunicação dentro do segmento local da rede. |
| 🔐 **Opções IPv6** | `mngtmpaddr`, `noprefixroute` | Indicam gerenciamento automático de endereços temporários e ausência de rota automática baseada no prefixo. |
| ⏳ **Validade IPv6** | `72826 s / 83118 s / forever` | Tempo de validade dos diferentes endereços IPv6 configurados. |
| ⭐ **Tempo Preferencial IPv6** | `58426 s / 83118 s / forever` | Tempo durante o qual os endereços IPv6 são preferenciais para novas conexões. |
---

```bash
#verificando as configurações de Gateway (route) no Ubuntu Server
#opções do comando ip: route (Routing table entry)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/ip.8.html
sudo ip route show
```

Entendendo a saída do comando: __`ip route show`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌍 **Rota Padrão (Default Gateway)** | `default via 172.16.1.254` | Define a rota padrão utilizada para encaminhar pacotes destinados a redes externas (Internet ou outras redes não presentes na tabela de roteamento). |
| 🚪 **Gateway** | `172.16.1.254` | Endereço IP do roteador (gateway padrão) responsável por encaminhar o tráfego para outras redes. |
| 🔗 **Interface de Saída** | `enp0s3` | Interface de rede utilizada para enviar os pacotes através da rota padrão. |
| ⚙️ **Protocolo da Rota**  | `dhcp` | A rota foi criada automaticamente pelo cliente DHCP. |
| 📍 **Endereço de Origem** | `172.16.1.157` | Endereço IP de origem utilizado pelo sistema ao enviar pacotes por essa rota. |
| 📊 **Métrica** | `100` | Prioridade da rota. Quanto menor o valor, maior a preferência quando existem múltiplas rotas para o mesmo destino. |
---

```bash
#verificando as informações de cache dos Servidores DNS (resolução de nomes)
#opção do comando resolvectl: status (Shows the global and per-link DNS settings currently in effect)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/resolvectl.1.html
sudo resolvectl status
```

Entendendo a saída do comando: __`resolvectl`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌍 **Escopo** | `Global` | Configurações globais do serviço **systemd-resolved**, responsável pela resolução de nomes (DNS) no sistema. |
| 🔄 **LLMNR** | `Desabilitado (-LLMNR)` | O protocolo **Link-Local Multicast Name Resolution** está desativado, evitando resolução de nomes em redes locais via multicast. |
| 📡 **mDNS** | `Desabilitado (-mDNS)` | O protocolo **Multicast DNS (Bonjour/Avahi)** está desabilitado, impedindo resolução automática de nomes em redes locais. |
| 🔒 **DNS over TLS (DoT)** | `Desabilitado (-DNSOverTLS)` | As consultas DNS são realizadas em texto puro (porta 53), sem criptografia TLS. |
| 🛡️ **DNSSEC** | `no/unsupported` | A validação criptográfica do DNSSEC não está habilitada ou não é suportada pelo servidor DNS configurado. |
| 📄 **Modo do resolv.conf** | `stub` | O arquivo `/etc/resolv.conf` aponta para o resolvedor local (`127.0.0.53`), gerenciado pelo **systemd-resolved**. |
---

| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌐 **Interface** | `enp0s3` | Interface de rede utilizada para resolução de nomes DNS. |
| 🔍 **Escopo Atual** | `DNS` | A interface está sendo utilizada para consultas DNS. |
| 🛣️ **Rota Padrão** | `+DefaultRoute` | A interface é utilizada como rota padrão para acesso à rede e à Internet. |
| 🔄 **LLMNR** | `Desabilitado (-LLMNR)` | A resolução de nomes via LLMNR está desativada nesta interface. |
| 📡 **mDNS** | `Desabilitado (-mDNS)` | A resolução de nomes via Multicast DNS está desabilitada. |
| 🔒 **DNS over TLS (DoT)** | `Desabilitado (-DNSOverTLS)` | A interface não utiliza DNS criptografado via TLS. |
| 🛡️ **DNSSEC** | `no/unsupported` | O servidor DNS informado não oferece validação DNSSEC ou o recurso está desativado. |
| 🌍 **Servidor DNS Atual** | `172.16.1.254` | Servidor DNS atualmente utilizado pelo sistema para resolução de nomes. |
| 📚 **Servidores DNS Configurados** | `172.16.1.254`<br>`2804:14c:90:8697::1` | Lista de servidores DNS configurados para a interface (IPv4 e IPv6). |
| 🚪 **Rota Padrão** | `yes` | Confirma que esta interface fornece a rota padrão para comunicação externa. |
---

```bash
#verificando as informações de Leases (Alugueis) do DHCP Client no Ubuntu Server
#opção do comando cat: -n (number line), * (asterisco) todos os arquivos
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
sudo cat -n /run/systemd/netif/leases/*
```

Entendendo a saída do arquivo: __`/run/systemd/netif/leases/*`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌐 **ADDRESS** | `172.16.1.157` | Endereço IPv4 atribuído ao cliente pelo servidor DHCP. |
| 🛡️ **NETMASK** | `255.255.255.0` | Máscara de sub-rede utilizada pela interface, correspondente ao prefixo `/24`. |
| 🚪 **ROUTER** | `172.16.1.254` | Gateway padrão (Default Gateway) utilizado para comunicação com outras redes e com a Internet. |
| 🖥️ **SERVER_ADDRESS** | `172.16.1.254` | Endereço IP do servidor DHCP responsável por fornecer a concessão (*lease*). |
| 📡 **NEXT_SERVER** | `172.16.1.254` | Endereço do próximo servidor utilizado em serviços de inicialização via rede (PXE/TFTP). Em ambientes comuns, normalmente corresponde ao próprio servidor DHCP. |
| ⏳ **T1 (Renew Time)** | `11h 4min 41s` | Tempo após o qual o cliente DHCP tenta renovar a concessão diretamente com o servidor DHCP. Geralmente corresponde a **50%** do tempo total da concessão. |
| 🔄 **T2 (Rebind Time)** | `20h 4min 41s` | Tempo após o qual o cliente tenta renovar a concessão com qualquer servidor DHCP disponível, caso o servidor original não responda. Geralmente corresponde a **87,5%** do tempo da concessão. |
| 📅 **LIFETIME** | `1d` | Tempo total de validade (*Lease Time*) da concessão DHCP antes de expirar. |
| 🌍 **DNS** | `172.16.1.254` | Servidor DNS fornecido pelo servidor DHCP para resolução de nomes. |
| 🏢 **DOMAINNAME** | `apto.intra` | Nome do domínio de pesquisa (*Search Domain*) distribuído pelo servidor DHCP. Permite resolver nomes curtos automaticamente, por exemplo `srv01` → `srv01.apto.intra`. |
| 💻 **HOSTNAME** | `srvvaamonde` | Nome do host informado pelo cliente DHCP ao servidor durante a solicitação do endereço IP. |
| 🆔 **CLIENTID** | `ffe2343f3e00020000ab11343a06a2a23df89c` | Identificador exclusivo do cliente DHCP (**DHCP Client Identifier**), utilizado pelo servidor para reconhecer o dispositivo e manter reservas ou concessões consistentes. |
---

```bash
#verificando as informações de Status do Netplan no Ubuntu Server
#opção do comando netplan: status (Query networking state of the running system)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan status
```

Entendendo a saída do comando: __`sudo netplan status`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌐 **Estado da Rede** | `online` | Indica que o sistema possui conectividade de rede ativa. |
| 🌍 **Resolvedor DNS Local** | `127.0.0.53 (stub)` | Endereço do resolvedor local gerenciado pelo **systemd-resolved**, responsável por encaminhar as consultas DNS aos servidores configurados. |
| 🔎 **Domínio de Pesquisa (DNS Search)** | `.` | Não há domínio de pesquisa configurado; apenas nomes de domínio totalmente qualificados (FQDN) são resolvidos automaticamente. |
---

| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🔗 **Interface** | `lo` | Interface de loopback utilizada para comunicação interna do sistema operacional. |
| 📡 **Tipo** | `ethernet` | Tipo lógico da interface apresentada pelo Netplan. |
| 📊 **Estado** | `UNKNOWN/UP` | Interface ativa; o estado `UNKNOWN` é esperado para interfaces de loopback. |
| ⚙️ **Gerenciamento** | `unmanaged` | Interface não gerenciada pelo Netplan ou pelo `systemd-networkd`. |
| 🆔 **Endereço MAC** | `00:00:00:00:00:00` | Endereço físico simbólico da interface de loopback. |
| 🌍 **IPv4** | `127.0.0.1/8` | Endereço IPv4 reservado para comunicação local (*localhost*). |
| 🌐 **IPv6** | `::1/128` | Endereço IPv6 reservado para comunicação local (*localhost*). |
---

| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🔗 **Interface** | `enp0s3` | Interface de rede física seguindo o padrão **Predictable Network Interface Names**. |
| 📡 **Tipo** | `ethernet` | Interface de rede Ethernet. |
| 📊 **Estado** | `UP` | Interface ativa e operacional. |
| ⚙️ **Gerenciador** | `systemd-networkd` | Serviço responsável por aplicar a configuração definida pelo Netplan. |
| 🆔 **Endereço MAC** | `08:00:27:45:05:cd` | Endereço físico (MAC Address) da interface. |
| 🏢 **Fabricante** | `Intel Corporation` | Fabricante da controladora de rede. |
| 🌍 **IPv4** | `172.16.1.157/24` | Endereço IPv4 obtido dinamicamente via DHCP. |
| 🌐 **IPv6 Global (RA)**  | `2804:14c:90:8697:a00:27ff:fe45:5cd/64` | Endereço IPv6 global obtido por **Router Advertisement (SLAAC)**. |
| 🌐 **IPv6 Global (DHCPv6)** | `2804:14c:90:8697::79/128` | Endereço IPv6 adicional obtido via DHCPv6. |
| 🔗 **IPv6 Link-Local** | `fe80::a00:27ff:fe45:5cd/64` | Endereço IPv6 utilizado apenas no segmento local da rede. |
| 🌍 **Servidor DNS IPv4** | `172.16.1.254` | Servidor DNS principal configurado para a interface. |
| 🌐 **Servidor DNS IPv6** | `2804:14c:90:8697::1` | Servidor DNS secundário utilizando IPv6. |
| 🌍 **Rota Padrão IPv4** | `default via 172.16.1.254` | Gateway padrão utilizado para acessar outras redes e a Internet. |
| 🖧 **Rede Local IPv4** | `172.16.1.0/24` | Rede diretamente conectada à interface `enp0s3`. |
| 🚪 **Rota para o Gateway** | `172.16.1.254` | Rota específica para comunicação com o gateway padrão. |
| 🌐 **Rede IPv6 Global** | `2804:14c:90:8697::/64` | Prefixo IPv6 anunciado pelo roteador (Router Advertisement).  |
| 🔗 **Rede Link-Local IPv6** | `fe80::/64` | Rede IPv6 utilizada para comunicação local entre dispositivos do mesmo segmento. |
| 🌍 **Gateway IPv6** | `default via fe80::e638:83ff:fe36:c58e` | Gateway padrão IPv6 informado pelo roteador via Router Advertisement (RA). |
---

## 04_ Alterando as configurações da Placa de Rede do Ubuntu Server

> **OBSERVAÇÃO:** o nome do arquivo de configuração da placa de rede pode mudar dependendo da versão do Ubuntu Server. O arquivo: __`/etc/netplan/00-installer-config.yaml`__ e o Padrão do Ubuntu Server 26.04.x LTS, no Ubuntu Server 24.04.x LTS tem o nome: __`/etc/netplan/50-cloud-init.yaml`__, sempre digitar o comando: __`ls -lh /etc/netplan`__ antes de editar o arquivo Netplan.

> **OBSERVAÇÃO IMPORTANTE:** o arquivo de configuração do Netplan e baseado no formato de *Serialização de Dados Legíveis YAML (Yet Another Markup Language)* utilizado na linguagem de programação Python por exemplo, muito cuidado com o uso de __`Espaços e Tabulação`__ e principalmente sua **Indentação**.

```bash
#listando o conteúdo do diretório de configuração do Netplan
#opção do comando ls: -l (long listing), -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.html
ls -lh /etc/netplan/

#fazendo o backup do arquivo de configuração original do Netplan
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.old

#download do arquivo de configuração do Netplan
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/00-installer-config.yaml

#editando o arquivo de configuração do Netplan
sudo vim /etc/netplan/00-installer-config.yaml

#entrando no modo de edição do editor de texto VIM
INSERT
```
```yaml
# Bloco inicial das configurações da Rede no Netplan
network:
  #
  # Início da configuração do Netplan usando a versão 2 (mais atual)
  version: 2
  #
  # Bloco de configuração das Interfaces Ethernet (físicas ou virtuais)
  ethernets:
    #
    # Configuração da Interface Física (Nome Lógico visto no comando: lshw -class network)
    enp0s3:
      #
      # Identificando a Interface de Rede Física pelo Endereço MAC Address 
      match:
        macaddress: 08:00:27:45:05:cd
      #
      # Definindo o Nome Lógico da Interface de Rede
      set-name: enp0s3
      #
      # Desabilitando o suporte ao DHCP Client IPv4 na interface física
      dhcp4: false
      #
      # Desabilitando o suporte ao DHCP Client IPv6 na interface física
      dhcp6: false
      #
      # Desabilitando o suporte da configuração automática do IPv6 na interface física
      link-local: []
      #
      # Desabilitando a configuração automática via Router Advertisement (IPv6)
      accept-ra: false
      #
      # Configuração do Endereço IPv4/CIDR e IPv6/CIDR para o seu cenário utilizando
      # endereço IPv6 Unicast Global e Link Local
      # OBSERVAÇÃO IMPORTANTE: configuração do Endereço IPv4 e IPv6 separados por Traço
      addresses:
        - SEU_ENDEREÇO_IPv4/CIDR
        - SEU_ENDEREÇO_IPv6_UNICAST_GLOBAL/CIDR
        - SEU_ENDEREÇO_IPv6_LINK_LOCAL/CIDR
      #
      # Configuração do Gateway Padrão IPv4/IPv6 (Rota Padrão) para o seu cenário
      routes:
        # Configuração da Rota Padrão IPv4 (cuidado com o traço antes da opção: to)
        - to: default
          # Configuração do endereço IPv4 do Gateway para o seu cenário
          via: SEU_ENDEREÇO_DE_GATEWAY_IPv4
          #
        # Configuração da Rota Padrão IPv6 (cuidado com o traço antes da opção: to)
        - to: default
          # Configuração do endereço IPv6 do Gateway para o seu cenário
          via: SEU_ENDEREÇO_DE_GATEWAY_IPV6_LINK_LOCAL
          #
      # Configuração dos servidores de DNS Server Preferencial e Alternativo
      nameservers:
        # Configuração dos Endereços IPv4 e IPv6 de DNS para o seu cenário com nível de
        # segurança contra Malware e Adult Content utilizando os DNS da CloudFlare
        addresses:
          - 1.1.1.1
          - 1.0.0.1
          - 2606:4700:4700::1111
          - 2606:4700:4700::1001
        # Configuração da pesquisa de domínio para o seu cenário
        # OBSERVAÇÃO: configuração da pesquisa de Domínio dentro de Colchetes
        search: [seu.domínio]
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```

## 05_ Aplicando as configurações do Netplan e verificando as informações de Rede do Ubuntu Server
```bash
#fazendo o backup do arquivo de configuração modificado do Netplan 
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bkp

#listando o conteúdo do diretório do Netplan com os novos arquivos
#opções do comando ls: -l (long listing), -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.htm
ls -lh /etc/netplan/

#verificando as configurações do arquivo do Netplan no Ubuntu Server
#opções do comando netplan: --debug (enable debug messages), get (get a settings config netplan)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan --debug get

#validando a sintaxe e gerando os arquivos do backend do Netplan em modo Debug (detalhado)
#opções do comando netplan: --debug (enable debug messages), generate (generate backend specific configuration)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan --debug generate

#testando a configuração com possibilidade de reversão o Netplan em modo Debug (detalhado)
#OBSERVAÇÃO IMPORTANTE: você pode utilizar a opção: try que caso aconteça alguma falha na 
#hora de configurar a placa de rede ele reverte a configuração inicial
#opções do comando netplan: --debug (enable debug messages), try (try to apply a new netplan config)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan --debug try

#aplicando as mudanças definitivas do Netplan em modo Debug (detalhado)
#opções do comando netplan: --debug (enable debug messages), apply (apply current netplan config)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan --debug apply

#verificando o status das configurações do Netplan no Ubuntu Server
#opções do comando netplan: status (Query networking state of the running system)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan status

#verificando o arquivo de configuração do Systemd do Netplan no Ubuntu Server
#opção do comando cat: -n (number line), * (asterisco) todos os arquivos
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
sudo cat -n /run/systemd/network/*.network

#verificar o status do serviço do Netplan no Ubuntu Server
#opção do comando systemctl: status (Show terse runtime status information about one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.htm
sudo systemctl status netplan-configure

#analisando os Log's e mensagens de erro do serviço do Netplan no Ubuntu Server
#opção do comando journalctl: u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u netplan-configure
```

## 06_ Habilitando o suporte ao DNS Over TLS (DoT) e DNSSEC no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** CUIDADO!!!!!! Nem todos os servidores Externos tem suporte ao __`DNSSEC ou DoT`__, segue lista dos principais servidores com suporte ao **DNSSEC e DoT** recomentado pelo Ubuntu Server no arquivo: __`/etc/systemd/resolved.conf`__

| **Servidor DNS** | **Endereços IPv4** | **Endereços IPv6** |
|------------------| -------------------| -------------------|
| **Google** | *8.8.8.8 e 8.8.4.4* | *2001:4860:4860::8888 e 2001:4860:4860::8844* |
| **Quad9** | *9.9.9.9 e 149.112.112.112* | *2620:fe::fe e 2620:fe::9* |
| **CloudFlare** | *1.1.1.1 e 1.0.0.1* | *2606:4700:4700::1111 e 2606:4700:4700::1001* |
---

```bash
#fazendo o backup do arquivo de configuração original do Resolved
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/systemd/resolved.conf /etc/systemd/resolved.conf.old

#editando o arquivo de configuração do Systemd Resolved no Ubuntu Server (NÃO COMENTADO NO VÍDEO)
sudo vim /etc/systemd/resolved.conf

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#descomentar e alterar o valor da variável Domains na linha 32 para: Domains=~.
#configuração domínio raiz (.) como domínio de roteamento ~ (routing domain)
#~. = Utilize este servidor DNS para resolver qualquer domínio da Internet
Domains=~.
 
#descomentar e alterar o valor da variável DNSSEC na linha 33 para: DNSSEC=yes
#habilita a validação do DNSSEC (Domain Name System Security Extensions)
DNSSEC=yes

#descomentar e alterar o valor da variável DNSOverTLS na linha 34 para: DNSOverTLS=yes
#habilita o DNS over TLS (DoT), As consultas DNS passam a ser criptografadas utilizando TLS (porta TCP 853)
DNSOverTLS=yes

#descomentar e alterar o valor da variável Cache na linha 37 para: Cache=yes
#habilita o cache local de respostas DNS
Cache=yes
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```

## 07_ Reinicializar o serviço do Systemd Resolved (Resolução de Nomes) no Ubuntu Server
```bash
#reiniciar o serviço do Resolved no Ubuntu Server
#opção do comando systemctl: restart (Stop and then start one or more units specified on the command line)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl restart systemd-resolved

#verificar o status do serviço do Resolved no Ubuntu Server
#opção do comando systemctl: status (Show terse runtime status information about one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.htm
sudo systemctl status systemd-resolved

#analisando os Log's e mensagens de erro do serviço do Ubuntu Pro
#opção do comando journalctl: u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u systemd-resolved
```

## 08_ Verificando as informações da Placa de Rede depois de alterada no Ubuntu Server
```bash
#verificando o endereço IPv4 e IPv6 da Interface de Rede
#opções do comando ip: address (Protocol (IP or IPv6) address on a device)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/ip.8.html
sudo ip address show

#verificando as configurações de Gateway (route) IPv4 e IPv6 no Ubuntu Server
#opções do comando ip: -4 (use IPv4), -6 (use IPv6) route (Routing table entry)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/ip.8.html
sudo ip -4 route show
sudo ip -6 route show

#verificando as informações dos Servidores DNS (resolução de nomes) IPv4 e IPv6 no Ubuntu Server
#opção do comando resolvectl: status (Shows the global and per-link DNS settings currently in effect)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/resolvectl.1.html
sudo resolvectl status

#verificando as informações de Estatísticas dos Servidores DNS (resolução de nomes) IPv4 e IPv6 no Ubuntu Server
#opção do comando resolvectl: statistics (Shows general resolver statistics, including information whether DNSSEC)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/resolvectl.1.html
sudo resolvectl statistics

#verificando as informações de Cache dos Servidores DNS (resolução de nomes) IPv4 e IPv6 no Ubuntu Server
#opção do comando resolvectl: show-cache (Show current cache content, per scope)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/resolvectl.1.html
sudo resolvectl show-cache

#monitorando as consultas dos Servidores DNS (resolução de nomes) IPv4 e IPv6 no Ubuntu Server
#opção do comando resolvectl: monitor (Show a continuous stream of local client resolution queries and their responses)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/resolvectl.1.html
sudo resolvectl monitor

#verificando o status das configurações do Netplan IPv4 e IPv6 no Ubuntu Server
#opções do comando netplan: status (Query networking state of the running system)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man5/netplan.5.html
sudo netplan status

#testando a conexão com a Internet e Resolução de nomes de DNS IPv4 e IPv6 no Ubuntu Server
#opções do comando ping: -4 (use IPv4), -6 (use IPv6) -c 5 (Stop after sending count ECHO_REQUEST packets)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping
ping -4 -c 5 8.8.8.8
ping -6 -c 5 2001:4860:4860::8888
ping -4 -c 5 google.com
ping -6 -c 5 google.com
```

## 09_ Acessando a máquina virtual do Ubuntu Server remotamente via SSH

> **OBSERVAÇÃO:** após a configuração da Placa de Rede do Ubuntu Server você já pode acessar remotamente o seu servidor utilizando o __`Protocolo SSH`__ nos clientes Linux ou Microsoft Windows para dá continuidade nas configurações do servidor, ficando mais fácil administrar e configurar os principais serviços de rede de forma remota.

> **DICA:** Você pode usar os softwares: __`Bash/Shell`__ (GNU/Linux), __`Powershell`__ (Microsoft Windows), __`PuTTY`__ (GNU/Linux ou Microsoft Windows) e __`Git Bash`__ (Microsoft Windows - RECOMENDADO SE ESTIVER USANDO O WINDOWS).

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

```bash
#testando a conexão com o Ubuntu Server (alterar o Endereço IPv6 para o seu cenário)
ping SEU_ENDEREÇO_IPV6_UBUNTU_SERVER

#acessando remotamente o Ubuntu Server (alterar o Usuário e Endereço IPv6 para o seu cenário)
ssh seu_usuário@SEU_ENDEREÇO_IPV6_UBUNTU_SERVER

#confirmando a troca das chaves públicas e do fingerprint do SSH (alterar sua senha para o seu cenário)
The authenticity of host 'SEU_ENDEREÇO_IPV6_UBUNTU_SERVER' can't be established.
ECDSA key fingerprint is SHA256:5yoVsKHMrn3FP/LBW1fyPTtVlt3og9jmyXPPkki/BY0.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes <Enter>

seu_usuário@SEU_ENDEREÇO_IPV6's password: sua_senha <Enter> (Por motivo de segurança a senha não aparece no Terminal)

seu_usuário@srvseunome:~$ (Acesso ao Terminal Remoto (Bash/Shell) via SSH)
```