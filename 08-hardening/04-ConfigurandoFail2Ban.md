**Autor:** `Robson Vaamonde`<br>
**Procedimentos em TI:** http://procedimentosemti.com.br<br>
**Bora para Prática:** http://boraparapratica.com.br<br>
**Robson Vaamonde:** http://vaamonde.com.br<br>
**Facebook Procedimentos em TI:** https://www.facebook.com/ProcedimentosEmTi<br>
**Facebook Bora para Prática:** https://www.facebook.com/BoraParaPratica<br>
**Instagram Procedimentos em TI:** https://www.instagram.com/procedimentoem<br>
**YouTUBE Bora Para Prática:** https://www.youtube.com/boraparapratica<br>
**LinkedIn Robson Vaamonde:** https://www.linkedin.com/in/robson-vaamonde-0b029028/<br>
**Github Robson Vaamonde:** https://github.com/vaamonde<br>

**Data de criação:** `21/11/2026`<br>
**Data de atualização:** `21/11/2026`<br>
**Versão:** `0.01`<br>

> __`Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS`__

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO OPENSSH A SEGUINTE FRASE: *Configuração do Fail2Ban On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #fail2ban #fail2banubuntu #fail2banubuntoserver #fail2banubuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/22-fail2ban.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
Site Oficial do Fail2Ban: http://www.fail2ban.org/<br>

