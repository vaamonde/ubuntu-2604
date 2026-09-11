# Curso GRÁTIS de GNU/Linux Ubuntu Server 26.04.x LTS (Resolute Raccoon) — Security & Hardening

Robson Vaamonde<br>
Procedimentos em TI: http://procedimentosemti.com.br<br>
Bora para Prática: http://boraparapratica.com.br<br>
Robson Vaamonde: http://vaamonde.com.br<br>
Facebook Procedimentos em TI: https://www.facebook.com/ProcedimentosEmTi<br>
Facebook Bora para Prática: https://www.facebook.com/boraparapratica<br>
Instagram Procedimentos em TI: https://www.instagram.com/procedimentoem<br>
YouTUBE Bora Para Prática: https://www.youtube.com/boraparapratica<br>
Linkedin Robson Vaamonde: https://www.linkedin.com/in/robson-vaamonde-0b029028/<br>
Github Procedimentos em TI: https://github.com/vaamonde<br>

## 💰 Ajude o projeto Bora para Prática a continuar fazendo vídeos e materiais gratuitos para o Canal do YouTUBE
## 💰 Chave PIX do projeto: robsonvaamonde@gmail.com

<div align="center">
<img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/y/vaamonde/ubuntu-2604?style=plastic">
<a href="https://github.com/vaamonde/ubuntu-2604/stargazers"><img src="https://img.shields.io/github/stars/vaamonde/ubuntu-2604" alt="Stars Badge"/></a>
<a href="https://github.com/vaamonde/ubuntu-2604/network/members"><img src="https://img.shields.io/github/forks/vaamonde/ubuntu-2604" alt="Forks Badge"/></a>
<a href="https://github.com/vaamonde/ubuntu-2604/pulls"><img src="https://img.shields.io/github/issues-pr/vaamonde/ubuntu-2604" alt="Pull Requests Badge"/></a>
<a href="https://github.com/vaamonde/ubuntu-2604/issues"><img src="https://img.shields.io/github/issues/vaamonde/ubuntu-2604" alt="Issues Badge"/></a>
<a href="https://github.com/vaamonde/ubuntu-2604/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/vaamonde/ubuntu-2604?color=2b9348"></a>
<a href="https://github.com/vaamonde/ubuntu-2604/blob/master/LICENSE"><img src="https://img.shields.io/github/license/vaamonde/ubuntu-2604?color=2b9348" alt="License Badge"/></a>
</div>

---

## 🎯 Sobre o Curso

Este é o curso **100% GRATUITO** de **GNU/Linux Ubuntu Server 26.04.x LTS (Resolute Raccoon)**, com foco em **Infraestrutura On-Premises**, **Segurança** e **Hardening**.

O objetivo é construir, passo a passo e do zero, um servidor Ubuntu Server pronto para produção, partindo da instalação física ou virtual (Oracle VirtualBOX) em ambiente **On-Premises**, passando pela configuração de Rede, Armazenamento (Discos, RAID e LVM) e Segurança, até chegar num conjunto completo de práticas de **Hardening** (blindagem) do Sistema Operacional. Todo o conteúdo foi pensado para servir tanto de base para Laboratórios de estudo quanto para cenários reais de servidores **On-Premises**, com o próximo passo natural sendo a migração desses conceitos para ambientes de **Cloud Computing**.

Todos os procedimentos seguem o mesmo padrão de documentação: testados e homologados na versão do **Ubuntu Server 26.04.x LTS x64**, com explicação de cada comando, das opções utilizadas e, sempre que possível, uma tabela detalhando a saída (output) esperada do comando executado.

## 🗺️ Trilha do Curso (Roadmap)

| **📂 Módulo** | **📖 Conteúdo** | **📌 Status** |
| :------------ | :--------------- | :-----------: |
| [`01-install`](./01-install) | Instalação do Ubuntu Server 26.04 no Oracle VirtualBOX | ✅ |
| [`02-update`](./02-update) | Atualização do Sistema e Configuração do Ubuntu Pro | ✅ |
| [`03-settings`](./03-settings) | Configuração de Rede, Hostname, Locale e Timezone | ✅ |
| [`04-harddisk`](./04-harddisk) | Configuração de Hard Disk, RAID-1 e LVM | ✅ |
| [`05-security`](./05-security) | Segurança de Rede: Bonding (Redundância de Placas de Rede) | ✅ |
| [`06-hardening`](./06-hardening) | Hardening completo do Sistema Operacional (SSH, Firewall, Fail2Ban, AppArmor, Auditoria e mais) | 🔄 Em andamento |
| [`99-workflow`](./99-workflow) | Backlog, cronograma e checklist de produção do curso | 🔄 Em andamento |
| [`conf`](./conf) | Arquivos de configuração prontos (Netplan, Chrony/NTP) utilizados ao longo do curso | ✅ |

## 📚 Conteúdo Detalhado por Módulo

### 01 — Instalação (`01-install`)
- Download da ISO oficial do Ubuntu Server 26.04.x LTS
- Criação e customização da Máquina Virtual no Oracle VirtualBOX
- Instalação padrão do Ubuntu Server (particionamento com LVM, criação de usuário, OpenSSH)
- Primeiro acesso local e acesso remoto via SSH

