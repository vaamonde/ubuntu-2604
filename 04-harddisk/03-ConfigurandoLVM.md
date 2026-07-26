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
Data de criação: 25/07/2026<br>
Data de atualização: 25/07/2026<br>
Versão: 0.01<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

Conteúdo estudado nessa configuração:<br>
#01_ Preparando o Array RAID-1 para a Configuração do LVM no Ubuntu Server<br>
#02_ Instalando os principais software de LVM no Ubuntu Server<br>
#03_ Verificando a versão do Sistema de LVM do Ubuntu Server<br>
#04_ Criando o Physical Volume (PV) sobre o Array do RAID-1 no Ubuntu Server<br>
#05_ Criando o Volume Group (VG) no Ubuntu Server<br>
#06_ Criando o Logical Volume (LV) no Ubuntu Server<br>
#07_ Formatando e Montando o Logical Volume no Ubuntu Server<br>
#08_ Localização dos Arquivos de Configuração do LVM no Ubuntu Server<br>
#09_ Verificando o Mapeamento de PE (Physical Extent) e LE (Logical Extent) no Ubuntu Server<br>
#10_ Redimensionando o Volume Group e o Logical Volume no Ubuntu Server<br>
#11_ Criando um Snapshot do Logical Volume no Ubuntu Server<br>
#12_ Analisando os Logs do LVM no Ubuntu Server<br>

