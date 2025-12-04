ip link add link eth2 name vlan10 type vlan id 10
ip addr add 10.10.10.10/24 dev vlan10
ip link set vlan10 up
ip route add default via 10.10.10.1
