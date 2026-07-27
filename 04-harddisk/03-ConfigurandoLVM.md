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
Data de atualização: 26/07/2026<br>
Versão: 0.02<br>
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

Entendendo a saída do comando: __`sudo cat /proc/mdstat`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🛡️ **Personalities** | `[raid1]` | Tipo de RAID suportado e atualmente carregado pelo kernel Linux. |
| 📦 **Array RAID** | `md0` | Nome do dispositivo lógico criado pelo `mdadm`. |
| ✅ **Status** | `active` | O array RAID está ativo e operacional. |
| 🛡️ **Nível RAID** | `raid1` | RAID-1 (Espelhamento/Mirroring), onde os dados são gravados simultaneamente em ambos os discos. |
| 💽 **Disco 1** | `sdb1 [0]` | Primeiro membro do array RAID. |
| 💽 **Disco 2** | `sdc1 [1]` | Segundo membro do array RAID. |
| 📦 **Blocos** | `52.392.960` | Quantidade total de blocos disponíveis no array RAID. |
| 🏷️ **Superbloco** | `super 1.2` | Versão dos metadados RAID armazenados nas partições. |
| 👥 **Discos Configurados** | `[2/2]` | Dois discos configurados e dois discos ativos no array. |
| ❤️ **Estado dos Discos** | `[UU]` | Ambos os discos estão íntegros e sincronizados. |
| 📝 **Bitmap** | `0/1 pages (0 KB)` | Bitmap utilizado para acelerar a sincronização após falhas ou reinicializações. |
| 📦 **Chunk Bitmap** | `65536 KB` | Tamanho do bloco monitorado pelo bitmap interno do RAID. |
| 🚫 **Dispositivos Não Utilizados** | `<none>` | Não existem discos RAID detectados e não utilizados pelo sistema. |
---

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
```

Entendendo a saída do comando: __`sudo pvs`__<br>
| **Campo** | **/dev/md0** | **/dev/sda3** | **Descrição** |
| :-------- | :----------- | :------------ | :------------ |
| 💽 **Physical Volume (PV)** | `/dev/md0` | `/dev/sda3` | Dispositivo físico utilizado pelo LVM como Volume Físico. |
| 🏷️ **Volume Group (VG)** | *(Não atribuído)* | `ubuntu-vg` | Grupo de Volumes ao qual o PV pertence. O `/dev/md0` ainda não foi adicionado a nenhum VG. |
| 📦 **Formato** | `lvm2` | `lvm2` | Versão do formato de metadados utilizada pelo LVM. |
| ⚙️ **Atributos** | `---` | `a--` | Estado e atributos do Physical Volume. |
| 💾 **Capacidade Total (PSize)** | `<49,97 GiB` | `<98,00 GiB` | Capacidade disponível para utilização pelo LVM. |
| 📂 **Espaço Livre (PFree)** | `<49,97 GiB` | `16,00 GiB` | Espaço ainda não alocado dentro do Volume Group. |
---

```bash
#verificando as informações detalhadas do Physical Volume no Ubuntu Server
#opção do comando pvdisplay: (Display various attributes of physical volume(s))
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/pvdisplay.8.html
sudo pvdisplay /dev/md0
```

Entendendo a saída do comando: __`sudo pvdisplay /dev/md0`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **PV Name** | `/dev/md0` | Nome do Physical Volume reconhecido pelo LVM. |
| 🏷️ **VG Name** | *(vazio)* | O Physical Volume ainda não pertence a nenhum Volume Group. |
| 💾 **PV Size** | `<49,97 GiB` | Capacidade total disponível para utilização pelo LVM. |
| ⚙️ **Allocatable** | `NO` | O PV ainda não pode receber alocações de dados, pois não faz parte de um Volume Group. |
| 📦 **PE Size** | `0` | Tamanho dos **Physical Extents (PE)**. Como o VG ainda não foi criado, os PE ainda não existem. |
| 🔢 **Total PE** | `0` | Quantidade total de Physical Extents disponíveis no PV. |
| 📂 **Free PE** | `0` | Quantidade de Physical Extents livres. |
| 📌 **Allocated PE** | `0` | Quantidade de Physical Extents já utilizados. |
| 🆔 **PV UUID** | `7YIW1H-rEVU-7XUy-k3wx-iwp7-c1qh-5KAdll` | Identificador único do Physical Volume dentro do LVM. |
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
```

