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
Data de atualização: 08/09/2026<br>
Versão: 0.07<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

Conteúdo estudado nessa configuração:<br>
#01_ Verificando o Serviço e Versão do Chrony Server e Client no Ubuntu Server<br>
#02_ Verificando a Porta de Conexão do Chrony Server no Ubuntu Server<br>
#03_ Localização dos Arquivos de Configuração do Chrony Server e Client no Ubuntu Server<br>
#04_ Atualizando os arquivos de configuração do Chrony Server e Client no Ubuntu Server<br>
#05_ Editando os arquivos de configuração do Chrony Server e Client no Ubuntu Server<br>
#06_ Verificando o Sincronismo de Data e Hora com o Protocolo NTP no Ubuntu Server<br>
#07_ Configuração de Data e Hora Manual no Sistema Operacional Ubuntu Server (SOMENTE SE NECESSÁRIO)<br>
#08_ Sincronizando Data e Hora do Sistema Operacional com o Hardware (BIOS) no Ubuntu Server (SOMENTE SE NECESSÁRIO)<br>

| **🌍 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| ⏱️ **NTP (Network Time Protocol)** | Protocolo de sincronização de tempo que utiliza **UDP porta 123** para manter os relógios de computadores e dispositivos sincronizados com servidores de referência de tempo. | Mantém a data e a hora corretas em servidores e equipamentos de rede, sendo essencial para autenticação, certificados digitais, auditorias, registros de logs, bancos de dados, clusters e ambientes distribuídos. |
| 🇧🇷 **NTP.br** | Projeto mantido pelo **NIC.br** em parceria com o **Observatório Nacional (ON)**, responsável por disponibilizar servidores públicos sincronizados com a Hora Legal Brasileira. Alguns servidores **Stratum 1** oferecem suporte ao **NTS (Network Time Security)**. | Permite que equipamentos localizados no Brasil sincronizem seus relógios com servidores nacionais de alta precisão, reduzindo a latência e aumentando a confiabilidade da sincronização do horário oficial brasileiro. |
| ⏰ **Chrony** | Implementação moderna do protocolo **NTP**, composta pelo daemon **chronyd** e pela ferramenta administrativa **chronyc**. É o serviço padrão de sincronização de horário do **Ubuntu Server 26.04 LTS**. | Realiza a sincronização inteligente do relógio do sistema, oferecendo maior precisão, inicialização mais rápida, melhor desempenho em máquinas virtuais, notebooks e servidores, além de suportar autenticação **NTS (Network Time Security)**. |
| 🔐 **NTS (Network Time Security)** | Extensão de segurança do protocolo NTP, padronizada pela **RFC 8915**, que utiliza **TLS (TCP/4460)** para autenticar o servidor NTP e negociar chaves criptográficas antes da sincronização do horário. | Protege a sincronização de horário contra ataques de falsificação (*spoofing*), interceptação (*Man-in-the-Middle*) e adulteração das respostas NTP, garantindo autenticidade, integridade e confiabilidade das informações de tempo. |
---

