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
Data de atualização: 20/07/2026<br>
Versão: 0.01<br>
Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS

Release Ubuntu Server 26.04: https://documentation.ubuntu.com/release-notes/26.04/<br>
Releases All Ubuntu Server: https://wiki.ubuntu.com/Releases<br>
Ciclo de Lançamento do Ubuntu Server: https://ubuntu.com/about/release-cycle<br>
Ubuntu Advantage for Infrastructure: https://ubuntu.com/advantage<br>

Conteúdo estudado nessa configuração:<br>

[![RAID-1 Ubuntu Server](http://img.youtube.com/vi//0.jpg)]( RAID-1 Ubuntu Server")

Link da vídeo aula: 

| **RAID** | **Redundância** | **Performance** | **Mínimo de Discos** | **Tolerância** |
| -------- | --------------- | --------------- | -------------------- | -------------- |
| **RAID0** | ❌ | ⭐⭐⭐⭐⭐ | 2 | Nenhuma |
| **RAID1** | ✅ | ⭐⭐⭐ | 2 | 1 disco |
| **RAID5** | ✅ | ⭐⭐⭐⭐ | 3 | 1 disco |
| **RAID6** | ✅ | ⭐⭐⭐ | 4 | 2 discos |
| **RAID10** | ✅ | ⭐⭐⭐⭐⭐ | 4 | até metade dos discos |
---

## 01_ Preparando os Discos para a Configuração do RAID-1 no Ubuntu Server
```bash
#verificando se já existe alguma assinatura de sistema de arquivos, RAID ou LVM nos discos novos
#opção do comando wipefs: -n (dry-run, apenas simula sem apagar nada)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/wipefs.8.html
sudo wipefs -n /dev/sdb
sudo wipefs -n /dev/sdc

#OBSERVAÇÃO IMPORTANTE: discos recém-criados no VirtualBOX normalmente não retornam nada,
#só execute o comando abaixo se o dry-run acima detectar alguma assinatura residual
#opção do comando wipefs: -a (apaga todas as assinaturas encontradas)
#mais informações acesse a documentação oficial em: https://man7.org/linux/man-pages/man8/wipefs.8.html
sudo wipefs -a /dev/sdb
sudo wipefs -a /dev/sdc
```