Entendendo a saída do comando: __`sudo vgs`__<br>
| **Campo** | **ubuntu-vg** | **vg_dados** | **Descrição** |
| :-------- | :------------ | :----------- | :------------ |
| 🏷️ **Volume Group (VG)** | `ubuntu-vg` | `vg_dados` | Nome do Grupo de Volumes. |
| 💽 **#PV** | `1` | `1` | Quantidade de Physical Volumes pertencentes ao VG. |
| 📂 **#LV** | `5` | `0` | Quantidade de Logical Volumes existentes no VG. |
| 📸 **#SN** | `0` | `0` | Quantidade de Snapshots LVM existentes no VG. |
| ⚙️ **Atributos (Attr)** | `wz--n-` | `wz--n-` | Estado e características do Volume Group. |
| 💾 **Capacidade Total (VSize)** | `<98,00 GiB` | `49,96 GiB`  | Capacidade total disponível no Volume Group. |
| 📂 **Espaço Livre (VFree)** | `16,00 GiB` | `49,96 GiB`  | Espaço ainda disponível para criação ou expansão de Logical Volumes. |
---

```bash
#verificando as informações detalhadas do Volume Group no Ubuntu Server
#opção do comando vgdisplay: (Display attributes of volume group(s))
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/vgdisplay.8.html
sudo vgdisplay vg_dados
```

Entendendo a saída do comando: __`sudo vgdisplay vg_dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🏷️ **VG Name** | `vg_dados` | Nome do Volume Group. |
| 🆔 **System ID** | *(vazio)* | Identificador do sistema. Normalmente permanece vazio em ambientes locais (não clusterizados). |
| 📦 **Format** | `lvm2` | Formato de metadados utilizado pelo LVM. |
| 🗂️ **Metadata Areas** | `1` | Quantidade de áreas de metadados armazenadas no Volume Group. |
| 🔢 **Metadata Sequence No** | `1` | Número da versão dos metadados. É incrementado sempre que ocorre alguma alteração no VG. |
| ✍️ **VG Access** | `read/write` | O Volume Group permite operações de leitura e gravação. |
| 🔄 **VG Status** | `resizable` | O Volume Group pode ser expandido adicionando novos Physical Volumes. |
| 📂 **MAX LV** | `0` | Quantidade máxima de Logical Volumes permitida. Valor **0** significa ilimitado. |
| 💽 **Cur LV** | `0` | Quantidade atual de Logical Volumes existentes no VG. |
| 🔓 **Open LV** | `0` | Número de Logical Volumes atualmente abertos (montados ou em uso). |
| 💾 **Max PV** | `0` | Quantidade máxima de Physical Volumes permitida. Valor **0** significa ilimitado. |
| 📀 **Cur PV** | `1` | Quantidade atual de Physical Volumes pertencentes ao VG. |
| ✅ **Act PV** | `1` | Quantidade de Physical Volumes ativos no Volume Group. |
| 💽 **VG Size** | `49,96 GiB` | Capacidade total do Volume Group. |
| 📦 **PE Size** | `4,00 MiB` | Tamanho de cada **Physical Extent (PE)**. Este é o bloco básico de alocação do LVM. |
| 🔢 **Total PE** | `12791` | Quantidade total de Physical E |
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
```

Entendendo a saída do comando: __`sudo lvs`__<br>
| **Campo** | **lv-root** | **lv-swap** | **lv-home** | **lv-tmp** | **lv-var** | **lv_dados** | **Descrição** |
| :-------- | :---------- | :---------- | :---------- | :--------- | :--------- | :----------- | :------------ |
| 📂 **Logical Volume (LV)** | `lv-root` | `lv-swap` | `lv-home` | `lv-tmp` | `lv-var` | `lv_dados` | Nome do Logical Volume. |
| 🏷️ **Volume Group (VG)** | `ubuntu-vg` | `ubuntu-vg` | `ubuntu-vg` | `ubuntu-vg` | `ubuntu-vg` | `vg_dados` | Volume Group ao qual o LV pertence. |
| ⚙️ **Atributos (Attr)** | `-wi-ao----` | `-wi-ao----` | `-wi-ao----` | `-wi-ao----` | `-wi-ao----` | `-wi-a-----` | Estado operacional do Logical Volume. |
| 💾 **Tamanho (LSize)** | `<49,00 GiB` | `8,00 GiB` | `5,00 GiB` | `5,00 GiB` | `15,00 GiB` | `20,00 GiB` | Capacidade do Logical Volume. |
| 🏊 **Pool** | — | — | — | —  | — | — | Thin Pool associado (não utilizado). |
| 📀 **Origin** | — | — | — | — | — | — | Volume de origem de Snapshot (não utilizado). |
| 📊 **Data%** | — | — | — | — | — | — | Percentual de utilização de Thin Provisioning (não utilizado). |
| 🗂️ **Meta%** | — | — | — | — | — | — | Utilização dos metadados do Thin Pool (não utilizado). |
| 🔄 **Move** | — | — | — | — | — | — | Indica movimentação de dados entre discos (não utilizada). |
| 📝 **Log** | — | — | — | — | — | — | Log de espelhamento (Mirror Log), não utilizado. |
| 🔁 **Cpy%Sync** | — | — | — | — | — | — | Percentual de sincronização de cópias (Mirror/RAID), não utilizado. |
| 🔧 **Convert** | — | — | — | — | — | — | Conversão de tipo de LV em andamento (não utilizada). |
---

