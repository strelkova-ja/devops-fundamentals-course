# devops-fundamentals-course
My diploma task of the DevOps Fundamentals course by EPAM

## What's this for?
This project deploys an infrastructure of 3 VMs with roles web, routher and database.
Routher have dhcp+dns, firewall settings
DB - MySQL with bash scripts(backup ans backup alerts)
Web - Apache, with serve Flask app
All of this VMs are monitored by Zabbix+Grafana

## How to start?
Requirements:
1. Vagrant
2. VirtualBox
3. Ansible

```
cd devops-fundamentals-course/
```
```
vagrant up
```
 
