
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

For configuring Server 1 created shell script
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


Configuring DHCP-server:

![image](https://user-images.githubusercontent.com/113692759/214577780-884a26cc-0bb9-45c5-8a0e-208f14cb9caa.png)


For routing throught Server 1 was needed to edit file /etc/sysctl.conf:

![image](https://user-images.githubusercontent.com/113692759/214687268-848504c9-d58d-40cd-85f9-bf3cf4d092ee.png)

## 3) Testing connection with commands ping and traceroute:

Ping and traceroute from Client 1 to Client 2

![image](https://user-images.githubusercontent.com/113692759/214688704-4609326a-1271-4d95-b19a-cb08562b4d88.png)


Ping and traceroute from Client 2 to Client 1

![image](https://user-images.githubusercontent.com/113692759/214688095-f8c3dec4-11c7-46d8-92d7-f3dded0fc322.png)

As can be seen, Clients can use ping in both sides. The result is that the DHCP server configures the clients interfaces wich linked to Server 1, so Clients can make information transfer only through that link. 


## 4) Configuring virtual interface lo

lo new ip:

172.17.34.1/24

172.17.44.1/24

To configure this addresses was modified file /etc/network/interfaces:

![image](https://user-images.githubusercontent.com/113692759/214825665-5c314bb0-a73b-466e-bc79-bf90fb2c8a73.png)

Configured addresses:

![image](https://user-images.githubusercontent.com/113692759/214930807-2c561873-b339-45dd-bb63-33edaaba8ef3.png)

Configured routes:

Server 1:

![image](https://user-images.githubusercontent.com/113692759/214932149-a2e88511-5cfa-4d56-8567-26f55367a117.png)


Client 2:

![image](https://user-images.githubusercontent.com/113692759/214931800-d5619411-3349-4518-ab7a-542810f781e2.png)


Route check with command 
```bash 
traceroute
```

![image](https://user-images.githubusercontent.com/113692759/214932914-449861e4-3ba4-4125-8314-7d52296905cc.png)


## 5) Creating summarized address

172.17.34.1/24

172.17.44.1/24

Difference between addresses in third octet = 10, so minimal number of needed bits is 4.

Check is 20 netmask enough:

Mask = 255.255.16.0
Nearest net address is 172.17.32.0/20

First host is 172.17.32.1 < 172.17.34.1
Last host is 172.17.48.254 > 172.17.44.254

In this case, that mask enough to insert created two addresses. 

Summarized address: 172.17.32.0/20

Removing route, that has been created in previous part:

Server 1

![image](https://user-images.githubusercontent.com/113692759/214941767-c6184144-7163-41f2-8869-8dc57b65b7d9.png)

Client 2

![image](https://user-images.githubusercontent.com/113692759/214942109-bdefd1df-1669-442d-b45d-cead6bbcb393.png)


Adding summarized route to Client 1 from Server 1:

![image](https://user-images.githubusercontent.com/113692759/214942715-0dcb1d69-3332-436b-b895-60abd90d375c.png)

Traceroute test from Client 2:

![image](https://user-images.githubusercontent.com/113692759/214943122-d78b98e0-9c39-4fca-ad2f-6dc7792a14cf.png)



## 6) Configuring computers, to have access from all to everyone with ssh protocol.

Starting sshd

Server 1

![image](https://user-images.githubusercontent.com/113692759/214947944-fb44b817-4349-41a2-b03d-8cee719ee6c0.png)

Client 1

![image](https://user-images.githubusercontent.com/113692759/214948282-b34ef53e-4474-4e5c-bb4b-75513a73c5b3.png)

Client 2

![image](https://user-images.githubusercontent.com/113692759/214948387-a3300823-d32c-4c61-b69d-596f61719c23.png)

Testing the connection between clients and server:

Client 2 connect to Client 1

![image](https://user-images.githubusercontent.com/113692759/214948684-cf630807-96f3-41d9-a442-48063ead0d16.png)

Client 1 connect to Client 2

![image](https://user-images.githubusercontent.com/113692759/214948845-69ee309c-b226-4cfc-9d05-48994ed80b28.png)

Client 1 connect to Server 1 through connect to Client 2

![image](https://user-images.githubusercontent.com/113692759/214949272-9b8d89d3-845b-489c-b905-bc0553823ee8.png)


## 7) Configuring firewall

Enabling the firewall on Server 1:

![image](https://user-images.githubusercontent.com/113692759/215290747-692c4271-d8a8-422a-a7f6-2ab283a1ed2f.png)

Trying to connect with ssh from Client 1 to Client 2:

![image](https://user-images.githubusercontent.com/113692759/215290816-c828c34b-71e0-4591-8454-4c7752f6438c.png)

So firewall is working and blocks ssh connection.

Creating rules:

Allowing connection from Client 1:

![image](https://user-images.githubusercontent.com/113692759/215294777-309070fc-7240-4d8e-b9da-4a006f14ac9c.png)

Testing rule:

![image](https://user-images.githubusercontent.com/113692759/215295012-c99a93d9-b147-4af5-ba14-dbccbb17feb0.png)