```bash
#verificando as informações detalhadas do Logical Volume no Ubuntu Server
#opção do comando lvdisplay: (Display attributes of logical volume(s))
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/lvdisplay.8.html
sudo lvdisplay /dev/vg_dados/lv_dados
```

Entendendo a saída do comando: __`sudo lvdisplay /dev/vg_dados/lv_dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📁 **LV Path** | `/dev/vg_dados/lv_dados` | Caminho completo do dispositivo lógico utilizado pelo sistema operacional. |
| 🏷️ **LV Name** | `lv_dados` | Nome do Logical Volume. |
| 📦 **VG Name** | `vg_dados` | Volume Group ao qual o Logical Volume pertence. |
| 🆔 **LV UUID** | `4XOVmh-hQLN-UxHe-osV3-VN1G-ggLz-n2NpP5` | Identificador único do Logical Volume dentro do LVM. |
| ✍️ **LV Write Access** | `read/write` | Permite operações de leitura e gravação no Logical Volume. |
| 🖥️ **LV Creation Host** | `srvvaamonde.pti.intra` | Host onde o Logical Volume foi criado. |
| 🕒 **LV Creation Time** | `2026-07-26 15:31:06 -0300` | Data e hora da criação do Logical Volume. |
| ✅ **LV Status** | `available` | Indica que o Logical Volume está ativo e disponível para utilização. |
| 🔓 **# open** | `0` | Quantidade de processos utilizando o Logical Volume. Valor **0** indica que ele ainda não está montado nem em uso. |
| 💾 **LV Size** | `20,00 GiB` | Capacidade total do Logical Volume. |
| 📦 **Current LE** | `5120` | Quantidade de **Logical Extents (LE)** alocados ao Logical Volume. |
| 🧩 **Segments** | `1` | Número de segmentos físicos que compõem o Logical Volume. |
| 📍 **Allocation** | `inherit` | Método de alocação herdado das configurações do Volume Group. |
| 🚀 **Read Ahead Sectors** | `auto` | Ajuste automático da leitura antecipada (Read Ahead) para melhorar o desempenho de acesso sequencial. |
| ⚙️ **Currently Set To** | `16384` | Valor atual de setores configurados para Read Ahead. |
| 🔢 **Block Device** | `252:5` | Número **Major:Minor** do dispositivo de bloco gerenciado pelo kernel Linux. |
---

## 07_ Formatando e Montando o Logical Volume no Ubuntu Server
```bash
#formatando o Logical Volume com o sistema de arquivos ext4 no Ubuntu Server
#opção do comando mkfs.ext4: (cria um sistema de arquivos ext4 no dispositivo informado)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/mkfs.ext4.8.html
sudo mkfs.ext4 /dev/vg_dados/lv_dados
```

Entendendo a saída do comando: __`sudo mkfs.ext4 /dev/vg_dados/lv_dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📦 **Filesystem Blocks** | `5242880` | Quantidade total de blocos de dados criados no sistema de arquivos. |
| 📏 **Block Size** | `4 KiB (4096 bytes)` | Tamanho de cada bloco utilizado para armazenamento dos dados. |
| 📄 **Inodes** | `1310720` | Quantidade total de inodes disponíveis para armazenar metadados de arquivos e diretórios. |
| 🆔 **Filesystem UUID** | `ddad3a66-9a2b-41aa-aff1-06e32a50fcd0` | Identificador único do sistema de arquivos, normalmente utilizado no arquivo `/etc/fstab`. |
| 💾 **Superblock Backups** | `32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 4096000` | Blocos onde foram gravadas cópias de segurança do Superbloco para recuperação em caso de corrupção. |
| 📑 **Group Tables** | `done` | Estruturas que organizam os grupos de blocos foram criadas com sucesso. |
| 📂 **Inode Tables** | `done` | Tabelas de inodes criadas corretamente. |
| 📓 **Journal** | `32768 blocks` | Área de journaling criada para registrar operações antes de gravá-las definitivamente no disco, aumentando a integridade dos dados. |
| ✅ **Filesystem Creation** | `done` | Sistema de arquivos criado com sucesso e pronto para utilização. |
| 🧾 **Filesystem Accounting** | `done` | Informações administrativas e estatísticas do sistema de arquivos gravadas corretamente. |
---

