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
#01_ Alterando as Configurações do Teclado no Ubuntu Server (SOMENTE SE NECESSÁRIO)<br>
#02_ Alterando as Configurações do Console no Ubuntu Server (SOMENTE SE NECESSÁRIO)<br>

| **🌍 Tecnologia** | **📖 O que é?** | **🎯 Para que serve?** |
| :---------------- | :-------------- | :--------------------- |


[![Keyboard Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( "Keyboard Ubuntu Server")

Link da vídeo aula: 

## 01_ Alterando as Configurações do Teclado no Ubuntu Server (SOMENTE SE NECESSÁRIO)
```bash
#verificando as configurações do Teclado no Ubuntu Server
#opção do comando cat: -n (number line)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
#mais informações acesse a documentação oficial em: https://manpages.debian.org/testing/keyboard-configuration/keyboard.5.en.html
sudo cat -n /etc/default/keyboard
  XKBMODEL="pc105"  (Padrão 105 teclas pc105)
  XKBLAYOUT="br"    (Layout de Teclado Português Brasileiro ABNT2)
```
```bash
#reconfigurando o Teclado no Ubuntu Server
#opção do comando dpkg-reconfigure: keyboard-configuration (packet reconfiguration)
#mais informações acesse a documentação oficial em: https://linuxcommandlibrary.com/man/dpkg-reconfigure
sudo dpkg-reconfigure keyboard-configuration
  Keyboard model: Generic 105-Key PC (intl <- Internacional) <Enter>;
  Country of origin for the keyboard: Portuguese (Brazil) <Enter>;
  Keyboard layout: Portuguese (Brazil) (Padrão ABNT-2) <Enter>;
  Key to function as AltGr: Right Alt (AltGr) <Enter>;
    (The Default for the Keyboard Layout (O padrão para o layout do teclado));
  No Compose Key (Nenhuma combinação de composição) <Enter>.
```

## 02_ Alterando as Configurações do Console no Ubuntu Server (SOMENTE SE NECESSÁRIO)
```bash
#verificando as configurações do UTF-8 (8-bit Unicode Transformation Format) e Console (Bash/Shell)
#opção do comando cat: -n (number line)
#mais informações acesse a documentação oficial em: https://www.man7.org/linux/man-pages/man1/cat.1.html
#mais informações acesse a documentação oficial em: https://manpages.debian.org/testing/console-setup/console-setup.5.en.html
sudo cat -n /etc/default/console-setup
  CHARMAP="UTF-8"
```
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
#reiniciando o servidor para aplicar as mudanças do Teclado e Console
#opção do comando systemctl: reboot (Shut down and reboot the system)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man1/systemctl.1.html
sudo systemctl reboot
```