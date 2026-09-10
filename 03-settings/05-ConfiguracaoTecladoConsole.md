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

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO KEYBOARD A SEGUINTE FRASE: *Configuração do Keyboard On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #keyboard #keyboardubuntu #keyboarduntuserver #keyboarduntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/08-keyboard.png

---

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

**Conteúdo estudado nessa configuração:**<br>
#01_ Alterando as Configurações do Teclado no Ubuntu Server (SOMENTE SE NECESSÁRIO)<br>
#02_ Alterando as Configurações do Console no Ubuntu Server (SOMENTE SE NECESSÁRIO)<br>

| **🌍 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |
| **⌨️ Keyboard (Teclado)** | Conjunto de configurações que define o **modelo físico, layout, variante e opções do teclado** utilizado pelo sistema operacional. | Permite ao sistema interpretar corretamente as **teclas, caracteres, acentos e símbolos** digitados pelo usuário. |
| **🖥️ Console (Console de Texto)** | Ambiente de **terminal virtual** utilizado para interação direta com o sistema, normalmente por meio de `tty1` a `tty6` em um servidor Ubuntu. | Permite **administrar o sistema sem interface gráfica**, incluindo login, execução de comandos e gerenciamento do servidor. |
| **🔤 UTF-8** | Padrão de codificação de caracteres utilizado pelo sistema. | Permite representar corretamente **acentos, caracteres especiais e diferentes idiomas** no console e nos aplicativos. |
| **🌐 XKB** | Sistema utilizado pelo Linux para definir **modelo, layout e variante do teclado**. | Controla como as teclas físicas são interpretadas e transformadas em **caracteres e comandos**. |
| **⚙️ `console-setup`** | Conjunto de configurações responsável pela **aparência e comportamento do console de texto**. | Define parâmetros como **fonte, tamanho da fonte, conjunto de caracteres e consoles ativos**. |
| **🔠 Fonte do Console** | Configuração que determina o tipo e tamanho dos caracteres exibidos no terminal virtual. | Controla a **legibilidade das informações** apresentadas no console. |
| **🖥️ TTY** | Terminal virtual disponibilizado pelo Linux para acesso ao sistema por texto. | Permite realizar **login e administração do servidor** diretamente pelo console, mesmo sem ambiente gráfico. |
---

