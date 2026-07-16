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
#01_ Alterando o nome FQDN (Fully Qualified Domain Name) do Ubuntu Server<br>
#02_ Alterando as entradas de resolução de nomes no arquivo Hosts do Ubuntu Server<br>
#03_ Verificando as informações da Placa de Rede depois de alterada no Ubuntu Server<br>

| **🖥️ Conceito** | **📖 O que é?** | **🎯 Para que serve?** |
| :-------------- | :-------------- | :--------------------- |
| 🌐 **FQDN (Fully Qualified Domain Name)** | É o **Nome de Domínio Totalmente Qualificado**, que identifica de forma única um host na hierarquia do **DNS (Domain Name System)**. Um FQDN é composto pelo **hostname** e pelo **nome do domínio**, por exemplo: `srvvaamonde.apto.intra`. | Permite identificar de forma única um equipamento na rede, sendo utilizado por serviços como DNS, servidores Web, SSH, e-mail, certificados TLS/SSL e Active Directory. |
| 💻 **Hostname** | É o nome atribuído a um computador ou servidor dentro de uma rede. No Ubuntu, esse nome é armazenado no arquivo **`/etc/hostname`** e representa a identidade local da máquina. | Facilita a identificação do equipamento, sendo utilizado pelo sistema operacional, serviços de rede, logs, monitoramento e administração remota. Quando combinado com um domínio, forma o **FQDN**. |
| 📄 **Arquivo `/etc/hosts`** | Arquivo de resolução local de nomes que associa **nomes de hosts** a **endereços IP**, sem depender de um servidor DNS. O sistema consulta esse arquivo antes (ou conforme a configuração do `nsswitch.conf`) de realizar consultas a servidores DNS. | Permite criar resoluções locais de nomes, testar serviços, definir apelidos (*aliases*) para hosts e garantir a resolução de nomes mesmo quando não existe ou não está disponível um servidor DNS. |
---

[![Hostname Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Hostname Ubuntu Server")

Link da vídeo aula: 

## 01_ Alterando o nome FQDN (Fully Qualified Domain Name) do Ubuntu Server
```bash
#editando o arquivo de configuração do Hostname
#mais informações veja a documentação oficial em: https://man7.org/linux/man-pages/man5/hostname.5.html
sudo vim /etc/hostname

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

#verificando as informações de Hostname no Ubuntu Server
sudo hostname
```

## 02_ Alterando as entradas de resolução de nomes no arquivo Hosts do Ubuntu Server
```bash
#editando o arquivo de configuração do Hosts
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/hosts
sudo vim /etc/hosts

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
#OBSERVAÇÃO IMPORTANTE: ALTERAR O ENDEREÇO IPv4, NOME DO DOMÍNIO E APELIDO PARA O SEU CENÁRIO
#mais informações veja a documentação oficial em: https://linux.die.net/man/5/hosts

#adicionar o nome de domínio e apelido nas linhas 2 e 3
127.0.0.1      localhost.seu.domínio   localhost
127.0.1.1      srvseunome.seu.domínio  srvseunome
SUA_REDE_IPV4  srvseunome.seu.domínio  srvseunome

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
SUA_REDE_LOCAL_IPV6   srvseunome.seu.domínio  srvseunome
SUA_REDE_GLOBAL_IPV6  srvseunome.seu.domínio  srvseunome
```
```bash
#salvar e sair do arquivo
ESC SHIFT :x <Enter>

#verificando as informações de hosts no Ubuntu Server
#opção do comando getent: hosts (When no key is provided to enumerate the hosts database)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/getent.1.html
sudo getent hosts

#verificando as informações do nome do servidor Ubuntu Server
#opção do comando hostname: -A (all-fqdns), -d (domain), -i (ip address)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/hostname.1.html
sudo hostname
sudo hostname -A
sudo hostname -d
sudo hostname -i
```

## 03_ Verificando as informações da Placa de Rede depois de alterada no Ubuntu Server
```bash
#verificando as resoluções de nomes DNS do servidor Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/nslookup
nslookup localhost
nslookup srvvaamonde
nslookup srvvaamonde.pti.intra

#verificando as resoluções de endereços IPv4 e IPv6 do servidor Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/nslookup
nslookup 127.0.0.1
nslookup 172.16.1.20
nslookup fe80::20
nslookup 2804:14c:90:8697::20

#testando a conexão com a Internet e Resolução de nomes de DNS
#opção do comando ping: -4 (use IPv4), -6 (use IPv6) -c 5 (Stop after sending count ECHO_REQUEST packets)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/ping
ping -4 -c 5 127.0.0.1
ping -4 -c 5 172.16.1.20
ping -6 -c 5 fe80::20%enp0s3
ping -6 -c 5 2804:14c:90:8697::20
```