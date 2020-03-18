# 1. Enter configuration mode.

configure

# 2. Add firewall rules for the L2TP traffic to the local firewall policy.

set firewall name WAN_LOCAL rule 30 action accept
set firewall name WAN_LOCAL rule 30 description ike
set firewall name WAN_LOCAL rule 30 destination port 500
set firewall name WAN_LOCAL rule 30 log disable
set firewall name WAN_LOCAL rule 30 protocol udp

set firewall name WAN_LOCAL rule 40 action accept
set firewall name WAN_LOCAL rule 40 description esp
set firewall name WAN_LOCAL rule 40 log disable
set firewall name WAN_LOCAL rule 40 protocol esp

set firewall name WAN_LOCAL rule 50 action accept
set firewall name WAN_LOCAL rule 50 description nat-t
set firewall name WAN_LOCAL rule 50 destination port 4500
set firewall name WAN_LOCAL rule 50 log disable
set firewall name WAN_LOCAL rule 50 protocol udp

set firewall name WAN_LOCAL rule 60 action accept
set firewall name WAN_LOCAL rule 60 description l2tp
set firewall name WAN_LOCAL rule 60 destination port 1701
set firewall name WAN_LOCAL rule 60 ipsec match-ipsec
set firewall name WAN_LOCAL rule 60 log disable
set firewall name WAN_LOCAL rule 60 protocol udp

# 3. Configure the server authentication settings, in this example we are using local authentication.

set vpn l2tp remote-access ipsec-settings authentication mode pre-shared-secret
set vpn l2tp remote-access ipsec-settings authentication pre-shared-secret <secret>

set vpn l2tp remote-access authentication mode local
set vpn l2tp remote-access authentication local-users username <username> password <secret>

# OPTIONAL: Use RADIUS instead of local authentication.

set vpn l2tp remote-access authentication mode radius
set vpn l2tp remote-access authentication radius-server <address> key <secret>

# 4. Define the IP address pool that will be used by the VPN clients.

set vpn l2tp remote-access client-ip-pool start 192.168.100.240
set vpn l2tp remote-access client-ip-pool stop 192.168.100.249

# 5. Define the DNS server(s) that will be used by the VPN clients.

set vpn l2tp remote-access dns-servers server-1 <address>
set vpn l2tp remote-access dns-servers server-2 <address>

# 6. Define the WAN interface which will receive L2TP requests from clients. Configure only one of the following statements:

# WAN = DHCP
set vpn l2tp remote-access dhcp-interface eth0

# Static WAN
set vpn l2tp remote-access outside-address <wan-address>

# WAN = PPPoE
set vpn l2tp remote-access outside-address 0.0.0.0

# 7. Define the IPsec interface which will receive L2TP requests from clients (eth0 in this example).

set vpn ipsec ipsec-interfaces interface eth0

# OPTIONAL: Lower the MTU for L2TP traffic.
set vpn l2tp remote-access mtu <value>

# 9. Commit the changes and save the configuration.
commit ; save