[![LVM Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "LVM Ubuntu Server")

Link da vídeo aula: 

| **🧱 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🗃️ **LVM (Logical Volume Manager)** | Camada de abstração de armazenamento do GNU/Linux, situada entre os discos físicos (ou Arrays RAID) e os sistemas de arquivos. | Permite criar, redimensionar, mover e gerenciar volumes de armazenamento de forma flexível, sem as limitações rígidas do particionamento tradicional (MBR/GPT). |
| 💽 **PV (Physical Volume)** | Disco, partição ou Array RAID (como o `/dev/md0`) inicializado e preparado para ser utilizado pelo LVM. | Representa a camada mais baixa do LVM, servindo como matéria-prima de armazenamento para compor um ou mais Volume Groups. |
| 🗄️ **VG (Volume Group)** | Pool de armazenamento lógico formado pela soma de um ou mais Physical Volumes. | Unifica o espaço de diversos discos/Arrays em um único "reservatório" de armazenamento, do qual os Logical Volumes são criados. |
| 📦 **LV (Logical Volume)** | Partição virtual criada a partir do espaço disponível em um Volume Group. | Funciona como uma partição tradicional para o sistema operacional, porém pode ser redimensionada, movida ou expandida sem a necessidade de desligar o servidor. |
| 🧩 **PE (Physical Extent)** | Menor unidade de alocação de espaço dentro de um Physical Volume, definida no momento da criação do Volume Group. | Divide o PV em blocos de tamanho fixo (por padrão 4 MiB), que serão utilizados para compor os Logical Volumes. |
| 🧩 **LE (Logical Extent)** | Unidade lógica correspondente ao PE, mapeada dentro de um Logical Volume. | Cada LE aponta para um ou mais PEs físicos, sendo a base do mapeamento entre o espaço lógico (LV) e o espaço físico (PV) do LVM. |
| 🔗 **Device Mapper** | Subsistema do Kernel Linux responsável por criar dispositivos de bloco virtuais (como os LVs) mapeados sobre dispositivos físicos. | É a tecnologia de baixo nível que viabiliza o funcionamento do LVM, do `dm-crypt` (criptografia) e do `multipath` no Linux. |
| 📸 **Snapshot** | Cópia pontual (ponto no tempo) e somente leitura/escrita de um Logical Volume, baseada em Copy-on-Write (CoW). | Permite criar backups consistentes ou pontos de restauração rápidos de um LV, sem interromper o serviço em produção. |
---

| **Camada** | **Comando de Criação** | **Comando de Consulta** | **Unidade de Alocação** |
| :--------- | :---------------------- | :------------------------ | :----------------------- |
| **PV (Physical Volume)** | `pvcreate` | `pvdisplay` / `pvs` | Não se aplica (disco/partição/RAID inteiro) |
| **VG (Volume Group)** | `vgcreate` | `vgdisplay` / `vgs` | **PE (Physical Extent)** |
| **LV (Logical Volume)** | `lvcreate` | `lvdisplay` / `lvs` | **LE (Logical Extent)** |
---

## 01_ Preparando o Array RAID-1 para a Configuração do LVM no Ubuntu Server
```bash
#verificando se já existe alguma assinatura de sistema de arquivos, RAID ou LVM no Array do RAID-1
#opção do comando wipefs: -n (dry-run, apenas simula sem apagar nada)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/wipefs.8.html
sudo wipefs -n /dev/md0
```
```bash
#removendo todas as assinaturas de sistema de arquivos, RAID ou LVM no Array do RAID-1
#opção do comando wipefs: -a (apaga todas as assinaturas encontradas)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/wipefs.8.html
sudo wipefs -a /dev/md0

#verificando o estado atual do Array do RAID-1 antes de iniciar a configuração do LVM
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
sudo cat /proc/mdstat
```

## 02_ Instalando os principais software de LVM no Ubuntu Server
```bash
#atualizando as lista do Apt do sources.list no Ubuntu Server
#opção do comando apt: update (Resynchronize the package index files from their sources)
sudo apt update

#instalando os pacotes e ferramentas de LVM no Ubuntu Server
#opção do comando apt: install (install is followed by one or more package names)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt install lvm2 thin-provisioning-tools
```

## 03_ Verificando a versão do Sistema de LVM do Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção.

```bash
#verificando a versão do sistema de gerenciamento de volumes lógicos
#opção do comando lvm: version (Display  the  LVM,  and  library, and driver version)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/lvm.8.html
sudo lvm version

#verificando o status do serviço do LVM no Ubuntu Server
#opção do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status lvm2-monitor
```

## 04_ Criando o Physical Volume (PV) sobre o Array do RAID-1 no Ubuntu Server
```bash
#criando o Physical Volume (PV) sobre o Array do RAID-1 no Ubuntu Server
#opção do comando pvcreate: (Initialize physical volume(s) for use by LVM)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/pvcreate.8.html
sudo pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.

#verificando as informações resumidas do Physical Volume no Ubuntu Server
#opção do comando pvs: (List physical volumes)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/pvs.8.html
sudo pvs

#verificando as informações detalhadas do Physical Volume no Ubuntu Server
#opção do comando pvdisplay: (Display various attributes of physical volume(s))
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/pvdisplay.8.html
sudo pvdisplay /dev/md0
```

Entendendo a saída do comando: __`sudo pvdisplay /dev/md0`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **PV Name** | `/dev/md0` | Dispositivo (neste caso o Array do RAID-1) inicializado como Physical Volume. |
| 🗄️ **VG Name** | *(vazio)* | Ainda não associado a nenhum Volume Group, pois o VG será criado na próxima etapa. |
| 📏 **PV Size** | `49.99 GiB` | Capacidade total do Physical Volume, correspondente ao tamanho útil do Array `/dev/md0`. |
| ⚙️ **Allocatable** | `NO` | Indica que o PV ainda não pertence a um VG, portanto seu espaço ainda não pode ser alocado em Logical Volumes. |
| 🆔 **PV UUID** | `k3Qz8p-1v9X-...` | Identificador único de 128 bits atribuído ao Physical Volume pelo LVM. |
---

## 05_ Criando o Volume Group (VG) no Ubuntu Server
```bash
#criando o Volume Group (VG) a partir do Physical Volume /dev/md0 no Ubuntu Server
#opção do comando vgcreate: (Create a volume group)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/vgcreate.8.html
sudo vgcreate vg_dados /dev/md0
  Volume group "vg_dados" successfully created

#verificando as informações resumidas do Volume Group no Ubuntu Server
#opção do comando vgs: (List volume groups)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/vgs.8.html
sudo vgs

#verificando as informações detalhadas do Volume Group no Ubuntu Server
#opção do comando vgdisplay: (Display attributes of volume group(s))
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/vgdisplay.8.html
sudo vgdisplay vg_dados
```

Entendendo a saída do comando: __`sudo vgdisplay vg_dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🗄️ **VG Name** | `vg_dados` | Nome atribuído ao Volume Group no momento da criação. |
| 🔢 **Format** | `lvm2` | Formato de metadados utilizado pelo LVM, o padrão atual é o **LVM2**. |
| 🆔 **VG UUID** | `pQ7f3K-...` | Identificador único do Volume Group. |
| 💽 **PV Count** | `1` | Quantidade de Physical Volumes que compõem o Volume Group (neste cenário, apenas o `/dev/md0`). |
| 📦 **LV Count** | `0` | Quantidade de Logical Volumes criados até o momento (ainda nenhum). |
| 📏 **VG Size** | `49.98 GiB` | Capacidade total disponível no Volume Group para a criação de Logical Volumes. |
| 🧩 **PE Size** | `4.00 MiB` | Tamanho de cada **Physical Extent (PE)**, a menor unidade de alocação do LVM. Valor padrão definido pelo `vgcreate`. |
| 🔢 **Total PE** | `12796` | Quantidade total de Physical Extents disponíveis no Volume Group (`VG Size` dividido pelo `PE Size`). |
| ✅ **Alloc PE / Size** | `0 / 0` | Quantidade de PEs já alocados a Logical Volumes (ainda nenhum). |
| 🆓 **Free PE / Size** | `12796 / 49.98 GiB` | Quantidade de PEs ainda livres para a criação de novos Logical Volumes. |
---

## 06_ Criando o Logical Volume (LV) no Ubuntu Server
```bash
#criando o Logical Volume (LV) com tamanho fixo de 20 GiB dentro do Volume Group vg_dados
#opções do comando lvcreate: -L (Specify the size directly), -n (Set the name)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/lvcreate.8.html
sudo lvcreate -L 20G -n lv_dados vg_dados
  Logical volume "lv_dados" created.

#verificando as informações resumidas do Logical Volume no Ubuntu Server
#opção do comando lvs: (List logical volumes)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/lvs.8.html
sudo lvs

#verificando as informações detalhadas do Logical Volume no Ubuntu Server
#opção do comando lvdisplay: (Display attributes of logical volume(s))
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/lvdisplay.8.html
sudo lvdisplay /dev/vg_dados/lv_dados
```

Entendendo a saída do comando: __`sudo lvdisplay /dev/vg_dados/lv_dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📦 **LV Path** | `/dev/vg_dados/lv_dados` | Caminho lógico do Logical Volume, criado automaticamente pelo Device Mapper. |
| 🏷️ **LV Name** | `lv_dados` | Nome atribuído ao Logical Volume no momento da criação. |
| 🗄️ **VG Name** | `vg_dados` | Volume Group ao qual o Logical Volume pertence. |
| 🆔 **LV UUID** | `9mQ1zR-...` | Identificador único do Logical Volume. |
| 📏 **LV Size** | `20.00 GiB` | Capacidade total alocada para o Logical Volume. |
| 🧩 **Current LE** | `5120` | Quantidade de **Logical Extents** que compõem o Logical Volume (`LV Size` dividido pelo `PE Size` do VG). |
| 🔗 **Block device** | `252:2` | Identificador Major/Minor do dispositivo de bloco virtual criado pelo Device Mapper. |
---

## 07_ Formatando e Montando o Logical Volume no Ubuntu Server
```bash
#formatando o Logical Volume com o sistema de arquivos ext4 no Ubuntu Server
#opção do comando mkfs.ext4: (cria um sistema de arquivos ext4 no dispositivo informado)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/mkfs.ext4.8.html
sudo mkfs.ext4 /dev/vg_dados/lv_dados

#criando o diretório de ponto de montagem do Logical Volume no Ubuntu Server
#opção do comando mkdir: -p (cria diretórios pais conforme necessário)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/mkdir.1.html
sudo mkdir -p /dados

#verificando o UUID do sistema de arquivos criado no Logical Volume
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/blkid.8.html
sudo blkid /dev/vg_dados/lv_dados

#fazendo o backup do arquivo de configuração original do Fstab
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/fstab /etc/fstab.old

#editando o arquivo de configuração do Fstab para montagem automática no boot
sudo vim /etc/fstab

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#adicionando a entrada de montagem do Logical Volume no Ubuntu Server
#OBSERVAÇÃO IMPORTANTE: ALTERAR O UUID PARA O UUID GERADO NO SEU CENÁRIO (comando blkid acima)
UUID=SEU_UUID_DO_LV_DADOS  /dados  ext4  defaults  0  2
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>

#montando todos os sistemas de arquivos listados no Fstab no Ubuntu Server
#opção do comando mount: -a (Mount all filesystems mentioned in fstab)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/mount.8.html
sudo mount -a

#verificando o espaço em disco e o ponto de montagem do Logical Volume no Ubuntu Server
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /dados
```

## 08_ Localização dos Arquivos de Configuração do LVM no Ubuntu Server
```bash
/etc/lvm/                    <-- Diretório de configuração do LVM
/etc/lvm/lvm.conf            <-- Arquivo principal de configuração do LVM
/etc/lvm/backup/             <-- Backup automático dos metadados atuais de cada Volume Group
/etc/lvm/archive/            <-- Histórico de versões anteriores dos metadados (a cada alteração)
/etc/lvm/lvmlocal.conf        <-- Arquivo de configurações locais específicas do host
```
```bash
#verificando o conteúdo do backup de metadados do Volume Group no Ubuntu Server
#opção do comando cat: -n (number line)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
sudo cat -n /etc/lvm/backup/vg_dados
```

## 09_ Verificando o Mapeamento de PE (Physical Extent) e LE (Logical Extent) no Ubuntu Server
```bash
#verificando o mapeamento detalhado dos Physical Extents (PE) do Physical Volume no Ubuntu Server
#opção do comando pvdisplay: -m (Display the mapping of physical extents to logical extents)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/pvdisplay.8.html
sudo pvdisplay -m /dev/md0
```

Entendendo a saída do comando: __`sudo pvdisplay -m /dev/md0`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🧩 **Physical extents** | `0 to 5119` | Faixa de **Physical Extents (PE)** do `/dev/md0` que está alocada ao Logical Volume `lv_dados`. |
| 🔗 **Logical volume** | `/dev/vg_dados/lv_dados` | Logical Volume ao qual essa faixa de PEs está mapeada. |
| 🧩 **Logical extents** | `0 to 5119` | Faixa de **Logical Extents (LE)** correspondente dentro do `lv_dados`, mapeada 1 para 1 com os PEs físicos. |
| 📊 **Relação PE:LE** | `1:1` | No mapeamento **Linear** (padrão do LVM), cada Logical Extent corresponde a exatamente um Physical Extent, sem distribuição (striping) entre múltiplos PVs. |
---

```bash
#verificando de forma resumida a relação entre PE Total, PE Alocado e PE Livre no Volume Group
#opções do comando vgs: -o (Select columns for output), +free (adiciona a coluna de espaço livre)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/vgs.8.html
sudo vgs -o vg_name,vg_extent_count,vg_free_count,vg_extent_size
```

## 10_ Redimensionando o Volume Group e o Logical Volume no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** essa é a principal vantagem do LVM sobre o particionamento tradicional: é possível **adicionar um novo Physical Volume ao Volume Group** e **expandir o Logical Volume e o sistema de arquivos**, tudo isso **sem desligar o servidor** (Hot Resize).

```bash
#OBSERVAÇÃO: exemplo de expansão do Volume Group adicionando um novo Physical Volume (ex: /dev/sdd
#já preparado como PV), caso exista um disco adicional disponível no cenário
#opção do comando pvcreate: (Initialize physical volume(s) for use by LVM)
#opção do comando vgextend: (Add physical volumes to a volume group)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/vgextend.8.html
sudo pvcreate /dev/sdd
sudo vgextend vg_dados /dev/sdd

#expandindo o Logical Volume utilizando mais 10 GiB do espaço livre do Volume Group
#opções do comando lvextend: -L (Specify the size directly), +10G (adiciona 10 GiB ao tamanho atual)
#-r (Resize the underlying filesystem together with the logical volume using fsadm)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/lvextend.8.html
sudo lvextend -L +10G -r /dev/vg_dados/lv_dados
  Size of logical volume vg_dados/lv_dados changed from 20.00 GiB to 30.00 GiB
  Filesystem at /dev/vg_dados/lv_dados is mounted on /dados; resizing
  The filesystem on /dev/vg_dados/lv_dados is now 30.00 GiB

#verificando o novo tamanho do Logical Volume e do sistema de arquivos no Ubuntu Server
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /dados
sudo lvs
```

> **OBSERVAÇÃO IMPORTANTE:** a opção `-r` do `lvextend` já executa o `resize2fs` automaticamente para sistemas de arquivos **ext4**. Caso prefira executar manualmente (ou em sistemas de arquivos onde o `-r` não é suportado), utilize: __`sudo resize2fs /dev/vg_dados/lv_dados`__ logo após o `lvextend`.

## 11_ Criando um Snapshot do Logical Volume no Ubuntu Server
```bash
#criando um Snapshot do Logical Volume lv_dados no Ubuntu Server
#opções do comando lvcreate: -s (Create a snapshot), -L (Specify the size directly), -n (Set the name)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/lvcreate.8.html
sudo lvcreate -s -L 5G -n lv_dados_snap /dev/vg_dados/lv_dados
  Logical volume "lv_dados_snap" created.

#verificando as informações resumidas dos Logical Volumes, incluindo o Snapshot, no Ubuntu Server
#opção do comando lvs: (List logical volumes)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/lvs.8.html
sudo lvs -o lv_name,vg_name,lv_size,origin,data_percent
```

Entendendo a saída do comando: __`sudo lvs -o lv_name,vg_name,lv_size,origin,data_percent`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🏷️ **LV** | `lv_dados_snap` | Nome do Logical Volume de Snapshot criado. |
| 🗄️ **VG** | `vg_dados` | Volume Group ao qual o Snapshot pertence. |
| 📏 **LV Size** | `5.00 GiB` | Espaço reservado para armazenar os blocos alterados (**Copy-on-Write**) desde a criação do Snapshot, não o tamanho total dos dados. |
| 🔗 **Origin** | `lv_dados` | Logical Volume de origem (original) ao qual o Snapshot está vinculado. |
| 📊 **Data%** | `0.15` | Percentual do espaço do Snapshot já utilizado para armazenar blocos alterados. Se atingir 100%, o Snapshot é invalidado automaticamente. |
---

```bash
#removendo o Snapshot do Logical Volume após o uso (backup/restore) no Ubuntu Server
#opção do comando lvremove: (Remove logical volume(s) from the system)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/lvremove.8.html
sudo lvremove /dev/vg_dados/lv_dados_snap
  Do you really want to remove active logical volume vg_dados/lv_dados_snap? [y/n]: y <Enter>
```

## 12_ Analisando os Logs do LVM no Ubuntu Server
```bash
#analisando os Log's do Kernel referente ao Device Mapper e ao LVM no Ubuntu Server
#opção do comando journalctl: k (kernel messages, equivalente ao comando dmesg)
#opção do comando grep: -i (Ignore case distinctions in patterns and input data)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/grep.1.html
sudo journalctl -k | grep -i 'device-mapper\|lvm'
```

Entendendo a saída do comando: __`sudo journalctl -k | grep -i 'device-mapper\|lvm'`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🖥️ **Origem** | `kernel` | Mensagens geradas diretamente pelo **Kernel Linux**, responsável pelo subsistema **Device Mapper**, base de funcionamento do LVM. |
| 🔗 **Evento de Criação** | `device-mapper: uevent: version 1.0.3` | Confirma que o módulo do Device Mapper foi carregado corretamente pelo Kernel. |
| 📦 **Evento de Volume** | `device-mapper: table: 252:2: adding target` | Registra a criação de um novo dispositivo mapeado (Logical Volume) no Device Mapper. |
---

```bash
#analisando os Log's do Sistema referente ao LVM no Ubuntu Server
#opção do comando cat: (concatena e exibe o conteúdo do arquivo de Log)
#opção do comando grep: -i (Ignore case distinctions in patterns and input data)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/grep.1.html
sudo cat /var/log/syslog | grep -i lvm
```

Entendendo a saída do comando: __`sudo cat /var/log/syslog | grep -i lvm`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📄 **Arquivo** | `/var/log/syslog` | Arquivo de Log padrão do sistema operacional, responsável por registrar mensagens de diversos serviços, incluindo o **lvm2-monitor**. |
| ⏱️ **Timestamp** | `Jul 25 10:14:02 srvvaamonde` | Data, hora e nome do host onde o evento do LVM foi registrado. |
| 🏷️ **Serviço (Origem)** | `lvm[PID]:` | Identifica que a mensagem foi gerada pelo daemon de monitoramento do **LVM** (`lvm2-monitor`). |
| ✅ **Alerta de Criação** | `vg_dados/lv_dados created` | Confirma no Log a criação de um novo Logical Volume dentro do Volume Group. |
| ⚠️ **Alerta de Snapshot** | `Snapshot vg_dados/lv_dados_snap is nn% full` | Alerta gerado quando um Snapshot se aproxima do limite de espaço reservado (Copy-on-Write), podendo ser invalidado se atingir 100%. |
---
