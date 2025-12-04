add name=vlan10_e2 vlan-id=10 interface=ether2
add name=vlan20_e2 vlan-id=20 interface=ether2
add name=vlan10_e3 vlan-id=10 interface=ether3
add name=vlan20_e4 vlan-id=20 interface=ether4
/interface bridge
add name=br_v10
add name=br_v20
/interface bridge port
add interface=vlan10_e2 bridge=br_v10
add interface=vlan10_e3 bridge=br_v10
add interface=vlan20_e2 bridge=br_v20
add interface=vlan20_e4 bridge=br_v20