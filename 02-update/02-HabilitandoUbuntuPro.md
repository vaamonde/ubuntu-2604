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
#01_ Verificando as Informações do Sistema Operacional do Ubuntu Server<br>
#02_ Atualizando o Sistema Operacional Ubuntu Server<br>
#03_ Criando sua conta no Ubuntu One para registrar o Ubuntu Pro no Ubuntu Server<br>
#04_ Criando uma Assinatura do Ubuntu Pro Free para uso Pessoal<br>
#05_ Verificando a versão do Ubuntu Advantage Tools no Ubuntu Server<br>
#06_ Ativando a sua Assinatura do Ubuntu Pro no Ubuntu Server<br>
#07_ Verificando os repositórios de origem das atualizações do Ubuntu Pro no Ubuntu Server<br>
#08_ Atualizando o sistema com o suporte do Ubuntu Pro no Ubuntu Server<br>
#09_ Configurando o serviço de Atualizações Automáticas do Ubuntu Server<br>

Site Oficial do Ubuntu Pro: https://ubuntu.com/pro<br>
Site Oficial dos Procedimentos do Ubuntu Pro: https://ubuntu.com/pro/tutorial<br>
Site Oficial do Ubuntu One: https://login.ubuntu.com/<br>
Site Oficial do Ubuntu CVE: https://ubuntu.com/security/cves<br>
Site Oficial do Ubuntu Membership: https://wiki.ubuntu.com/Membership

| **🛡️ Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🚀 **Ubuntu Pro** | Versão corporativa do Ubuntu desenvolvida pela Canonical, destinada a ambientes de produção, servidores, nuvens públicas e privadas. Inclui serviços adicionais de segurança, conformidade e suporte estendido. | Fornece **atualizações de segurança ampliadas**, correções para milhares de pacotes além do repositório principal, recursos de conformidade (CIS, FIPS, Common Criteria), Livepatch, suporte ao ESM e gerenciamento centralizado para ambientes empresariais. |
| 🔐 **ESM (Extended Security Maintenance)** | Serviço da Canonical que estende as atualizações de segurança para versões **LTS** do Ubuntu após o término do suporte padrão. | Mantém servidores protegidos contra vulnerabilidades críticas por vários anos adicionais, evitando a necessidade de atualização imediata do sistema operacional. O ESM cobre tanto os pacotes do repositório **Main** quanto do **Universe** (dependendo da assinatura Ubuntu Pro). |
| 📦 **LTS (Long-Term Support)** | Modelo de lançamento do Ubuntu que prioriza estabilidade, compatibilidade e suporte de longo prazo. As versões LTS são publicadas a cada dois anos. | Ideal para servidores e ambientes corporativos, pois recebem **5 anos de suporte padrão**, podendo chegar a **10 anos ou mais** com o Ubuntu Pro e o serviço ESM, reduzindo a necessidade de migrações frequentes. |
| ⚠️ **CVE (Common Vulnerabilities and Exposures)** | Padrão internacional para identificação e catalogação de vulnerabilidades de segurança conhecidas em softwares, sistemas operacionais e equipamentos. É mantido pela **MITRE Corporation**. | Permite identificar, documentar, rastrear e corrigir vulnerabilidades de forma padronizada. Fabricantes, distribuições Linux, pesquisadores e ferramentas de segurança utilizam os identificadores **CVE** para aplicar patches, gerar alertas e realizar auditorias de segurança. |

