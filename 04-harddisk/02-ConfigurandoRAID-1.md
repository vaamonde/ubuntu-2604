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
Data de atualização: 21/07/2026<br>
Versão: 0.02<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

Conteúdo estudado nessa configuração:<br>

[![RAID-1 Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( RAID-1 Ubuntu Server")

Link da vídeo aula: 

| **🛡️ Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🗄️ **RAID (Redundant Array of Independent Disks)** | Tecnologia que combina dois ou mais discos físicos em uma única unidade lógica, distribuindo ou espelhando os dados entre eles. | Aumenta a **disponibilidade**, **desempenho** e/ou **redundância** dos dados, dependendo do nível de RAID escolhido. |
| 🪞 **RAID 1 (Mirroring/Espelhamento)** | Nível de RAID que grava os **mesmos dados simultaneamente em dois ou mais discos**, criando uma cópia idêntica (espelho) entre eles. | Garante **redundância total dos dados**: caso um disco falhe, o sistema continua funcionando normalmente com o disco restante, sem perda de informação. |
| ⚙️ **mdadm (Multiple Disk Administration)** | Ferramenta padrão do GNU/Linux para criar, gerenciar e monitorar **Software RAID** através do subsistema **md (Multiple Devices)** do kernel. | Permite criar, montar, monitorar, recuperar e remover Arrays de RAID diretamente via linha de comando, sem depender de controladora RAID física (Hardware RAID). |
| 🔢 **Array** | Conjunto lógico de discos físicos agrupados pelo mdadm para formar um único dispositivo RAID (ex: `/dev/md0`). | Representa a unidade de armazenamento resultante da combinação dos discos físicos conforme o nível de RAID configurado. |
| 🧩 **Superblock** | Estrutura de metadados gravada em cada disco membro do Array, contendo informações sobre o RAID (nível, UUID, discos membros, estado de sincronismo). | Permite que o kernel identifique e remonte automaticamente o Array de RAID durante a inicialização do sistema. |
| 🔄 **Sincronismo (Resync)** | Processo em que o mdadm copia os dados de um disco para o(s) outro(s) até que fiquem idênticos (espelhados). | Garante a consistência dos dados entre todos os discos membros do RAID 1, sendo executado na criação do Array e após a substituição de um disco. |
| 🚨 **Estado Degradado (Degraded)** | Condição do Array de RAID quando um ou mais discos membros falham ou são removidos, mas o Array continua funcional com os discos restantes. | Indica que o RAID está operando sem redundância total, sendo necessário substituir o disco com falha o mais rápido possível para restaurar a proteção total dos dados. |
| 🆘 **Hot Spare** | Disco reserva configurado no Array, que permanece inativo até que um dos discos membros falhe. | Quando ocorre uma falha, o mdadm inicia automaticamente a reconstrução (rebuild) do RAID utilizando o disco Hot Spare, reduzindo o tempo em estado degradado. |
---

| **RAID** | **Redundância** | **Performance** | **Mínimo de Discos** | **Tolerância** |
| -------- | --------------- | --------------- | -------------------- | -------------- |
| **RAID0** | ❌ | ⭐⭐⭐⭐⭐ | 2 | Nenhuma |
| **RAID1** | ✅ | ⭐⭐⭐ | 2 | 1 disco |
| **RAID5** | ✅ | ⭐⭐⭐⭐ | 3 | 1 disco |
| **RAID6** | ✅ | ⭐⭐⭐ | 4 | 2 discos |
| **RAID10** | ✅ | ⭐⭐⭐⭐⭐ | 4 | até metade dos discos |
---

## 01_ Preparando os Discos para a Configuração do RAID-1 no Ubuntu Server
```bash
#verificando se já existe alguma assinatura de sistema de arquivos, RAID ou LVM nos discos novos
#opção do comando wipefs: -n (dry-run, apenas simula sem apagar nada)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/wipefs.8.html
sudo wipefs -n /dev/sdb
sudo wipefs -n /dev/sdc
```

> **OBSERVAÇÃO IMPORTANTE:** discos recém-criados no VirtualBOX normalmente não retornam nada, só execute o comando abaixo se o dry-run acima detectar alguma assinatura residual

```bash
#removendo todas as assinatura de sistema de arquivos, RAID ou LVM nos discos novos
#opção do comando wipefs: -a (apaga todas as assinaturas encontradas)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/wipefs.8.html
sudo wipefs -a /dev/sdb
sudo wipefs -a /dev/sdc
```

## 02_ Verificando a versão do Sistema de RAID-1 do Ubuntu Server
```bash
#verificando a versão do sistema de gerenciamento de dispositivos RAID
#opção do comando mdadm: --version (Print version information for mdadm)
sudo mdadm --version
```

## 03_ Criando a Tabela e Partição GPT dos Discos para a Configuração do RAID-1 no Ubuntu Server
```bash
#verificando as tabelas de partições GPT dos Discos do RAID-1
#opção do comando gdisk: -l (list known partition types)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/gdisk
sudo gdisk -l /dev/sdb
sudo gdisk -l /dev/sdc
```

```bash
#criando a tabela de particionamento RAID-1 no Disco /dev/sdb
#opções do comando gdisk: o (create a new empty GUID partition table (GPT)), n (add a new partition), 
#t (change a partition's type code), p (print the partition table), v (verify disk), w (write table 
#to disk and exit)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/gdisk
sudo gdisk /dev/sdb
  #criando a tabela GPT no disco /dev/sdb
  Command (? for help): o <Enter>
    This option deletes all partitions and creates a new protective MBR.
    Proceed? (Y/N): y <Enter>
  #criando a partição GPT no disco /dev/sdb
  Command (? for help): n <Enter>
    Partition number (1-128, default 1): <Enter>
    First sector (34-104857566, default = 2048) or {+-}size{KMGTP}: <Enter>
    Last sector (2048-104857566, default = 104855551) or {+-}size{KMGTP}: <Enter>
    Current type is 8300 (Linux filesystem)
    Hex code or GUID (L to show codes, Enter = 8300): <Enter>
    Changed type of partition to 'Linux filesystem'
  #alterando a partição GPT para RAID no disco /dev/sdb
  Command (? for help): t <Enter>
    Hex code or GUID (L to show codes, Enter = 8300): fd00 <Enter>
  #visualizando as informações da tabela e partição GPT no disco /dev/sdb
  Command (? for help): p <Enter>
  #verificando problemas no disco /dev/sdb
  Command (? for help): v <Enter>
  #salvando as configurações da tabela e partição GPT no disco /dev/sdb
  Command (? for help): w <Enter>
    Do you want to proceed? (Y/N): y <Enter>
```

```bash
#criando a tabela de particionamento RAID-1 no Disco /dev/sdc
#opções do comando gdisk: o (create a new empty GUID partition table (GPT)), n (add a new partition), 
#t (change a partition's type code), p (print the partition table), v (verify disk), w (write table 
#to disk and exit)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/gdisk
sudo gdisk /dev/sdc
  #criando a tabela GPT no disco /dev/sdc
  Command (? for help): o <Enter>
    This option deletes all partitions and creates a new protective MBR.
    Proceed? (Y/N): y <Enter>
  #criando a partição GPT no disco /dev/sdc
  Command (? for help): n <Enter>
    Partition number (1-128, default 1): <Enter>
    First sector (34-104857566, default = 2048) or {+-}size{KMGTP}: <Enter>
    Last sector (2048-104857566, default = 104855551) or {+-}size{KMGTP}: <Enter>
    Current type is 8300 (Linux filesystem)
    Hex code or GUID (L to show codes, Enter = 8300): <Enter>
    Changed type of partition to 'Linux filesystem'
  #alterando a partição GPT para RAID no disco /dev/sdc
  Command (? for help): t <Enter>
    Hex code or GUID (L to show codes, Enter = 8300): fd00 <Enter>
  #visualizando as informações da tabela e partição GPT no disco /dev/sdc
  Command (? for help): p <Enter>
  #verificando problemas no disco /dev/sdc
  Command (? for help): v <Enter>
  #salvando as configurações da tabela e partição GPT no disco /dev/sdc
  Command (? for help): w <Enter>
    Do you want to proceed? (Y/N): y <Enter>
```

```bash
#listando as partições RAID-1 dos Disco /dev/sdb e /dev/sdc do Ubuntu Server
#opção do comando grep: -i (Ignore case distinctions in patterns and input data)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/grep.1.html
sudo blkid | grep -i 'sdb\|sdc'
```

## 04_ Criando o Array (Conjunto) dos Discos do RAID-1 no Ubuntu Server
```bash
#criando o array do RAID-1 com as partições /dev/sdb1 e /dev/sdb2 do Ubuntu Server
#opções do comando mdadm: --create (Create a new array.), --verbose (verbose output) 
#--level (Set RAID level), --raid-devices (Specify the number of active devices in the array)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/mdadm
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1 
  To optimize recovery speed, it is recommended to enable write-intent bitmap, do you want to enable it now? [y/N]? y <Enter>
  Continue creating array [y/N]? y <Enter>
```
```bash
#listando as partições RAID-1 dos Disco /dev/sdb e /dev/sdc do Ubuntu Server
#opção do comando grep: -i (Ignore case distinctions in patterns and input data)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/blkid.8.html
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/grep.1.html
sudo blkid | grep -i 'sdb\|sdc'
```

Entendendo a saída do comando: __`sudo blkid | grep -i 'sdb\|sdc'`__<br>
| **Campo** | **/dev/sdb1** | **/dev/sdc1** | **Descrição** |
| :-------- | :------------ | :------------ | :------------ |
| 💽 **Dispositivo** | `/dev/sdb1` | `/dev/sdc1` | Partições utilizadas como membros do RAID-1. |
| 🆔 **UUID do Array** | `5db5f355-8c80-02ce-8747-72493cd6c53c` | `5db5f355-8c80-02ce-8747-72493cd6c53c` | Identificador único do **array RAID**. É igual em todos os discos pertencentes ao mesmo conjunto RAID. |
| 🔖 **UUID_SUB** | `13bfcbc3-82a2-cf86-7e55-dee7819c2a38` | `821e85a7-f176-f504-e323-38431ba0ad57` | Identificador exclusivo de cada membro do array RAID. Cada disco possui seu próprio UUID_SUB. |
| 🏷️ **LABEL** | `srvvaamonde.pti.intra:0` | `srvvaamonde.pti.intra:0` | Nome atribuído ao array RAID pelo `mdadm`. O sufixo `:0` indica o primeiro array criado nesse host. |
| 📦 **TYPE** | `linux_raid_member` | `linux_raid_member` | Tipo da partição reconhecido pelo sistema operacional. |
| 📑 **PARTLABEL** | `Linux RAID` | `Linux RAID` | Rótulo GPT da partição, indicando sua finalidade para RAID. |
| 🆔 **PARTUUID** | `84ab21c7-febb-4d57-8590-7a9bc47d882a` | `36ec5d58-2fd5-4a93-8dca-1c0754aff854` | Identificador exclusivo da partição GPT. Cada partição possui um PARTUUID diferente. |
---

```bash
#listando os discos e partições em formato de árvore no Ubuntu Server
#opção do comando lsblk: -f (mostra sistema de arquivos e UUID)
#opção do comando grep: -i (Ignore case distinctions in patterns and input data)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsblk.8.html
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/grep.1.html
sudo lsblk -f | grep -i 'sdb\|sdc\|md'
```

Entendendo a saída do comando: __`sudo lsblk -f | grep -i 'sdb\|sdc\|md'`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💽 **Disco Físico 2** | `/dev/sdb e /dev/sdc` | Primeiro e Segundo discos físicos participantes do RAID-1. |
| 📂 **Partição** | `/dev/sdb1 e /deb/sdc1` | Partições configuradas como membro do array RAID. |
| 📦 **Tipo** | `linux_raid_member` | Identifica que as partições pertencem a um RAID Linux. |
| 🏷️ **Versão dos Metadados** | `1.2` | Formato dos metadados utilizados pelo `mdadm`. |
| 🏷️ **Label** | `srvvaamonde.pti.intra:0` | Nome atribuído ao array RAID. |
| 🆔 **UUID** | `5db5f355-8c80-02ce-8747-72493cd6c53c` | Identificador único compartilhado pelo array RAID.  |
| 🔗 **Dispositivo Associado** | `/dev/md0` | Dispositivo lógico ao qual a partição pertence. |
---

```bash
#verificando as informações do Kernel referente ao sistema de RAID do Ubuntu Server
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
#mais informações acesse a documentação oficial em: https://archive.kernel.org/oldwiki/raid.wiki.kernel.org/index.php/Mdstat.html
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

## 05_ Verificando as Informações do Array (Conjunto) do RAID-1 no Ubuntu Server
```bash
#verificando as informações do Array do RAID-1 no Ubuntu Server
#opções do comando mdadm: --detail (Print details of one or more md devices)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/mdadm
sudo mdadm --detail /dev/md0
```

Entendendo a saída do comando: __`sudo mdadm --detail /dev/md0`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🛡️ **Dispositivo RAID** | `/dev/md0` | Dispositivo lógico criado pelo `mdadm` que representa o array RAID-1. |
| 📦 **Versão dos Metadados** | `1.2` | Versão do superbloco utilizada para armazenar os metadados do RAID. |
| 📅 **Data de Criação** | `Tue Jul 21 13:07:23 2026` | Data e hora em que o array RAID foi criado. |
| 🛡️ **Nível RAID** | `raid1` | RAID-1 (Espelhamento/Mirroring), onde todos os dados são gravados simultaneamente em ambos os discos. |
| 💽 **Tamanho do Array** | `52.392.960 blocos (49,97 GiB / 53,65 GB)` | Capacidade útil disponível do array RAID. |
| 💽 **Tamanho por Disco** | `52.392.960 blocos (49,97 GiB / 53,65 GB)` | Espaço efetivamente utilizado de cada disco membro do RAID. |
| 👥 **Discos Configurados** | `2` | Quantidade de discos prevista na configuração do RAID. |
| 💿 **Discos Detectados** | `2` | Quantidade total de discos atualmente pertencentes ao array. |
| 💾 **Persistência** | `Superblock is persistent` | Os metadados do RAID permanecem gravados nos discos, permitindo a remontagem automática após reinicializações. |
| 📝 **Intent Bitmap** | `Internal` | Bitmap interno utilizado para acelerar processos de reconstrução (*resync*). |
| 🔄 **Última Atualização** | `Tue Jul 21 13:11:46 2026` | Última vez em que o estado do array foi atualizado. |
| ✅ **Estado** | `clean` | O array está íntegro, sincronizado e sem inconsistências. |
| 🟢 **Dispositivos Ativos** | `2` | Quantidade de discos ativos no array. |
| ⚙️ **Dispositivos Operacionais** | `2` | Quantidade de discos funcionando corretamente. |
| ❌ **Discos com Falha** | `0` | Não há discos com falhas. |
| 🔄 **Discos Reserva (Spare)** | `0` | Não existem discos configurados como reserva automática (*Hot Spare*). |
| 📋 **Política de Consistência** | `bitmap` | Utiliza bitmap para controlar alterações e acelerar a sincronização após falhas. |
| 🏷️ **Nome do Array** | `srvvaamonde.pti.intra:0` | Nome atribuído ao array RAID durante sua criação. |
| 🖥️ **Host Local** | `srvvaamonde.pti.intra` | Servidor onde o array RAID foi criado originalmente. |
| 🆔 **UUID** | `5db5f355:8c8002ce:87477249:3cd6c53c` | Identificador único do array RAID. |
| 🔢 **Eventos** | `52` | Contador de alterações realizadas no array desde sua criação. |
---

## 06_ Examinando os Discos do Array (Conjunto) do RAID-1 no Ubuntu Server
```bash
#examinando os discos do Array do RAID-1 no Ubuntu Server
#opções do comando mdadm: --examine (Print contents of the metadata stored on the named device(s))
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/mdadm
sudo mdadm --examine /dev/sdb1
sudo mdadm --examine /dev/sdc1
```

Entendendo a saída do comando: __`sudo mdadm --examine /dev/sdb1`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🔐 **Magic** | `a92b4efc` | Assinatura hexadecimal que identifica a presença de um superbloco RAID válido. |
| 📦 **Version** | `1.2` | Versão dos metadados do RAID utilizada pelo `mdadm`. |
| 🗺️ **Feature Map** | `0x1` | Mapa de funcionalidades habilitadas para este superbloco RAID. |
| 🆔 **Array UUID** | `5db5f355:8c8002ce:87477249:3cd6c53c` | Identificador único do array RAID ao qual esta partição pertence. |
| 🏷️ **Name** | `srvvaamonde.pti.intra:0` | Nome atribuído ao array RAID durante sua criação. |
| 📅 **Creation Time** | `Tue Jul 21 13:07:23 2026` | Data e hora da criação do array RAID. |
| 🛡️ **Raid Level** | `raid1` | Nível do RAID configurado (Espelhamento/Mirroring). |
| 💽 **Raid Devices** | `2` | Quantidade de discos prevista na configuração do array. |
---

| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💾 **Avail Dev Size** | `104785920 sectors (49.97 GiB / 53.65 GB)` | Espaço disponível desta partição para utilização pelo RAID. |
| 📦 **Array Size** | `52392960 KiB (49.97 GiB / 53.65 GB)` | Capacidade útil disponibilizada pelo array RAID-1. |
| 📍 **Data Offset** | `67584 sectors` | Local onde os dados do usuário começam na partição, após os metadados. |
| 📍 **Super Offset** | `8 sectors` | Localização do superbloco RAID dentro da partição. |
| 📐 **Unused Space** | `before=67504 sectors, after=0 sectors` | Espaço reservado antes e após os dados do RAID. |
---

| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| ✅ **State** | `clean` | O membro do RAID encontra-se íntegro e sincronizado. |
| 🆔 **Device UUID** | `13bfcbc3:82a2cf86:7e55dee7:819c2a38` | Identificador exclusivo desta partição dentro do array RAID. |
| 📝 **Internal Bitmap** | `8 sectors from superblock` | Bitmap interno utilizado para acelerar a sincronização após falhas. |
| 🕒 **Update Time** | `Tue Jul 21 13:11:46 2026` | Data e hora da última atualização dos metadados do RAID. |
| 🚫 **Bad Block Log** | `512 entries available` | Área reservada para registrar setores defeituosos detectados durante a operação do RAID. |
| ✔️ **Checksum** | `549c5a15 - correct` | Soma de verificação dos metadados. Indica que o superbloco está íntegro. |
| 🔢 **Events** | `52` | Número de alterações registradas no histórico do array RAID. |
---

| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🎯 **Device Role** | `Active device 0` | Esta partição ocupa a posição lógica **0** dentro do array RAID. |
| ❤️ **Array State** | `AA` | Ambos os discos do RAID estão ativos e sincronizados. |
---

## 07_ Configurando o Serviço do RAID-1 no Ubuntu Server
```bash
#fazendo o backup do arquivo de configuração original do mdadm
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/mdadm/mdadm.conf /etc/mdadm/mdadm.conf.old

#adicionando as informações do Array de RAID 1 no arquivo de configuração do mdadm
#opção do comando mdadm: --detail (Print detail of a device), --scan (scan config file or
#/proc/mdstat for missing information)
#opção do redirecionador >> (append): adiciona a saída no final do arquivo, sem sobrescrever
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/mdadm.8.html
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf

#verificando o conteúdo do arquivo de configuração do mdadm
#opção do comando cat: -n (number line)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
sudo cat -n /etc/mdadm/mdadm.conf

#atualizando o Initramfs com as novas informações do RAID (necessário para o boot reconhecer o Array)
#opção do comando update-initramfs: -u (update an existing initramfs)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/update-initramfs.8.html
sudo update-initramfs -u
```

## 08_ Verificando o Serviço do RAID Monitor no Ubuntu Server
```bash
sudo systemctl status mdmonitor
sudo journalctl -u mdmonitor
```