[![NTP Ubuntu Server](http://img.youtube.com/vi//0.jpg)](E "NTP Ubuntu Server")

Link da vídeo aula: 

## 01_ Verificando o Serviço e Versão do Chrony Server e Client no Ubuntu Server
```bash
#verificando o serviço do Chrony Server e Client no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then start one or
#more units), stop (Stop (deactivate) one or more units), start (Start (activate) one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status chrony
sudo systemctl restart chrony
sudo systemctl stop chrony
sudo systemctl start chrony

#analisando os Log's e mensagens de erro do serviço do Chrony Server e Client no Ubuntu Server
#opção do comando journalctl: x (catalog), e (pager-end), u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u chrony
```

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção.

```bash
#verificando a versão do Chrony Server no Ubuntu Server
#opção do comando chronyd: -v (version)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/chronyd
sudo chronyd -v

#verificando a versão do Chrony Client no Ubuntu Server
#opção do comando chronyc: -v (version)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/chronyc
sudo chronyc -v
```

## 02_ Verificando a Porta de Conexão do Chrony Server no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** no Ubuntu Server as Regras de Firewall utilizando o comando: __` iptables `__ ou: __` ufw `__ está desabilitado por padrão **(INACTIVE)**, caso você tenha habilitado algum recurso de Firewall é necessário fazer a liberação do *Fluxo de Entrada (INPUT), Porta (PORT) e Protocolo (PROTOCOL) TCP* do Serviço corresponde nas tabelas do firewall e testar a conexão.

| **🔌 Portas** | **🧭 Protocolos** | **📦 Serviços** | **📖 Descrição** |
| :----------: | :--------------: | :------------- | :--------------- |
| **123** | `UDP` | *NTP* | Porta padrão do protocolo NTP. O **chronyd** envia e recebe pacotes NTP por esta porta para sincronização de horário. |
| **4460** | `TCP` | *NTS-KE* | Porta padrão do **Network Time Security - Key Establishment (NTS-KE)**, utilizada para negociação TLS e troca de chaves criptográficas antes da sincronização NTP. Definida pela **RFC 8915**. |
| **323** | `UDP` | *Chronyc* | Porta utilizada pelo protocolo de monitoramento remoto do **Chrony**. Por padrão, no Ubuntu ela normalmente fica disponível apenas para comunicação local e não deve ser exposta na rede sem necessidade. |
---

```bash
#verificando a porta padrão UDP-323 do Chrony Server Monitor no Ubuntu Server
#opção do comando lsof: -n (network number), -P (port number), -i (list IP Address)
sudo lsof -nP -iUDP:'323'
```

## 03_ Localização dos Arquivos de Configuração do Chrony Server e Client no Ubuntu Server
```bash
/etc/chrony/                                <-- Diretório de configuração do Chrony Server e Client
/etc/chrony/chrony.conf                     <-- Arquivo de configuração do Chrony Server e Client
/etc/chrony/chrony.keys                     <-- Arquivo de configuração das chaves de autenticação do Chrony Server e Client
/etc/chrony/conf.d/                         <-- Diretório dos arquivos de configuração extras do Chrony Server e Client
/etc/chrony/sources.d/                      <-- Diretório dos arquivos de servidores NTP do Chrony Server e Client
/etc/chrony/sources.d/ntp-br-pools.sources  <-- Arquivo de configuração dos servidores NTP.br do Chrony Server e Client
/var/log/chrony/                            <-- Diretório de logs do Chrony Server e Client
/var/lib/chrony/                            <-- Diretório das configurações de sincronismo Chrony Server e Client
```

## 04_ Atualizando os arquivos de configuração do Chrony Server e Client no Ubuntu Server
```bash
#fazendo o backup do arquivo de configuração original do Chrony Server e Client no Ubuntu Server
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/chrony/chrony.conf /etc/chrony/chrony.conf.old

#fazendo o backup do arquivo de servidores NTP original do Chrony Server e Client no Ubuntu Server
#opção do comando mv: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/mv.1.html
sudo mv -v /etc/chrony/sources.d/ubuntu-ntp-pools.sources /etc/chrony/sources.d/ubuntu-ntp-pools.sources.old

#download do arquivo de configuração personalizado do Chrony Server e Client no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/chrony/chrony.conf https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/chrony.conf

#download do arquivo de servidores NTP personalizados do Chrony Server e Client no Ubuntu Server
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/chrony/sources.d/ntp-br-pools.sources https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/ntp-br-pools.sources
```

## 05_ Editando os arquivos de configuração do Chrony Server e Client no Ubuntu Server

> **OBSERVAÇÃO:** O `NTP` (Network Time Protocol) é um protocolo para sincronização dos relógios dos computadores baseado no protocolo __`UDP`__ sob a porta __`123`__. É utilizado para sincronização do relógio de um conjunto de computadores e dispositivos em redes de dados com latência variável.

> **OBSERVAÇÃO IMPORTANTE:** no Brasil sempre utilizar o site: https://ntp.br/ para o sincronismo de Data e Hora de forma correta nos servidores. O `ntp.br` é o serviço oficial de sincronização de horário do Brasil, mantido pelo **Observatório Nacional (ON)** (Site Oficial: https://www.gov.br/observatorio/pt-br/assuntos/areas-de-atuacao/tempo-e-frequencia), em parceria com o **NIC.br** (Núcleo de Informação e Coordenação do Ponto BR) - Site Oficial: https://nic.br/.

```bash
#editando o arquivo de configuração do Chrony Server e Client
sudo vim /etc/chrony/chrony.conf

#habilitando o número de linhas do arquivo chrony.conf
ESC SHIFT :set number <Enter>

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
# Exigindo autenticação NTS (Network Time Security) das fontes selecionadas na linha: 31
authselectmode require
#
# Utilizar no mínimo duas fontes confiáveis na linha: 34
minsources 2
#
# Descartar fontes com distância excessiva na linha: 37
maxdistance 1.0
#
# Não registrar consultas de clientes na linha: 40
noclientlog
#
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>

#editando o arquivo de origens dos NTP do Chrony Server
sudo vim /etc/chrony/sources.d/ntp-br-pools.sources

#habilitando o número de linhas do arquivo ntp-br-pools.sources
ESC SHIFT :set number <Enter>

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
# Bloco inicial das configurações dos Servidores de NTP do NTP.br na linha: 14
#Servidores de NTP | Sincronismo | Fonte de Hora | Habilitar NTS | Porta do NTS | Preferencia
server a.st1.ntp.br iburst maxsources 1 nts ntsport 4460 prefer
server c.st1.ntp.br iburst maxsources 1 nts ntsport 4460 prefer
server e.st1.ntp.br iburst maxsources 1 nts ntsport 4460 prefer
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>

#verificando o serviço do Chrony Server e Client no Ubuntu Server
#opções do comando systemctl: status (runtime status information), restart (Stop and then start one or
#more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl restart chrony
sudo systemctl status chrony

#analisando os Log's e mensagens de erro do serviço do Chrony Server e Client no Ubuntu Server
#opção do comando journalctl: u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u chrony
```

## 06_ Verificando o Sincronismo de Data e Hora com o Protocolo NTP no Ubuntu Server

```bash
#verificando as configuração do serviço do Chrony no Ubuntu Server
#opção do comando chronyc: tracking (displays parameters about the system’s clock performance)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/chronyc.1.html
sudo chronyc tracking
```

Entendendo a saída do comando: __`chronyc tracking`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🆔 **Reference ID** | `4C7F238E (a.st1.ntp.br)` | Identificador e nome do servidor NTP de referência com o qual o serviço **Chrony** está sincronizado. |
| 🏛️ **Stratum** | `2` | Nível hierárquico da fonte de tempo. Um servidor **Stratum 3** obtém seu horário de um servidor **Stratum 2**. Quanto menor o valor, mais próxima é a fonte primária de tempo. |
| 🕒 **Ref time (UTC)** | `Tue Jul 14 20:55:26 2026` | Data e hora (UTC) da última sincronização bem-sucedida com o servidor NTP de referência. |
| ⏱️ **System time** | `0.002079217 seconds slow of NTP time` | Diferença entre o relógio local e o horário fornecido pelo servidor NTP. Neste caso, o relógio do sistema está aproximadamente **2,08 ms atrasado**. |
| 📏 **Last offset** | `+0.000055376 seconds` | Última diferença medida entre o relógio do sistema e o servidor NTP durante a sincronização. |
| 📊 **RMS offset** | `0.041223809 seconds` | Média estatística (Root Mean Square) dos desvios de sincronização. Quanto menor esse valor, maior a precisão do relógio. |
| ⚙️ **Frequency** | `8.820 ppm slow` | Correção aplicada à frequência do relógio do sistema, em **ppm (partes por milhão)**, para compensar atrasos naturais do hardware. |
| 📈 **Residual freq** | `+0.115 ppm` | Pequeno erro residual na frequência do relógio após os ajustes realizados pelo Chrony. |
| 📉 **Skew** | `3.264 ppm` | Estimativa da margem de erro na frequência do relógio. Valores menores indicam maior estabilidade da sincronização. |
| 🌐 **Root delay** | `0.184614673 seconds` | Tempo total estimado de ida e volta (latência) entre o sistema e a fonte primária de tempo. |
| 🎯 **Root dispersion** | `0.004770702 seconds` | Estimativa da precisão acumulada da sincronização em relação à fonte primária de tempo. Quanto menor, melhor a qualidade da sincronização. |
| 🔄 **Update interval** | `64.7 seconds` | Intervalo entre as sincronizações realizadas pelo Chrony com o servidor NTP. |
| ✅ **Leap status** | `Normal` | Indica que não há anúncios de **Leap Second** pendentes e que a sincronização está ocorrendo normalmente. |
---

```bash
#verificando as configuração das origens do NTP do Chrony no Ubuntu Server
#opção do comando chronyc: sources (displays information about the current time sources that chronyd is accessing)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/chronyc.1.html
sudo chronyc sources
```

Entendendo a saída do comando: __`chronyc sources`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🏷️ **Modo (`M`)** | `^` | Indica que a fonte de tempo é um **servidor NTP** (Network Time Protocol). Outros símbolos podem representar relógio local (`#`), relógio de referência (`=`) ou fontes PTP. |
| 📊 **Status (`S`)** | `*`, `+`, `-` | Estado da fonte de sincronização. `*` = servidor atualmente utilizado; `+` = candidato válido para sincronização; `-` = fonte disponível, porém descartada pelo algoritmo de seleção. |
| 🌐 **Servidor NTP** | `a.st1.ntp.br` | Servidor NTP fornecido pela NTP.br, **Servidor atualmente selecionado** pelo Chrony para sincronizar o relógio do sistema.|
| 🌐 **Servidor NTP** | `2800:1e0:1080:a::83` | Servidor NTP alternativo utilizado como referência secundária. |
| 🏛️ **Stratum** | `1` | Todos os servidores pertencem ao **Stratum 2**, recebendo o horário de servidores Stratum 1. |
| ⏱️ **Poll** | `7` | Intervalo de consulta aos servidores. O valor é expresso em potência de dois (**2⁷ = 128 segundos** entre consultas). |
| 📡 **Reach** | `277`, `167`, `377`, `355`, `73` | Registro octal das últimas oito tentativas de comunicação. Valores próximos de **377** indicam excelente conectividade com o servidor. |
| ⏳ **LastRx** | `561`, `1015`, `752`, `819`, `99` | Tempo, em segundos, desde a última resposta recebida do servidor NTP. |
| 📏 **Last sample** | `+27ms`, `+161ms`, `-10ms`, `-8398us`, `-2294us` | Diferença entre o relógio local e cada servidor NTP. Valores próximos de zero indicam melhor sincronização. Também apresenta a incerteza (`+/-`) da medição. |
---

```bash
#verificando as configuração de autenticação NTS (Network Time Security) do Chrony no Ubuntu Server
#opção do comando chronyc: authdata (displays information specific to authentication of NTP sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man1/chronyc.1.html
sudo chronyc authdata
```

Entendendo a saída do comando: __`chronyc authdata`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌐 **Servidor NTP** | `a.st1.ntp.br`<br>`2800:1e0:1080:a::83` | Servidores NTP configurados e autenticados pelo serviço **Chrony** para sincronização segura do relógio do sistema. |
| 🔐 **Mode** | `NTS` | Método de autenticação utilizado. **NTS (Network Time Security)** adiciona autenticação e criptografia ao protocolo NTP, protegendo contra ataques como spoofing e adulteração do horário. |
| 🔑 **KeyID** | `1` | Identificador da chave criptográfica utilizada durante a autenticação NTS. |
| 🔒 **Type** | `30` | Identificador interno do algoritmo criptográfico utilizado pelo Chrony para autenticação NTS. |
| 🔑 **KLen** | `128` | Tamanho da chave criptográfica em **bits**. Neste caso, é utilizada uma chave de **128 bits**. |
| ⏱️ **Last** | `47h` / `35m` | Tempo decorrido desde a última autenticação ou atualização bem-sucedida das credenciais NTS com o servidor. |
| 🔄 **Atmp** | `0` | Número de tentativas de autenticação desde a última autenticação bem-sucedida. Valor **0** indica que não houve novas tentativas necessárias. |
| ❌ **NAK** | `0` | Quantidade de respostas negativas (**Negative Acknowledgement**) recebidas durante a autenticação. Valor **0** indica que nenhuma autenticação foi rejeitada. |
| 🍪 **Cook** | `8` | Quantidade de **cookies NTS** armazenados pelo Chrony para reutilização em futuras conexões seguras com o servidor. |
| 📦 **CLen** | `64` | Tamanho, em bytes, dos cookies NTS utilizados durante a autenticação. |
---

```bash
#testando a conectividade da porta TCP-4460 do NTP.br utilizada pelo NTS (Network Time Security)
#opções do comando nc: -z (Only scan for listening daemons), -v (Produce more verbose output)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/nc
nc -zv a.st1.ntp.br 4460
```

Entendendo a saída do comando: __`nc -zv a.st1.ntp.br 4460`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💻 **Comando** | `nc -zv a.st1.ntp.br 4460` | Utiliza o **Netcat (nc)** para verificar se a porta TCP **4460** do servidor está acessível. A opção `-z` realiza apenas o teste da porta, sem transmitir dados, e `-v` exibe informações detalhadas da conexão. |
| 🌐 **Servidor** | `a.st1.ntp.br` | Servidor **Stratum 1** do projeto **NTP.br**, utilizado como fonte oficial de sincronização de horário e com suporte ao **NTS (Network Time Security)**. |
| 🌍 **Endereço IP** | `2001:12ff:0:7::186` | Endereço **IPv6** resolvido para o servidor `a.st1.ntp.br`. O Netcat utilizou IPv6 para estabelecer a conexão. |
| 🚪 **Porta** | `4460/TCP` | Porta oficial do serviço **NTS-KE (Network Time Security - Key Establishment)**, utilizada para negociar chaves e cookies criptográficos entre o cliente e o servidor NTP. |
| 🔐 **Serviço** | `tcp/ntske` | Nome oficial do serviço associado à porta TCP 4460, responsável pela etapa de autenticação do protocolo **NTS**, conforme a RFC 8915. |
| ✅ **Resultado** | `Connection succeeded!` | A conexão foi estabelecida com sucesso, indicando que o servidor está acessível e aceita conexões para negociação do protocolo **NTS**. |
---

```bash
#testando o certificado de conexão segura da porta TCP-4460 do NTP.br utilizada pelo NTS (Network Time Security)
#opções do comando openssl: s_client (This implements a generic SSL/TLS client which can establish
#a transparent connection to a remote server speaking SSL/TLS ), -connect (This specifies the host
#and optional port to connect to), -servername (Set the TLS SNI (Server Name Indication) extension
#in the ClientHello message to the given value)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/s_client
sudo openssl s_client -connect a.st1.ntp.br:4460 -servername a.st1.ntp.br
```

Entendendo a saída do comando: __`openssl s_client -connect a.st1.ntp.br:4460 -servername a.st1.ntp.br`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 💻 **Comando** | `openssl s_client -connect a.st1.ntp.br:4460 -servername a.st1.ntp.br` | Utiliza o **OpenSSL** para estabelecer uma conexão **TLS** com o servidor NTS e exibir informações sobre o certificado digital apresentado durante a negociação. A opção `-servername` habilita o **SNI (Server Name Indication)**. |
| 🌐 **Servidor** | `a.st1.ntp.br` | Servidor **Stratum 1** do projeto **NTP.br**, com suporte ao **Network Time Security (NTS)**. |
| 🚪 **Porta** | `4460/TCP` | Porta padrão do serviço **NTS-KE (Network Time Security - Key Establishment)**, utilizada para estabelecer uma sessão TLS e negociar chaves criptográficas. |
| 🔐 **Protocolo** | `TLS` | Protocolo criptográfico utilizado para autenticar o servidor e negociar os cookies NTS antes da sincronização NTP. |
| 📜 **Certificado** | `-----END CERTIFICATE-----` | Indica o final da cadeia de certificados X.509 enviada pelo servidor durante a negociação TLS. |
| 👤 **Subject (CN)** | `CN=a.st1.ntp.br` | **Common Name (CN)** do certificado digital. Deve corresponder ao nome DNS do servidor acessado, confirmando sua identidade. |
| 🏛️ **Issuer** | `C=US, O=Let's Encrypt, CN=YR2` | Autoridade Certificadora (CA) que emitiu o certificado digital. Neste caso, o certificado foi emitido pela **Let's Encrypt**, cadeia **YR2**. |
---

## 07_ Configuração de Data e Hora Manual no Sistema Operacional Ubuntu Server (SOMENTE SE NECESSÁRIO)

> **OBSERVAÇÃO IMPORTANTE:** só utilizar as configurações de __`Data e Hora em Modo Manual`__ caso as configurações de *Sincronismo Automático* não funcione de forma adequada, não é recomendado configurar a Data e Hora em modo manual em servidores, isso é um alerta de **Erro de Sistema (BIOS/Hardware ou Rede/Internet)**.

```bash
#verificando o status atual de Data, Hora, Timezone e Sincronismo NTP antes de qualquer alteração manual
#opção do comando timedatectl: status (Show current time settings)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl status

#definindo que o relógio de hardware (RTC) utiliza UTC e não Hora Local (0 = desabilita RTC em Hora Local)
#opção do comando timedatectl: set-local-rtc (Takes a boolean argument)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl set-local-rtc 0

#desabilitando temporariamente a sincronização automática via NTP/Chrony no Ubuntu Server
#opção do comando timedatectl: set-ntp (Controls whether NTP based network time synchronization is active)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl set-ntp false

#configurando o Timezone de São Paulo no Ubuntu Server
#opção do comando timedatectl: set-timezone (Set the system time zone to the specified value)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl set-timezone America/Sao_Paulo

#configurando manualmente a Data e Hora do sistema no Ubuntu Server
#OBSERVAÇÃO IMPORTANTE: ALTERAR O VALOR "YYYY-MM-DD HH:MM:SS" PARA A DATA/HORA CORRETA DO SEU CENÁRIO
#opção do comando timedatectl: set-time (Set the system clock to the specified date and time)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl set-time "YYYY-MM-DD HH:MM:SS"

#reabilitando a sincronização automática via NTP/Chrony após o ajuste manual
#opção do comando timedatectl: set-ntp (Controls whether NTP based network time synchronization is active)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl set-ntp true

#verificando o status final de Data, Hora, Timezone e Sincronismo NTP no Ubuntu Server
#opção do comando timedatectl: status (Show current time settings)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl status

#reiniciando o serviço do Chrony para forçar uma nova sincronização com os servidores NTP.br
#opção do comando systemctl: restart (Stop and then start one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl restart chrony.service

#reiniciando o serviço do Systemd Resolved para limpar o cache de respostas DNS/DNSSEC inválidas
#opção do comando systemctl: restart (Stop and then start one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl restart systemd-resolved

#analisando os Log's e mensagens de erro mais recentes do serviço do Chrony no Ubuntu Server
#opção do comando journalctl: -e (jump to the end of the journal), -u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -eu chrony

#analisando os Log's e mensagens de erro mais recentes do serviço do Systemd Resolved no Ubuntu Server
#opção do comando journalctl: -e (jump to the end of the journal), -u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -eu systemd-resolved

#testando a resolução de nomes e a validação do DNSSEC após o ajuste manual de Data e Hora
#opção do comando resolvectl: query (Resolve domain names, as well as IPv4 and IPv6 addresses)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/resolvectl.1.html
sudo resolvectl query cloudflare.com
```

## 08_ Sincronizando Data e Hora do Sistema Operacional com o Hardware (BIOS) no Ubuntu Server (SOMENTE SE NECESSÁRIO)

> **OBSERVAÇÃO IMPORTANTE:** mesmo cenário da utilização do comando __`timedatectl`__, a da Data e Hora da BIOS do Hardware é mantida pela *CMOS e Bateria* que mantém essa hora armazenada, caso a Data e Hora de BIOS esteja errada, recomendo verificar a Bateria pois já é um sinal de falha de Hardware, no GNU/Linux você pode sincronizar a Data e Hora de Software para o Hardware e vice-versa, também, não é recomendo a sua utilização.

```bash
#verificando as informações de Data e Hora de Hardware no Ubuntu Server
#opções do comando hwclock: --show (show hardware clock)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/hwclock.8.html
sudo hwclock --show

#sincronizando a data hora de software para o hardware de forma manual no Ubuntu Server
#opções do comando hwclock: --systohc (system clock to hardware clock)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/hwclock.8.html
sudo hwclock --systohc

#sincronizando a data hora de hardware para o software de forma manual no Ubuntu Server
#opções do comando hwclock: --hctosys (hardware clock to system clock)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/hwclock.8.html
sudo hwclock --hctosys
```