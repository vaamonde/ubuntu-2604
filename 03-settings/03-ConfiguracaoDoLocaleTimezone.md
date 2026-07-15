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
Data de atualização: 13/07/2026<br>
Versão: 0.03<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

Conteúdo estudado nessa configuração:<br>

| **🌍 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🌐 **Locale**  | Conjunto de configurações que define **idioma, país/região, formato de datas, horas, números, moedas e unidades de medida** utilizados pelo sistema operacional e pelas aplicações. | Personaliza a forma como informações são exibidas ao usuário, garantindo que datas, horários, moedas e mensagens sejam apresentados de acordo com a localização e o idioma configurados. Exemplo: `pt_BR.UTF-8` ou `en_US.UTF-8`. |
| 🔤 **UTF-8 (Unicode Transformation Format - 8 bits)** | Padrão de codificação de caracteres baseado no **Unicode**, capaz de representar praticamente todos os idiomas e símbolos existentes. É a codificação padrão na maioria dos sistemas Linux modernos. | Permite armazenar, transmitir e exibir textos corretamente em diferentes idiomas, evitando problemas de caracteres inválidos ou acentuação incorreta (como "ç", "ã", "é", "ü"). |
| 🕒 **Timezone (Fuso Horário)** | Configuração que determina o fuso horário utilizado pelo sistema operacional, considerando a localização geográfica e, quando aplicável, regras de horário de verão. | Garante que o relógio do sistema apresente a hora local correta, influenciando registros de logs, tarefas agendadas (cron), autenticação, bancos de dados e aplicações distribuídas. Exemplo: `America/Sao_Paulo`. |
| ⏱️ **NTP (Network Time Protocol)** | Protocolo de sincronização de tempo que utiliza **UDP porta 123** para manter o relógio dos computadores sincronizado com servidores de referência de tempo. | Mantém a data e a hora corretas em servidores e dispositivos de rede, sendo essencial para autenticação (Kerberos), certificados digitais, registros de logs, auditorias, clusters e ambientes distribuídos. |
| 🇧🇷 **NTP.br** | Projeto mantido pelo **NIC.br** em parceria com o **Observatório Nacional (ON)**, responsável por disponibilizar servidores públicos de sincronização da Hora Legal Brasileira. | Permite que equipamentos localizados no Brasil sincronizem seus relógios com servidores nacionais de alta precisão, reduzindo a latência e garantindo maior confiabilidade na sincronização do horário oficial brasileiro. |

