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
Data de atualização: 20/07/2026<br>
Versão: 0.02<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

Conteúdo estudado nessa configuração:<br>
#01_ Adicionando Hard Disk na Máquina Virtual UbuntuOnPremise no Oracle VirtualBOX<br>
#02_ Instalando os principais software de Hard Disk no Ubuntu Server<br>
#03_ Verificando as informações da Controladora de Hard Disk do Ubuntu Server<br>
#04_ Verificando as informações de Hard Disk e Partições do Ubuntu Server<br>
#05_ Verificando todas as informações detalhadas de Hard Disk e Partições do Ubuntu Server<br>
#06_ Verificando o Desempenho (Performance) dos Discos no Ubuntu Server<br>
#07_ Verificando a Saúde (SMART) dos Discos no Ubuntu Server<br>
#08_ Verificando o Espaço em Disco Utilizado no Ubuntu Server<br>

[![Hard Disk Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Hard Disk Ubuntu Server")

Link da vídeo aula: 

| **💾 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🔌 **SATA (Serial ATA)** | Interface de conexão entre a controladora e os dispositivos de armazenamento. | Permite a comunicação entre o sistema operacional e discos rígidos/SSDs. |
| ⚙️ **AHCI (Advanced Host Controller Interface)** | Especificação de interface para controladoras SATA. | Habilita recursos como NCQ (Native Command Queuing) e Hot Plug. |
| 🗂️ **GPT (GUID Partition Table)** | Tabela de partições moderna, sucessora da MBR. | Suporta discos maiores que 2TB e até 128 partições primárias por padrão. |
| 🆔 **UUID (Universally Unique Identifier)** | Identificador único de 128 bits atribuído a sistemas de arquivos e partições. | Garante montagem correta e persistente das partições, independente da ordem de detecção (/dev/sdX pode mudar, o UUID não). |
| 📊 **S.M.A.R.T. (Self-Monitoring, Analysis and Reporting Technology)** | Sistema de monitoramento embutido em HDs/SSDs modernos. | Detecta falhas de hardware antes que causem perda de dados. |
| 🧵 **I/O Scheduler** | Algoritmo do kernel que organiza as operações de leitura/escrita em disco. | Otimiza desempenho conforme o tipo de mídia (HDD ou SSD/NVMe). |
---

## 01_ Adicionando Hard Disk na Máquina Virtual UbuntuOnPremise no Oracle VirtualBOX

```bash
01) Selecionar a Máquina Virtual: UbuntuOnPremise
<Configurações>
    Expert

02) Armazenamento
    Dispositivos
      Controladora: SATA
        Adicionar Hard Disk
          Criar
            Localização e Tamanho do Arquivo de Disco Virtual
              Localização: raid-01.vdi
              Tamanho: 50,00 GB
          <Finalizar>
            Localização e Tamanho do Arquivo de Disco Virtual
              Localização: raid-02.vdi
              Tamanho: 50,00 GB
           <Finalizar>
        raid-01.vdi <Escolher>
        raid-02.vdi <Escolher>
    <OK>
03) Selecionar a Máquina Virtual: UbuntuOnPremise: 
<Iniciar>
```

## 02_ Instalando os principais software de Hard Disk no Ubuntu Server
```bash
#atualizando as lista do Apt do sources.list no Ubuntu Server
#opção do comando apt: update (Resynchronize the package index files from their sources)
sudo apt update

#instalando os pacotes e ferramentas de hard disk no Ubuntu Server
#opção do comando apt: install (install is followed by one or more package names)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt install smartmontools hdparm sysstat
```

## 03_ Verificando as informações da Controladora de Hard Disk do Ubuntu Server
```bash
#verificando os dispositivos PCI de controladora de armazenamento (SATA/SCSI/NVMe)
#opção do comando lspci: -v (verbose)
#opção do comando grep: -i (Ignore case distinctions in patterns and input data), -A5 (Print NUM
#lines of trailing context after matching lines)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lspci.8.html
sudo lspci -v | grep -i -A5 "SATA\|SCSI\|NVM"
```

Entendendo a saída do comando: __`sudo lspci -v | grep -i -A5 "SATA\|SCSI\|NVM"`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🖥️ **Dispositivo PCI** | `00:0d.0` | Endereço do controlador no barramento **PCI (Bus:Device.Function)**. Identifica fisicamente o dispositivo na placa-mãe ou na máquina virtual. |
| 💾 **Tipo de Controladora** | `SATA controller` | Tipo de dispositivo detectado. Trata-se de uma controladora **SATA (Serial ATA)** responsável pela comunicação entre o sistema operacional e os dispositivos de armazenamento (HDs, SSDs e unidades ópticas). |
| 🏭 **Fabricante** | `Intel Corporation` | Fabricante da controladora SATA. Neste caso, trata-se de um chipset Intel amplamente utilizado em ambientes físicos e virtualizados. |
| 🔧 **Modelo** | `82801HM/HEM (ICH8M/ICH8M-E)` | Modelo da controladora SATA pertencente à família de chipsets **Intel ICH8M**, frequentemente utilizada em máquinas virtuais como o Oracle VirtualBox. |
| ⚙️ **Modo de Operação** | `AHCI mode` | A controladora está operando em modo **AHCI (Advanced Host Controller Interface)**, permitindo recursos modernos como **NCQ (Native Command Queuing)** e **Hot Plug**. |
| 🔢 **Revisão do Hardware** | `rev 02` | Revisão do hardware da controladora SATA. Utilizada para identificação de versões do dispositivo. |
| 📚 **Interface de Programação** | `prog-if 01 [AHCI 1.0]` | Indica que a controladora segue a especificação **AHCI 1.0**, compatível com drivers modernos do Linux. |
| 🚩 **Flags** | `bus master, fast devsel, latency 64, IRQ 21` | Recursos disponíveis na controladora: acesso direto à memória (**Bus Master**), seleção rápida do dispositivo (**Fast DevSel**), latência PCI configurada em 64 ciclos e utilização da interrupção **IRQ 21**. |
| 🔌 **Portas de I/O** | `d060`, `d068`, `d070`, `d078` | Endereços de entrada e saída (I/O Ports) utilizados pela controladora SATA para comunicação com o sistema operacional. |
| 📦 **Capacidade** | `SATA HBA v1.0` | A controladora implementa a especificação **Host Bus Adapter (HBA)** para dispositivos SATA versão 1.0. |
| 🐧 **Driver em Uso** | `ahci` | Driver atualmente carregado pelo kernel Linux para controlar a interface SATA. É o driver padrão para controladoras AHCI. |
| 📚 **Módulo do Kernel** | `ahci` | Módulo do kernel responsável por fornecer suporte ao padrão AHCI durante a inicialização do sistema. |
---

```bash
#verificando os detalhes de controladora de hard disk
#opção do comando lshw: -class (Only show the given class of hardware)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/lshw.1.html
sudo lshw -class storage
```

Entendendo a saída do comando: __`sudo lshw -class storage`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🖥️ **Classe do Dispositivo** | `storage` | Classe de hardware responsável pelo gerenciamento dos dispositivos de armazenamento do sistema. |
| 💾 **Tipo de Controladora** | `SATA controller` | Controladora responsável pela comunicação entre o sistema operacional e dispositivos de armazenamento conectados à interface SATA. |
| 🔧 **Modelo** | `82801HM/HEM (ICH8M/ICH8M-E) SATA Controller [AHCI mode]` | Modelo da controladora SATA Intel operando em modo **AHCI (Advanced Host Controller Interface)**, proporcionando melhor desempenho e suporte a recursos modernos. |
| 🏭 **Fabricante** | `Intel Corporation` | Fabricante da controladora SATA detectada pelo sistema operacional. |
| 🆔 **Physical ID** | `d` | Identificador interno utilizado pelo `lshw` para representar o dispositivo na árvore de hardware. |
| 🚌 **Bus Info** | `pci@0000:00:0d.0` | Endereço completo do dispositivo no barramento **PCI (Bus:Device.Function)**. |
| 🔗 **Logical Name** | `scsi2` | Primeiro barramento lógico SCSI criado pelo driver AHCI para comunicação com dispositivos SATA. |
| 🔗 **Logical Name** | `scsi3` | Segundo barramento lógico SCSI disponibilizado pela controladora AHCI. |
| 🔗 **Logical Name** | `scsi4` | Terceiro barramento lógico SCSI disponibilizado pela controladora AHCI. Cada porta SATA é apresentada ao Linux como um barramento SCSI. |
| 🔢 **Versão** | `02` | Revisão do hardware da controladora SATA. |
| 📐 **Largura do Barramento** | `32 bits` | Largura do barramento PCI utilizada pela controladora para transferência de dados. |
| ⏱️ **Clock** | `33 MHz` | Frequência de operação do barramento PCI utilizado pela controladora. |
| ⚙️ **Capacidades** | `sata pm ahci_1.0 bus_master cap_list emulated` | Recursos suportados pela controladora: **SATA**, **Power Management (PM)**, **AHCI 1.0**, **Bus Master DMA**, lista de capacidades PCI e dispositivo **emulado** (VirtualBox). |
| 🔧 **Driver** | `ahci` | Driver do kernel Linux responsável pelo gerenciamento da controladora SATA em modo AHCI. |
| ⚡ **Latência** | `64` | Valor da latência configurada para acesso ao barramento PCI. |
| 🚨 **IRQ** | `21` | Linha de interrupção utilizada pela controladora SATA para comunicação com o processador. |
| 🔌 **Portas de I/O** | `d060`, `d068`, `d070`, `d078`, `d080` | Endereços de entrada e saída (I/O Ports) utilizados pelo driver AHCI para acessar os registradores da controladora SATA. |
| 🧠 **Memória Mapeada** | `f0806000-f0807fff` | Região de memória utilizada pelo kernel para acessar diretamente os registradores da controladora através de **Memory Mapped I/O (MMIO)**. |
---

## 04_ Verificando as informações de Hard Disk e Partições do Ubuntu Server
```bash
#verificando os detalhes de armazenamento de hard disk
#opção do comando lshw: -class (Only show the given class of hardware)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/lshw.1.html
sudo lshw -class disk
```

Entendendo a saída do comando: __`sudo lshw -class disk`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💾 **Quantidade de Discos** | `3` | O sistema possui três discos rígidos virtuais reconhecidos pelo kernel Linux. |
| 🖥️ **Tipo de Dispositivo** | `ATA Disk` | Todos os discos são apresentados ao sistema como dispositivos ATA conectados à controladora SATA (AHCI). |
| 📦 **Modelo** | `VBOX HARDDISK` | Modelo padrão de disco virtual criado pelo Oracle VirtualBox. |
| 🏭 **Fabricante** | `VirtualBox` | Fabricante do hardware virtualizado. Indica que os discos são dispositivos virtuais. |
| 📂 **Disco 1 (Sistema)** | `/dev/sda` | Primeiro disco do sistema, utilizado para instalação do Ubuntu Server e armazenamento do sistema operacional. |
| 📂 **Disco 2 (Dados)** | `/dev/sdb` | Segundo disco disponível para criação de partições, LVM, RAID ou armazenamento de dados. |
| 📂 **Disco 3 (Dados)** | `/dev/sdc` | Terceiro disco disponível para implementação de RAID, LVM ou expansão do armazenamento. |
| 🚌 **Barramento Disco 1** | `scsi@2:0.0.0` | Endereço lógico do disco `/dev/sda` apresentado pela camada SCSI do kernel Linux. |
| 🚌 **Barramento Disco 2** | `scsi@3:0.0.0` | Endereço lógico do disco `/dev/sdb`. |
| 🚌 **Barramento Disco 3** | `scsi@4:0.0.0` | Endereço lógico do disco `/dev/sdc`. |
| 🔢 **Versão** | `1.0` | Revisão do hardware virtual dos três discos. |
| 🆔 **Serial Disco 1** | `VB2dc3e2f7-0b8c5ac1` | Número de série exclusivo do disco virtual `/dev/sda`. |
| 🆔 **Serial Disco 2** | `VB80443986-ef293c39` | Número de série exclusivo do disco virtual `/dev/sdb`. |
| 🆔 **Serial Disco 3** | `VB58ac26eb-8805b6b3` | Número de série exclusivo do disco virtual `/dev/sdc`. |
| 📏 **Capacidade Disco 1** | `100 GiB (107 GB)` | Disco principal utilizado pelo sistema operacional Ubuntu Server. |
| 📏 **Capacidade Disco 2** | `50 GiB (53 GB)` | Disco adicional destinado a laboratórios de armazenamento, LVM ou RAID. |
| 📏 **Capacidade Disco 3** | `50 GiB (53 GB)` | Disco adicional destinado a laboratórios de armazenamento, LVM ou RAID. |
| 🗂️ **Tabela de Partições** | `GPT (apenas /dev/sda)` | O disco `/dev/sda` utiliza tabela de partições **GUID Partition Table (GPT)**. Os discos `/dev/sdb` e `/dev/sdc` ainda não possuem particionamento. |
| 📐 **Tamanho do Setor Lógico** | `512 bytes` | Todos os discos utilizam setores lógicos de 512 bytes. |
| 📐 **Tamanho do Setor Físico** | `512 bytes` | Todos os discos utilizam setores físicos de 512 bytes. |
| 📚 **ANSI Version** | `5` | Versão do padrão ANSI/SCSI suportada pelos dispositivos virtuais. |
---

```bash
#verificando o UUID e o tipo de sistema de arquivos de cada dispositivo
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/blkid.8.html
sudo blkid
```

Entendendo a saída do comando: __`sudo blkid`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Dispositivo** | `/dev/sda1` | Primeira partição do disco principal. Normalmente utilizada para a partição de **BIOS Boot** em sistemas com tabela GPT e inicialização em modo Legacy BIOS. Possui apenas **PARTUUID**, pois não contém sistema de arquivos. |
| 🆔 **PARTUUID (/dev/sda1)** | `2672d079-e361-4b9a-b9fc-de4355c212d` | Identificador único da partição utilizado pelo kernel e pelo gerenciador de boot para localizar a partição. |
| 💽 **Dispositivo** | `/dev/sda2` | Segunda partição do disco principal, utilizada para armazenar o diretório **/boot**. |
| 📂 **Sistema de Arquivos** | `ext4` | Sistema de arquivos utilizado na partição `/boot`, responsável por armazenar o kernel Linux, initramfs e arquivos do GRUB. |
| 🆔 **UUID (/dev/sda2)** | `8eab4e16-9924-4f98-b708-e487caed2f6a` | Identificador único do sistema de arquivos da partição `/boot`, utilizado no arquivo `/etc/fstab`. |
| 🆔 **PARTUUID (/dev/sda2)** | `5c03323f-265f-4e93-9a4b-84b6ea48a16d` | Identificador único da partição GPT. |
| 💽 **Dispositivo** | `/dev/sda3` | Terceira partição do disco principal, utilizada como **Volume Físico (PV)** do LVM. |
| 🗃️ **Tipo** | `LVM2_member` | Indica que a partição pertence ao **LVM2 (Logical Volume Manager)** e serve como Volume Físico (PV). |
| 🆔 **UUID LVM** | `sTG8ae-OUeX-tebi-lasV-EMsT-0lnM-sYZYDV` | Identificador exclusivo do Volume Físico (PV) do LVM. |
| 🆔 **PARTUUID (/dev/sda3)** | `8a02900d-0319-48c8-937e-215621569576` | Identificador único da partição GPT utilizada pelo LVM. |
| 📦 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--root` | Volume lógico (LV) responsável pelo sistema de arquivos raiz (**/**). |
| 📂 **Sistema de Arquivos** | `ext4` | Sistema de arquivos utilizado no volume lógico raiz. |
| 🆔 **UUID (root)** | `10335044-64e5-42d0-bbc3-cc440a6beac0` | UUID utilizado para montagem automática da partição raiz. |
| 📏 **Block Size** | `4096 bytes` | Tamanho do bloco utilizado pelo sistema de arquivos ext4. |
| 📦 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--home` | Volume lógico destinado ao diretório **/home**. |
| 📂 **Sistema de Arquivos** | `ext4` | Sistema de arquivos do diretório `/home`. |
| 🆔 **UUID (home)** | `81f16b2d-13e7-40fe-bba9-b2999e41c9ce` | Identificador exclusivo do sistema de arquivos `/home`. |
| 📦 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--var` | Volume lógico destinado ao diretório **/var**. |
| 📂 **Sistema de Arquivos** | `ext4` | Sistema de arquivos utilizado pelo diretório `/var`, onde ficam logs, cache e arquivos variáveis do sistema. |
| 🆔 **UUID (var)** | `0a2eeb23-a8a5-4552-8246-ed8c7667d8f6` | UUID do sistema de arquivos `/var`. |
| 📦 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--tmp` | Volume lógico destinado ao diretório **/tmp**. |
| 📂 **Sistema de Arquivos** | `ext4` | Sistema de arquivos utilizado para armazenamento de arquivos temporários. |
| 🆔 **UUID (tmp)** | `fab2e050-7c15-4d14-b7d8-11b592a997d9` | UUID do sistema de arquivos `/tmp`. |
| 📦 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--swap` | Volume lógico utilizado como área de troca (**Swap**) da memória RAM. |
| 🔄 **Tipo** | `swap` | Área de memória virtual utilizada quando a memória física é insuficiente ou durante a hibernação (quando suportada). |
| 🆔 **UUID (swap)** | `738d862b-f138-41f9-8a44-1c87e4159093` | UUID da área de Swap. |
| 📦 **Dispositivo Loop** | `/dev/loop0` | Dispositivo de loop utilizado para montar pacotes **Snap** em formato **SquashFS**. |
| 📦 **Dispositivo Loop** | `/dev/loop1` | Dispositivo de loop utilizado para montar pacotes **Snap**. |
| 📦 **Dispositivo Loop** | `/dev/loop2` | Dispositivo de loop utilizado para montar pacotes **Snap**. |
| 📂 **Sistema de Arquivos (Loop)** | `squashfs` | Sistema de arquivos somente leitura utilizado pelos pacotes Snap. |
| 📏 **Block Size (Loop)** | `131072 bytes (128 KiB)` | Tamanho do bloco utilizado pelo sistema de arquivos SquashFS. |
---

```bash
#verificando as informações do kernel sobre as partições reconhecidas
#opção do comando cat: -n (number lines)
#mais informações acesse a documentação oficial em: 
sudo cat -n /proc/partitions
```

Entendendo a saída do comando: __`sudo cat -n /proc/partitions`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📄 **Arquivo** | `/proc/partitions` | Arquivo virtual do sistema **procfs** que exibe todos os dispositivos de bloco (Block Devices) reconhecidos pelo kernel Linux, incluindo discos, partições, dispositivos LVM, CD/DVD e dispositivos Loop. |
| 🔢 **Major Number** | `7` | Número principal (Major Number) reservado para dispositivos **Loop (loopX)**. |
| 🔢 **Major Number** | `8` | Número principal reservado para discos **SCSI/SATA/SAS/USB** (`sdX`). |
| 🔢 **Major Number** | `11` | Número principal reservado para dispositivos de mídia óptica (**CD/DVD - srX**). |
| 🔢 **Major Number** | `252` | Número principal atribuído aos dispositivos do **Device Mapper (LVM, dm-crypt, multipath, etc.)**. |
| 🔹 **Minor Number** | `0, 1, 2...` | Identifica individualmente cada dispositivo pertencente ao mesmo Major Number. |
| 💾 **#Blocks** | `Quantidade de blocos` | Número de blocos de armazenamento disponíveis para o dispositivo. Cada bloco corresponde a **1 KiB (1024 bytes)**. |
| 📦 **Name** | `Nome do dispositivo` | Nome atribuído pelo kernel ao dispositivo de bloco. |
---

```bash
#verificando os dispositivos de bloco reconhecidos pelo sysfs (link físico/lógico)
#opção do comando ls: -l (Display detailed information), -h (Print human readable file sizes)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.html
ls -lh /sys/block/
```

Entendendo a saída do comando: __`ls -lh /sys/block/`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📂 **Diretório** | `/sys/block/` | Diretório do **SysFS** que contém os dispositivos de bloco reconhecidos pelo kernel Linux. Cada item é um link simbólico para o dispositivo correspondente na árvore de hardware do sistema. |
| 🗂️ **Sistema de Arquivos** | `sysfs` | Sistema de arquivos virtual que expõe informações do kernel sobre dispositivos, drivers e barramentos. |
| 🔗 **Tipo de Arquivo** | `Link Simbólico (lrwxrwxrwx)` | Cada entrada é um link simbólico apontando para o caminho real do dispositivo dentro da árvore de dispositivos do kernel. |
| 💽 **Discos SATA** | `sda`, `sdb`, `sdc` | Discos físicos (virtuais no VirtualBox) conectados à controladora SATA AHCI. |
| 📀 **Unidade Óptica** | `sr0` | Unidade de CD/DVD virtual disponibilizada pelo Oracle VirtualBox. |
| 📦 **Device Mapper** | `dm-0` até `dm-4` | Dispositivos virtuais criados pelo **Device Mapper**, utilizados pelo **LVM** para representar os Volumes Lógicos (LV). |
| 🔄 **Loop Devices** | `loop0` até `loop7` | Dispositivos virtuais utilizados para montar imagens de arquivos, principalmente pacotes **Snap** em formato **SquashFS**. |
| 🖥️ **Controladora SATA** | `0000:00:0d.0` | Controladora **Intel ICH8M/ICH8M-E AHCI** à qual os discos SATA estão conectados. |
| 📂 **Barramentos ATA** | `ata3`, `ata4`, `ata5` | Portas SATA utilizadas pelos discos `sda`, `sdb` e `sdc`. |
| 🎯 **Objetivo** | Gerenciamento de dispositivos | Permite ao kernel e às aplicações consultar informações detalhadas sobre discos, filas de I/O, tamanho, setores, estado e atributos dos dispositivos de armazenamento. |
---

## 05_ Verificando todas as informações detalhadas de Hard Disk e Partições do Ubuntu Server
```bash
#listando os discos e partições em formato de árvore
#opção do comando lsblk: -f (mostra sistema de arquivos e UUID)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsblk.8.html
sudo lsblk -f
```

Entendendo a saída do comando: __`sudo lsblk -f`__<br>
| **Dispositivo** | **Sistema de Arquivos** | **UUID** | **Montagem** | **Descrição** |
| :-------------- | :---------------------- | :------- | :----------- | :------------ |
| 🔄 `loop0` | `squashfs 4.0` | — | `/snap/canonical-livepatch/406` | Pacote Snap do **Canonical Livepatch** montado em modo somente leitura. |
| 🔄 `loop1` | `squashfs 4.0` | — | `/snap/core22/2411` | Pacote base **Core22** utilizado pelo Snap. |
| 🔄 `loop2` | `squashfs 4.0` | — | `/snap/snapd/27406` | Pacote do serviço **Snapd**. |
| 💽 `sda1` | — | — | — | Partição reservada para inicialização (BIOS Boot), sem sistema de arquivos. |
| 🚀 `sda2` | `ext4` | `8eab4e16-9924-4f98-b708-e487caed2f6a` | `/boot` | Contém o kernel Linux, initramfs e arquivos do GRUB. |
| 📦 `sda3` | `LVM2_member` | `sTG8ae-OUeX-tebi-lasV-EMsT-0lnM-sYZYDV` | — | Volume Físico (PV) utilizado pelo LVM. |
| 📦 `ubuntu-vg/lv-root` | `ext4` | `10335044-64e5-42d0-bbc3-cc440a6beac0` | `/` | Sistema de arquivos raiz do Ubuntu Server. |
| 🔄 `ubuntu-vg/lv-swap` | `swap` | `738d862b-f138-41f9-8a44-1c87e4159093` | `[SWAP]` | Área de memória virtual (Swap). |
| 🏠 `ubuntu-vg/lv-home` | `ext4` | `81f16b2d-13e7-40fe-bba9-b2999e41c9ce` | `/home` | Diretório dos usuários. |
| 📁 `ubuntu-vg/lv-tmp` | `ext4` | `fab2e050-7c15-4d14-b7d8-11b592a997d9` | `/tmp` | Diretório de arquivos temporários. |
| 📂 `ubuntu-vg/lv-var` | `ext4` | `0a2eeb23-a8a5-4552-8246-ed8c7667d8f6` | `/var` | Diretório de logs, cache e dados variáveis do sistema. |
| 💽 `sdb` | — | — | — | Disco adicional sem particionamento ou sistema de arquivos. |
| 💽 `sdc` | — | — | — | Disco adicional sem particionamento ou sistema de arquivos. |
| 📀 `sr0` | — | — | — | Unidade óptica virtual sem mídia inserida. |
---

```bash
#listando as tabelas de partição de todos os discos
#opção do comando fdisk: -l (List the partition tables for the specified devices and then exit)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/fdisk.8.html
sudo fdisk -l
```

Entendendo a saída do comando: __`sudo fdisk -l`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Disco Principal** | `/dev/sda` | Disco principal onde está instalado o Ubuntu Server 26.04 LTS. |
| 📦 **Modelo** | `VBOX HARDDISK` | Disco virtual fornecido pelo Oracle VirtualBox. |
| 📏 **Capacidade** | `100 GiB (107.374.182.400 bytes)` | Capacidade total do disco principal. |
| 🔢 **Setores** | `209.715.200` | Quantidade total de setores físicos disponíveis no disco. |
| 📐 **Tamanho do Setor** | `512 bytes (lógico/físico)` | Tamanho dos setores utilizado pelo disco virtual. |
| ⚙️ **I/O Size** | `512 / 512 bytes` | Tamanho mínimo e ótimo das operações de entrada e saída. |
| 🗂️ **Tabela de Partições** | `GPT (GUID Partition Table)` | Padrão moderno de particionamento utilizado no disco. |
| 🆔 **Disk Identifier** | `0DE48432-362C-4220-A1E6-4F0D4122476D` | Identificador único (GUID) da tabela GPT do disco. |
| 📂 **Partição 1** | `/dev/sda1` | Partição **BIOS Boot** utilizada pelo GRUB em sistemas GPT com inicialização Legacy BIOS. |
| 📏 **Tamanho (/dev/sda1)** | `1 MiB` | Espaço reservado para o carregador de inicialização (GRUB). |
| 📂 **Partição 2** | `/dev/sda2` | Partição destinada ao diretório **/boot**. |
| 📏 **Tamanho (/dev/sda2)** | `2 GiB` | Armazena o kernel Linux, initramfs e arquivos do GRUB. |
| 📂 **Partição 3** | `/dev/sda3` | Partição utilizada como **Volume Físico (PV)** do LVM. |
| 📏 **Tamanho (/dev/sda3)** | `98 GiB` | Área destinada ao armazenamento dos Volumes Lógicos (LVM). |
| 💽 **Disco Secundário** | `/dev/sdb` | Disco adicional disponível para expansão, LVM ou RAID. |
| 📏 **Capacidade (/dev/sdb)** | `50 GiB (53.687.091.200 bytes)` | Disco sem partições e sem sistema de arquivos. |
| 💽 **Disco Terciário** | `/dev/sdc` | Segundo disco adicional disponível para expansão, LVM ou RAID. |
| 📏 **Capacidade (/dev/sdc)** | `50 GiB (53.687.091.200 bytes)` | Disco sem partições e sem sistema de arquivos. |
| 📦 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--root` | Volume lógico destinado ao sistema de arquivos raiz (**/**). |
| 📏 **Capacidade (root)** | `49 GiB` | Volume principal do sistema operacional. |
| 🔄 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--swap` | Volume lógico utilizado como área de Swap. |
| 📏 **Capacidade (swap)** | `8 GiB` | Área de memória virtual utilizada pelo kernel. |
| 🏠 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--home` | Volume lógico destinado ao diretório **/home**. |
| 📏 **Capacidade (home)** | `5 GiB` | Armazenamento dos diretórios pessoais dos usuários. |
| 📁 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--tmp` | Volume lógico destinado ao diretório **/tmp**. |
| 📏 **Capacidade (tmp)** | `5 GiB` | Armazena arquivos temporários do sistema e das aplicações. |
| 📂 **Volume Lógico** | `/dev/mapper/ubuntu--vg-lv--var` | Volume lógico destinado ao diretório **/var**. |
| 📏 **Capacidade (var)** | `15 GiB` | Armazena logs, cache, spool, bancos de dados e arquivos variáveis do sistema. |
---

```bash
#listando as tabelas de partição detalhadas de setor/alinhamento
#opção do comando parted: -l (lists partition layout on all block devices)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/parted.8.html
sudo parted -l
```

Entendendo a saída do comando: __`sudo parted -l`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Disco Principal** | `/dev/sda` | Disco principal onde está instalado o Ubuntu Server 26.04 LTS. |
| 📦 **Modelo** | `ATA VBOX HARDDISK (SCSI)` | Disco virtual apresentado pelo Oracle VirtualBox através da controladora SATA/AHCI. |
| 📏 **Capacidade** | `107 GB` | Capacidade total do disco principal (valor decimal informado pelo `parted`). |
| 📐 **Tamanho do Setor** | `512B / 512B` | Tamanho dos setores lógicos e físicos do disco. |
| 🗂️ **Tabela de Partições** | `GPT (GUID Partition Table)` | Padrão moderno de particionamento utilizado no disco. |
| 🚩 **Disk Flags** | `Nenhuma` | Não há flags especiais configuradas para o disco. |
| 📂 **Partição 1** | `/dev/sda1` | Partição reservada para o carregador de inicialização (GRUB). |
| 🚩 **Flag da Partição 1** | `bios_grub` | Identifica a partição utilizada pelo GRUB em sistemas GPT com boot Legacy BIOS. |
| 📏 **Tamanho (/dev/sda1)** | `1,049 MB` | Espaço reservado para os arquivos do GRUB. |
| 📂 **Partição 2** | `/dev/sda2` | Partição destinada ao diretório **/boot**. |
| 📂 **Sistema de Arquivos** | `ext4` | Sistema de arquivos utilizado na partição `/boot`. |
| 📏 **Tamanho (/dev/sda2)** | `2,147 GB` | Armazena o kernel Linux, initramfs e arquivos do GRUB. |
| 📂 **Partição 3** | `/dev/sda3` | Partição utilizada como Volume Físico (PV) do LVM. |
| 📏 **Tamanho (/dev/sda3)** | `105 GB` | Área destinada ao armazenamento dos Volumes Lógicos (LVM). |
| 💽 **Disco Secundário** | `/dev/sdb` | Disco adicional ainda sem particionamento. |
| 📦 **Modelo (/dev/sdb)** | `ATA VBOX HARDDISK (SCSI)` | Disco virtual disponibilizado pelo VirtualBox. |
| 📏 **Capacidade (/dev/sdb)** | `53,7 GB` | Capacidade total do disco secundário. |
| 🗂️ **Tabela de Partições (/dev/sdb)** | `unknown` | O disco ainda não possui tabela de partições criada. |
| ⚠️ **Status (/dev/sdb)** | `unrecognised disk label` | Mensagem informando que o disco está vazio e ainda não foi inicializado com GPT ou MBR. |
| 💽 **Disco Terciário** | `/dev/sdc` | Segundo disco adicional ainda sem particionamento. |
| 📦 **Modelo (/dev/sdc)** | `ATA VBOX HARDDISK (SCSI)` | Disco virtual disponibilizado pelo VirtualBox. |
| 📏 **Capacidade (/dev/sdc)** | `53,7 GB` | Capacidade total do disco terciário. |
| 🗂️ **Tabela de Partições (/dev/sdc)** | `unknown` | O disco ainda não possui tabela de partições criada. |
| ⚠️ **Status (/dev/sdc)** | `unrecognised disk label` | Mensagem indicando que o disco ainda não foi inicializado. |
---

## 06_ Verificando o Desempenho (Performance) dos Discos no Ubuntu Server
```bash
#testando a velocidade de leitura em cache e em disco (bruto)
#opção do comando hdparm: -t (device readings), -T (cache readings)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/hdparm
sudo hdparm -Tt /dev/sda
sudo hdparm -Tt /dev/sdb
sudo hdparm -Tt /dev/sdc
```

Entendendo a saída do comando: __`sudo hdparm -Tt /dev/sdx`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Comando** | `hdparm -Tt /dev/sdX` | Realiza um teste simples de desempenho dos dispositivos de armazenamento, medindo a velocidade de leitura da memória cache e do disco. |
| ⚡ **Opção `-T`** | `Timing cached reads` | Mede a velocidade de leitura da memória **cache do sistema (RAM/Page Cache)**. Não avalia o desempenho físico do disco. |
| 💿 **Opção `-t`** | `Timing buffered disk reads` | Mede a velocidade de leitura sequencial diretamente do dispositivo de armazenamento, indicando seu desempenho real. |
| 📦 **Unidade** | `MB/sec` | Taxa de transferência medida em Megabytes por segundo (MB/s). Quanto maior o valor, melhor o desempenho. |
| ⚠️ **Observação** | Ambiente Virtualizado | Como o Ubuntu está executando em uma máquina virtual (**Oracle VirtualBox**), os resultados refletem também o desempenho do disco do sistema hospedeiro (Host). |
---

| **Dispositivo** | **Leitura em Cache (`-T`)** | **Leitura do Disco (`-t`)** | **Descrição** |
| :-------------- | --------------------------: | --------------------------: | :------------ |
| 💽 `/dev/sda` | **12.955,39 MB/s** | **1.315,43 MB/s** | Disco principal contendo o Ubuntu Server, GPT, LVM e sistema operacional. |
| 💽 `/dev/sdb` | **14.162,83 MB/s** | **3.664,43 MB/s** | Disco adicional vazio utilizado para futuros laboratórios de armazenamento.  
| 💽 `/dev/sdc` | **14.428,26 MB/s** | **3.855,92 MB/s** | Disco adicional vazio com o melhor desempenho entre os três discos testados. |
---

## 07_ Verificando a Saúde (SMART) dos Discos no Ubuntu Server
```bash
#verificando a saúde geral e informações completas do disco
#opções do comando smartctl: -i (device identify)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/smartctl.8.html
sudo smartctl -i /dev/sda
sudo smartctl -i /dev/sdb
sudo smartctl -i /dev/sdc
```

Entendendo a saída do comando: __`sudo smartctl -i /dev/sdx`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Comando** | `smartctl -i /dev/sdX` | Exibe as informações básicas de identificação do dispositivo e verifica se há suporte à tecnologia **S.M.A.R.T.** |
| 🔍 **Ferramenta** | `smartctl 7.5` | Utilitário do pacote **smartmontools** utilizado para monitoramento da integridade dos dispositivos de armazenamento. |
| 📦 **Modelo dos Discos** | `VBOX HARDDISK` | Discos virtuais apresentados pelo Oracle VirtualBox. |
| 💾 **Tipo de Interface** | `ATA/ATAPI-6` | Versão da especificação ATA suportada pelo dispositivo virtual. |
| 📏 **Tamanho do Setor** | `512 bytes (lógico/físico)` | Tamanho dos setores utilizados pelos discos virtuais. |
| ⚠️ **Suporte ao SMART** | `Unavailable` | Os discos virtuais do VirtualBox não implementam a tecnologia SMART para monitoramento de saúde do hardware. |
---

Entendendo a saída do comando: __`sudo smartctl -i /dev/sdx`__<br>
| **Campo** | **/dev/sda** | **/dev/sdb** | **/dev/sdc** | **Descrição** |
| :-------- | :----------: | :----------: | :----------: | :------------ |
| 💽 **Dispositivo** | `/dev/sda` | `/dev/sdb` | `/dev/sdc` | Nome do dispositivo de bloco reconhecido pelo kernel Linux. |
| 📦 **Modelo** | VBOX HARDDISK | VBOX HARDDISK | VBOX HARDDISK | Modelo do disco virtual fornecido pelo Oracle VirtualBox. |
| 🔢 **Número de Série** | `VB2dc3e2f7-0b8c5ac1` | `VB80443986-ef293c39` | `VB58ac26eb-8805b6b3` | Identificador único atribuído pelo VirtualBox a cada disco virtual. |
| ⚙️ **Firmware** | `1.0` | `1.0` | `1.0` | Versão do firmware virtual do dispositivo. |
| 💾 **Capacidade** | **107 GB** | **53,6 GB** | **53,6 GB** | Capacidade total do disco virtual. |
| 📏 **Setor Lógico/Físico** | 512 / 512 bytes | 512 / 512 bytes | 512 / 512 bytes | Tamanho dos setores utilizados pelo dispositivo. |
| 💿 **Versão ATA** | ATA/ATAPI-6 | ATA/ATAPI-6 | ATA/ATAPI-6 | Especificação ATA apresentada pelo dispositivo virtual. |
| 📚 **Base do smartctl** | Não cadastrado | Não cadastrado | Não cadastrado | O modelo virtual não faz parte do banco de dados do `smartctl`. |
| ❤️ **Suporte SMART** | ❌ Não disponível | ❌ Não disponível | ❌ Não disponível | O dispositivo virtual não fornece informações SMART. |
---

```bash
#verificando se existem setores defeituosos nos discos antes de montar o RAID (opcional, teste demorado)
#opções do comando badblocks: -s (show progress), -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/badblocks.8.html
sudo badblocks -sv /dev/sdb
sudo badblocks -sv /dev/sdc
```

Entendendo a saída do comando: __`sudo badblocks -sv /dev/sdx`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🛡️ **Modo de Teste** | `Read-Only` | Realiza somente leitura dos blocos, sem modificar ou apagar dados existentes no disco. |
| 💽 **Dispositivo** | `/dev/sdb` | Disco físico (virtual no VirtualBox) submetido ao teste de integridade. |
| 🔢 **Blocos Verificados** | `0 a 52.428.799` | Intervalo de blocos lógicos analisados durante a verificação. |
| 📖 **Tipo de Verificação** | `Checking for bad blocks (read-only test)` | Teste de leitura sequencial para identificar blocos inacessíveis ou com falhas. |
| ✅ **Resultado** | `Pass completed` | O teste foi concluído com sucesso. |
| ❤️ **Blocos Defeituosos** | `0 bad blocks found` | Nenhum bloco defeituoso foi encontrado durante a verificação. |
| ⚠️ **Erros Encontrados** | `0/0/0 errors` | Não foram detectados erros de leitura, gravação ou verificação durante o teste. |
---

## 08_ Verificando o Espaço em Disco Utilizado no Ubuntu Server
```bash
#verificando o espaço disponível/utilizado por partição montada
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h
```

Entendendo a saída do comando: __`sudo df -h`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📂 **Sistema de Arquivos** | `/dev/mapper/ubuntu--vg-lv--root` | Volume Lógico (LVM) responsável pelo diretório raiz (`/`). |
| 📏 **Tamanho** | **48 GB** | Capacidade total do sistema de arquivos raiz. |
| 💾 **Utilizado** | **2,6 GB** | Espaço atualmente ocupado. |
| 📦 **Disponível** | **43 GB** | Espaço livre disponível para armazenamento. |
| 📈 **Uso** | **6%** | Percentual de utilização do sistema de arquivos. |
| 📍 **Ponto de Montagem** | `/` | Diretório raiz do sistema operacional. |
---