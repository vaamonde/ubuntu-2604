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
#01_ Verificando as informações do Locale (Localidade) do Sistema Operacional Ubuntu Server<br>
#02_ Configurando o Locale (Localidades) do Brasil no Sistema Operacional Ubuntu Server<br>
#03_ Verificando as informações do Timezone (Fuso Horário) do Sistema Operacional Ubuntu Server<br>
#04_ Configurando o Timezone (Fuso Horário) de São Paulo no Sistema Operacional Ubuntu Server<br>

| **🌍 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| 🌐 **Locale** | Conjunto de configurações que define **idioma, país/região, formato de datas, horas, números, moedas e unidades de medida** utilizados pelo sistema operacional e pelas aplicações. | Personaliza a forma como informações são exibidas pelo sistema, garantindo que datas, horários, números, moedas e mensagens sejam apresentados conforme o idioma e a região configurados. Exemplo: `pt_BR.UTF-8` ou `en_US.UTF-8`. |
| 🔤 **UTF-8 (Unicode Transformation Format - 8 bits)** | Padrão universal de codificação de caracteres baseado no **Unicode**, capaz de representar praticamente todos os idiomas e símbolos existentes. É a codificação padrão dos sistemas Linux modernos. | Permite armazenar, transmitir e exibir textos corretamente em diferentes idiomas, evitando problemas com caracteres especiais, acentuação e compatibilidade entre sistemas. |
| 🕒 **Timezone (Fuso Horário)** | Configuração que define o fuso horário utilizado pelo sistema operacional, considerando a localização geográfica e, quando aplicável, regras de horário de verão. | Garante que o relógio do sistema apresente a hora correta para a região configurada, influenciando logs, tarefas agendadas (Cron), autenticação, bancos de dados e aplicações distribuídas. Exemplo: `America/Sao_Paulo` ou `Etc/UTC`. |
---

[![Data e Hora Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Data e Hora Ubuntu Server")

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

> **OBSERVAÇÃO IMPORTANTE:** O *pt_BR.UTF-8* é uma codificação de caractere que indica o uso da **Língua Portuguesa (pt) como falada no Brasil (BR)** com a codificação __`UTF-8`__. UTF-8 (Unicode Transformation Format - 8 bits) é uma codificação de caracteres que pode representar qualquer caractere no conjunto Unicode, o que inclui praticamente todos os caracteres de todas as línguas do mundo.

```bash
#gerando a localidade do Português do Brasil (pt_BR) no Ubuntu Server
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/locale-gen.8.html
sudo locale-gen pt_BR.UTF-8

#configurando a localidade do Português do Brasil no Ubuntu Server
#opção do comando localectl: set-locale (Set the system locale), LANG (This sets the base locale for your system)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/localectl.1.html
sudo localectl set-locale LANG=pt_BR.UTF-8

#atualizando as localidades do Português do Brasil e Linguagem no Ubuntu Server
#opções das variáveis do comando update-locale: LANG (This sets the base locale for your system),
#LC_ALL (This is the strongest overriding variable), LANGUAGE (his variable controls GNU gettext 
#message translation fallbacks)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/update-locale.8.html
sudo update-locale LANG=pt_BR.UTF-8 LC_ALL=pt_BR.UTF-8 LANGUAGE="pt_BR:pt:en"

#recomendado rebootar o sistema para testar as localidades no Ubuntu Server
#opção do comando systemctl: reboot (Shut down and reboot the system)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl reboot
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

> **OBSERVAÇÃO IMPORTANTE:** no __`Sistema Operacional Ubuntu Server`__ temos basicamente: **03 (três)** configurações de hora (time) sendo elas: 

| **Campo** | **Valor** | **Descrição** |
| :-------- | :---------| :------------ |
| 🕒 **Local time** | **Hora Local do Servidor (Sistema Operacional)** | Hora utilizada pelo sistema operacional conforme o **fuso horário (Timezone)** configurado. É a referência para logs, serviços, tarefas agendadas (*cron*), autenticação e aplicações. |
| 🌍 **Universal time (UTC)** | **Hora Universal Coordenada (UTC)** | Horário de referência mundial, independente de fusos horários e horário de verão. É utilizado para sincronização entre sistemas, registros de eventos, bancos de dados distribuídos e protocolos como **NTP**. |
| 🔋 **RTC time (Real-Time Clock)** | **Relógio de Tempo Real (Hardware/BIOS/UEFI)** | Relógio mantido pelo hardware da placa-mãe, alimentado pela bateria CMOS. É consultado durante a inicialização do computador e serve como referência para que o sistema operacional ajuste a hora do sistema. |
---

```bash
#verificando as informações de fuso horário do sistema no Ubuntu Server
#opção do comando timedatectl: status (Show current settings of the system clock and RTC)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl status
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

> **OBSERVAÇÃO IMPORTANTE:** geralmente mudar para o Time Zone de __`America/Sao_Paulo`__ a hora fica errada no sistema, nesse caso podemos mudar para __`America/Fortaleza`__ ou __`America/Bahia`__ esse error é por causa do **Fuso Horário** em relação ao __`Horário de Verão`__ que não existe mais no Brasil (foi criado em 1931 pelo Governo Getúlio Vargas, só começou a ser aplicado no Brasil em 1985 no Governo José Sarney e foi cancelado em 2018 no Governo Bolsonaro).

> **OBSERVAÇÃO IMPORTANTE:** Em 2025 o horário de verão estava em __`Processo de Avaliação`__ pelo Governo Federal. De acordo com o ministro de Minas e Energia, **Alexandre Silveira**, a volta da medida será analisada com base na *situação hídrica e na segurança energética*. "Nós temos a segurança energética assegurada, há o início de um processo de restabelecimento ainda muito modesto da nossa condição hídrica. Temos condições de chegar depois do verão em condição de avaliar, sim, a volta dessa política em 2025"

> **OBSERVAÇÃO IMPORTANTE:** Em 2026 o horário de verão não está previsto para ocorrer no Brasil. A medida foi suspensa por decreto em 2019 (decreto número: 9.772, de 25 de abril de 2019) e, até o momento, o governo federal decidiu por não retomá-la, nem para o período de 2025/2026.

> **OBSERVAÇÃO:** ALTERAR O LOCALE CONFORME A LOCALIDADE DO SEU SERVIDOR, MAIS INFORMAÇÕES SOBRE TIMEZONE ACESSE: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

```bash
#listando os Timezones disponíveis do comando timedatectl (PARA SAIR PRESSIONE Q (de quit))
#opção do comando timedatectl: list-timezones (List available time zones, one per line)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl list-timezones

#configurando o fuso horário de America São Paulo no Ubuntu Server
#opção do comando timedatectl: set-timezone (set the system time zone to the specified value)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl set-timezone "America/Sao_Paulo"

#verificando as mudanças do Timezone no Sistema do Ubuntu Server
#opção do comando timedatectl: status (Show current settings of the system clock and RTC)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/timedatectl.1.html
sudo timedatectl status
```