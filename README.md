# 2025_2026-introduction_in_routing-k3320-Rodionov_A_A
# 1-ая лабораторная

## Общая информация

University: [ITMO University](https://itmo.ru/ru/)
Faculty: [FICT](https://fict.itmo.ru)
Course: [Introduction in routing](https://github.com/itmo-ict-faculty/introduction-in-routing)
Year: 2025/2026
Group: K3320
Author: Rodionov Anatoliy Alexandrovich
Lab: Lab1


## Выполнение работы

Поднятие сети:

```bash
containerlab deploy -t lab1.yaml
```

Результат:

```
╭────────────────┬─────────────────────────────┬────────────────────┬────────────────╮
│      Name      │          Kind/Image         │        State       │ IPv4/6 Address │
├────────────────┼─────────────────────────────┼────────────────────┼────────────────┤
│ clab-lab_1-PC1 │ linux                       │ running            │ 10.10.10.2     │
│                │ alpine:latest               │                    │ N/A            │
├────────────────┼─────────────────────────────┼────────────────────┼────────────────┤
│ clab-lab_1-PC2 │ linux                       │ running            │ 10.10.10.3     │
│                │ alpine:latest               │                    │ N/A            │
├────────────────┼─────────────────────────────┼────────────────────┼────────────────┤
│ clab-lab_1-R1  │ vr-mikrotik_ros             │ running            │ 10.10.10.11    │
│                │ vrnetlab/vr-routeros:6.47.9 │ (health: starting) │ N/A            │
├────────────────┼─────────────────────────────┼────────────────────┼────────────────┤
│ clab-lab_1-SW1 │ vr-mikrotik_ros             │ running            │ 10.10.10.12    │
│                │ vrnetlab/vr-routeros:6.47.9 │ (health: starting) │ N/A            │
├────────────────┼─────────────────────────────┼────────────────────┼────────────────┤
│ clab-lab_1-SW2 │ vr-mikrotik_ros             │ running            │ 10.10.10.13    │
│                │ vrnetlab/vr-routeros:6.47.9 │ (health: starting) │ N/A            │
├────────────────┼─────────────────────────────┼────────────────────┼────────────────┤
│ clab-lab_1-SW3 │ vr-mikrotik_ros             │ running            │ 10.10.10.14    │
│                │ vrnetlab/vr-routeros:6.47.9 │ (health: starting) │ N/A            │
╰────────────────┴─────────────────────────────┴────────────────────┴───────────
```

Схема сети:

![network](network.png)

Конфигурация сети на 1-ом ПК:

```
anantoliy@anantoliy-RLEF-XX:~/lab1$ sudo docker exec -it clab-lab_1-PC1 sh
/ # ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0@if521: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP 
    link/ether aa:1d:39:e8:77:a1 brd ff:ff:ff:ff:ff:ff
    inet 10.10.10.2/24 brd 10.10.10.255 scope global eth0
       valid_lft forever preferred_lft forever
3: vlan10@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 qdisc noqueue state UP qlen 1000
    link/ether aa:c1:ab:2f:e8:4b brd ff:ff:ff:ff:ff:ff
    inet 10.10.10.10/24 scope global vlan10
       valid_lft forever preferred_lft forever
    inet6 fe80::a8c1:abff:fe2f:e84b/64 scope link 
       valid_lft forever preferred_lft forever
519: eth2@if520: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 9500 qdisc noqueue state UP 
    link/ether aa:c1:ab:2f:e8:4b brd ff:ff:ff:ff:ff:ff
    inet6 fe80::a8c1:abff:fe2f:e84b/64 scope link 
       valid_lft forever preferred_lft forever


```

Конфигурация сети на 2-ом ПК:

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0@if522: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP 
    link/ether 0e:83:3c:16:f7:38 brd ff:ff:ff:ff:ff:ff
    inet 10.10.10.3/24 brd 10.10.10.255 scope global eth0
       valid_lft forever preferred_lft forever
3: vlan20@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9500 qdisc noqueue state UP qlen 1000
    link/ether aa:c1:ab:f7:d3:74 brd ff:ff:ff:ff:ff:ff
    inet 10.10.20.10/24 scope global vlan20
       valid_lft forever preferred_lft forever
    inet6 fe80::a8c1:abff:fef7:d374/64 scope link 
       valid_lft forever preferred_lft forever
517: eth2@if518: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 9500 qdisc noqueue state UP 
    link/ether aa:c1:ab:f7:d3:74 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::a8c1:abff:fef7:d374/64 scope link 
       valid_lft forever preferred_lft forever
```

Пинг с 1-го ПК на 2-ой:

```
PING 10.10.10.3 (10.10.10.3): 56 data bytes
64 bytes from 10.10.10.3: seq=0 ttl=64 time=0.228 ms
64 bytes from 10.10.10.3: seq=1 ttl=64 time=0.164 ms
64 bytes from 10.10.10.3: seq=2 ttl=64 time=0.151 ms
64 bytes from 10.10.10.3: seq=3 ttl=64 time=0.159 ms

--- 10.10.10.3 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 0.151/0.175/0.228 ms
```

## Заключение

В результате выполнения лабораторной работы была настроена трехуровневая сеть связи классического предприятия с VLAN и DHCP.
