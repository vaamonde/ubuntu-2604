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

**Data de criação:** `06/07/2026`<br>
**Data de atualização:** `10/09/2026`<br>
**Versão:** `0.07`<br>

> __`Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS`__

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO HOSTNAME A SEGUINTE FRASE: *Configuração do Hostname On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #hostname #hostnameubuntu #hostnamebuntuserver #hostnameubuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/05-hostname.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

**Conteúdo estudado nessa configuração:**<br>
[#01_ Alterando o nome FQDN (Fully Qualified Domain Name) do Ubuntu Server](#01_-alterando-o-nome-fqdn-fully-qualified-domain-name-do-ubuntu-server)<br>
[#02_ Alterando as entradas de resolução de nomes no arquivo Hosts do Ubuntu Server](#02_-alterando-as-entradas-de-resolução-de-nomes-no-arquivo-hosts-do-ubuntu-server)<br>
[#03_ Verificando as informações da Placa de Rede depois de alterada no Ubuntu Server](#03_-verificando-as-informações-de-resolução-de-nomes-locais-depois-de-alterada-no-ubuntu-server)<br>

| **🖥️ Conceito** | **📖 O que é?** | **🎯 Para que serve?** |
| :-------------- | :-------------- | :--------------------- |
| 🌐 **FQDN (Fully Qualified Domain Name)** | É o **Nome de Domínio Totalmente Qualificado**, que identifica de forma única um host na hierarquia do **DNS (Domain Name System)**. Um FQDN é composto pelo **hostname** e pelo **nome do domínio**, por exemplo: `srvvaamonde.pti.intra`. | Permite identificar de forma única um equipamento na rede, sendo utilizado por serviços como DNS, servidores Web, SSH, e-mail, certificados TLS/SSL e Active Directory. |
| 💻 **Hostname** | É o nome atribuído a um computador ou servidor dentro de uma rede. No Ubuntu, esse nome é armazenado no arquivo **`/etc/hostname`** e representa a identidade local da máquina. | Facilita a identificação do equipamento, sendo utilizado pelo sistema operacional, serviços de rede, logs, monitoramento e administração remota. Quando combinado com um domínio, forma o **FQDN**. |
| 📄 **Arquivo `/etc/hosts`** | Arquivo de resolução local de nomes que associa **nomes de hosts** a **endereços IP**, sem depender de um servidor DNS. O sistema consulta esse arquivo antes (ou conforme a configuração do `nsswitch.conf`) de realizar consultas a servidores DNS. | Permite criar resoluções locais de nomes, testar serviços, definir apelidos (*aliases*) para hosts e garantir a resolução de nomes mesmo quando não existe ou não está disponível um servidor DNS. |
---

[![Hostname Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Hostname Ubuntu Server")

Link da vídeo aula: 

## 01_ Alterando o nome FQDN (Fully Qualified Domain Name) do Ubuntu Server
```bash
#editando o arquivo de configuração do Hostname no Ubuntu Server
#mais informações veja a documentação oficial em: https://man7.org/linux/man-pages/man5/hostname.5.html
sudo vim /etc/hostname
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#alterar o nome de domínio FQDN na linha 1
#OBSERVAÇÃO IMPORTANTE: ALTERAR O NOME DO DOMÍNIO PARA O SEU CENÁRIO
srvseunome.seu.domínio
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```
```bash
#verificando as informações de Hostname no Ubuntu Server
sudo hostname
```

## 02_ Alterando as entradas de resolução de nomes no arquivo Hosts do Ubuntu Server
```bash
#fazendo o backup do arquivo de configuração original do Hosts no Ubuntu Server
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/hosts /etc/hosts.old
```
```bash
#editando o arquivo de configuração do Hosts no Ubuntu Server
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/hosts
sudo vim /etc/hosts
```
```bash
#habilitando o número de linhas do arquivo hosts
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#OBSERVAÇÃO IMPORTANTE: ALTERAR O ENDEREÇO IPv4, NOME DE DOMÍNIO E APELIDO PARA O SEU CENÁRIO
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/hosts

#adicionar o nome de domínio e apelido nas linhas 1 até 3
#Endereço IPv4      Nome FQDN do Servidor    Apelido do Servidor
127.0.0.1           localhost.seu.domínio    localhost
127.0.1.1           srvseunome.seu.domínio   srvseunome
SEU_ENDEREÇO_IPV4   srvseunome.seu.domínio   srvseunome

#adicionar o nome de domínio e apelido nas linhas 11 e 12
#Endereço IPv6             Nome FQDN do Servidor    Apelido do Servidor
::1                        ip6-localhost            ip6-loopback
fe00::0                    ip6-localnet
ff00::0                    ip6-mcastprefix
ff02::1                    ip6-allnodes
ff02::2                    ip6-allrouters
SEU_ENDEREÇO_LOCAL_IPV6    srvseunome.seu.domínio   srvseunome
SEU_ENDEREÇO_GLOBAL_IPV6   srvseunome.seu.domínio   srvseunome
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>
```
```bash
#verificando as informações de hosts IPv4 no Ubuntu Server
#opção do comando getent: hosts (When no key is provided to enumerate the hosts database)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/getent.1.html
sudo getent hosts
```
```bash
#verificando as informações do nome do servidor no Ubuntu Server
#opção do comando hostname: -A (all-fqdns), -d (domain), -i (ip address)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/hostname.1.html
```
```bash
#visualizando o nome FQDN do servidor no Ubuntu Server
sudo hostname
```
```bash
#visualizando todas as informações FQDN do servidor no Ubuntu Server
sudo hostname -A
```
```bash
#visualizando o nome de domínio do servidor no Ubuntu Server
sudo hostname -d
```
```bash
#visualizando todas as informações de IPv4 e IPv6 do servidor no Ubuntu Server
sudo hostname -i
```

## 03_ Verificando as informações de Resolução de Nomes Locais depois de alterada no Ubuntu Server
```bash
#verificando as resoluções de nomes DNS do servidor Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/nslookup
nslookup localhost               #OBSERVAÇÃO: consultando o localhost
nslookup srvvaamonde             #OBSERVAÇÃO: consultando o hostname
nslookup srvvaamonde.pti.intra   #OBSERVAÇÃO: consultando o nome FQDN
```
```bash
#verificando as resoluções de endereços IPv4 e IPv6 do servidor Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/nslookup
nslookup 127.0.0.1              #OBSERVAÇÃO: endereço de Loopback padrão é sempre 127.0.0.1
nslookup 172.16.1.20            #OBSERVAÇÃO: alterar o endereço IPv4 do seu servidor
nslookup fe80::20               #OBSERVAÇÃO: alterar o endereço IPv6 de Link Local do seu servidor
nslookup 2804:14c:90:8697::20   #OBSERVAÇÃO: alterar o endereço IPv6 de Unicast Global do seu servidor
```
```bash
#verificando as resoluções de endereços IPv4 e IPv6 e estatísticas do servidor Ubuntu Server
#opção do comando resolvectl: query (Resolve domain names, as well as IPv4 and IPv6 addresses)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/resolvectl.1.html
resolvectl query localhost               #OBSERVAÇÃO: nome do Localhost padrão que faz referência ao Loopback
resolvectl query srvvaamonde             #OBSERVAÇÃO: alterar o hostname do seu servidor
resolvectl query srvvaamonde.pti.intra   #OBSERVAÇÃO: alterar o nome FQDN do seu servidor
```
```bash
#testando a conexão com a Internet e Resolução de nomes de DNS do servidor Ubuntu Server
#opção do comando ping: -4 (use IPv4), -6 (use IPv6) -c 5 (Stop after sending count ECHO_REQUEST packets)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping
ping -4 -c 5 127.0.0.1              #OBSERVAÇÃO: pingando o endereço de Loopback (Localhost)
ping -4 -c 5 172.16.1.20            #OBSERVAÇÃO: pingando o endereço IPv4
ping -6 -c 5 fe80::20%enp0s3        #OBSERVAÇÃO: para pingar o endereço IPv6 Link Local e necessário indicar a interface
ping -6 -c 5 2804:14c:90:8697::20   #OBSERVAÇÃO: pingando o endereço IPv6 Global Unicast
```

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO HOSTNAME A SEGUINTE FRASE: *Configuração do Hostname On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #hostname #hostnameubuntu #hostnamebuntuserver #hostnameubuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/05-hostname.png

---