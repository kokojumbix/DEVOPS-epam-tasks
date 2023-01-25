
## Basic configuration:

Server_1: Ubuntu

Client_1: Kali linux

Client_2: Centos 7

Адреса мережі Net2 – 10.3.24.0/24

Адреса мережі Net3 – 10.1.3.0/24.

Адреса мережі Net4 – 172.16.24.0/24.

## Configured adapters:

Server_1 (Ubuntu)

![image](https://user-images.githubusercontent.com/113692759/214542075-597e5367-b42b-4abc-9e70-a83f9faeaf1b.png)

Client_1 (Kali)

![image](https://user-images.githubusercontent.com/113692759/214542566-8c07fe37-6d53-4ad4-8d07-8eddcd40096f.png)

Client_2 (Centos)

![image](https://user-images.githubusercontent.com/113692759/214542639-6b97eb2e-bacc-431f-b518-654f19027080.png)

## 1) Configuring static addresses on server

For configuring Server 1 was created shell script
```Bash
nmcli connection modify "Wired connection 1" ipv4.addresses "192.168.31.200/24"
nmcli connection modify "Wired connection 1" ipv4.method "Manual"
nmcli connection modify "Wired connection 2" ipv4.addresses "10.3.24.1/24"
nmcli connection modify "Wired connection 2" ipv4.method "Manual"
nmcli connection modify "Wired connection 3" ipv4.addresses "10.1.3.1/24"
nmcli connection modify "Wired connection 3" ipv4.method "Manual"
```

Result config:
![image](https://user-images.githubusercontent.com/113692759/214548816-cb350dee-8d2b-46be-95ba-647fa51476d6.png)

## 2) Setting up the dhcp server, wich will configure Client 1 and Client 2 link:

Installing DHCP-server
```Bash
sudo apt-get install isc-dhcp-server -y
```

Configuring interfaces, wich will be used:

![image](https://user-images.githubusercontent.com/113692759/214551368-9881b52a-3540-4520-bcd1-84fcfaf27778.png)