### 02 — Atualização (`02-update`)
- Verificação das informações do Sistema Operacional (`os-release`, `lsb-release`, `uname`)
- Atualização completa dos pacotes (`apt update`, `upgrade`, `full-upgrade`, `dist-upgrade`)
- Ativação do **Ubuntu Pro** (Free Personal Token) com os serviços **ESM-INFRA**, **ESM-APPS** e **Livepatch**
- Configuração das **Atualizações Automáticas** (Unattended Upgrades)
- Boas práticas sobre repositórios (Main, Restricted, Universe, Multiverse, Backports, Proposed, PPA)

### 03 — Configurações (`03-settings`)
- Configuração de rede estática (IPv4/IPv6) com **Netplan v2**
- Habilitação de **DNS over TLS (DoT)** e **DNSSEC** via `systemd-resolved`
- Configuração de **Hostname/FQDN** e do arquivo `/etc/hosts`
- Configuração de **Locale** (`pt_BR.UTF-8`) e **Timezone** (`America/Sao_Paulo`)
- Sincronização de data/hora com **Chrony** e servidores **NTP.br** (com suporte a **NTS**)
- Configuração de teclado e console (layout ABNT2)

### 04 — Armazenamento (`04-harddisk`)
- Adição de novos discos virtuais e verificação de controladora SATA/AHCI
- Análise de performance (`hdparm`) e saúde dos discos (S.M.A.R.T.)
- Configuração de **RAID-1 por Software** com `mdadm` (criação, monitoramento, simulação de falha e rebuild)
- Configuração de **LVM (Logical Volume Manager)**: PV, VG, LV, snapshots e redimensionamento a quente (Hot Resize)

### 05 — Segurança de Rede (`05-security`)
- **Bonding (Link Aggregation)** de Placas de Rede via Netplan (`bond0`)
- Modo `active-backup` recomendado para laboratório no Oracle VirtualBOX
- Testes de redundância e failover de rede

### 06 — Hardening (`06-hardening`)
Módulo dedicado à blindagem do Ubuntu Server, cobrindo:

| **🛡️ Tópico** | **📖 Descrição** |
| :------------- | :---------------- |
| Hardening OpenSSH | Certificados, autenticação por chave e 2FA |
| TCP Wrappers | Controle de acesso a serviços de rede |
| Firewall UFW | Regras de entrada/saída e restrição de portas |
| Fail2Ban | Bloqueio automático contra tentativas de força bruta |
| AppArmor | Controle de acesso obrigatório (MAC) por aplicação |
| Syslog | Centralização e proteção dos logs do sistema |
| Auditoria | Rastreamento de eventos com `auditd` |
| Systemctl | Redução da superfície de ataque via serviços do systemd |
| PAM (libpam) | Políticas de autenticação e senha |
| Kernel/Módulos | Desabilitação de módulos desnecessários do kernel |
| AIDE | Detecção de intrusão baseada em integridade de arquivos |
| SUDO | Políticas restritivas de escalonamento de privilégio |
| Grub2 | Proteção do bootloader |
| Cloud-Init | Hardening do provisionamento automatizado |
| Snap | Restrições ao gerenciador de pacotes Snap |

## ⚙️ Arquivos de Configuração (`conf`)

Modelos de configuração prontos, referenciados diretamente pelas aulas via `wget`:

| **📄 Arquivo** | **🎯 Utilizado em** |
| :-------------- | :------------------- |
| `00-installer-config.yaml` | Configuração de rede padrão (uma interface) via Netplan |
| `00-installer-config-bond.yaml` | Configuração de rede com Bonding (`bond0`, duas interfaces) via Netplan |
| `chrony.conf` | Configuração do serviço de sincronização de horário Chrony |
| `ntp-br-pools.sources` | Servidores NTP.br com suporte a NTS (Network Time Security) |

## 🧰 Tecnologias e Ferramentas Abordadas

`Ubuntu Server 26.04 LTS` • `Oracle VirtualBOX 7.x` • `Netplan v2` • `Ubuntu Pro / ESM / Livepatch` • `Chrony (NTP/NTS)` • `mdadm (RAID-1)` • `LVM2` • `Bonding (Kernel Linux)` • `OpenSSH` • `UFW` • `Fail2Ban` • `AppArmor` • `Auditd` • `PAM` • `AIDE` • `Cloud-Init` • `Systemd`

## ✅ Pré-requisitos

- Conhecimentos básicos de GNU/Linux (Terminal/Bash)
- Oracle VirtualBOX 7.x instalado (ou servidor físico On-Premises)
- Mínimo recomendado: 4 GB de RAM, 2 vCPUs e 100 GB de disco para o Laboratório
- Acesso à Internet para download de pacotes e ISOs

## 📌 Observação Importante

Toda a documentação está em constante atualização, acompanhando as versões mais recentes do **Ubuntu Server 26.04.x LTS**. Consulte o arquivo [`99-workflow/00-workflow.md`](./99-workflow/00-workflow.md) para acompanhar o cronograma, o status de cada aula e os próximos tópicos planejados (Backup, Particionamento avançado, ISPConfig/Painéis de Administração, entre outros).

Contribuições, sugestões e Pull Requests são muito bem-vindos! 🚀
