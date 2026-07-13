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

Conteúdo estudado nessa atualização:<br>
#01_ Verificando as políticas dos repositórios locais no Ubuntu Server<br>
#02_ Removendo os repositórios Multiverse (Multiverso) e Universe (Universo) no Ubuntu Server<br>
#03_ Atualizando as Listas (sources.list) do Apt no Ubuntu Server<br>
#04_ Verificando todos os pacotes a serem atualizados no Ubuntu Server<br>
#05_ Atualizando todos os software (Pacotes) no Ubuntu Server<br>
#06_ Forçando uma atualização completa de todos os software e dependências no Ubuntu Server<br>
#07_ Forçando uma atualização e remoção de software desnecessários no Ubuntu Server<br>
#08_ Removendo todos os pacotes desnecessários no Ubuntu Server<br>
#09_ Fazendo a limpeza dos repositórios locais e pacotes desnecessários no Ubuntu Server<br>
#10_ Limpando o cache local do (sources.list) no Ubuntu Server<br>
#11_ Verificando todas as versões de software atualizados no Ubuntu Server<br>
#12_ Verificando os Logs de atualização de software no Ubuntu Server<br>
#13_ Reiniciando o sistema operacional do Ubuntu Server para aplicar as mudanças<br>

[![Atualização Ubuntu Server](http://img.youtube.com/vi//0.jpg)]("Atualização Ubuntu Server")

Link da vídeo aula: 

## 01_ Verificando as políticas dos repositórios locais no Ubuntu Server
```bash
#Policy é utilizado para mostra as propriedades e prioridades dos repositórios configurados.
#opção do comando apt: policy (This is meant to help debug issues relating to the preferences file.)
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/apt-cache
sudo apt policy
```

| Ícone | Repositório | Descrição | Suporte | Recomendação para Hardening |
| :---: | ----------- | --------- | ------- | :-------------------------: |
| ✅ | **Main** | Pacotes oficiais do Ubuntu mantidos pela Canonical. Contém o kernel, systemd, OpenSSH, OpenSSL, APT, Bash, Coreutils, Netplan, AppArmor, UFW e demais componentes essenciais do sistema operacional. | Canonical | **Sempre habilitado** ⭐⭐⭐⭐⭐ |
| ✅ | **Restricted** | Drivers, firmware e microcódigos proprietários necessários para determinados hardwares (Intel/AMD Microcode, controladoras RAID, NICs, GPUs, etc.). | Canonical  | **Recomendado** ⭐⭐⭐⭐⭐ |
| ⚠️ | **Universe** | Grande coleção de softwares livres mantidos pela comunidade. Inclui muitas ferramentas administrativas (Ansible, Fail2Ban, BorgBackup, Restic, tmux, jq, tree, etc.). Com Ubuntu Pro, muitos pacotes recebem cobertura adicional de segurança. | Comunidade / Ubuntu Pro | **Habilitar somente quando necessário** ⭐⭐⭐⭐☆ |
| ❌ | **Multiverse** | Softwares com restrições de licença, codecs, componentes proprietários e pacotes sem suporte oficial. Pouco utilizado em servidores. | Sem suporte oficial | **Não recomendado** ⭐☆☆☆☆ |
| ❌ | **Backports** | Disponibiliza versões mais recentes de alguns pacotes para a versão LTS. Pode introduzir mudanças de comportamento e reduzir a previsibilidade do ambiente. | Comunidade | **Não recomendado em produção** ⭐☆☆☆☆ |
| ❌ | **Proposed** | Repositório de testes contendo pacotes candidatos antes da publicação oficial. Destinado a validação e desenvolvimento. | Canonical (teste) | **Nunca habilitar em produção** 🚫 |
| ⚠️ | **Partner** | Repositório histórico da Canonical para softwares comerciais de terceiros. Atualmente possui uso bastante limitado. | Canonical | **Habilitar somente se houver necessidade específica** ⭐⭐☆☆☆ |
| ⚠️ | **deb-src** | Repositório que fornece apenas o código-fonte dos pacotes (`.dsc` e fontes). Utilizado para compilação, análise e auditoria. | Mesmo suporte do pacote binário | **Desabilitado em servidores** ⭐☆☆☆☆ |
| ❌ | **PPA (Launchpad)** | Repositórios pessoais hospedados no Launchpad. Permitem instalar versões customizadas ou mais recentes de softwares. Não fazem parte do ciclo oficial de testes do Ubuntu. | Responsabilidade do mantenedor | **Nunca utilizar em produção** 🚫 |
| ⚠️ | **Repositórios de Terceiros** | Repositórios oficiais de fabricantes (Docker, Microsoft, Grafana, Elastic, Kubernetes, HashiCorp, NVIDIA etc.). | Fabricante | **Somente quando exigido pela solução implantada** ⭐⭐⭐☆☆ |

## 02_ Removendo os repositórios Multiverse (Multiverso) e Universe (Universo) no Ubuntu Server
```bash
#Add-Apt-Repository é utilizado para adicionar, gerenciar ou remover repositórios.
#opção do comando add-apt-repository: --remove (Remove the specified repository)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/jammy/man1/add-apt-repository.1.html
#Removendo o repositório Multiverso
sudo add-apt-repository --remove multiverse
  Removing component(s) 'multiverse' from all repositories.
  Press [ENTER] to continue or Ctrl-c to cancel.
#Removendo o repositório Universo
sudo add-apt-repository --remove universe
  Removing component(s) 'multiverse' from all repositories.
  Press [ENTER] to continue or Ctrl-c to cancel.
```

## 03_ Atualizando as Listas (sources.list) do Apt no Ubuntu Server
```bash
#Update é utilizado para baixar as informações de pacotes de todas as fontes configuradas.
#opção do comando apt: update (Resynchronize the package index files from their sources)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt update
```

## 04_ Verificando todos os pacotes a serem atualizados no Ubuntu Server
```bash
#List é utilizado para listar todos os software que serão atualizados no sistema.
#opção do comando apt: list (list is used to display a list of packages), --upgradable (shows
#a list of packages that can be upgraded using the apt package manager)
#opção do redirecionador | (pipe): Conecta a saída padrão com a entrada padrão de outro comando
#opção do comando cat: -n (number line)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt list --upgradable | cat -n
```

## 05_ Atualizando todos os software (Pacotes) no Ubuntu Server
```bash
#Upgrade é utilizado para instalar atualizações disponíveis de todos os pacotes atualmente 
#instalados no sistema a partir das fontes configuradas via sources.list
#opção do comando apt: upgrade (Install the newest versions of all packages currently installed
#on the system from the sources enumerated in /etc/apt/sources.list.)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt upgrade
  Continue? [Y/n] y <Enter>

#OBSERVAÇÃO: algumas vezes pode aparecer uma tela na cor: Rosa/Branca informando que alguns
#serviços de rede serão reinicializados, isso é comum na distribuição Ubuntu Server.
Daemons using outdated libraries
  Which services should be restarted?
<OK>
```

## 06_ Forçando uma atualização completa de todos os software e dependências no Ubuntu Server
```bash
#Dist-Upgrade além de executar a função de atualização, também lida de forma inteligente 
#com as novas dependências das novas versões de pacotes
#opção do comando apt: dist-upgrade (dist-upgrade in addition to performing the function of upgrade, 
#also intelligently handles changing dependencies with new versions of packages)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt dist-upgrade
```

## 07_ Forçando uma atualização e remoção de software desnecessários no Ubuntu Server
```bash
#Full-Upgrade executa a função de atualização, mas removerá os pacotes atualmente 
#instalados se isso for necessário para atualizar o sistema como um todo
#opção do comando apt: full-upgrade (Perform the function of upgrade but may also remove installed
#packages if that is required in order to resolve a package conflict)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt full-upgrade
```

## 08_ Removendo todos os pacotes desnecessários no Ubuntu Server
```bash
#Autoremove é utilizado para remover pacotes que foram instalados automaticamente para 
#satisfazer dependências de outros pacotes e agora não são mais necessários, pois as 
#dependências foram alteradas ou os pacotes que precisavam deles foram removidos nesse 
#meio tempo.
#opção do comando apt: autoremove (Autoremove is used to remove packages that were automatically
#installed to satisfy dependencies)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt autoremove
```

## 09_ Fazendo a limpeza dos repositórios locais e pacotes desnecessários no Ubuntu Server
```bash
#Autoclean como Clean, o autoclean limpa o repositório local de arquivos de pacotes 
#recuperados. A diferença é que ele remove apenas arquivos de pacotes que não podem 
#mais ser baixados e são inúteis.
#opção do comando apt: autoclean (Like clean, autoclean clears out the local repository of 
#retrieved package files)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt autoclean
```

## 10_ Limpando o cache local do (sources.list) no Ubuntu Server
```bash
#Clean limpa o repositório local de arquivos de pacotes recuperados
#opção do comando apt: clean (clean clears out the local repository of retrieved package files)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt clean
```

## 11_ Verificando todas as versões de software atualizados no Ubuntu Server
```bash
#List é utilizado para listar todos os software que serão atualizados no sistema.
#opção do comando apt: list (list is used to display a list of packages), --installed (shows
#a list of packages names as well as options to list installed)
#opção do redirecionador | (pipe): Conecta a saída padrão com a entrada padrão de outro comando
#opção do comando cat: -n (number line)
#mais informações acesse a documentação oficial em: https://manpages.ubuntu.com/manpages/resolute/man8/apt.8.html
sudo apt list --installed | cat -n
```

## 12_ Verificando os Logs de atualização de software no Ubuntu Server
```bash
#Verificando o Log de instalação e atualização de pacotes no Ubuntu Server
#opção do comando cat: -n (number line)
sudo cat -n /var/log/apt/history.log

#Verificando o Log de finalização da atualização de pacotes no Ubuntu Server
#opção do comando cat: -n (number line)
sudo cat -n /var/log/apt/term.log
```

## 13_ Reiniciando o sistema operacional do Ubuntu Server para aplicar as mudanças
```bash
#Reiniciar o servidor para testar as atualizações
#mais informações acesse a documentação oficial em: https://linux.die.net/man/8/reboot
sudo reboot
```