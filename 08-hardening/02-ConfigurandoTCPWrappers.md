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

**Data de criação:** `29/09/2026`<br>
**Data de atualização:** `18/11/2026`<br>
**Versão:** `0.02`<br>

> __`Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS`__

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO TCP WRAPPERS A SEGUINTE FRASE: *Configuração do TCP Wrappers On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #tcpwrappers #tcpwrappersubuntu #tcpwrappersubuntuserver #tcpwrappersubuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/20-tcpwrappers.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
Site Oficial do OpenSSH: https://www.openssh.com/<br>
Site Oficial do OpenSSL: https://www.openssl.org/<br>
Site Oficial do PuTTY: https://www.putty.org/<br>

**Conteúdo estudado nessa configuração:**<br>
[#00_ Principais arquivos de configuração desse procedimento no Ubuntu Server](#00_-principais-arquivos-de-configuração-desse-procedimento-no-ubuntu-server)<br>
[#01_ Atualizando os arquivos de configuração do TCP Wrappers no Ubuntu Server](#01_-atualizando-os-arquivos-de-configuração-do-tcp-wrappers-no-ubuntu-server)<br>
[#02_ Editando os arquivos de configuração do TCP Wrappers Deny Ubuntu Server](#02_-editando-os-arquivos-de-configuração-do-tcp-wrappers-deny-ubuntu-server)<br>
[#03_ Editando os arquivos de configuração do TCP Wrappers Allow Ubuntu Server](#03_-editando-os-arquivos-de-configuração-do-tcp-wrappers-allow-ubuntu-server)<br>
[#04_ Acessando remotamente o OpenSSH Server via Powershell, PuTTY e Git Bash](#04_-acessando-remotamente-o-openssh-server-via-powershell-putty-e-git-bash)<br>

| **🔐 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🛡️ **TCP Wrappers** | Mecanismo tradicional de segurança do GNU/Linux utilizado para controlar o acesso a determinados serviços de rede. | Permitir ou negar conexões com serviços compatíveis, utilizando regras baseadas em endereços IP, nomes de computadores e serviços. |
| ✅ **hosts.allow** | Arquivo de configuração do TCP Wrappers, normalmente localizado em `/etc/hosts.allow`. | Definir quais computadores, endereços IP ou redes possuem autorização para acessar serviços compatíveis com TCP Wrappers. |
| ⛔ **hosts.deny** | Arquivo de configuração do TCP Wrappers, normalmente localizado em `/etc/hosts.deny`. | Definir quais computadores, endereços IP ou redes devem ter o acesso negado aos serviços compatíveis. |
| 🔍 **libwrap** | Biblioteca que disponibiliza funcionalidades do TCP Wrappers para aplicações compatíveis. | Permitir que serviços e aplicações utilizem as regras definidas nos arquivos `hosts.allow` e `hosts.deny`. |
| 🖥️ **tcpd** | Programa associado ao TCP Wrappers que atua como intermediário no controle de conexões de serviços compatíveis. | Verificar as regras de acesso antes de permitir ou negar uma conexão. |
---

[![TCP Wrappers](http://img.youtube.com/vi//0.jpg)]( "TCP Wrappers")

Link da vídeo aula: 

## 00_ Principais arquivos de configuração desse procedimento no Ubuntu Server

| **📁 Diretório/Arquivo** | **📖 Descrição** |
| :----------------------- | :--------------- |
| 🛡️ `/etc/hosts.deny` | Arquivo utilizado pelo mecanismo TCP Wrappers para definir quais endereços IP, computadores ou serviços terão suas conexões negadas. As regras são aplicadas somente aos serviços compatíveis com TCP Wrappers. |
| 🔐 `/etc/hosts.allow` | Arquivo utilizado pelo TCP Wrappers para definir quais endereços IP, computadores ou serviços estão autorizados a estabelecer conexões. As regras de permissão têm prioridade sobre as regras de negação do `hosts.deny`. |
| 📂 `/var/log/` | Diretório utilizado pelo GNU/Linux para armazenar arquivos de registro (*logs*) de serviços, aplicações e componentes do sistema operacional. |
| 📝 `/var/log/syslog` | Arquivo de log geral do sistema, quando utilizado pelo serviço de registro correspondente. Pode armazenar mensagens de serviços, aplicações e eventos relacionados ao funcionamento do servidor. |
| 🔑 `/var/log/auth.log` | Arquivo de log relacionado à autenticação e autorização de usuários. Pode registrar tentativas de conexão SSH, logins bem-sucedidos, falhas de autenticação e atividades relacionadas ao uso do `sudo`. |
| ✅ `/var/log/allow-ssh.log` | Arquivo de log personalizado que pode ser utilizado para registrar conexões SSH permitidas. Seu conteúdo depende da implementação das regras de registro e dos mecanismos de segurança configurados no servidor. |
| ⛔ `/var/log/deny.log` | Arquivo de log personalizado que pode ser utilizado para registrar conexões ou tentativas de acesso negadas. Seu conteúdo depende da configuração do mecanismo responsável pelo bloqueio e pelo registro dos eventos. |
---

## 01_ Atualizando os arquivos de configuração do TCP Wrappers no Ubuntu Server
```bash
#atualizando o arquivo de configuração do TCP Wrapper hosts allow do Ubuntu Server do Github
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/hosts.allow https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/hosts.allow
```
```bash
#atualizando o arquivo de configuração do TCP Wrapper hosts deny do Ubuntu Server do Github
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/hosts.deny https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/hosts.deny
```

## 02_ Editando os arquivos de configuração do TCP Wrappers Deny Ubuntu Server
```bash
#editando o arquivo de configuração do TCP Wrappers Deny no Ubuntu Server
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/hosts.deny
sudo vim /etc/hosts.deny
```
```bash
#habilitando o número de linhas do arquivo sshd_config
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash

```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```

## 03_ Editando os arquivos de configuração do TCP Wrappers Allow Ubuntu Server
```bash
#editando o arquivo de configuração do TCP Wrappers Allow no Ubuntu Server
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/hosts.allow
sudo vim /etc/hosts.allow
```
```bash
#habilitando o número de linhas do arquivo sshd_config
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash

```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```

## 04_ Acessando remotamente o OpenSSH Server via Powershell, PuTTY e Git Bash
```bash
#acessando o OpenSSH via Powershell
Windows
  Pesquisa do Windows
    Powershell
      ssh seu_usuário@ENDEREÇO_IPV4_SERVIDOR (alterar para o endereço IPv4 do seu servidor)
```
```bash
#acessando o OpenSSH via PuTTY
Windows
  Pesquisa do Windows
    PuTTY

Category
  Session
    Host Name (or IP address): seu_usuário@ENDEREÇO_IPV4_SERVIDOR (alterar para o endereço IPv4 do seu servidor)
    Port: 22
    SSH: On
<Open>
```
```bash
#acessando o OpenSSH via Git Bash no Windows
Windows
  Git Bash
    ssh seu_usuário@ENDEREÇO_IPV4_SERVIDOR (alterar o usuário e endereço IPv4 do seu servidor)
```
```bash
#acessando o OpenSSH via Terminal no Linux Mint
Linux
  Terminal: Ctrl + Alt + T
    ssh seu_usuário@ENDEREÇO_IPV4_SERVIDOR (alterar o usuário e endereço IPv4 do seu servidor)
```
```bash
#verificando informações detalhadas dos usuários logados no Ubuntu Server
sudo w
```

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO TCP WRAPPERS A SEGUINTE FRASE: *Configuração do TCP Wrappers On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #tcpwrappers #tcpwrappersubuntu #tcpwrappersubuntuserver #tcpwrappersubuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/20-tcpwrappers.png

---