[![Data e Hora Ubuntu Server](http://img.youtube.com/vi//0.jpg)](E "Data e Hora Ubuntu Server")

Link da vídeo aula: 

## 01_ Verificando as informações do Locale (Localidade) do Sistema Operacional Ubuntu Server
```bash
#verificando as informações detalhas de localidade no Ubuntu Server
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/localectl.1.html
sudo localectl
```

Entendendo a saída do comando: __`localectl`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌐 **System Locale** | `LANG=en_US.UTF-8` | Define o idioma, a região e a codificação de caracteres padrão do sistema. Neste caso, utiliza o idioma **Inglês (Estados Unidos)** com codificação **UTF-8**. |
| ⌨️ **VC Keymap** | `(unset)` | Mapeamento do teclado para o console virtual (TTY). Como está **unset**, o sistema utiliza o mapeamento padrão ou herda a configuração definida durante a inicialização.  |
| 🖥️ **X11 Layout** | `us` | Layout do teclado utilizado no ambiente gráfico **X11**, configurado para o padrão **US (Estados Unidos)**. |
| ⌨️ **X11 Model** | `pc105` | Modelo físico do teclado utilizado pelo X11. O modelo **PC105** corresponde ao teclado padrão de **105 teclas**, comum em computadores modernos. |
| 🌍 **X11 Variant** | `altgr-intl` | Variante do layout **US International**, permitindo digitação de caracteres acentuados e símbolos internacionais utilizando a tecla **AltGr** (ou combinações de teclas). |
---

```bash
#verificando as informações de localidades instaladas no Ubuntu Server 
#opção do comando locale: -a (all-locales)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/locale.1.html
sudo locale -a
```

Entendendo a saída do comando: __`locale`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🌐 **Locale** | `C` | Localidade padrão da linguagem C (ANSI/POSIX). Utiliza ordenação, formatação e mensagens básicas, independentemente da região ou idioma. É frequentemente utilizada para garantir comportamento consistente em scripts e aplicações. |
| 🔤 **Locale** | `C.utf8` | Variante da localidade `C` com suporte à codificação **UTF-8**, permitindo o uso de caracteres Unicode sem alterar as regras básicas da localidade padrão. |
| 🇺🇸 **Locale** | `en_US.utf8` | Localidade para **Inglês (Estados Unidos)** utilizando codificação **UTF-8**. Define idioma, ordenação, formatos de data, hora, números e moedas conforme os padrões dos Estados Unidos. |
| ⚙️ **Locale** | `POSIX` | Localidade compatível com o padrão **POSIX**, funcionalmente equivalente à localidade `C`. É utilizada para garantir portabilidade e comportamento previsível entre diferentes sistemas Unix/Linux. |
---

## 02_ Configurando o Locale (Localidades) do Brasil no Sistema Operacional Ubuntu Server

**OBSERVAÇÃO IMPORTANTE:** O *pt_BR.UTF-8* é uma codificação de caractere que indica o uso da **Língua Portuguesa (pt) como falada no Brasil (BR)** com a codificação __`UTF-8`__. UTF-8 (Unicode Transformation Format - 8 bits) é uma codificação de caracteres que pode representar qualquer caractere no conjunto Unicode, o que inclui praticamente todos os caracteres de todas as línguas do mundo.

```bash
#gerando a localidade do Português do Brasil (pt_BR) no Ubuntu Server
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/locale-gen.8.html
sudo locale-gen pt_BR.UTF-8

#configurando a localidade do Português do Brasil no Ubuntu Server
#opção do comando localectl: set-locale (Set the system locale)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/localectl.1.html
sudo localectl set-locale LANG=pt_BR.UTF-8

#atualizando as localidades do Português do Brasil e Linguagem no Ubuntu Server
#opções das variáveis do comando update-locale: LANG (This sets the base locale for your system),
#LC_ALL (This is the strongest overriding variable), LANGUAGE (his variable controls GNU gettext 
#message translation fallbacks)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/update-locale.8.html
sudo update-locale LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8 LANGUAGE="pt_BR:pt:en"

#recomendado rebootar o sistema para testar as localidades
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/reboot
sudo reboot
```
```bash
#verificando as mudanças de localidades do sistema no Ubuntu Server depois do reboot
#opção do comando locale: -a (all-locales)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/locale-gen.8.html
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/localectl.1.html
sudo locale -a
sudo localectl
```

## 03_ Verificando as informações do Timezone (Fuso Horário) do Sistema Operacional Ubuntu Server

**OBSERVAÇÃO IMPORTANTE:** no __`Sistema Operacional Ubuntu Server`__ temos basicamente: **03 (três)** configurações de hora (time) sendo elas: 

| **Campo** | **Valor** | **Descrição** |
| :-------- | :---------| :------------ |
| 🕒 **Local time** | **Hora Local do Servidor (Sistema Operacional)** | Hora utilizada pelo sistema operacional conforme o **fuso horário (Timezone)** configurado. É a referência para logs, serviços, tarefas agendadas (*cron*), autenticação e aplicações. |
| 🌍 **Universal time (UTC)** | **Hora Universal Coordenada (UTC)** | Horário de referência mundial, independente de fusos horários e horário de verão. É utilizado para sincronização entre sistemas, registros de eventos, bancos de dados distribuídos e protocolos como **NTP**. |
| 🔋 **RTC time (Real-Time Clock)** | **Relógio de Tempo Real (Hardware/BIOS/UEFI)** | Relógio mantido pelo hardware da placa-mãe, alimentado pela bateria CMOS. É consultado durante a inicialização do computador e serve como referência para que o sistema operacional ajuste a hora do sistema. |
---

```bash
#verificando as informações de fuso horário do sistema no Ubuntu Server
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl
```

Entendendo a saída do comando: __`timedatectl`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| 🕒 **Local time** | `ter 2026-07-14 20:43:01 UTC` | Hora local utilizada pelo sistema operacional. Como o fuso horário configurado é **UTC**, ela é idêntica à Hora Universal. |
| 🌍 **Universal time** | `ter 2026-07-14 20:43:01 UTC` | Hora Universal Coordenada (**UTC**), utilizada como referência mundial para sincronização de tempo entre sistemas. |
| 🔋 **RTC time** | `ter 2026-07-14 20:43:01` | Hora armazenada no **Real-Time Clock (RTC)** da placa-mãe (BIOS/UEFI), utilizada durante a inicialização do sistema. |
| 🌐 **Time zone** | `Etc/UTC (UTC, +0000)` | Fuso horário configurado no sistema operacional. Neste caso, utiliza **UTC (Coordinated Universal Time)** com deslocamento **+00:00**. |
| ✅ **System clock synchronized** | `yes` | Indica que o relógio do sistema está sincronizado corretamente com um servidor de tempo (**NTP**). |
| ⏱️ **NTP service** | `active` | O serviço de sincronização de horário (**NTP**) está ativo e mantendo o relógio do sistema sincronizado automaticamente. |
| 🔄 **RTC in local TZ** | `no` | O relógio de hardware (**RTC**) está configurado para utilizar **UTC**, e não a hora local. Esta é a configuração recomendada para sistemas Linux. |
---

## 04_ Configurando o Timezone (Fuso Horário) de São Paulo no Sistema Operacional Ubuntu Server

**OBSERVAÇÃO IMPORTANTE:** geralmente mudar para o Time Zone de __`America/Sao_Paulo`__ a hora fica errada no sistema, nesse caso podemos mudar para __`America/Fortaleza`__ ou __`America/Bahia`__ esse error é por causa do **Fuso Horário** em relação ao __`Horário de Verão`__ que não existe mais no Brasil (foi criado em 1931 pelo Governo Getúlio Vargas, só começou a ser aplicado no Brasil em 1985 no Governo José Sarney e foi cancelado em 2018 no Governo Bolsonaro).

**OBSERVAÇÃO IMPORTANTE:** Até o momento (25/06/2025), o horário de verão 2025 está em __`Processo de Avaliação`__ pelo Governo Federal. De acordo com o ministro de Minas e Energia, **Alexandre Silveira**, a volta da medida será analisada com base na *situação hídrica e na segurança energética*. "Nós temos a segurança energética assegurada, há o início de um processo de restabelecimento ainda muito modesto da nossa condição hídrica. Temos condições de chegar depois do verão em condição de avaliar, sim, a volta dessa política em 2025"

**OBSERVAÇÃO IMPORTANTE:** Até a data de 14/07/2026, o horário de verão não está previsto para ocorrer no Brasil em 2026. A medida foi suspensa por decreto em 2019 (decreto número: 9.772, de 25 de abril de 2019) e, até o momento, o governo federal decidiu por não retomá-la, nem para o período de 2025/2026.

**OBSERVAÇÃO:** ALTERAR O LOCALE CONFORME A LOCALIDADE DO SEU SERVIDOR, MAIS INFORMAÇÕES SOBRE TIMEZONE ACESSE: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

```bash
#listando os Timezones disponíveis do comando timedatectl (PARA SAIR PRESSIONE Q (quit))
#opção do comando timedatectl: list-timezones (List available time zones, one per line)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl list-timezones

#configurando o fuso horário de America São Paulo no Ubuntu Server
#opção do comando timedatectl: set-timezone (set the system time zone to the specified value)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl set-timezone "America/Sao_Paulo"

#verificando as mudanças do Timezone no Sistema do Ubuntu Server
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.htm
sudo timedatectl
```

## 05_ Verificando o Serviço e Versão do Chrony Server e Client no Ubuntu Server
```bash
#verificando o serviço do Chrony Server e Client
#opções do comando systemctl: status (runtime status information), restart (Stop and then start one or
#more units), stop (Stop (deactivate) one or more units), start (Start (activate) one or more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl status chrony
sudo systemctl restart chrony
sudo systemctl stop chrony
sudo systemctl start chrony

#analisando os Log's e mensagens de erro do serviço do Chrony Server e Client
#opção do comando journalctl: x (catalog), e (pager-end), u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u chrony
```

> **OBSERVAÇÃO IMPORTANTE:** Por que sempre é necessário verificar a versão do serviço de rede que você está implementando ou configurando no Servidor Ubuntu Server, devido as famosas falhas de segurança chamadas de: *CVE (Common Vulnerabilities and Exposures)*, com base na versão utilizada podemos pesquisar no site do **Ubuntu Security CVE Reports:** https://ubuntu.com/security/cves as falhas de segurança encontradas e corrigidas da versão do nosso aplicativo, o que ela afeta, se foi corrigida e como aplicar a correção.

```bash
#verificando as versões do Chrony Server
#opção do comando sshd e sshd: -v (version)
sudo chronyd -v

#verificando as versões do Chrony Client
#opção do comando ssh: -v (version)
sudo chronyc -v
```

## 06_ Verificando a Porta de Conexão do Chrony Server no Ubuntu Server

> **OBSERVAÇÃO IMPORTANTE:** no Ubuntu Server as Regras de Firewall utilizando o comando: __` iptables `__ ou: __` ufw `__ está desabilitado por padrão **(INACTIVE)**, caso você tenha habilitado algum recurso de Firewall é necessário fazer a liberação do *Fluxo de Entrada (INPUT), Porta (PORT) e Protocolo (PROTOCOL) TCP* do Serviço corresponde nas tabelas do firewall e testar a conexão.

```bash
#verificando a porta padrão UDP-323 do Chrony Server
#opção do comando lsof: -n (network number), -P (port number), -i (list IP Address)
sudo lsof -nP -iUDP:'323'
```

## 07_ Localização dos Arquivos de Configuração do Chrony Server e Client no Ubuntu Server
```bash
/etc/chrony/                                <-- Diretório de configuração do Chrony Server e Client
/etc/chrony/chrony.conf                     <-- Arquivo de configuração do Chrony Server e Client
/etc/chrony/chrony.keys                     <-- Arquivo de configuração das chaves de autenticação do Chrony Server e Client
/etc/chrony/conf.d/                         <-- Diretório dos arquivos de configuração extras do Chrony Server e Client
/etc/chrony/sources.d/                      <-- Diretório dos arquivos de servidores NTP do Chrony Server e Client
/etc/chrony/sources.d/ntp-br-pools.sources  <-- Arquivo de configuração dos servidot NTP.br do Chrony Server e Client
/var/log/chrony/                            <-- Diretório de logs do Chrony Server e Client
/var/lib/chrony/                            <-- Diretório das configurações de sincronismo Chrony Server e Client
```

## 08_ Atualizando os arquivos de configuração do Chrony Server e Client no Ubuntu Server
```bash
#fazendo o backup do arquivo de configuração original do Chrony Server e Client 
#opção do comando cp: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/cp.1.html
sudo cp -v /etc/chrony/chrony.conf /etc/chrony/chrony.conf.old

#fazendo o backup do arquivo de servidores NTP original do Chrony Server e Client 
#opção do comando mv: -v (verbose)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/mv.1.html
sudo mv -v /etc/chrony/sources.d/ubuntu-ntp-pools.sources /etc/chrony/sources.d/ubuntu-ntp-pools.sources.old

#download do arquivo de configuração do Chrony Server e Client 
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/chrony/chrony.conf https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/chrony.conf

#download do arquivo de servidores NTP do Chrony Server e Client 
#opção do comando wget: -v (verbose), -O (output file)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/1/wget
sudo wget -v -O /etc/chrony/sources.d/ntp-br-pools.sources https://raw.githubusercontent.com/vaamonde/ubuntu-2604/main/conf/ntp-br-pools.sources
```

## 09_ Editando os arquivos de configuração do Chrony Server e Client no Ubuntu Server

**OBSERVAÇÃO:** O NTP (Network Time Protocol) é um protocolo para sincronização dos relógios dos computadores baseado no protocolo __`UDP`__ sob a porta __`123`__. É utilizado para sincronização do relógio de um conjunto de computadores e dispositivos em redes de dados com latência variável.

**OBSERVAÇÃO IMPORTANTE:** no Brasil sempre utilizar o site: https://ntp.br/ para o sincronismo de Data e Hora de forma correta nos servidores. O ntp.br é o serviço oficial de sincronização de horário do Brasil, mantido pelo Observatório Nacional (ON), em parceria com o NIC.br (Núcleo de Informação e Coordenação do Ponto BR).

```bash
#editando o arquivo de configuração do Chrony Server e Client
sudo vim /etc/chrony/chrony.conf

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
# Exige autenticação NTS das fontes selecionadas na linha: 31
authselectmode require
#
# Utiliza no mínimo duas fontes confiáveis na linha: 34
minsources 2
#
# Descarta fontes com distância excessiva  na linha: 37
maxdistance 1.0
#
# Não registra consultas de clientes na linha: 40
noclientlog
#
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>

#editando o arquivo de origens do Chrony
sudo vim /etc/chrony/sources.d/ntp-br-pools.sources

#entrando no modo de edição do editor de texto VIM
INSERT
```
```bash
# Bloco inicial das configurações dos Servidores de NTP do NTP.br na linha: 14
server a.st1.ntp.br iburst maxsources 1 nts ntsport 4460 prefer
server c.st1.ntp.br iburst maxsources 1 nts ntsport 4460 prefer
server e.st1.ntp.br iburst maxsources 1 nts ntsport 4460 prefer
```
```bash
#salvar e sair do arquivo
ESC SHIFT : x <Enter>

#verificando o serviço do Chrony Server e Client
#opções do comando systemctl: status (runtime status information), restart (Stop and then start one or
#more units)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl restart chrony
sudo systemctl status chrony

#analisando os Log's e mensagens de erro do serviço do Chrony Server e Client
#opção do comando journalctl: x (catalog), e (pager-end), u (unit)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/journalctl.1.html
sudo journalctl -u chrony
```

## 10_ Verificando o Sincronismo de Data e Hora com o Protocolo NTP no Ubuntu Server

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
#verificando as configuração de autenticação NTS do Chrony no Ubuntu Server
#opção do comando chronyc: authdata ()
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
#testando a conectividade da porta TCP-4460 do NTP.br utilizada pelo NTS
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
#testando o certificado de conexão segura da porta TCP-4460 do NTP.br utilizada pelo NTS
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

## 11_ Configuração de Data e Hora Manual no Sistema Operacional Ubuntu Server (SOMENTE SE NECESSÁRIO)

**OBSERVAÇÃO IMPORTANTE:** só utilizar as configurações de Data e Hora em modo manual caso as configurações de sincronismo automático não funcione de forma adequada, não recomendo a configuração de Data e Hora em modo manual, isso é um alerta de erro de sistema (BIOS/Hardware ou Rede/Internet).

```bash
#configuração da data e hora no modo manual no Ubuntu Server
#opções do comando date: -s (set), %d (day of month), %m (month), %Y (year), %H (hour), 
#%M (minute), %S (second)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/date.1.html
sudo date
sudo date +%d/%m/%Y
sudo date -s 20/01/2023
sudo date +%H:%M:%S
sudo date -s 13:30:00
```

## 12_ Sincronizando Data e Hora do Sistema Operacional com o Hardware (BIOS) no Ubuntu Server (SOMENTE SE NECESSÁRIO)

**OBSERVAÇÃO IMPORTANTE:** mesmo cenário da utilização do comando __`date`__, a da Data e Hora da BIOS do Hardware é mantida pela *CMOS e Bateria* que mantém essa hora armazenada, caso a Data e Hora de BIOS esteja errada, recomendo verificar a Bateria pois já é um sinal de falha de Hardware, no GNU/Linux você pode sincronizar a Data e Hora de Software para o Hardware e vice-versa, também, não é recomendo a sua utilização.

```bash
#sincronizando a data hora de software e hardware manual no Ubuntu Server
#opções do comando hwclock: --systohc (system clock to hardware clock), --hctosys (hardware 
#clock to system clock)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/hwclock.8.html
sudo hwclock --show
sudo hwclock --systohc
sudo hwclock --hctosys
```

## 13_ Alterando as Configurações do Teclado e Console no Ubuntu Server (SOMENTE SE NECESSÁRIO)

```bash
#verificando as configurações do Teclado no Ubuntu Server
#opção do comando cat: -n (number line)
sudo cat -n /etc/default/keyboard
  XKBMODEL="pc105"  (Padrão 105 teclas pc105)
  XKBLAYOUT="br"    (Layout de Teclado Português Brasileiro ABNT2)
```
```bash
#reconfigurando o Teclado no Ubuntu Server
sudo dpkg-reconfigure keyboard-configuration
  Keyboard model: Generic 105-Key PC (intl <- Internacional) <Enter>;
  Country of origin for the keyboard: Portuguese (Brazil) <Enter>;
  Keyboard layout: Portuguese (Brazil) (Padrão ABNT-2) <Enter>;
  Key to function as AltGr: Right Alt (AltGr) <Enter>;
    (The Default for the Keyboard Layout (O padrão para o layout do teclado));
  No Compose Key (Nenhuma combinação de composição) <Enter>.
```
```bash
#verificando as configurações do UTF-8 (8-bit Unicode Transformation Format) e Console (Bash/Shell)
#opção do comando cat: -n (number line)
sudo cat -n /etc/default/console-setup
  CHARMAP="UTF-8"
```
```bash
#reconfigurando o UTF-8 e Console no Ubuntu Server
sudo dpkg-reconfigure console-setup
  UTF-8 <Enter>;
  Guess optimal character set (Supor o melhor conjunto de caracteres) <Enter>;
  Fixed <Enter>;
  8x16 <Enter>.
```
```bash
#reiniciando o servidor para aplicar as mudanças do Teclado e Console
sudo reboot
```