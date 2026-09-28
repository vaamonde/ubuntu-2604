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
**Data de atualização:** `28/09/2026`<br>
**Versão:** `0.01`<br>

> __`Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS`__

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO OPENSSH A SEGUINTE FRASE: *Configuração do OpenSSH On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #openssh #opensshubuntu #opensshuntuserver #opensshuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/19-openssh.png

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


[![OpenSSH Server](http://img.youtube.com/vi//0.jpg)]("OpenSSH Server")

Link da vídeo aula: 

## 02_ Verificando o Serviço e Versão do OpenSSH Server e Client no Ubuntu Server
```bash
#verificando o serviço do OpenSSH Server no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then start
#one or more units), stop (Stop (deactivate) one or more units), start (Start (activate) one or
#more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status ssh
sudo systemctl restart ssh
sudo systemctl stop ssh
sudo systemctl start ssh
```
```bash
#analisando os Log's e mensagens de erro do Servidor do OpenSSH no Ubuntu Server
#opção do comando journalctl: -x (catalog), -e (pager-end), -u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -xeu ssh
```

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção.

```bash
#verificando as versões do OpenSSH Server no Ubuntu Server
#opção do comando sshd e sshd: -V (version)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/sshd
sudo sshd -V
```
```bash
#verificando as versões do OpenSSH Client no Ubuntu Server
#opção do comando ssh: -V (version)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/ssh
sudo ssh -V
```

## 03_ Verificando a Porta de Conexão do OpenSSH Server no Ubuntu Server
```bash
#verificando a porta padrão TCP-22 do OpenSSH Server no Ubuntu Server
#opção do comando lsof: -n (network number), -P (port number), -i (list IP Address), -s (alone directs)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/lsof
sudo lsof -nP -iTCP:'22' -sTCP:LISTEN
```

## 04_ Localização dos Arquivos de Configuração do OpenSSH Server no Ubuntu Server
```bash
/etc/ssh/                <-- Diretório de configuração do OpenSSH Server e Client
/etc/ssh/sshd_config     <-- Arquivo de configuração do OpenSSH Server
/etc/ssh/ssh_config      <-- Arquivo de configuração do OpenSSH Client
/etc/issue.net           <-- Arquivo de configuração do Banner do Ubuntu Server para acesso remoto
/etc/issue               <-- Arquivo de configuração do Prompt de Login do Ubuntu Server para acesso local
/var/log/                <-- Diretório de Logs do Sistema Operacional Ubuntu Server
/var/log/syslog          <-- Log principal do Sistema Operacional Ubuntu Server
/var/log/auth.log        <-- Log principal das autenticações do Sistema Operacional Ubuntu Server
/var/run/sshd/           <-- Diretório do Pid de Processo e Socket do OpenSSH Server
```

## 05_ Atualizando os arquivos de configuração do OpenSSH Server e do Banner no Ubuntu Server
```bash
#fazendo o backup do arquivo de configuração do OpenSSH Server no Ubuntu Server
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/ssh/sshd_config /etc/ssh/sshd_config.old
```
```bash
#atualizando o arquivo de configuração do OpenSSH Server do Ubuntu Server do Github
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/ssh/sshd_config https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/sshd_config
```
```bash
#atualizando o arquivo de configuração do Banner do Ubuntu Server do Github
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/issue.net https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/issue.net
```
```bash
#atualizando o arquivo de configuração do Prompt de Login do Ubuntu Server do Github
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/issue https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/issue
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
#alterar a variável ListenAddress na linha: 27 
#ListenAddress 172.16.1.xxx para: SEU_ENDEREÇO_IPV4_DO_UBUNTU
#OBSERVAÇÃO: ALTERAR O ENDEREÇO IPv4 CONFORME A SUA NECESSIDADE
ListenAddress SEU_ENDEREÇO_IPV4_DO_UBUNTU
ListenAddress SEU_ENDEREÇO_IPV6_DO_UBUNTU

#alterar a variável AllowUsers na linha: 77
#OBSERVAÇÃO: ALTERAR O USUÁRIO DE ACESSO CONFORME A SUA NECESSIDADE
AllowUsers SEU_USUÁRIO

#alterar a variável AllowGroups na linha: 83
#OBSERVAÇÃO: ALTERAR O GRUPO DE ACESSO CONFORME A SUA NECESSIDADE
AllowGroups SEU_GRUPO_DO_USUÁRIO
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
#editando o arquivo de configuração do Banner do Ubuntu Server
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/issue.net
sudo vim /etc/issue.net
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#alterar a linha 5: Servidor e Admin
#OBSERVAÇÃO: ALTERAR O BANNER CONFORME A SUA NECESSIDADE
Servidor: wsseunome - Admin: SEU NOME E SOBRENOME
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```
```bash
#editando o arquivo de configuração do Prompt de Login do Ubuntu Server
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/issue
sudo vim /etc/issue
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#alterar a linha 1: Servidor do Projeto
#OBSERVAÇÃO: ALTERAR O PROMPT CONFORME A SUA NECESSIDADE
Servidor do Projeto NOME_DO_SEU_PROJETO - GNU/Linux Server

#alterar a linha 4: Administrador do servidor
#OBSERVAÇÃO: ALTERAR O PROMPT CONFORME A SUA NECESSIDADE
Administrador do servidor.: SEU_NOME_E_SOBRENOME 
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
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

**OBSERVAÇÃO IMPORTANTE 01:** no comando: __`w`__ ele mostra na primeira linha as informações de:<br>
14:28:13   up 16 min,   1 user,   load average: 0,00, 0,00, 0,00<br>

| Valores | Descrição |
|---------|-----------|
| **14:28:13** | Data e Hora Atual do Sistema; |
| **up 16 min** | Período de Tempo Ativo; |
| **1 user** | Número de Usuários Logados; |
| **load average: 0,00, 0,00, 0,00** | Médias de Cargas do Sistema (1, 5 e 15 minutos). |

**OBSERVAÇÃO IMPORTANTE 02:** no comando: __`w`__ ele mostra as informações separadas por colunas:<br>
USER   TTY   FROM   LOGIN@   IDLE   JCPU   PCPU   WHAT<br>

| Colunas | Descrição | 
|---------|-----------|
| **USER** | usuário logado; |
| **TTY** | terminal do usuário |
| **FROM** | origem da conexão; |
| **LOGIN@** | hora do login do usuário; |
| **IDLE** | tempo ocioso do usuário; |
| **JCPUv** | tempo de CPU dos processos do TTY; |
| **PCPU** | tempo de CPU do processo do último comando o usuário; |
| **WHAT** | processo atual do usuário. |

```bash
#verificando os usuários logados remotamente no Ubuntu Server
#opção do comando who: -H (heading), -a (all)
sudo who -Ha
```

**OBSERVAÇÃO IMPORTANTE:** no comando: __`who`__ ele mostra as informações separadas por colunas:<br>
NAME   LINE   TIME   IDLE   PID COMMENT   EXIT<br>

| Colunas | Descrição | 
|---------|-----------|
| **NAME** | usuário logado; |
| **LINE** | terminal do usuário; |
| **TIME** | data e hora do login do usuário; |
| **IDLE** | tempo ocioso do usuário; |
| **PID** | identificação do processo; |
| **COMMENT** | origem da conexão do usuário; |
| **EXIT** | saída do processo. |

```bash
#verificando os usuários logados no Ubuntu Server
users
```

## 09_ Criando um usuário Administrador no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** NESSE EXEMPLO ESTÁ SENDO CRIADO UM USUÁRIO ADMIN PARA A ADMINISTRAÇÃO DO SERVIDOR, *NÃO RECOMENDO CRIAR UM USUÁRIO CHAMADO:* __`admin`__ POIS É UM USUÁRIO CONHECIDO E EXISTE VÁRIOS SOFTWARE DE **FORÇA BRUTA (BRUTE FORCE)** QUE USA ESSE USUÁRIO PARA *INVADIR SERVIDORES*. NESSE EXEMPLO SERÁ CRIADO APENAS PARA EFEITO DE APRENDIZAGEM.
>
> **OBSERVAÇÃO** Mais informações veja o Site do Wikipedia das 10.000 senhas mais comuns: https://en.wikipedia.org/wiki/Wikipedia:10,000_most_common_passwords

```bash
#criando o usuário Admin local no Ubuntu Server
#OBSERVAÇÃO: ALTERAR A SENHA DO USUÁRIO ADMIN CONFORME SUA NECESSIDADE
sudo adduser admin
  New password: sua_senha
  Retype new password: sua_senha
    Full Name []: Admin Sua Empresa
    Room Number []: <Enter>
    Work Phone []: <Enter>
    Home Phone []: <Enter>
    Other []: <Enter>
  Is the information correct? [Y/n] y <Enter>
```
```bash
#listando o usuário criado no arquivo passwd
#opção do comando cat: -n (number line)
#opção do redirecionador |: Conecta a saída padrão com a entrada padrão de outro comando
sudo cat -n /etc/passwd | grep admin
```
```bash
#listando o usuário criado com o comando getent (MAIS SIMPLES)
#opção do comando getent: passwd (the database system user)
sudo getent passwd admin
```
```bash
#listando o grupo criado no arquivo group
#opção do comando cat: -n (number line)
#opção do redirecionador |: Conecta a saída padrão com a entrada padrão de outro comando
sudo cat -n /etc/group | grep admin
```
```bash
#listando o grupo criado com o comando getent (MAIS SIMPLES)
#opção do comando getent: group (the database system group)
sudo getent group admin
```

## 10_ Adicionando o usuário Admin no grupo SUDO (Super User Do) do Ubuntu Server
```bash
#adicionando o usuário Admin ao grupo do SUDO
#opção do comando usermod: -a (append), -G (groups)
sudo usermod -a -G sudo admin
```
```bash
#verificando os grupos do usuário Admin
sudo groups admin
```
```bash
#verificando as identificações de grupos do usuário Admin
sudo id admin
```
```bash
#verificando as informações do grupo SUDO
#opção do comando getent: group (the database system group)
sudo getent group sudo
```

## 11_ Se logando no Terminal TTY (Teletype Bash/Shell) do Ubuntu Server

```bash
#abrindo um segundo Terminal TTY (Teletype) no Ubuntu Server
Atalho: Alt + F2

Ubuntu 22.04.5 LTS wsseunome tty2
  wsseunome login: admin
  Password: sua_senha

#para sair do Terminal TTY você pode digitar os comandos
logout   #(sair do login)
exit     #(sair do login)
Ctrl+D   #(atalho para sair do login)

#voltar para o primeiro Terminal TTY (Teletype) do Ubuntu Server
Atalho: Alt + F1
```

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO OPENSSH A SEGUINTE FRASE: *Configuração do OpenSSH On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #openssh #opensshubuntu #opensshuntuserver #opensshuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/19-openssh.png

---