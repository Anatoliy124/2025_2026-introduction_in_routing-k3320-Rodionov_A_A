add name=vlan10_e2 vlan-id=10 interface=ether2
add name=vlan10_e3 vlan-id=10 interface=ether3
/interface bridge
add name=br_v10
/interface bridge port
add interface=vlan10_e2 bridge=br_v10
add interface=vlan10_e3 bridge=br_v10