[![Ubuntu Pro Free](http://img.youtube.com/vi//0.jpg)]( "Ubuntu Pro Free")

Link da vídeo aula: 

## 01_ Verificando as Informações do Sistema Operacional do Ubuntu Server
```bash
#verificando as informações de identificação do Sistema Operacional
#opção do comando cat: -n (number all output lines)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man5/os-release.5.html
sudo cat -n /etc/os-release
```

Entendendo a saída do arquivo: __`os-release`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🖥️ **PRETTY_NAME** | `Ubuntu 26.04 LTS` | Nome completo e amigável da distribuição, utilizado para identificação do sistema. |
| 🐧 **NAME** | `Ubuntu` | Nome da distribuição GNU/Linux instalada. |
| 🔢 **VERSION_ID** | `26.04` | Identificador numérico da versão da distribuição. |
| 📦 **VERSION** | `26.04 LTS (Resolute Raccoon)` | Versão completa da distribuição, incluindo o tipo de suporte (**LTS**) e o codinome oficial. |
| 🏷️ **VERSION_CODENAME**  | `resolute` | Codinome da versão do Ubuntu, utilizado em repositórios, atualizações e gerenciamento de pacotes. |
| 🆔 **ID** | `ubuntu` | Identificador único da distribuição, utilizado por aplicações e scripts para detectar o sistema operacional. |
| 🔗 **ID_LIKE** | `debian` | Indica que o Ubuntu é derivado da distribuição Debian, compartilhando sua base de pacotes e ferramentas de gerenciamento. |
| 🌐 **HOME_URL** | `https://www.ubuntu.com/` | Site oficial da distribuição Ubuntu. |
| 📚 **SUPPORT_URL** | `https://help.ubuntu.com/` | Portal oficial de documentação e suporte da Ubuntu. |
| 🐞 **BUG_REPORT_URL** | `https://bugs.launchpad.net/ubuntu/` | Endereço oficial para registro e acompanhamento de bugs da distribuição Ubuntu. |
| 🔒 **PRIVACY_POLICY_URL** | `https://www.ubuntu.com/legal/terms-and-policies/privacy-policy` | Página da política oficial de privacidade da Ubuntu. |
| 🦝 **UBUNTU_CODENAME** | `resolute` | Codinome específico da versão do Ubuntu, utilizado internamente pela distribuição. |
| 🎨 **LOGO** | `ubuntu-logo` | Identificador do logotipo padrão da distribuição, utilizado por interfaces gráficas e aplicações compatíveis. |

```bash
#verificando as informações específicas do Sistema Operacional
#opção do comando cat: -n (number all output lines)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/lsb_release
sudo cat -n /etc/lsb-release
```

Entendendo a saída do arquivo: __`lsb-release`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🐧 **DISTRIB_ID** | `Ubuntu` | Nome da distribuição GNU/Linux instalada no sistema. |
| 🔢 **DISTRIB_RELEASE** | `26.04` | Versão da distribuição Ubuntu instalada. O formato `AA.MM` representa **Ano.Mês** de lançamento. |
| 🏷️ **DISTRIB_CODENAME** | `resolute` | Codinome oficial da versão do Ubuntu, utilizado em repositórios, documentação e gerenciamento de pacotes. |
| 📖 **DISTRIB_DESCRIPTION** | `Ubuntu 26.04 LTS` | Descrição completa da distribuição, indicando que se trata de uma versão **LTS (Long Term Support)**, com suporte estendido e maior estabilidade para servidores e ambientes corporativos. |

```bash
#verificando as informações de Kernel do Sistema Operacional
#opção do comando uname: -a (Behave as though all of the options)
#mais informações acesse a documentação oficial:
sudo uname -a
```

Entendendo a saída do comando: __`uname -a`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🖥️ **Kernel** | `Linux` | Nome do kernel do sistema operacional em execução. |
| 📛 **Hostname** | `srvvaamonde` | Nome do host (hostname) configurado no servidor. |
| 🔢 **Versão do Kernel** | `7.0.0-27-generic` | Versão do kernel Linux instalada, incluindo o tipo de compilação (`generic`). |
| 🏗️ **Build do Kernel**    | `#27-Ubuntu SMP PREEMPT_DYNAMIC` | Número da compilação do kernel, indicando que foi compilado pela Ubuntu com suporte a **SMP (Symmetric Multi-Processing)** e **PREEMPT_DYNAMIC** (preempção dinâmica). |
| 📅 **Data da Compilação** | `Thu Jun 18 19:13:49 UTC 2026` | Data e hora em que o kernel foi compilado pela equipe da Ubuntu (fuso horário UTC). |
| 💻 **Arquitetura** | `x86_64` | Arquitetura de 64 bits compatível com processadores AMD64 e Intel 64. |
| 🐧 **Sistema Operacional** | `GNU/Linux` | Indica que o sistema utiliza o kernel Linux juntamente com as ferramentas do projeto GNU. |


## 02_ Forçando uma Atualizando Completa do Sistema Operacional do Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** recomendo fazer um upgrade completo do servidor antes de adicionar a *Licença do Ubuntu Pro*.

```bash
#Forçando uma atualização completa do servidor antes de habilitar o Ubuntu Pro
sudo apt update
sudo apt upgrade
sudo apt full-upgrade
sudo apt dist-upgrade
sudo apt autoremove
sudo apt autoclean
```

## 03_ Criando sua conta no Ubuntu One para registrar o Ubuntu Pro no Ubuntu Server

Link para o cadastro oficial: Acesse o site: https://login.ubuntu.com/

```bash
01) Clique em: I don’t have an Ubuntu One account
    Preencha os campos:
      Please type your email: (DIGITE_SEU_EMAIL)
      Full name: (DIGITE SEU NOME COMPLETO)
      Username: (DIGITE O NOME DO SEU USUÁRIO)
      Choose password: (DIGITE SUA SENHA)
      Re-type password: (CONFIRME SUA SENHA)
      Marque a opção: I have read and accept the Ubuntu One terms of service, data privacy policy and Canonical SSO privacy notice.
      Clique em: <Create account>

02) Finalize os procedimentos acessando seu email para ativar a sua conta no Ubuntu One.
    Are you sure you want to confirm and validate this email address?
<Sim, tenho certeza>
```

## 04_ Criando uma Assinatura do Ubuntu Pro Free para uso Pessoal (Suporte para 5 Servidores)

Link para o Dashboard oficial do Ubuntu Pro: Acesse o site: https://ubuntu.com/pro/dashboard

```bash
01) Faça a autenticação com a sua conta criada no Ubuntu One;
    Personal Data Request: <Yes, log me in>

02) Será mostrado no campo Free Personal Token o seu token;
    Copiar o seu Token no campo: Token. ou
    Copiar o comando com o Token na linha: Command to attach a machine: 

03) No lado esquerdo em: Free Personal Token é mostrado as colunas:
    Machines (Licenças Disponíveis), Created (Data de Criação) e Expires (Data de Expiração)
```

## 05_ Verificando a versão do Ubuntu Advantage Tools no Ubuntu Server
```bash
#verificando a versão do cliente do Ubuntu Pro Client
#opção do comado pro: --version ou version (Show version of the Ubuntu Pro package)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/ua.1.html
sudo pro --version
```

## 06_ Ativando a sua Assinatura do Ubuntu Pro no Ubuntu Server
```bash
#adicionando o Token da licença do Ubuntu Pro
#opção do comando pro: attach (Connect an Ubuntu Pro support contract to this machine)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/ua.1.html
sudo pro attach COPIAR_E_COLAR_O_SEU_TOKEN
```

## 07_ Verificando os repositórios de origem das atualizações do Ubuntu Pro no Ubuntu Server
```bash
#verificando o status de serviço do Ubuntu Pro
#opção do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/systemctl.1.html
sudo systemctl status ubuntu-advantage

#analisando os Log's e mensagens de erro do serviço do Ubuntu Pro
#opção do comando journalctl: u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u ubuntu-advantage

#verificando o status do Ubuntu Pro
#opção do comando pro: status (Report current status of Ubuntu Pro services on system)
#--all (view all information command and verbose mode)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/ua.1.html
sudo pro status --all
```

> **OBSERVAÇÃO IMPORTANTE:** por padrão após habilitar o *Token do Ubuntu Pro* os principais serviços são habilitados, sendo o: **ESM-INFRA**, **ESM-APPS** e o **Livepatch**, caso queira habilitar mais serviços veja a lista abaixo:

| **Serviço** | **Nome** | **Descrição** |
| :---------: | -------- | ------------- |
| 📱 | **anbox-cloud** | Plataforma escalável para execução de instâncias Android na nuvem. |
| 🛡️ | **cc-eal** | Pacotes de provisionamento para conformidade com a certificação **Common Criteria EAL2**. |
| 🔒 | **cis** | Ferramentas de auditoria e conformidade de segurança baseadas nos benchmarks do **Center for Internet Security (CIS)**. |
| ✅ | **esm-apps** | **Expanded Security Maintenance** para aplicações do repositório **Universe**, fornecendo atualizações de segurança estendidas. |
| ✅ | **esm-infra** | **Expanded Security Maintenance** para a infraestrutura do sistema operacional, incluindo pacotes essenciais do Ubuntu. |
| 🔐 | **fips** | Pacotes criptográficos certificados pelo padrão **FIPS (Federal Information Processing Standards)** do NIST. |
| 🧪 | **fips-preview** | Versão de avaliação dos pacotes criptográficos **FIPS** ainda em processo de certificação pelo NIST. |
| 🔑 | **fips-updates** | Pacotes criptográficos compatíveis com **FIPS**, incluindo atualizações estáveis de segurança. |
| 🖥️ | **landscape** | Plataforma da Canonical para gerenciamento, monitoramento e administração centralizada de servidores Ubuntu. |
| ⚡ | **livepatch** | Serviço **Canonical Livepatch**, que aplica correções de segurança ao kernel sem necessidade de reinicialização. |
| ⏱️ | **realtime-kernel** | Kernel Ubuntu com patches **PREEMPT_RT**, destinado a aplicações de tempo real (Real-Time). |
| 🤖 | **ros** | Atualizações de segurança para o **Robot Operating System (ROS)**. |
| 🔄 | **ros-updates** | Todas as atualizações disponíveis para o **Robot Operating System (ROS)**, incluindo novos recursos e correções. |

```bash
#verificando os status dos pacotes de segurança do Ubuntu Pro
#opção do comando pro: security-status (Show security updates for packages in the system)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/ua.1.html
sudo pro security-status

#verificando os status dos pacotes de segurança ESM (Enterprise Service Manager) do Ubuntu Pro
#opção do comando pro: security-status (Show security updates for packages in the system), 
#--esm-apps (flag will only  show  information  about esm-apps packages)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/ua.1.html
sudo pro security-status --esm-apps

#verificando as informações de Fix (correções) dos CVE (Common Vulnerabilities and Exposures)
#opção do comando pro: fix (Fix a CVE or USN on the  system  by  upgrading  the  appropriate
#package(s))
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/ua.1.html
#Site dos CVEs do Ubuntu: https://ubuntu.com/security/cves
sudo pro fix CVE-2026-54591

#verificando os status do Canonical Livepatch do Ubuntu Pro
#opção do comando canonical-livepatch: status (To show the current state of the client)
#--verbose (shows extended details such as client version, architecture, boot time, and applied CVEs.)
#mais informações acesse a documentação oficial em: https://ubuntu.com/security/livepatch/docs/livepatch/how-to/status
sudo canonical-livepatch status --verbose
```

## 08_ Atualizando o Sistema Operacional com o suporte do Ubuntu Pro no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** após adicionar a licença do *Ubuntu Pro* é recomendado fazer um __`Upgrade Completo do Sistema`__ para testar o *Token* e as novas listas do **sources.list** do Ubuntu Pro.

```bash
#Policy é utilizado para mostra as propriedades e prioridades dos repositórios configurados.
#opção do comando apt: policy (This is meant to help debug issues relating to the preferences file.)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/apt-cache
sudo apt policy
```
```bash
#Forçando uma atualizando completa do sistema operacional com suporte do Ubuntu Pro
sudo apt clean
sudo apt update
sudo apt upgrade
sudo apt full-upgrade
sudo apt dist-upgrade
sudo apt autoremove
sudo apt autoclean
```

## 09_ Configurando o serviço de Atualizações Automáticas do Ubuntu Server
```bash
#verificando o status de serviço das Atualizações Automáticas
#opção do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/systemctl.1.html
sudo systemctl status unattended-upgrades

#editando o arquivo de configuração de atualizações automáticas do Ubuntu Server
sudo vim /etc/apt/apt.conf.d/50unattended-upgrades

#mostrando o número de linha do arquivo 50unattended-upgrades
ESC SHIFT :set number <Enter>

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#descomentar a opção da linha: 94 (Unattended-Upgrade::Automatic-Reboot "false";)
Unattended-Upgrade::Automatic-Reboot "false";
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```
```bash
#reiniciando o serviço das Atualizações Automáticas
#opção do comando systemctl: restart (Stop and then start one or more units specified on the command line)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/systemctl.1.html
sudo systemctl restart unattended-upgrades

#verificando o status de serviço das Atualizações Automáticas
#opção do comando systemctl: status (runtime status information)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/systemctl.1.html
sudo systemctl status unattended-upgrades

#analisando os Log's e mensagens de erro das Atualizações Automáticas
#opção do comando journalctl: u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u unattended-upgrades
```