```bash
#criando o diretório de ponto de montagem do Logical Volume no Ubuntu Server
#opção do comando mkdir: -p (cria diretórios pais conforme necessário), -v (modo verboso)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/mkdir.1.html
sudo mkdir -pv /dados

#verificando o UUID do sistema de arquivos criado no Logical Volume
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/blkid.8.html
sudo blkid /dev/vg_dados/lv_dados
```

Entendendo a saída do comando: __`sudo blkid /dev/vg_dados/lv_dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📁 **Dispositivo** | `/dev/vg_dados/lv_dados` | Caminho do Logical Volume onde o sistema de arquivos está armazenado. |
| 🆔 **UUID** | `ddad3a66-9a2b-41aa-aff1-06e32a50fcd0` | Identificador único do sistema de arquivos. É recomendado utilizá-lo no arquivo `/etc/fstab` para montagem automática, pois permanece o mesmo mesmo que o nome do dispositivo seja alterado. |
| 📏 **BLOCK_SIZE** | `4096` bytes (4 KiB) | Tamanho do bloco lógico utilizado pelo sistema de arquivos EXT4 para armazenar dados. |
| 📂 **TYPE** | `ext4` | Tipo de sistema de arquivos criado sobre o Logical Volume. |
---

```bash
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
#Opção default: rw,suid,dev,exec,auto,nouser,async
#Identificação do LV        Ponto de   Sistema de   Opção de   Dump   FSCK
#      Dados                Montagem    Arquivos    Montagem
UUID=SEU_UUID_DO_LV_DADOS   /dados     ext4         defaults    0      2
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>

#reinicializando as configurações do SystemD com as mudanças do Fstab
#opção do comando systemctl: daemon-reload (Reload the systemd manager configuration)
#mais informações acesse a documentação oficial em
sudo systemctl daemon-reload

#montando todos os sistemas de arquivos listados no Fstab no Ubuntu Server
#opção do comando mount: -v (Enables verbose mode), -a (Mount all filesystems mentioned in fstab)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/mount.8.html
sudo mount -va
```

Entendendo a saída do comando: __`sudo mount -va`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🚫 **none** | `ignored` | Entrada especial do `/etc/fstab` que não representa um sistema de arquivos físico. Foi ignorada durante o processamento. |
| 📁 **/** | `ignored` | A partição raiz (`/`) já estava montada pelo sistema durante o boot, não sendo necessário montá-la novamente. |
| 🚀 **/boot** | `already mounted` | A partição `/boot` já se encontrava montada. |
| 🏠 **/home** | `already mounted` | O sistema de arquivos `/home` já estava montado. |
| 📂 **/tmp** | `already mounted` | O sistema de arquivos `/tmp` já estava montado. |
| 📦 **/var** | `already mounted` | O sistema de arquivos `/var` já estava montado. |
| 💾 **/dados** | `successfully mounted` | O novo sistema de arquivos foi montado com sucesso conforme definido no `/etc/fstab`. |
---

```bash
#verificando o espaço em disco e o ponto de montagem do Logical Volume no Ubuntu Server
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /dados
```

Entendendo a saída do comando: __`sudo df -h /dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Filesystem** | `/dev/mapper/vg_dados-lv_dados` | Logical Volume criado no Volume Group `vg_dados`, formatado com o sistema de arquivos EXT4 e montado em `/dados`. |
| 📦 **Size** | `20G` | Capacidade total disponível do sistema de arquivos. |
| 📁 **Used** | `2,1M` | Espaço atualmente utilizado pelos metadados e estruturas iniciais do sistema de arquivos EXT4. |
| 📂 **Avail** | `19G` | Espaço livre disponível para armazenamento de dados. |
| 📈 **Use%** | `1%` | Percentual de utilização do sistema de arquivos. |
| 📌 **Mounted on** | `/dados` | Diretório onde o Logical Volume está montado e acessível aos usuários e aplicações. |
---