**Conteúdo estudado nessa configuração:**<br>
[#00_ Principais arquivos de configuração desse procedimento no Ubuntu Server](#00_-principais-arquivos-de-configuração-desse-procedimento-no-ubuntu-server)<br>


| **🔐 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |

---

[![Fail2Ban](http://img.youtube.com/vi//0.jpg)]( "Fail2Ban")

Link da vídeo aula: 

## 00_ Principais arquivos de configuração desse procedimento no Ubuntu Server

| **📁 Diretório/Arquivo** | **📖 Descrição** |

```bash
/etc/fail2ban/                <-- Diretório de configuração do Fail2Ban
/etc/fail2ban/action.d/       <-- Diretório de configuração das Ações do Fail2Ban
/etc/fail2ban/filter.d/       <-- Diretório de configuração dos Filtros do Fail2Ban
/etc/fail2ban/jail.d/         <-- Diretório de configuração das Regras do Fail2Ban
/etc/fail2ban/fail2ban.conf   <-- Arquivo de configuração do Serviços do Fail2Ban
/var/log/fail2ban.log         <-- Arquivo de Log do Serviço do Fail2Ban
/var/run/fail2ban/            <-- Diretório do PID de Processo e Socket do Fail2Ban
/var/lib/fail2ban/            <-- Diretório do Banco de Dados SQLite3 do Fail2Ban
```
---

## 01_ Instalando o Fail2Ban no Ubuntu Server
```bash
#atualizando as lista do Apt do sources.list no Ubuntu Server
#opção do comando apt: update (Resynchronize the package index files from their sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt update
```
```bash
#instalando o Fail2Ban no Ubuntu Server
#opção do comando apt: install (install is followed by one or more package names)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt install fail2ban
```

## 02_ Habilitando o Serviço do Fail2Ban no Ubuntu Server
```bash
#habilitando o serviço do Fail2Ban no Ubuntu Server
#opção do comando systemctl: daemon-reload (Reload the systemd manager configuration), 
#enable (Enable one or more units), start (Start (activate) one or more units)
sudo systemctl daemon-reload
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

## 03_ Verificando o Serviço e Versão do Fail2Ban no Ubuntu Server
```bash
#verificando o serviço do Fail2Ban no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then 
#start one or more units), stop (Stop (deactivate) one or more units), start (Start (activate) 
#one or more units)
sudo systemctl status fail2ban
sudo systemctl restart fail2ban
sudo systemctl reload fail2ban
sudo systemctl stop fail2ban
sudo systemctl start fail2ban

#analisando os Log's e mensagens de erro do Fail2Ban
#opção do comando journalctl: x (catalog), e (pager-end), u (unit)
sudo journalctl -xeu fail2ban

#verificando os arquivos de configuração do Fail2Ban
#opção do comando fail2ban-client: -t (test configuration)
sudo fail2ban-client -t
```

**OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção.

```bash
#verificando a versão do Fail2Ban
#opção do comando fail2ban-client: -V (version)
sudo fail2ban-client -V
```

## 05_ Atualizando os arquivos de configuração do Fail2Ban no Ubuntu Server
```bash
#atualizando o arquivo de configuração do Fail2Ban Local do Github
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/fail2ban/fail2ban.local https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/fail2ban.local
```
```bash
#atualizando o arquivo de configuração do Jail (Cadeia/Jaula) Local do Fail2Ban do Github
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/fail2ban/jail.local https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/jail.local
```
```bash
#atualizando o arquivo de configuração de Reincidência do Fail2Ban do Github
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/fail2ban/jail.d/recidive.conf https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/recidive.conf
```

## 06_ Editando os arquivos de configuração do Fail2Ban no Ubuntu Server
```bash
#editar o arquivo de configuração padrão do Fail2Ban
sudo vim /etc/fail2ban/fail2ban.local

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#alterar as linhas: 41 até 43 conforme sua necessidade de tempo de Banimento
#Configuração das Políticas de Banimento mais Restritiva do Fail2Ban
bantime = 1h
findtime = 10m
maxretry = 3
#Configuração das Políticas de Banimento de Reincidência do Fail2Ban
enabled = true
bantime = 7d
findtime = 7d
maxretry = 5
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>

#editar o arquivo de configuração padrão do Jail (Cadeia/Jaula) do Fail2Ban
sudo vim /etc/fail2ban/jail.local

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#alterar as linhas: 30 até 33 conforme sua necessidade de tempo de Banimento
30 #Configurações globais de banimento do Fail2Ban
bantime = 1h
findtime = 10m
maxretry = 3
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>

#editar o arquivo de configuração padrão do Recidive (Reincidência) do Fail2Ban
sudo vim /etc/fail2ban/jail.d/recidive.conf

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#alterar as linhas: 30 até 33 conforme sua necessidade de tempo de Banimento
30 #Configurações globais de banimento do Fail2Ban
bantime = 1h
findtime = 10m
maxretry = 3
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>

#verificando os arquivos de configuração do Fail2Ban
#opção do comando fail2ban-client: -t (test configuration)
sudo fail2ban-client -t
```

## 07_ Configurando o Monitoramento e Jail (Cadeia/Jaula) do serviço do OpenSSH no Ubuntu Server
```bash
#removendo o arquivo de Jail padrão do Fail2Ban no Ubuntu Server
sudo rm -v /etc/fail2ban/jail.d/defaults-debian.conf

#atualizando o arquivo de configuração do Jail (Cadeia/Jaula) do OpenSSH do Github
sudo wget -v -O /etc/fail2ban/jail.d/sshd.conf https://raw.githubusercontent.com/vaamonde/ubuntu-2204/main/conf/sshd.conf

#editar o arquivo de configuração do Jail do OpenSSH Server
sudo vim /etc/fail2ban/jail.d/sshd.conf

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#alterar as linhas: 31 até 41 conforme sua necessidade de tempo de Banimento
# Número máximo de tentativas falhas permitidas antes de aplicar o banimento
maxretry = 3
# Janela de tempo (10 minutos) para contar as tentativas falhas
findtime = 10m
# Tempo de banimento do IP ofensivo (1 hora)
bantime = 1h
# Ação aplicada no banimento; aqui, integra com o UFW para bloquear o IP
banaction = ufw
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>

#verificando os arquivos de configuração do Fail2Ban
#opção do comando fail2ban-client: -t (test configuration)
sudo fail2ban-client -t
```

## 08_ Reiniciando e Aplicando as novas regras de Jail (Cadeia/Jaula) do Fail2Ban no Ubuntu Server
```bash
#reiniciando o serviço do Fail2Ban no Ubuntu Server
#opção do comando systemctl: restart (Stop and then start one or more units), status (runtime status information)
sudo systemctl restart fail2ban
sudo systemctl status fail2ban

#verificando o status de todos os Jails (Cadeias/Jaulas) do Fail2Ban
#opção do comando fail2ban-client: status (gets the current status of the server)
sudo fail2ban-client status

#verificando o status do Jail (Cadeia/Jaula) do serviço do OpenSSH no Fail2Ban
#opção do comando fail2ban-client: status (gets the current status of the server), sshd (gets the current status of <JAIL>)
sudo fail2ban-client status sshd
```




========================================DESAFIOS=========================================

**#12_ DESAFIO-01:** 

=========================================================================================

**OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DO FAIL2BAN SE VOCÊ CONSEGUIU FAZER O DESAFIO COM A SEGUINTE FRASE: *Desafio do Fail2Ban realizado com sucesso!!! #BoraParaPrática*

COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS (LINKEDIN, FACEBOOK, INSTAGRAM) MARCANDO: ROBSON VAAMONDE COM AS HASHTAGS E COPIANDO O CONTEÚDO DO DESAFIO ABAIXO: 

LINK DO SELO: https://github.com/vaamonde/ubuntu-2204/blob/main/selos/21-fail2ban.png

#boraparapratica #boraparaprática #vaamonde #robsonvaamonde #procedimentosemti #ubuntuserver #ubuntuserver2204 #desafiovaamonde #desafioboraparapratica #desafiofail2ban #desafiosecurityp
