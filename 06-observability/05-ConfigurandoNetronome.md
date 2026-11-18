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
**Data de atualização:** `18/11/2026`<br>
**Versão:** `0.02`<br>

> __`Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS`__

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO BORG BACKUP SERVER A SEGUINTE FRASE: *Configuração do Netronome On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #netronome #netronomeubuntu #netronomeuntuserver #netronomeuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/18-netronome.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>
Netronome Github: https://github.com/autobrr/netronome<br>
Site Oficial do Librespeed: https://librespeed.org/<br>
Github Oficial do Projeto Librespeed: https://github.com/librespeed/speedtest<br>

**Conteúdo estudado nessa configuração:**<br>
[#00_ Principais arquivos de configuração desse procedimento no Ubuntu Server](#00_-principais-arquivos-de-configuração-desse-procedimento-no-ubuntu-server)
[#01_ Instalando as dependências do Netronome Server no Ubuntu Server](#01_-instalando-as-dependências-do-netronome-server-no-ubuntu-server)
[#02_ Instalando o Netronome Server do Projeto do Github no Ubuntu Server](#02_-instalando-o-netronome-server-do-projeto-do-github-no-ubuntu-server)
[#03_ Instalando o SpeedTest do Projeto do Github no Ubuntu Server](#03_-instalando-o-speedtest-do-projeto-do-github-no-ubuntu-server)
[#04_ Configurando o Netronome Server no Ubuntu Server](#04_-configurando-o-netronome-server-no-ubuntu-server)
[#05_ Atualizando os arquivos de configuração do Netronome Server no Ubuntu Server](#05_-atualizando-os-arquivos-de-configuração-do-netronome-server-no-ubuntu-server)
[#06_ Habilitando os Serviços do Netronome e Iperf3 Server no Ubuntu Server](#06_-habilitando-os-serviços-do-netronome-e-iperf3-server-no-ubuntu-server)
[#07_ Verificando os Serviços e Versão do Netronome e Iperf3 Server no Ubuntu Server](#07_-verificando-os-serviços-e-versão-do-netronome-e-iperf3-server-no-ubuntu-server)
[#08_ Editando o arquivo de configuração de Portas do Apache2 Server no Ubuntu Server](#08_-editando-o-arquivo-de-configuração-de-portas-do-apache2-server-no-ubuntu-server)
[#09_ Instalando o Netronome Agent do Projeto do Github no Ubuntu Server](#09_-instalando-o-netronome-agent-do-projeto-do-github-no-ubuntu-server)
[#10_ Verificando as Portas de Conexões do Apache2, SpeedTest, Netronome e Iperf3 Server no Ubuntu Server](#10_-verificando-as-portas-de-conexões-do-apache2-speedtest-netronome-e-iperf3-server-no-ubuntu-server)
[#11_ Editando os arquivos de configuração do Netronome Server no Ubuntu Server](#11_-editando-os-arquivos-de-configuração-do-netronome-server-no-ubuntu-server)
[#12_ Configurado o Netronome Server via Navegador](#12_-configurado-o-netronome-server-via-navegador)
[#13_ Configurando os principais Monitoramento do Netronome Server via Navegador](#13_-configurando-os-principais-monitoramento-do-netronome-server-via-navegador)

[![Netronome Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Netronome Ubuntu Server")

Link da vídeo aula: 

| **💾 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🌐 **Netronome** | Aplicação de código aberto para testes de velocidade e monitoramento de redes e servidores. | Centralizar testes de conexão, monitoramento de equipamentos, acompanhamento de métricas e notificações. |
| 🚀 **Speedtest.net (Ookla)** | Serviço de medição de velocidade de conexão com a Internet. | Medir as velocidades de Download e Upload, além de indicadores como Ping e Jitter, utilizando servidores de teste da rede Speedtest.net. |
| ⚡ **LibreSpeed** | Ferramenta de teste de velocidade de Internet de código aberto, que pode ser hospedada em um servidor próprio. | Realizar testes de Download, Upload, Ping e Jitter utilizando uma infraestrutura própria ou servidores LibreSpeed configurados. |
| 📊 **iPerf3** | Ferramenta de código aberto para medir o desempenho e a largura de banda de conexões de rede. | Avaliar a capacidade de transmissão entre dois equipamentos, medindo a velocidade de transferência de dados em TCP ou UDP. |
| 🌍 **Geolocalização IP** | Técnica que estima a localização geográfica associada a um endereço IP. | Identificar informações geográficas aproximadas de endereços IP e auxiliar na identificação ou seleção de servidores de teste próximos. |
| 🏢 **GeoIP / GeoLite2 Country** | Base de dados da MaxMind que associa endereços IP a informações geográficas, como países. | Consultar o país associado a um endereço IP sem depender necessariamente de uma consulta on-line a cada verificação. |
| 🧩 **GeoLite2 ASN** | Base de dados da MaxMind que relaciona endereços IP a números de sistemas autônomos (ASN) e organizações responsáveis pelas redes. | Identificar a organização ou provedor associado a um endereço IP e obter informações sobre sua rede. |
| 🖥️ **Agent (Agente Netronome)** | Processo do Netronome executado em outro servidor ou equipamento monitorado. | Coletar e enviar informações de utilização de rede, recursos do sistema, discos e dados SMART para a instância principal do Netronome. |
---

## 00_ Principais arquivos de configuração desse procedimento no Ubuntu Server

| **Diretório/Arquivo** | **Descrição** |
|-----------------------|---------------|
| `/var/www/html/` | 📁 Diretório padrão utilizado pelo servidor Web Apache para armazenar arquivos que serão disponibilizados por meio de páginas e aplicações Web. Pode conter arquivos HTML, CSS, JavaScript, imagens e outros recursos utilizados por aplicações de teste de velocidade. |
| `/var/www/html/speedtest/` | 📁 Diretório utilizado para armazenar os arquivos da interface Web do LibreSpeed, integrada ao Netronome. Contém os recursos necessários para disponibilizar a página de testes de velocidade de conexão, permitindo que usuários realizem testes diretamente pelo navegador. |
| `/root/.config/netronome/` | 📁 Diretório de configuração do Netronome para o usuário `root`. Armazena arquivos de configuração da aplicação, listas de servidores LibreSpeed e bases de dados geográficas utilizadas para identificar informações relacionadas a endereços IP. |
| `/root/.config/netronome/config.toml` | 📄 Arquivo principal de configuração do Netronome, no formato TOML, utilizado para definir parâmetros de funcionamento da aplicação, como configurações do servidor, banco de dados, testes de velocidade, integração com iperf3, LibreSpeed, monitoramento, notificações, autenticação e outras opções disponíveis. |
| `/root/.config/netronome/librespeed-servers.json` | 📄 Arquivo JSON que armazena informações sobre servidores compatíveis com LibreSpeed, utilizados para realizar testes de velocidade de conexão. Pode conter dados como identificadores, nomes, endereços, portas e localizações dos servidores disponíveis para os testes. |
| `/root/.config/netronome/GeoLite2-ASN.mmdb` | 🌎 Arquivo de banco de dados geográfico GeoLite2 ASN, da MaxMind, utilizado para identificar o Sistema Autônomo (ASN — Autonomous System Number) associado a um endereço IP, permitindo obter informações sobre a organização ou provedor responsável pela rede. |
| `/root/.config/netronome/GeoLite2-Country.mmdb` | 🌎 Arquivo de banco de dados geográfico GeoLite2 Country, da MaxMind, utilizado para identificar o país associado a um endereço IP. Pode ser utilizado pelo Netronome para apresentar informações geográficas relacionadas aos endereços IP monitorados. |
| `/etc/apache2/` | 📁 Diretório principal que armazena arquivos de configuração do servidor Web Apache, incluindo configurações globais, módulos, portas de comunicação, Virtual Hosts e outras opções de funcionamento do serviço HTTP/HTTPS. |
| `/etc/apache2/ports.conf` | 📄 Arquivo de configuração do Apache utilizado para definir as portas TCP nas quais o servidor Web deve aguardar conexões HTTP e HTTPS, normalmente as portas `80` e `443`. Também pode definir endereços IP específicos para escuta. |
| `/etc/apache2/sites-available/` | 📁 Diretório que armazena arquivos de configuração dos Virtual Hosts do Apache, permitindo configurar diferentes sites e aplicações Web, incluindo domínios, portas, diretórios raiz (*DocumentRoot*) e regras de acesso. Os arquivos armazenados nesse diretório não estão necessariamente ativos; normalmente, são habilitados por meio de links simbólicos em `/etc/apache2/sites-enabled/`. |
| `/etc/apache2/sites-available/speedtest.conf` | 📄 Arquivo de configuração de um Virtual Host do Apache destinado à aplicação de teste de velocidade Speedtest/LibreSpeed integrada ao Netronome. Pode definir o domínio ou endereço de acesso, a porta de comunicação, o diretório raiz dos arquivos da aplicação e outras regras necessárias para disponibilizar a interface Web. |
| `/etc/systemd/system/` | 📁 Diretório que armazena arquivos de unidade (*unit files*) personalizados do systemd, utilizados para configurar e gerenciar serviços, timers, sockets, mounts e outros recursos do sistema GNU/Linux. |
| `/etc/systemd/system/netronome.service` | 📄 Arquivo de unidade do systemd que define como o serviço Netronome deve ser iniciado, interrompido e gerenciado pelo sistema. Pode especificar o executável, argumentos de inicialização, caminho do arquivo de configuração, usuário e grupo de execução, dependências e políticas de reinicialização do serviço. O Netronome utiliza esse serviço para executar sua aplicação principal, disponibilizar a interface Web e realizar atividades de monitoramento e testes de rede. |
| `/etc/systemd/system/iperf3.service` | 📄 Arquivo de unidade do systemd que define como o serviço iperf3 deve ser iniciado, interrompido e gerenciado pelo sistema. Normalmente, configura o iperf3 para executar em modo servidor, aguardando conexões de clientes para realizar testes de desempenho de rede, medindo largura de banda, vazão (*throughput*) e outros parâmetros de comunicação. |
---

## 01_ Instalando as dependências do Netronome Server no Ubuntu Server
```bash
#atualizando as listas do Apt do sources.list no Ubuntu Server (garantindo pacotes atualizados)
#opção do comando apt: update (Resynchronize the package index files from their sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt update
```
```bash
#atualizando todos os software instalado no Ubuntu Server (garantindo versões atualizadas)
#opção do comando apt: upgrade (Install the newest versions of all packages currently installed
#on the system from the sources enumerated in /etc/apt/sources.list.)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt upgrade
  Continue? [Y/n] y <Enter>
```
```bash
#instalando as dependências do Netronome Server no Ubuntu Server
#opção do comando apt: install (install is followed by one or more package names)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt install iperf3 traceroute mtr-tiny vnstat apache2 php librespeed-cli
  Iniciar o Iperf3 automaticamente como um daemon?  <Yes><Enter>
```

## 02_ Instalando o Netronome Server do Projeto do Github no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o tempo todo o `Netronome` sofre alteração, antes de fazer o download do arquivo verifique a versão no link oficial de releases em: https://github.com/autobrr/netronome/releases/

```bash
#baixando o Netronome Server do Github (link atualizando em: 14/09/2026)
#opções do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
wget -v -O netronome.deb https://github.com/autobrr/netronome/releases/download/v0.14.0/netronome_0.14.0_linux_amd64.deb
```
```bash
#instalando o Netronome Server no Ubuntu Server
#opção do comando dpkg: -i (The package is selected for installation)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/dpkg.1.html
sudo dpkg -i netronome.deb
```

## 03_ Instalando o SpeedTest do Projeto do Github no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** o tempo todo o `SpeedTest` sofre alteração, antes de fazer o download do arquivo verifique a versão no link oficial de releases em: https://github.com/librespeed/speedtest/releases

```bash
#baixando o SpeedTest do Github (link atualizando em: 14/09/2026)
#opções do comando wget: -v (Turn on verbose output), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
wget -v -O speedtest.tar.gz https://github.com/librespeed/speedtest/archive/refs/tags/v6.3.0.tar.gz
```
```bash
#descompactando o arquivo do SpeedTest no Ubuntu Server
#opções do comando tar: -z (Filter the archive through gzip), -x (Extract files from an archive),
#-v (Verbosely list files processed), -f (Use archive file or device ARCHIVE)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/tar.1.html
tar -zxvf speedtest.tar.gz
```

> **OBSERVAÇÃO IMPORTANTE:** nesse cenário como temos o serviço do `BorgBackupServer - BBS` instalado no mesmo servidor ele depende do **Apache2 Server** instalado e configurado, o diretório `Document Root` deve existir para hospedar a página do **SpeedTest**, caso contrário faça a instalação do Apache2: __`sudo apt install apache2`__.

```bash
#movendo o diretório do SpeedTest para a raiz do Apache2 Server no Ubuntu Server
#opção do comando mv: -v (verbose explain what is being done), * (asterisco) autocomplemento
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/mv.1.html
sudo mv -v speedtest-*/ /var/www/html/speedtest/
```

## 04_ Configurando o Netronome Server no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** recomendado que o procedimento abaixo seja feito utilizando o usuário: __`root`__ do Ubuntu Server para facilitar a instalação e configuração do *Netronome Server*.

```bash
#mudando para o usuário Root do Ubuntu Server
#opção do comando sudo: -i (Run the shell specified by the target user’s password database entry as a login shell)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/sudo.8.html
sudo -i
```
```bash
#gerando o arquivo de configuração do Netronome Server no Ubuntu Server
#opção do comando netronome: generate-config (Generate a default configuration file)
#mais informações acesse a documentação oficial em: https://github.com/autobrr/netronome#basic-configuration
netronome generate-config
```

## 05_ Atualizando os arquivos de configuração do Netronome Server no Ubuntu Server
```bash
#download do arquivo de configuração do Netronome Server no Ubuntu Server
#opções do comando wget: -v (Turn on verbose output), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
wget -v -O /root/.config/netronome/config.toml https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/config.toml
```
```bash
#download do arquivo de configuração do Librespeed Server no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
wget -v -O /root/.config/netronome/librespeed-servers.json https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/librespeed-servers.json
```
```bash
#download do arquivo de configuração do Virtual Host do SpeedTest no Ubuntu Server
#opções do comando wget: -v (Turn on verbose output), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
wget -v -O /etc/apache2/sites-available/speedtest.conf https://raw.githubusercontent.com/vaamonde/ubuntu-2204/main/conf/speedtest.conf
```
```bash
#download do arquivo da Base de Dados de GeoIP Lite ANS no Ubuntu Server (link atualizado em: 14/09/2026)
#link oficial do projeto no Github: https://github.com/P3TERX/GeoLite.mmdb/releases
#opções do comando wget: -v (Turn on verbose output), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
wget -v -O /root/.config/netronome/GeoLite2-ASN.mmdb https://git.io/GeoLite2-ASN.mmdb
```
```bash
#download do arquivo da Base de Dados de GeoIP Lite Country no Ubuntu Server (link atualizado em: 14/09/2026)
#link oficial do projeto no Github: https://github.com/P3TERX/GeoLite.mmdb/releases
#opções do comando wget: -v (Turn on verbose output), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
wget -v -O /root/.config/netronome/GeoLite2-Country.mmdb https://git.io/GeoLite2-Country.mmdb
```
```bash
#download do arquivo de serviço do Netronome Server no Ubuntu Server
#opções do comando wget: -v (Turn on verbose output), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
wget -v -O /etc/systemd/system/netronome.service https://raw.githubusercontent.com/vaamonde/ubuntu-2204/main/conf/netronome.service
```
```bash
#download do arquivo de serviço do IPerf3 Server no Ubuntu Server
#opções do comando wget: -v (Turn on verbose output), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
wget -v -O /etc/systemd/system/iperf3.service https://raw.githubusercontent.com/vaamonde/ubuntu-2204/main/conf/iperf3.service
```
```bash
#saindo do perfil do usuário Root no Ubuntu Server
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man2/exit.2.html
exit
```

## 06_ Habilitando os Serviços do Netronome e Iperf3 Server no Ubuntu Server
```bash
#habilitando os serviços do Netronome e Iperf3 Server no Ubuntu Server
#opções do comando systemctl: daemon-reload (Reload the systemd manager configuration), 
#enable (Enable one or more units), start (Start (activate) one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#atualizando os serviços do Systemd no Ubuntu Server
sudo systemctl daemon-reload
```
```bash
#habilitando os serviços do Netronome e Iperf3 no Ubuntu Server
sudo systemctl enable netronome iperf3
```
```bash
#iniciando os serviços do Netronome e Iperf3 no Ubuntu Server
sudo systemctl start netronome iperf3
```

## 07_ Verificando os Serviços e Versão do Netronome e Iperf3 Server no Ubuntu Server
```bash
#verificando os serviços do Netronome e Iperf3 no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then 
#start one or more units), stop (Stop (deactivate) one or more units), start (Start (activate) 
#one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#verificando o status dos serviços do Netronome e Iperf3 no Ubuntu Server
sudo systemctl status netronome iperf3
```
```bash
#reinicializando os serviços do Netronome e Iperf3 no Ubuntu Server
sudo systemctl restart netronome iperf3
```
```bash
#parando os serviços do Netronome e Iperf3 no Ubuntu Server
sudo systemctl stop netronome iperf3
```
```bash
#iniciando os serviços do Netronome e Iperf3 no Ubuntu Server
sudo systemctl start netronome iperf3
```
```bash
#analisando os Log's e mensagens de erro do Netronome e Iperf3 no Ubuntu Server 
#opção do comando journalctl: -t (identifier), -x (catalog), -e (pager-end), -u (unit)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -xeu netronome
sudo journalctl -xeu iperf3
```

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção

```bash
#verificando a versão do Netronome no Ubuntu Server
#opção do comando netronome: version (Print version information)
#mais informações acesse a documentação oficial em: https://github.com/autobrr/netronome#basic-configuration
sudo netronome version
```
```bash
#verificado a versão do IPerf3 no Ubuntu Server
#opção do comando iperf3: --version (Show version information and quit)
#mais informações acesse a documentação oficial em: https://iperf.fr/iperf-doc.php#3doc
sudo iperf3 --version
```
```bash
#verificado a versão do Librespeed-Cli no Ubuntu Server
#opção do comando librespeed-cli: --version (Show the version number and exit)
#mais informações acesse a documentação oficial em: https://github.com/librespeed/speedtest-cli
sudo librespeed-cli --version
```

## 08_ Editando o arquivo de configuração de Portas do Apache2 Server no Ubuntu Server
```bash
#editando arquivo de configuração de Portas do Apache2 Server no Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/vi
sudo vim /etc/apache2/ports.conf
```
```bash
#habilitando o número de linhas do arquivo ports.conf
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```yaml
#adicionar o valor da variável Listen a partir da linha: 06
Listen 8080
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>
```
```bash
#testando os arquivos de configuração do Apache2 Server no Ubuntu Server
#opção do comando apache2ctl: -t (Run a configuration file syntax test)
#mais informações acesse a documentação oficial em: https://linuxcommandlibrary.com/man/apache2ctl
sudo apache2ctl -t
```
```bash
#reiniciando o serviço do Apache2 Server no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then 
#start one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#reiniciando o serviço do Apache2 Server no Ubuntu Server
sudo systemctl restart apache2
```
```bash
#verificando o status o serviço do Apache2 Server no Ubuntu Server
sudo systemctl status apache2
```

## 09_ Instalando o Netronome Agent do Projeto do Github no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** recomendo utilizar o `script de instalação e configuração do Netronome Agent` nos servidores GNU/Linux, mais informação acesse o link oficial do projeto em: https://github.com/autobrr/netronome
>
>**OBSERVAÇÃO IMPORTANTE:** para sistemas `Microsoft Windows` utilizar a versão de **Servidor** que já tem o **Agent** incluso, mais informações acesse o link oficial do projeto em: https://github.com/autobrr/netronome/releases

```bash
#instalando o Netronome Agent do Github no Ubuntu Server (link atualizando em: 14/09/2026)
#opção do comando curl: -s (silent), -L (location)
#opção do redirecionar de saída piper (|): Conecta a saída padrão com a entrada padrão de outro comando
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/curl.1.html
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/bash.1.html
curl -sL https://netrono.me/install-agent | sudo bash
```
```bash
#informações que serão solicitadas no momento da instalação do Netronome Agent no Ubuntu Server

#Interfaces de Redes disponíveis no Ubuntu Server
01) Available network interfaces:
    Enter the interface name to monitor (leave empty for all): bond0 <Enter>
```
```bash
#Configuração da segurança utilizando o Tailscale no Netronome Agent
02) Tailscale provides secure, encrypted connectivity without exposing ports to the internet.
    Do you want to enable Tailscale for secure connectivity? (y/n): n <Enter>
```
```bash
#Configuração da Chave de API de conexão do Netronome Agent
03) API Key Configuration: 
    Select an option [1-3]: 1 <Enter>
```
```bash
#Configuração do Endereço do Host do Netronome Agent
04) Enter the host/IP to listen on (default: 0.0.0.0): <Enter>
```
```bash
#Configuração da Porta de Conexão do Host do Netronome Agent
05) Enter the port number (default: 8200): <Enter>
```
```bash
#Configuração dos Discos e Partições de Monitoramento do Netronome Agent
06) You can specify additional disk mounts to monitor or exclude certain mounts.
    Enter disk mounts to include (comma-separated, e.g., /mnt/storage,/mnt/backup): <Enter>
```
```bash
#Configuração dos Discos e Partições Sem Monitoramento do Netronome Agent
07) Enter disk mounts to exclude (comma-separated, e.g., /boot,/tmp): /boot,/tmp <Enter>
```
```bash
#Configuração do suporte a atualização do Netronome Agent
08) Would you like to enable automatic daily updates? (y/n): y
```

>**OBSERVAÇÃO IMPORTANTE:** após a instalação do `Netronome Agent` no Ubuntu Server, copiar a `API Key` gerado no procedimento: **03) API Key Configuration:**, essa chave será utilizada na configuração do Netronome Agent no Netronome Server.

```bash
#habilitando o serviço do Netronome Agent no Ubuntu Server
#opções do comando systemctl: daemon-reload (Reload the systemd manager configuration), 
#enable (Enable one or more units), start (Start (activate) one or more units), status 
#(runtime status information)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#atualizando os serviços do Systemd no Ubuntu Server
sudo systemctl daemon-reload
```
```bash
#habilitando o serviço do Netronome Agent no Ubuntu Server
sudo systemctl enable netronome-agent
```
```bash
#iniciando o serviço do Netronome Agent no Ubuntu Server
sudo systemctl start netronome-agent
```
```bash
#verificando o status do serviço do Netronome Agent no Ubuntu Server
sudo systemctl status netronome-agent
```
```bash
#analisando os Log's e mensagens de erro do Netronome Agent no Ubuntu Server 
#opção do comando journalctl: -x (catalog), -e (pager-end), -u (unit)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -xeu netronome-agent
```

## 10_ Verificando as Portas de Conexões do Apache2, SpeedTest, Netronome e Iperf3 Server no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** no Ubuntu Server as Regras de Firewall utilizando o comando: __` iptables `__ ou: __` ufw `__ está desabilitado por padrão **(INACTIVE)**, caso você tenha habilitado algum recurso de Firewall é necessário fazer a liberação do *Fluxo de Entrada (INPUT), Porta (PORT) e Protocolo (PROTOCOL) TCP* do Serviço corresponde nas tabelas do firewall e testar a conexão.

```bash
#verificando a porta padrão TCP-80 (Apache2), TCP-8080 (SpeedTest), TCP-5201 (Iperf3), TCP-7575 (Netronome) e TCP-8200 (Agent)
#opção do comando lsof: -n (network number), -P (port number), -i (list IP Address), -s (alone directs)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/lsof.8.html
sudo lsof -nP -iTCP:'80,8080,8200,5201,7575' -sTCP:LISTEN
```

## 11_ Editando os arquivos de configuração do Netronome Server no Ubuntu Server
```bash
#editando o arquivo de configuração do Netronome Server no Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/vi
sudo vim /root/.config/netronome/config.toml
```
```bash
#habilitando o número de linhas do arquivo config.toml
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```yaml
#alterar os valores da variável: whitelist na linha: 33
whitelist = ["127.0.0.1/32", "172.16.1.0/24", "::/0"]
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>
```
```bash
#editando o arquivo de configuração do Librespeed Servers no Ubuntu Server
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/vi
sudo vim /root/.config/netronome/librespeed-servers.json
```
```bash
#habilitando o número de linhas do arquivo librespeed-servers.json
ESC SHIFT :set number <Enter>
```
```bash
#entrando no modo de edição do editor de texto VIM
INSERT
```
```yaml
#alterar os valores das variáveis dos blocos dos servidores
#linhas de: 03 até 05
"id": 1,
    "name": "seu_nome_de_servidor",
    "server": "http://seu_endereço_ipv4:8080/backend",
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>
```
```bash
#reiniciando o serviço do Netronome Server no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then 
#start one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
```
```bash
#reiniciando o serviço do Netronome Server no Ubuntu Server
sudo systemctl restart netronome
```
```bash
#verificando o status o serviço do Netronome Server no Ubuntu Server
sudo systemctl status netronome
```

## 12_ Configurado o Netronome Server via Navegador

> **OBSERVAÇÃO IMPORTANTE:** a partir desta etapa, a configuração ocorre pela **Interface Web** do `Netronome Server`, acessada de um navegador na mesma rede do `Ubuntu Server`. Utilize o Endereço `IPv4 ou o FQDN` configurado no procedimento de Settings.

```bash
#Acessando o navegador para fazer as primeiras configurações do Netronome Server
01) Abrir o navegador e acessar o Painel Web do Netronome Server
    URL: https://srvvaamonde.pti.intra:7575 (ou https://SEU_ENDEREÇO_IPv4:7575 ou https://SEU_ENDEREÇO_IPv6:7575)
```
```bash
#Usuário e senha padrão de acesso ao Netronome Server
02) Netronome - Network performance testing
    Username: admin
    Password: admin
    <Sign in>
```

## 13_ Configurando os principais Monitoramento do Netronome Server via Navegador
```bash
```

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO BORG BACKUP SERVER A SEGUINTE FRASE: *Configuração do Netronome On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #netronome #netronomeubuntu #netronomeuntuserver #netronomeuntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/18-netronome.png

---