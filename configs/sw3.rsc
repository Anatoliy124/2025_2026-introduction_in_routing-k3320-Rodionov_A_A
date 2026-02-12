add name=vlan20_e2 vlan-id=20 interface=ether2
add name=vlan20_e3 vlan-id=20 interface=ether3
/interface bridge
add name=br_v20
/interface bridge port
add interface=vlan20_e2 bridge=br_v20
add interface=vlan20_e3 bridge=br_v20
