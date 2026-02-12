# 2-ая лабораторная

## Общая информация

University: [ITMO University](https://itmo.ru/ru/)
Faculty: [FICT](https://fict.itmo.ru)
Course: [Introduction in routing](https://github.com/itmo-ict-faculty/introduction-in-routing)
Year: 2025/2026
Group: K3320
Author: Rodionov Anatoliy Alexandrovich
Lab: Lab2
Date of create: 15.01.2026
Date of finished: 12.02.2026

## Задание

<https://itmo-ict-faculty.github.io/introduction-in-routing/education/labs2023_2024/lab2/lab2/>

### Топология

```yaml
name: lab2
mgmt:
  network: custom_mgmt
  ipv4-subnet: 172.16.16.0/24

topology:
  kinds:
    vr-ros:
      image: vrnetlab/mikrotik_routeros:6.47.9

  nodes:
    R1.BERLIN:
      kind: vr-ros
      mgmt-ipv4: 172.16.16.103
      startup-config: config/R1.BERLIN.rsc
    R1.FRANKFURT:
      kind: vr-ros
      mgmt-ipv4: 172.16.16.102
      startup-config: config/R1.FRANKFURT.rsc
    R1.MOSCOW:
      kind: vr-ros
      mgmt-ipv4: 172.16.16.101
      startup-config: config/R1.MOSCOW.rsc
    pc:
      kind: linux
      image: alpine:latest
      mgmt-ipv4: 172.16.16.2
      binds:
        - ./config:/config
      exec:
        - sh /config/pc.sh
    PC2:
      kind: linux
      image: alpine:latest
      mgmt-ipv4: 172.16.16.3
      binds:
        - ./config:/config
      exec:
        - sh /config/pc.sh
    PC3:
      kind: linux
      image: alpine:latest
      mgmt-ipv4: 172.16.16.4
      binds:
        - ./config:/config
      exec:
        - sh /config/pc.sh

  links:
    - endpoints: ["R1.BERLIN:eth1","R1.MOSCOW:eth2"]
    - endpoints: ["R1.BERLIN:eth2","R1.FRANKFURT:eth1"]
    - endpoints: ["R1.MOSCOW:eth1","R1.FRANKFURT:eth2"]
    - endpoints: ["R1.BERLIN:eth3","PC3:eth1"]
    - endpoints: ["R1.FRANKFURT:eth3","PC2:eth1"]
    - endpoints: ["R1.MOSCOW:eth3","pc:eth1"]
```

![Топология сети](./PHOTO/topology.png)

### Деплой

```
01:30:52 INFO Containerlab started version=0.72.0
01:30:52 INFO Parsing & checking topology file=lab2.yaml
01:30:52 INFO Creating docker network name=custom_mgmt IPv4 subnet=172.16.16.0/24 IPv6 subnet="" MTU=0
01:30:53 INFO Creating lab directory path=/home/anantoliy/Desktop/Routing/2025_2026-introduction_in_routing-k3320-Rodionov_A_A/lab2/clab-lab2
01:30:53 INFO Creating container name=pc
01:30:53 INFO Creating container name=R1.MOSCOW
01:30:53 INFO Creating container name=PC2
01:30:53 INFO Creating container name=PC3
01:30:53 INFO Creating container name=R1.BERLIN
01:30:53 INFO Creating container name=R1.FRANKFURT
01:30:53 INFO Created link: R1.BERLIN:eth2 ▪┄┄▪ R1.FRANKFURT:eth1
01:30:53 INFO Created link: R1.BERLIN:eth1 ▪┄┄▪ R1.MOSCOW:eth2
01:30:53 INFO Created link: R1.FRANKFURT:eth3 ▪┄┄▪ PC2:eth1
01:30:53 INFO Created link: R1.BERLIN:eth3 ▪┄┄▪ PC3:eth1
01:30:53 INFO Created link: R1.MOSCOW:eth1 ▪┄┄▪ R1.FRANKFURT:eth2
01:30:53 INFO Created link: R1.MOSCOW:eth3 ▪┄┄▪ pc:eth1
01:32:04 INFO Executed command node=pc command="sh /config/pc.sh" stdout=""
01:32:04 INFO Executed command node=PC2 command="sh /config/pc.sh" stdout=""
01:32:04 INFO Executed command node=PC3 command="sh /config/pc.sh" stdout=""
01:32:04 INFO Adding host entries path=/etc/hosts
01:32:04 INFO Adding SSH config for nodes path=/etc/ssh/ssh_config.d/clab-lab2.conf
01:32:04 INFO containerlab version
  🎉=
  │ A newer containerlab version (0.73.0) is available!
  │ Release notes: https://containerlab.dev/rn/0.73/
  │ Run 'clab version upgrade' or see https://containerlab.dev/install/ for other installation options.
╭────────────────────────┬───────────────────────────────────┬───────────┬────────────────╮
│          Name          │             Kind/Image            │   State   │ IPv4/6 Address │
├────────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab2-PC2          │ linux                             │ running   │ 172.16.16.3    │
│                        │ alpine:latest                     │           │ N/A            │
├────────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab2-PC3          │ linux                             │ running   │ 172.16.16.4    │
│                        │ alpine:latest                     │           │ N/A            │
├────────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab2-R1.BERLIN    │ vr-ros                            │ running   │ 172.16.16.103  │
│                        │ vrnetlab/mikrotik_routeros:6.47.9 │ (healthy) │ N/A            │
├────────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab2-R1.FRANKFURT │ vr-ros                            │ running   │ 172.16.16.102  │
│                        │ vrnetlab/mikrotik_routeros:6.47.9 │ (healthy) │ N/A            │
├────────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab2-R1.MOSCOW    │ vr-ros                            │ running   │ 172.16.16.101  │
│                        │ vrnetlab/mikrotik_routeros:6.47.9 │ (healthy) │ N/A            │
├────────────────────────┼───────────────────────────────────┼───────────┼────────────────┤
│ clab-lab2-pc           │ linux                             │ running   │ 172.16.16.2    │
│                        │ alpine:latest                     │           │ N/A           
```

## Тест

Пинг с PC1 на PC2:

```
/ # ping 10.2.255.254
PING 10.2.255.254 (10.2.255.254): 56 data bytes
64 bytes from 10.2.255.254: seq=0 ttl=62 time=1.243 ms
64 bytes from 10.2.255.254: seq=1 ttl=62 time=1.192 ms
64 bytes from 10.2.255.254: seq=2 ttl=62 time=1.684 ms
```

Пинг с PC1 на PC3:

```
/ # ping 10.3.255.254
PING 10.3.255.254 (10.3.255.254): 56 data bytes
64 bytes from 10.3.255.254: seq=0 ttl=62 time=1.692 ms
64 bytes from 10.3.255.254: seq=1 ttl=62 time=1.468 ms
64 bytes from 10.3.255.254: seq=2 ttl=62 time=1.484 ms
```