[![Keyboard Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Keyboard Ubuntu Server")

Link da vídeo aula: 

## 01_ Alterando as Configurações do Teclado no Ubuntu Server (SOMENTE SE NECESSÁRIO)
```bash
#verificando as configurações do Teclado no Ubuntu Server
#opção do comando cat: -n (number line)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
#mais informações acesse a documentação oficial em: https://manpages.debian.org/testing/keyboard-configuration/keyboard.5.en.html
sudo cat -n /etc/default/keyboard
```

Entendendo a saída do comando: __`cat -n /etc/default/keyboard`__<br>
| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | :------------ |
| **XKBMODEL** | `pc105` | Define o **modelo físico do teclado** como `pc105`, correspondente ao padrão de teclado PC com 105 teclas. |
| **XKBLAYOUT** | `us` | Define o **layout do teclado** como **Estados Unidos (US)**. |
| **XKBVARIANT** | `altgr-intl` | Define a **variante internacional do layout US**, utilizando a tecla **AltGr** para acessar caracteres adicionais, como caracteres acentuados e símbolos. |
| **XKBOPTIONS** | `""` | Define **opções adicionais do XKB**. Está vazio, portanto não há opções extras configuradas. |
| **BACKSPACE** | `guess` | Define o comportamento da tecla **Backspace**. `guess` permite que o sistema determine automaticamente o comportamento adequado. |
---

```bash
#reconfigurando o Teclado no Ubuntu Server
#opção do comando dpkg-reconfigure: keyboard-configuration (packet reconfiguration)
#mais informações acesse a documentação oficial em: https://linuxcommandlibrary.com/man/dpkg-reconfigure
sudo dpkg-reconfigure keyboard-configuration
  Keyboard model: Generic 105-Key PC (intl <-- Internacional) <Enter>;
  Country of origin for the keyboard: Portuguese (Brazil) <Enter>;
  Keyboard layout: Portuguese (Brazil) (Padrão ABNT-2) <Enter>;
  Key to function as AltGr: Right Alt (AltGr) <Enter>;
    (The Default for the Keyboard Layout (O padrão para o layout do teclado));
  No Compose Key (Nenhuma combinação de composição) <Enter>.
```

## 02_ Alterando as Configurações do Console no Ubuntu Server (SOMENTE SE NECESSÁRIO)
```bash
#verificando as configurações do UTF-8 (8-bit Unicode Transformation Format) e Console (Bash/Shell) no Ubuntu Server
#opção do comando cat: -n (number line)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
#mais informações acesse a documentação oficial em: https://manpages.debian.org/testing/console-setup/console-setup.5.en.html
sudo cat -n /etc/default/console-setup
```

| **Campo** | **Valor** | **Descrição** |
| :-------- | :-------- | ------------- |
| **ACTIVE_CONSOLES** | `/dev/tty[1-6]` | Define os **consoles virtuais ativos** que utilizarão essa configuração. Nesse caso, `tty1` até `tty6`. |
| **CHARMAP** | `UTF-8` | Define o **mapa de caracteres** utilizado pelo console. `UTF-8` permite a representação de caracteres internacionais, incluindo acentos e símbolos.|
| **CODESET** | `guess` | Define o **conjunto de caracteres (code set)** utilizado pelo console. `guess` permite que o sistema tente identificar automaticamente o conjunto adequado. |
| **FONTFACE** | `Fixed` | Define a **família da fonte** utilizada no console. `Fixed` corresponde à fonte monoespaçada padrão para o console. |
| **FONTSIZE** | `8x16` | Define o **tamanho da fonte** utilizada no console, com caracteres de 8×16 pixels. |
| **VIDEOMODE** | *(vazio)* | Define o **modo de vídeo** do console. Como o valor está vazio, nenhum modo de vídeo específico está configurado nesse arquivo. |
| **FONT** | *(comentado)* | Exemplo de configuração para utilizar uma **fonte com suporte a Braille**. A linha está comentada e, portanto, não está ativa. |
---

```bash
#reconfigurando o UTF-8 e Console no Ubuntu Server
#opção do comando dpkg-reconfigure: console-setup (packet reconfiguration)
#mais informações acesse a documentação oficial em: https://linuxcommandlibrary.com/man/dpkg-reconfigure
sudo dpkg-reconfigure console-setup
  UTF-8 <Enter>;
  Guess optimal character set (Supor o melhor conjunto de caracteres) <Enter>;
  Fixed <Enter>;
  8x16 <Enter>.
```
```bash
#reiniciando o servidor para aplicar as mudanças do Teclado e Console no Ubuntu Server
#opção do comando systemctl: reboot (Shut down and reboot the system)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl reboot
```

---

> **OBSERVAÇÃO IMPORTANTE:** COMENTAR NO VÍDEO DE CONFIGURAÇÃO DO KEYBOARD A SEGUINTE FRASE: *Configuração do Keyboard On-Premises realizado com sucesso!!! Então #BoraParaPrática que #VavaAprova*
>
> COMPARTILHAR O SELO DO DESAFIO NAS SUAS REDES SOCIAIS DO LINKEDIN: `@Robson Vaamonde` E NO INSTAGRAM: `@procedimentoem` MARCANDO COM AS HASHTAGS ABAIXO E COPIANDO O CONTEÚDO ESTUDADO DESSA INSTALAÇÃO: 
>
> #boraparapratica #boraparaprática #vaamonde #robsonvaamonde #vavaaprova #ubuntu #ubuntuserver #ubuntuserver2604 #keyboard #keyboardubuntu #keyboarduntuserver #keyboarduntuserver2604
>
> LINK DO SELO: https://github.com/vaamonde/ubuntu-2604/blob/main/selos/08-keyboard.png

---