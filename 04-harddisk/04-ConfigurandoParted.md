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
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
Relax-and-Recover: https://relax-and-recover.org/<br>
Borg Backup Server (Referência do próximo procedimento): https://github.com/marcpope/borgbackupserver

Conteúdo estudado nessa configuração:<br>
#01_ Adicionando o Hard Disk de Backup na Máquina Virtual UbuntuOnPremise no Oracle VirtualBOX<br>
#02_ Verificando os Discos Reconhecidos no Ubuntu Server<br>
#03_ Criando a Tabela e Partição GPT do Disco de Backup no Ubuntu Server<br>
#04_ Formatando a Partição com o Sistema de Arquivos EXT4 no Ubuntu Server<br>
#05_ Criando o Diretório de Ponto de Montagem do Backup no Ubuntu Server<br>
#06_ Verificando o UUID da Partição de Backup no Ubuntu Server<br>
#07_ Configurando a Montagem Automática no Fstab no Ubuntu Server<br>
#08_ Montando e Verificando o Espaço em Disco da Partição de Backup no Ubuntu Server<br>
#09_ Preparando Permissões e Estrutura de Diretórios para o BorgBackupServer<br>
#10_ Localização dos Arquivos de Configuração do Particionamento no Ubuntu Server<br>

[![Particionamento Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Particionamento Ubuntu Server")

Link da vídeo aula: 

> **OBSERVAÇÃO IMPORTANTE:** este procedimento é a **base (pré-requisito)** para o próximo passo do Workflow: __`11. Configuração do Backup`__, onde o disco particionado e formatado aqui será utilizado como **destino (repositório) dos backups** gerados pelo software **BorgBackupServer**, responsável por proteger a partição de dados criada anteriormente no procedimento de **LVM (Logical Volume Manager)**.

| **🧱 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🗂️ **Particionamento Tradicional** | Divisão de um disco físico em uma ou mais áreas lógicas (Partições), gravadas diretamente na Tabela de Partições do disco (GPT/MBR), sem nenhuma camada de abstração adicional. | Ideal para discos com finalidade única e simples, como um **destino de backup**, onde não há necessidade de Redundância (RAID) nem de Flexibilidade de Redimensionamento (LVM). |
| 🗄️ **GPT (GUID Partition Table)** | Tabela de partições moderna, sucessora da MBR, com suporte a discos maiores que 2 TB. | Padroniza a criação de partições no disco de Backup, mantendo compatibilidade com o restante do ambiente (mesmo padrão utilizado no RAID-1 e no disco de Sistema). |
| 📂 **EXT4 (Fourth Extended Filesystem)** | Sistema de arquivos padrão e estável do GNU/Linux, com suporte a Journaling. | Garante integridade dos dados do repositório de Backup, com bom desempenho para escrita sequencial de grandes arquivos, cenário típico do BorgBackupServer. |
| 🆔 **UUID (Universally Unique Identifier)** | Identificador único de 128 bits atribuído ao sistema de arquivos criado na partição. | Garante a montagem correta e persistente da partição de Backup no `/etc/fstab`, independente da ordem de detecção do disco (`/dev/sdX` pode mudar, o UUID não). |
| 📦 **/etc/fstab** | Arquivo de configuração responsável por montar automaticamente os sistemas de arquivos durante o Boot do Ubuntu Server. | Assegura que a partição de Backup esteja sempre disponível após reinicializações, sem necessidade de montagem manual. |
---

> **DIFERENÇA IMPORTANTE:** ao contrário dos procedimentos anteriores (**RAID-1** e **LVM**), este disco de Backup **NÃO** utiliza `mdadm` (Software RAID) nem `lvm2` (Volume Manager). É um **Particionamento Tradicional**, simples e direto, pois o objetivo é apenas disponibilizar um espaço de armazenamento isolado, dedicado exclusivamente ao repositório do **BorgBackupServer**, sem misturar a camada de Backup com a camada de Dados (LVM) protegida por Redundância (RAID-1).

## 01_ Adicionando o Hard Disk de Backup na Máquina Virtual UbuntuOnPremise no Oracle VirtualBOX

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
              Localização: backup-01.vdi
              Tamanho: 50,00 GB (altere conforme a sua necessidade)
          <Finalizar>
        backup-01.vdi <Escolher>
    <OK>

03) Selecionar a Máquina Virtual: UbuntuOnPremise: 
<Iniciar>
```

> **OBSERVAÇÃO IMPORTANTE:** neste roteiro o novo disco será reconhecido pelo Ubuntu Server como __`/dev/sdd`__, pois os dispositivos __`/dev/sdb`__ e __`/dev/sdc`__ já estão em uso pelo Array do **RAID-1** (procedimento anterior). Sempre confira o dispositivo correto no seu cenário antes de prosseguir.

## 02_ Verificando os Discos Reconhecidos no Ubuntu Server

```bash
#verificando se já existe alguma assinatura de sistema de arquivos, RAID ou LVM no disco novo
#opção do comando wipefs: -n (dry-run, apenas simula sem apagar nada)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/wipefs.8.html
sudo wipefs -n /dev/sdd
```

> **OBSERVAÇÃO IMPORTANTE:** discos recém-criados no VirtualBOX normalmente não retornam nada, só execute o comando abaixo se o dry-run acima detectar alguma assinatura residual.

```bash
#removendo todas as assinaturas de sistema de arquivos, RAID ou LVM no disco novo
#opção do comando wipefs: -a (apaga todas as assinaturas encontradas)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/wipefs.8.html
sudo wipefs -a /dev/sdd

#listando os discos e partições em formato de árvore no Ubuntu Server
#opção do comando lsblk: -f (mostra sistema de arquivos e UUID)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsblk.8.html
sudo lsblk -f

#listando as tabelas de partição de todos os discos reconhecidos
#opção do comando fdisk: -l (List the partition tables for the specified devices and then exit)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/fdisk.8.html
sudo fdisk -l /dev/sdd
```

Entendendo a saída do comando: __`sudo lsblk -f`__ (Disco Novo)<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Disco** | `/dev/sdd` | Quarto disco físico (virtual) reconhecido pelo Ubuntu Server, ainda sem particionamento. |
| 🗂️ **Sistema de Arquivos** | *(vazio)* | Confirma que o disco está limpo, sem sistema de arquivos, RAID ou LVM configurado. |
| 🆔 **UUID** | *(vazio)* | Não existe UUID, pois ainda não há sistema de arquivos criado no disco. |
---

## 03_ Criando a Tabela e Partição GPT do Disco de Backup no Ubuntu Server

```bash
#criando a tabela de particionamento GPT no Disco /dev/sdd
#opções do comando gdisk: o (create a new empty GUID partition table (GPT)), n (add a new partition),
#t (change a partition's type code), p (print the partition table), v (verify disk), w (write table
#to disk and exit)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/gdisk
sudo gdisk /dev/sdd
  #criando a tabela GPT no disco /dev/sdd
  Command (? for help): o <Enter>
    This option deletes all partitions and creates a new protective MBR.
    Proceed? (Y/N): y <Enter>
  #criando a partição GPT no disco /dev/sdd (utilizando 100% do espaço disponível)
  Command (? for help): n <Enter>
    Partition number (1-128, default 1): <Enter>
    First sector (34-104857566, default = 2048) or {+-}size{KMGTP}: <Enter>
    Last sector (2048-104857566, default = 104855551) or {+-}size{KMGTP}: <Enter>
    Current type is 8300 (Linux filesystem)
    Hex code or GUID (L to show codes, Enter = 8300): <Enter>
    Changed type of partition to 'Linux filesystem'
  #visualizando as informações da tabela e partição GPT no disco /dev/sdd
  Command (? for help): p <Enter>
  #verificando problemas no disco /dev/sdd
  Command (? for help): v <Enter>
  #salvando as configurações da tabela e partição GPT no disco /dev/sdd
  Command (? for help): w <Enter>
    Do you want to proceed? (Y/N): y <Enter>
```

> **OBSERVAÇÃO IMPORTANTE:** diferente do procedimento de **RAID-1** (`04-harddisk/02-ConfigurandoRAID-1.md`), aqui o Código Hexadecimal (Hex code) da partição __`PERMANECE 8300 (Linux filesystem)`__, e **NÃO** deve ser alterado para __`fd00 (Linux RAID)`__, pois este disco não fará parte de nenhum Array de RAID.

```bash
#listando a partição criada no Disco /dev/sdd do Ubuntu Server
#opção do comando cat: -n (number line)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
sudo cat -n /proc/partitions | grep -i sdd

#verificando a nova tabela de partição GPT criada no Disco /dev/sdd
#opção do comando parted: -l (lists partition layout on all block devices)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/parted.8.html
sudo parted -l /dev/sdd
```

Entendendo a saída do comando: __`sudo parted -l /dev/sdd`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Disco** | `/dev/sdd` | Disco dedicado ao repositório de Backup. |
| 🗂️ **Tabela de Partições** | `gpt` | Confirma a criação da tabela GPT no disco. |
| 📂 **Partição 1** | `/dev/sdd1` | Partição única, ocupando 100% do espaço disponível do disco. |
| 🏷️ **Sistema de Arquivos** | *(ainda não formatado)* | A partição foi criada, porém ainda não recebeu nenhum sistema de arquivos. |
---

## 04_ Formatando a Partição com o Sistema de Arquivos EXT4 no Ubuntu Server

```bash
#formatando a partição /dev/sdd1 com o sistema de arquivos ext4 no Ubuntu Server
#opção do comando mkfs.ext4: (cria um sistema de arquivos ext4 no dispositivo informado)
#opção -L (Label): atribui um rótulo (nome) ao sistema de arquivos, facilitando a identificação
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/mkfs.ext4.8.html
sudo mkfs.ext4 -L backup01 /dev/sdd1
```

Entendendo a saída do comando: __`sudo mkfs.ext4 -L backup01 /dev/sdd1`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🏷️ **Label** | `backup01` | Rótulo atribuído ao sistema de arquivos, útil para identificação rápida em comandos como `lsblk` e `blkid`. |
| 📏 **Block Size** | `4 KiB (4096 bytes)` | Tamanho de cada bloco utilizado para armazenamento dos dados. |
| 📄 **Inodes** | *(quantidade calculada)* | Quantidade total de inodes disponíveis para armazenar metadados de arquivos e diretórios. |
| 🆔 **Filesystem UUID** | *(UUID gerado)* | Identificador único do sistema de arquivos, utilizado posteriormente no `/etc/fstab`. |
| 📓 **Journal** | *(blocos reservados)* | Área de journaling criada para registrar operações antes de gravá-las definitivamente no disco, aumentando a integridade do repositório de Backup. |
| ✅ **Filesystem Creation** | `done` | Sistema de arquivos criado com sucesso e pronto para utilização. |
---

## 05_ Criando o Diretório de Ponto de Montagem do Backup no Ubuntu Server

```bash
#criando o diretório de ponto de montagem do repositório de Backup no Ubuntu Server
#opção do comando mkdir: -p (cria diretórios pais conforme necessário), -v (modo verboso)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/mkdir.1.html
sudo mkdir -pv /backup
```

> **OBSERVAÇÃO IMPORTANTE:** o diretório __`/backup`__ será utilizado no próximo procedimento (__`11. Configuração do Backup`__) como o **Repositório (Repository)** do **BorgBackupServer**, onde ficarão armazenados os Snapshots incrementais e deduplicados da partição de Dados criada no procedimento de **LVM** (`/dados`, Volume Lógico `lv_dados`).

## 06_ Verificando o UUID da Partição de Backup no Ubuntu Server

```bash
#verificando o UUID e o Label do sistema de arquivos criado na partição de Backup
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/blkid.8.html
sudo blkid /dev/sdd1
```

Entendendo a saída do comando: __`sudo blkid /dev/sdd1`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 📁 **Dispositivo** | `/dev/sdd1` | Partição onde o repositório de Backup está armazenado. |
| 🆔 **UUID** | *(gerado automaticamente)* | Identificador único do sistema de arquivos. Recomendado para uso no `/etc/fstab`, pois permanece o mesmo mesmo que o nome do dispositivo (`/dev/sdX`) seja alterado. |
| 🏷️ **LABEL** | `backup01` | Rótulo definido durante a formatação, facilita a identificação do disco de Backup. |
| 📂 **TYPE** | `ext4` | Tipo de sistema de arquivos criado sobre a partição. |
| 🆔 **PARTUUID** | *(gerado automaticamente)* | Identificador único da partição GPT. |
---

## 07_ Configurando a Montagem Automática no Fstab no Ubuntu Server

```bash
#fazendo o backup do arquivo de configuração original do Fstab
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/fstab /etc/fstab.bkp-backup

#editando o arquivo de configuração do Fstab para montagem automática no boot
sudo vim /etc/fstab

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#adicionando a entrada de montagem da partição de Backup no Ubuntu Server
#OBSERVAÇÃO IMPORTANTE: ALTERAR O UUID PARA O UUID GERADO NO SEU CENÁRIO (comando blkid acima)
#Opção default: rw,suid,dev,exec,auto,nouser,async
#Opção nofail: evita que o Boot trave/pare caso o disco de Backup esteja indisponível
#Identificação da Partição   Ponto de   Sistema de   Opção de           Dump   FSCK
#      Backup                Montagem    Arquivos    Montagem
UUID=SEU_UUID_DA_PARTICAO_SDD1   /backup   ext4   defaults,nofail    0      2
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>

#reinicializando as configurações do SystemD com as mudanças do Fstab
#opção do comando systemctl: daemon-reload (Reload the systemd manager configuration)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl daemon-reload
```

> **OBSERVAÇÃO IMPORTANTE:** a opção __`nofail`__ é uma boa prática para discos de **Backup**, pois evita que o Ubuntu Server fique preso na tela de Boot (Emergency Mode) caso o disco de Backup esteja fisicamente desconectado ou indisponível no momento da inicialização.

## 08_ Montando e Verificando o Espaço em Disco da Partição de Backup no Ubuntu Server

```bash
#montando todos os sistemas de arquivos listados no Fstab no Ubuntu Server
#opção do comando mount: -v (Enables verbose mode), -a (Mount all filesystems mentioned in fstab)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/mount.8.html
sudo mount -va

#verificando o espaço em disco e o ponto de montagem da partição de Backup no Ubuntu Server
#opção do comando df: -h (human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/df.1.html
sudo df -h /backup

#listando os discos e partições em formato de árvore, incluindo o disco de Backup montado
#opção do comando lsblk: -f (mostra sistema de arquivos e UUID)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsblk.8.html
sudo lsblk -f
```

Entendendo a saída do comando: __`sudo df -h /backup`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Filesystem** | `/dev/sdd1` | Partição de Backup formatada com o sistema de arquivos EXT4 e montada em `/backup`. |
| 📦 **Size** | `50G` | Capacidade total disponível do sistema de arquivos de Backup. |
| 📁 **Used** | `24K` | Espaço atualmente utilizado pelos metadados e estruturas iniciais do sistema de arquivos EXT4. |
| 📂 **Avail** | `47G` | Espaço livre disponível para armazenamento dos Snapshots do BorgBackupServer. |
| 📈 **Use%** | `1%` | Percentual de utilização do sistema de arquivos. |
| 📌 **Mounted on** | `/backup` | Diretório onde a partição de Backup está montada e acessível pelo BorgBackupServer. |
---

## 09_ Preparando Permissões e Estrutura de Diretórios para o BorgBackupServer

> **OBSERVAÇÃO IMPORTANTE:** esta etapa apenas prepara a estrutura de diretórios e permissões da partição de Backup. A instalação, configuração e inicialização dos Repositórios do **BorgBackupServer** propriamente ditos serão detalhadas no próximo procedimento do Workflow: __`11. Configuração do Backup`__.

```bash
#criando a estrutura de diretórios do repositório de Backup, separado por tipo de dado protegido
#opção do comando mkdir: -p (cria diretórios pais conforme necessário), -v (modo verboso)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/mkdir.1.html
sudo mkdir -pv /backup/repository/lv-dados

#criando o grupo dedicado para administração dos Backups no Ubuntu Server
#opção do comando groupadd: (Create a new group)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/groupadd.8.html
sudo groupadd backupadm

#ajustando o proprietário (Owner) e grupo (Group) do diretório de Backup no Ubuntu Server
#opção do comando chown: -R (recursive), -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/chown.1.html
sudo chown -Rv root:backupadm /backup

#ajustando as permissões do diretório de Backup no Ubuntu Server
#opção do comando chmod: -R (recursive), -v (verbose)
#770 = Leitura/Escrita/Execução para Owner e Group, Sem acesso para Others
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/chmod.1.html
sudo chmod -Rv 770 /backup

#verificando as permissões finais aplicadas no diretório de Backup no Ubuntu Server
#opção do comando ls: -lh (long listing, human-readable)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.html
sudo ls -lh /backup
```

Entendendo a saída do comando: __`sudo ls -lh /backup`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🔐 **Permissões** | `drwxrwx---` | Leitura, Escrita e Execução liberadas para o Proprietário (`root`) e para o Grupo (`backupadm`); sem nenhum acesso para outros usuários. |
| 👤 **Proprietário (Owner)** | `root` | Usuário responsável pela administração do repositório de Backup. |
| 👥 **Grupo (Group)** | `backupadm` | Grupo dedicado, criado para futuramente conceder acesso ao serviço/usuário do **BorgBackupServer**, sem a necessidade de privilégios totais de `root`. |
| 📁 **Diretório** | `repository/lv-dados` | Subdiretório destinado especificamente ao Repositório de Backup da partição de Dados (LVM) criada no procedimento anterior. |
---

## 10_ Localização dos Arquivos de Configuração do Particionamento no Ubuntu Server

| **📂 Caminho** | **📝 Descrição** |
| :------------- | :--------------- |
| **`/etc/fstab`** | Arquivo principal responsável pela montagem automática de sistemas de arquivos durante o Boot, incluindo a partição de Backup (`/dev/sdd1`) configurada neste procedimento. |
| **`/etc/fstab.bkp-backup`** | Cópia de segurança (backup) do arquivo `/etc/fstab` realizada antes da inclusão da nova entrada de montagem. |
| **`/backup`** | Ponto de montagem da partição dedicada ao Repositório de Backup, utilizada pelo **BorgBackupServer** no próximo procedimento. |
| **`/backup/repository/lv-dados`** | Subdiretório reservado para armazenar especificamente os Backups da partição de Dados (`/dados`, Volume Lógico `lv_dados`) protegida pelo **RAID-1 + LVM**. |
---

```bash
#analisando os Log's do Kernel referente ao disco e à partição de Backup no Ubuntu Server
#opção do comando journalctl: k (kernel messages, equivalente ao comando dmesg)
#opção do comando grep: -i (Ignore case distinctions in patterns and input data)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/grep.1.html
sudo journalctl -k | grep -i sdd
```

> **PRÓXIMO PASSO DO WORKFLOW:** com a partição de Backup __`/dev/sdd1`__ criada, formatada em __`ext4`__ e montada de forma persistente em __`/backup`__, o ambiente está pronto para o procedimento __`11. Configuração do Backup`__, onde será instalado e configurado o **BorgBackupServer**, responsável por gerar Backups incrementais, deduplicados e criptografados da partição de Dados (__`/dados`__) para o repositório: __`/backup/repository/lv-dados`__.
