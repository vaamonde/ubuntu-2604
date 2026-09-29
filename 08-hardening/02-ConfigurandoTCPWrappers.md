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
**Data de atualização:** `29/09/2026`<br>
**Versão:** `0.01`<br>

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
#01_


[![TCP Wrappers](http://img.youtube.com/vi//0.jpg)]("TCP Wrappers")

Link da vídeo aula: 

## 04_ Localização dos Arquivos de Configuração do OpenSSH Server no Ubuntu Server
```bash
/etc/hosts.deny          <-- Arquivo de configuração do Firewall de Aplicação TCP Wrappers Deny
/etc/hosts.allow         <-- Arquivo de configuração do Firewall de Aplicação TCP Wrappers Allow
/var/log/                <-- Diretório de Logs do Sistema Operacional Ubuntu Server
/var/log/syslog          <-- Log principal do Sistema Operacional Ubuntu Server
/var/log/auth.log        <-- Log principal das autenticações do Sistema Operacional Ubuntu Server
/var/log/allow-ssh.log   <-- Log principal dos acessos remoto do TCP Wrappers Allow do OpenSSH Server
/var/log/deny.log        <-- Log principal dos acesso negados do TCP Wrappers Deny do OpenSSH Server
```

## 05_ Atualizando os arquivos de configuração do TCP Wrappers no Ubuntu Server
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

## 07_ Editando os arquivos de configuração do OpenSSH Server e do Banner no Ubuntu Server
```bash
#editando o arquivo de configuração do OpenSSH Server no Ubuntu Server
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/sshd_config
sudo vim /etc/ssh/sshd_config
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


## 08_ Acessando remotamente o OpenSSH Server via Powershell, PuTTY e Git Bash
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