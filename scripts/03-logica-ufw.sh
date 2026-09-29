# ---------- 0. VARIÁVEIS (ADAPTAR) ----------
IF=bond0                        # bond0 se já estiver com Bonding
IP4=172.16.1.20
IP6=2804:14c:90:8697::20
NET4=172.16.1.0/24
NET6=2804:14c:90:8697::/64
ADM=172.16.1.113                 # estação de administração

# ---------- 1. ROLLBACK DE SEGURANÇA (5 min) ----------
sudo systemd-run --unit=ufw-rollback --on-active=5m /usr/sbin/ufw disable

# ---------- 2. BACKUP E RESET ----------
sudo cp -av /etc/ufw /etc/ufw.bkp-$(date +%F)
sudo ufw --force reset
grep -i '^IPV6' /etc/default/ufw

# ---------- 3. POLÍTICAS PADRÃO ----------
sudo ufw default deny incoming    OK
sudo ufw default deny outgoing    OK
sudo ufw default deny routed      OK
sudo ufw logging medium           OK

# ---------- 4. LOOPBACK (serviços locais: MySQL 3306, Chrony 323, Node Exporter 9100, Agents) ----------
sudo ufw allow in on lo           OK
sudo ufw allow out on lo          OK

# ---------- 5. SAÍDAS COM ORIGEM RESTRITA ----------
# DNS over TLS somente para a CloudFlare
for D in 1.1.1.1 1.0.0.1; do
  sudo ufw allow out on $IF from $IP4 to $D port 853 proto tcp comment 'DoT CloudFlare v4'    OK
done
for D in 2606:4700:4700::1111 2606:4700:4700::1001; do
  sudo ufw allow out on $IF from $IP6 to $D port 853 proto tcp comment 'DoT CloudFlare v6'    OK
done
# (53/udp e 53/tcp somente se DNSOverTLS=opportunistic)

# HTTP/HTTPS (APT, Github, Grafana repo)
sudo ufw allow out on $IF from $IP4 to any port 443 proto tcp comment 'HTTPS v4'              OK
sudo ufw allow out on $IF from $IP6 to any port 443 proto tcp comment 'HTTPS v6'              OK
sudo ufw allow out on $IF from $IP4 to any port 80 proto tcp comment 'HTTP APT v4'            OK
sudo ufw allow out on $IF from $IP6 to any port 80 proto tcp comment 'HTTP APT v6'            OK

# NTP + NTS-KE somente para NTP.br
for H in a.st1.ntp.br c.st1.ntp.br e.st1.ntp.br; do
  for IP in $(getent ahosts $H | awk '{print $1}' | sort -u); do
    sudo ufw allow out on $IF to $IP port 123 proto udp comment "NTP $H"                      OK
    sudo ufw allow out on $IF to $IP port 4460 proto tcp comment "NTS-KE $H"                  OK
  done
done

# ---------- 8. ENTRADAS COM ORIGEM RESTRITA ----------
# SSH (limit + log) IPv4 e IPv6
sudo ufw limit in on $IF log-all from $NET4 to $IP4 port 22 proto tcp comment 'SSH v4'        OK
sudo ufw limit in on $IF log-all from $NET6 to $IP6 port 22 proto tcp comment 'SSH v6'        OK

# Painéis Web somente da estação de administração (Apache/BBS, Grafana, Prometheus, Netronome)
for P in 80 443 3000 9090 7575; do
  sudo ufw allow in on $IF log from $ADM to $IP4 port $P proto tcp comment "ADM tcp $P"       OK
done

# Serviços de teste de rede somente da sub-rede (SpeedTest, iperf3)
for P in 8080 5201; do
  sudo ufw allow in on $IF log from $NET4 to $IP4 port $P proto tcp comment "LAN tcp $P"      OK
done

# ---------- 6. ICMP ----------
# IPv4: saída (bloco #13) + entrada somente da sub-rede
sudo cp -v /etc/ufw/before.rules /etc/ufw/before.rules.bkp

-A ufw-before-input -p icmp --icmp-type echo-request -j ACCEPT                                OK
-A ufw-before-input -s 172.16.1.20/24 -p icmp --icmp-type echo-request -j ACCEPT              OK

# ok icmp codes for OUTPUT
-A ufw-before-output -p icmp --icmp-type destination-unreachable -j ACCEPT                    OK
-A ufw-before-output -p icmp --icmp-type time-exceeded -j ACCEPT                              OK
-A ufw-before-output -p icmp --icmp-type parameter-problem -j ACCEPT                          OK
-A ufw-before-output -p icmp --icmp-type echo-request -j ACCEPT                               OK


# IPv6: saída (faltava no procedimento)
sudo cp -v /etc/ufw/before6.rules /etc/ufw/before6.rules.bkp

# ok icmp codes for OUTPUT
-A ufw6-before-output -p icmpv6 --icmpv6-type destination-unreachable -j ACCEPT               OK
-A ufw6-before-output -p icmpv6 --icmpv6-type packet-too-big -j ACCEPT                        OK
-A ufw6-before-output -p icmpv6 --icmpv6-type time-exceeded -j ACCEPT                         OK
-A ufw6-before-output -p icmpv6 --icmpv6-type parameter-problem -j ACCEPT                     OK
-A ufw6-before-output -p icmpv6 --icmpv6-type echo-request -j ACCEPT                          OK


# ---------- 7. REMOVENDO ACEITES DESNECESSÁRIOS (mDNS, SSDP, DHCP com IP estático) ----------
sudo sed -i '/224.0.0.251\|239.255.255.250\|--sport 67 --dport 68/ s/^/#/' /etc/ufw/before.rules
sudo sed -i '/ff02::fb\|ff02::f:c\|--sport 547 --dport 546/ s/^/#/' /etc/ufw/before6.rules
grep -n '^#-A' /etc/ufw/before.rules /etc/ufw/before6.rules



# SEM REGRA (bloqueados + logados pela política padrão): 3306, 323, 9100, 8200

# ---------- 9. APLICAR ----------
sudo ufw enable
sudo ufw reload
sudo systemctl stop ufw-rollback.timer     # cancela o rollback SOMENTE após validar o SSH em nova sessão

# ---------- 10. VALIDAÇÃO ----------
sudo ufw status verbose
sudo ufw status numbered
sudo ufw show added
sudo resolvectl query cloudflare.com
sudo chronyc sources
sudo chronyc authdata
sudo apt update
ping -4 -c2 8.8.8.8
ping -6 -c2 2001:4860:4860::8888
sudo lsof -nP -iTCP -sTCP:LISTEN
sudo nmap -p- $IP4                          # de outra máquina FORA da sub-rede/ADM
sudo tail -f /var/log/ufw.log