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

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO OPENSSH A SEGUINTE FRASE: *Configuração do OpenSSH + Chaves + TOTP On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #openssh #opensshubuntu #opensshuntuserver #opensshuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/21-openssh-totp.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
Site Oficial do OpenSSH: https://www.openssh.com/<br>
Site Oficial do OpenSSL: https://www.openssl.org/<br>
Site Oficial do PuTTY: https://www.putty.org/<br>
Site Oficial do Google Authentication LibPAM: https://github.com/google/google-authenticator-libpam<br>
Aplicação (Android e iPhone) 2FA Authentication: https://play.google.com/store/apps/details/2FA_Authenticator_2FAS?id=com.twofasapp&hl=pt_BR<br>

**Conteúdo estudado nessa configuração:**<br>
[#00_ Principais arquivos de configuração desse procedimento no Ubuntu Server](#00_-principais-arquivos-de-configuração-desse-procedimento-no-ubuntu-server)<br>


| **🔐 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |

---

[![OpenSSH 2FA-TOTP](http://img.youtube.com/vi//0.jpg)]( "OpenSSH 2FA-TOTP")

Link da vídeo aula: 

## 00_ Principais arquivos de configuração desse procedimento no Ubuntu Server

| **📁 Diretório/Arquivo** | **📖 Descrição** |
| :----------------------- | :--------------- |
| 🔐 `/etc/ssh/` | Diretório que armazena os arquivos de configuração do OpenSSH, incluindo configurações do servidor SSH, do cliente SSH e chaves de identificação do servidor. |
| 🖥️ `/etc/ssh/sshd_config` | Arquivo principal de configuração do serviço servidor SSH (*OpenSSH Daemon*). Define opções como porta de conexão, autenticação por senha ou chave pública, acesso do usuário root e limites de tentativas de autenticação. |

---

## 01_ Gerando o Par de Chaves de Autenticação do OpenSSH Server e Client no Linux Mint
```bash
#gerando o par de chaves Pública/Privada no perfil do usuário local no Linux Mint
#mais informações veja a documentação oficial em: https://man7.org/linux/man-pages/man1/ssh-keygen.1.html
ssh-keygen
  Enter file in which to save the key (/home/seu_usuário/.ssh/id_rsa): /home/seus_usuário/.ssh/lm_openssh
  Enter passphrase (empty for no passphrase):
  Enter same passphrase again:

#verificando as chaves criadas no perfil do usuário local no Linux Mint
#opções do comando ls: ~ (atalho do path $HOME), -l (long listing), -h (human readable), * (curinga qualquer coisa)
#mais informações veja a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.html
ls -lh ~/.ssh/lm*
```

> **OBSERVAÇÃO IMPORTANTE:** arquivo `lm_openssh.pub` é a Chave Pública e o arquivo: `lm_openssh` é a Chave Privada.

```bash
#copiando a Chave Pública local do Linux Mint para o servidor Ubuntu Server
#opção do comando ssh-copy-id: -i (identity_file)
#mais informações veja a documentação oficial em: https://man7.org/linux/man-pages/man1/ssh-copy-id.1.html
ssh-copy-id -i .ssh/lm_openssh.pub vaamonde@172.16.1.20

#verificando remotamente a Chave Pública copiada para o servidor Ubuntu Server
#opção do comando ls: ~ (atalho do path $HOME), -l (long listing), -h (human readable), * (curinga qualquer coisa)
#mais informações veja a documentação oficial em: https://man7.org/linux/man-pages/man1/ssh.1.html
#mais informações veja a documentação oficial em: https://man7.org/linux/man-pages/man1/ls.1.html
ssh vaamonde@172.16.1.20 "ls -lh ~/.ssh/*"
```

## 02_ Editando o arquivo de configuração do OpenSSH Server no Ubuntu Server
```bash
#editando o arquivo de configuração do OpenSSH Server no Ubuntu Server
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/sshd_config
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/vi
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
#descomentar a variável AuthenticationMethods na linha: 38
#SOLICITAR PRIMEIRO A CHAVE PÚBLICA E DEPOIS SOLICITAR A SENHA DO USUÁRIO
AuthenticationMethods publickey password
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```
```bash
#testando o arquivo de configuração do OpenSSH Server no Ubuntu Server
#opção do comando sshd: -T (text mode check configuration)
sudo sshd -T
```
```bash
#reiniciar e verificar o status do serviço do OpenSSH Server no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then 
#start one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl restart ssh
sudo systemctl status ssh
```
```bash
#analisando os Log's e mensagens de erro do Servidor do OpenSSH no Ubuntu Server
#opção do comando journalctl: -t (identifier), x (catalog), e (pager-end), u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -t sshd
sudo journalctl -xeu ssh
```

## 03_ Acessando remotamente o OpenSSH Server via Powershell, PuTTY e Git Bash
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

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO OPENSSH A SEGUINTE FRASE: *Configuração do OpenSSH + Chaves + TOTP On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #openssh #opensshubuntu #opensshuntuserver #opensshuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/21-openssh-totp.png

---