## 08_ Localização dos Arquivos de Configuração do LVM no Ubuntu Server
```bash
/etc/lvm/                <-- Diretório de configuração do LVM
/etc/lvm/lvm.conf        <-- Arquivo principal de configuração do LVM
/etc/lvm/backup/         <-- Diretório de ackup automático dos metadados atuais de cada Volume Group
/etc/lvm/archive/        <-- Diretório de histórico de versões anteriores dos metadados (a cada alteração)
/etc/lvm/profile/        <-- Diretório do perfil de configuração do LVM
/etc/lvm/lvmlocal.conf   <-- Arquivo de configurações locais específicas do host
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
| 📀 **PV Name** | `/dev/md0` | Nome do Physical Volume utilizado pelo LVM. |
| 📦 **VG Name** | `vg_dados` | Volume Group ao qual o Physical Volume pertence. |
| 💽 **PV Size** | `<49,97 GiB` | Capacidade total disponível do Physical Volume. |
| 🚫 **Not Usable** | `0` | Espaço reservado pelo LVM para metadados. Neste caso, não existe espaço inutilizável. |
| ✅ **Allocatable** | `yes` | Indica que o Physical Volume pode receber novas alocações de extents para Logical Volumes. |
| 📏 **PE Size** | `4,00 MiB` | Tamanho de cada Physical Extent (PE). Todas as alocações do LVM são realizadas em múltiplos desse tamanho. |
| 🧱 **Total PE** | `12791` | Quantidade total de Physical Extents existentes no PV. |
| 🟢 **Free PE** | `7671` | Número de Physical Extents ainda disponíveis para criação ou expansão de Logical Volumes. |
| 📌 **Allocated PE** | `5120` | Número de Physical Extents atualmente utilizados por Logical Volumes. |
| 🆔 **PV UUID** | `7YIW1H-rEVU-7XUy-k3wx-iwp7-c1qh-5KAdll` | Identificador único do Physical Volume. |
---

| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📦 **Physical Extent Inicial** | `0` | Primeiro Physical Extent utilizado pelo Logical Volume. |
| 📦 **Physical Extent Final** | `5119` | Último Physical Extent atualmente alocado ao Logical Volume. |
| 💾 **Logical Volume** | `/dev/vg_dados/lv_dados` | Logical Volume que utiliza esses Physical Extents. |
| 🔢 **Logical Extents (LE)** | `0 a 5119` | Logical Extents correspondentes aos Physical Extents utilizados pelo LV. |
| 🟢 **PE Livres** | `5120 a 12790` | Faixa de Physical Extents ainda não utilizada e disponível para novas alocações ou expansão do Volume Group. |
---

| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📏 **Tamanho de cada PE/LE** | `4 MiB` | Tanto os Physical Extents quanto os Logical Extents possuem o mesmo tamanho definido pelo Volume Group. |
| 📦 **PE Utilizados** | `5120` | Quantidade de Physical Extents consumidos pelo Logical Volume `lv_dados`. |
| 💽 **Espaço Utilizado** | `20 GiB` | Resultado da multiplicação de **5120 × 4 MiB**, correspondente ao tamanho do Logical Volume criado. |
| 🟢 **PE Disponíveis** | `7671` | Espaço livre que pode ser utilizado para criar novos Logical Volumes ou expandir os existentes. |
---

```bash
#verificando de forma resumida a relação entre PE Total, PE Alocado e PE Livre no Volume Group
#opções do comando vgs: -o (Select columns for output), +free (adiciona a coluna de espaço livre)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/vgs.8.html
sudo vgs -o vg_name,vg_extent_count,vg_free_count,vg_extent_size vg_dados
```

Entendendo a saída do comando: __`sudo vgs -o vg_name,vg_extent_count,vg_free_count,vg_extent_size vg_dados`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📦 **VG Name** | `vg_dados` | Volume Group criado sobre o dispositivo RAID-1 (`/dev/md0`) destinado ao armazenamento de dados. |
| 📊 **VG Extent Count (#Ext)** | `12791` | Quantidade total de **Physical Extents (PE)** existentes no Volume Group. |
| 🟢 **VG Free Count (Free)** | `7671` | Número de Physical Extents ainda disponíveis para expansão do `lv_dados` ou criação de novos Logical Volumes. |
| 📏 **VG Extent Size (Ext)** | `4,00 MiB` | Tamanho de cada Physical Extent utilizado pelo Volume Group. |
---

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
