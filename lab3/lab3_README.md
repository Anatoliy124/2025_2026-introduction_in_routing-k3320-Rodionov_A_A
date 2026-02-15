# Лабораторная работа 3

## Общая информация

University: [ITMO University](https://itmo.ru/ru/)
Faculty: [FICT](https://fict.itmo.ru)
Course: [Introduction in routing](https://github.com/itmo-ict-faculty/introduction-in-routing)
Year: 2025/2026
Group: K3320
Author: Rodionov Anatoliy Alexandrovich
Lab: Lab3
Date of create: 7.02.2026
Date of finished: 13.02.2026

## Задание

<https://itmo-ict-faculty.github.io/introduction-in-routing/education/labs2023_2024/lab3/lab3/>

### Топология

```
anantoliy@anantoliy-RLEF-XX:~/Desktop/Routing/2025_2026-introduction_in_routing-k3320-Rodionov_A_A/lab3$ cat lab3.yaml 
name: lab3
mgmt:
  network: lab-3
  ipv4-subnet: 172.10.0.0/24

topology:

  nodes:
    R01.SPB:
      kind: vr-mikrotik_ros
      image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt-ipv4: 172.10.0.101
      startup-config: config/R01.SPB.rsc
    R01.HKI:
      kind: vr-mikrotik_ros
      image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt-ipv4: 172.10.0.102
      startup-config: config/R01.HKI.rsc
    R01.MSK:
      kind: vr-mikrotik_ros
      image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt-ipv4: 172.10.0.103
      startup-config: config/R01.MSK.rsc
    R01.LND:
      kind: vr-mikrotik_ros
      image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt-ipv4: 172.10.0.104
      startup-config: config/R01.LND.rsc
    R01.LBN:
      kind: vr-mikrotik_ros
      image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt-ipv4: 172.10.0.105
      startup-config: config/R01.LBN.rsc
    R01.NY:
      kind: vr-mikrotik_ros
      image: vrnetlab/mikrotik_routeros:6.47.9
      mgmt-ipv4: 172.10.0.106
      startup-config: config/R01.NY.rsc
    PC1:
      kind: linux
      image: alpine:latest
      mgmt-ipv4: 172.10.0.2
      binds:
        - ./config:/config
      exec:
        - sh /config/PC.sh
    SGI-PRISM:
      kind: linux
      image: alpine:latest
      mgmt-ipv4: 172.10.0.3
      binds:
        - ./config:/config
      exec:
        - sh /config/PC.sh


  links:
    - endpoints: ["R01.SPB:eth1","R01.HKI:eth1"]
    - endpoints: ["R01.SPB:eth2","R01.MSK:eth1"]
    - endpoints: ["R01.SPB:eth3","PC1:eth1"]
    - endpoints: ["R01.HKI:eth3","R01.LBN:eth3"]
    - endpoints: ["R01.HKI:eth2","R01.LND:eth1"]
    - endpoints: ["R01.MSK:eth2","R01.LBN:eth1"]
    - endpoints: ["R01.LND:eth2","R01.NY:eth1"]
    - endpoints: ["R01.LBN:eth2","R01.NY:eth2"]
    - endpoints: ["R01.NY:eth3", "SGI-PRISM:eth1"]
```

![Топология](PHOT/topology.png)



### Настройка маршрутизаторов

Конфигурация настраивает маршрутизаторов: назначаются IP-адреса на интерфейсы ether2-ether4 (10.10.6.2/30, 10.10.4.1/30, 10.10.5.2/30), создается bridge-интерфейс loopback с адресом 10.255.255.5/32, настраивается OSPF-инстанс inst с router-id 10.255.255.5, который анонсирует сети 10.10.4.0/30, 10.10.5.0/30, 10.10.6.0/30 и loopback-адрес в области backbonev28. Также включается редистрибуция маршрутов, так как без нее ospf знает о маршрутах, но не рассказывает соседям о них. Настраивается MPLS LDP с transport-адресом 10.255.255.5, который работает на интерфейсах ether2-ether4 с фильтрами на прием и отдачу изформации соседям только из сети 10.255.255.0/24. 


### Деплой

```
anantoliy@anantoliy-RLEF-XX:~/Desktop/Routing/2025_2026-introduction_in_routing-k3320-Rodionov_A_A/lab3$ sudo containerlab deploy -t lab3.yaml
01:50:50 INFO Containerlab started version=0.72.0
01:50:50 INFO Parsing & checking topology file=lab3.yaml
01:50:50 INFO Creating docker network name=lab-3 IPv4 subnet=172.10.0.0/24 IPv6 subnet="" MTU=0
01:50:50 INFO Creating lab directory path=/home/anantoliy/Desktop/Routing/2025_2026-introduction_in_routing-k3320-Rodionov_A_A/lab3/clab-lab3
01:50:50 INFO Creating container name=PC1
01:50:50 INFO Creating container name=SGI-PRISM
01:50:50 INFO Creating container name=R01.HKI
01:50:50 INFO Creating container name=R01.NY
01:50:50 INFO Creating container name=R01.LND
01:50:50 INFO Creating container name=R01.SPB
01:50:50 INFO Creating container name=R01.LBN
01:50:50 INFO Creating container name=R01.MSK
01:50:51 INFO Created link: R01.MSK:eth2 ▪┄┄▪ R01.LBN:eth1
01:50:51 INFO Created link: R01.NY:eth3 ▪┄┄▪ SGI-PRISM:eth1
01:50:51 INFO Created link: R01.LND:eth2 ▪┄┄▪ R01.NY:eth1
01:50:51 INFO Created link: R01.LBN:eth2 ▪┄┄▪ R01.NY:eth2
01:50:51 INFO Created link: R01.SPB:eth1 ▪┄┄▪ R01.HKI:eth1
01:50:51 INFO Created link: R01.SPB:eth2 ▪┄┄▪ R01.MSK:eth1
01:50:51 INFO Created link: R01.SPB:eth3 ▪┄┄▪ PC1:eth1
01:50:51 INFO Created link: R01.HKI:eth3 ▪┄┄▪ R01.LBN:eth3
01:50:52 INFO Created link: R01.HKI:eth2 ▪┄┄▪ R01.LND:eth1
01:52:02 INFO Executed command node=PC1 command="sh /config/PC.sh" stdout=""
01:52:02 INFO Executed command node=SGI-PRISM command="sh /config/PC.sh" stdout=""
01:52:02 INFO Adding host entries path=/etc/hosts
01:52:02 INFO Adding SSH config for nodes path=/etc/ssh/ssh_config.d/clab-lab3.conf
01:52:03 INFO containerlab version
  🎉=
  │ A newer containerlab version (0.73.0) is available!
  │ Release notes: https://containerlab.dev/rn/0.73/
  │ Run 'clab version upgrade' or see https://containerlab.dev/install/ for other installation options.
╭─────────────────────┬───────────────────────────────────┬───────────┬────────────────╮
│         Name        │             Kind/Image            │   State   │ IPv4/6 Address │
├─────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab3-PC1       │ linux                             │ running   │ 172.10.0.2     │
│                     │ alpine:latest                     │           │ N/A            │
├─────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab3-R01.HKI   │ vr-mikrotik_ros                   │ running   │ 172.10.0.102   │
│                     │ vrnetlab/mikrotik_routeros:6.47.9 │ (healthy) │ N/A            │
├─────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab3-R01.LBN   │ vr-mikrotik_ros                   │ running   │ 172.10.0.105   │
│                     │ vrnetlab/mikrotik_routeros:6.47.9 │ (healthy) │ N/A            │
├─────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab3-R01.LND   │ vr-mikrotik_ros                   │ running   │ 172.10.0.104   │
│                     │ vrnetlab/mikrotik_routeros:6.47.9 │ (healthy) │ N/A            │
├─────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab3-R01.MSK   │ vr-mikrotik_ros                   │ running   │ 172.10.0.103   │
│                     │ vrnetlab/mikrotik_routeros:6.47.9 │ (healthy) │ N/A            │
├─────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab3-R01.NY    │ vr-mikrotik_ros                   │ running   │ 172.10.0.106   │
│                     │ vrnetlab/mikrotik_routeros:6.47.9 │ (healthy) │ N/A            │
├─────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab3-R01.SPB   │ vr-mikrotik_ros                   │ running   │ 172.10.0.101   │
│                     │ vrnetlab/mikrotik_routeros:6.47.9 │ (healthy) │ N/A            │
├─────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab3-SGI-PRISM │ linux                             │ running   │ 172.10.0.3     │
│                     │ alpine:latest                     │           │ N/A            │
╰─────────────────────┴───────────────────────────────────┴───────────┴────────────────╯
```

### Тест

Пинг с PC1 на SGI-PRISM:

```
/ # ping -c 3 192.168.14.100
PING 192.168.14.100 (192.168.14.100): 56 data bytes
64 bytes from 192.168.14.100: seq=0 ttl=60 time=2.132 ms
64 bytes from 192.168.14.100: seq=1 ttl=60 time=2.478 ms
64 bytes from 192.168.14.100: seq=2 ttl=60 time=2.714 ms

--- 192.168.14.100 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.132/2.441/2.714 ms
```

Пинг с SGI-PRISM на PC1:

```
/ # ping -c 3 192.168.28.100
PING 192.168.28.100 (192.168.28.100): 56 data bytes
64 bytes from 192.168.28.100: seq=0 ttl=60 time=2.391 ms
64 bytes from 192.168.28.100: seq=1 ttl=60 time=2.584 ms
64 bytes from 192.168.28.100: seq=2 ttl=60 time=2.647 ms

--- 192.168.28.100 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.391/2.540/2.647 ms
```

Доказательство работы OSPF:

```
[panindv@R01.HKI] > ip route print 
Flags: X - disabled, A - active, D - dynamic, C - connect, S - static, r - rip, b - bgp, o - ospf, m - mme, B - blackhole, U - unreachable, P - prohibit 
 #      DST-ADDRESS        PREF-SRC        GATEWAY            DISTANCE
 0 ADC  10.10.1.0/30       10.10.1.2       ether2                    0
 1 ADC  10.10.2.0/30       10.10.2.1       ether3                    0
 2 ADo  10.10.3.0/30                       10.10.2.2               110
 3 ADo  10.10.4.0/30                       10.10.5.2               110
 4 ADC  10.10.5.0/30       10.10.5.1       ether4                    0
 5 ADo  10.10.6.0/30                       10.10.5.2               110
 6 ADo  10.10.7.0/30                       10.10.1.1               110
 7 ADo  10.255.255.2/32                    10.10.1.1               110
 8 ADC  10.255.255.3/32    10.255.255.3    loopback                  0
 9 ADo  10.255.255.4/32                    10.10.1.1               110
                                           10.10.5.2         
10 ADo  10.255.255.5/32                    10.10.5.2               110
11 ADo  10.255.255.6/32                    10.10.2.2               110
12 ADo  10.255.255.7/32                    10.10.5.2               110
                                           10.10.2.2         
13 ADC  172.31.255.28/30   172.31.255.30   ether1                    0
14 ADo  192.168.14.0/24                    10.10.5.2               110
                                           10.10.2.2         
15 ADo  192.168.28.0/24                    10.10.1.1               110
```

Доказательство работы MPLS:

```
[panindv@R01.HKI] > mpls forwarding-table print 
Flags: H - hw-offload, L - ldp, V - vpls, T - traffic-eng 
 #    IN-LABEL                                      OUT-LABELS                                   DESTINATION                    INTERFACE                                   NEXTHOP        
 0    expl-null                                    
 1  L 16                                                                                         10.255.255.2/32                ether2                                      10.10.1.1      
 2  L 17                                            18                                           10.255.255.4/32                ether2                                      10.10.1.1      
 3  L 18                                                                                         10.255.255.5/32                ether4                                      10.10.5.2      
 4  L 19                                                                                         10.255.255.6/32                ether3                                      10.10.2.2      
 5  L 20                                            20                                           10.255.255.7/32                ether4                                      10.10.5.2
```

Доказательство работы EoMPLS:

```
[panindv@R01.NY] > interface vpls monitor SGIPC 
       remote-label: 21
        local-label: 21
      remote-status: 
          transport: 10.255.255.2/32
  transport-nexthop: 10.10.3.1
     imposed-labels: 16,21
```

```
[panindv@R01.SPB] > interface vpls monitor SGIPC 
       remote-label: 21
        local-label: 21
      remote-status: 
  transport-nexthop: 10.10.1.2
     imposed-labels: 20,21
```
