# Jupyter-Cluster
## Warning
This project is Work-in-Progress status and not all features are functional

## Overview
This project is a cluster of containers for JupyterLab with JupyterHub+LDAP authentication and with Git(Gitea) repository.

### Components
|Container|Description|Network Ports|
| ------ | ------ | ------ |
|[Jupyter](../../../jupyter-container)|JupyterHub+JupyterLab|HTTPS/8000|
|[Gitea](https://github.com/go-gitea/gitea)|Git repository|HTTPS/3000|
|[OpenLDAP](https://github.com/osixia/docker-openldap)|LDAP server|TCP/389,TCP/639|
|[phpLDAPadmin](https://github.com/osixia/docker-phpLDAPadmin)|Web GUI for OpenLDAP|HTTPS/9080|
|[Traefik](https://github.com/traefik/traefik)|Reverse proxy|HTTPS/8080|

### To Do
* LDAP integration<br>
  Note: Currently Jupyter, Gitea and OpenLDAP are just running in the same network and LDAP authentication is NOT integrated yet.

## Deployment
Pre-requisite: Docker Compose
1. Clone this repository
2. Clone [Jupyter Container](../../../jupyter-container) repository and copy jupyter folder in the repository<br>
   Example
   ```
   git clone https://github.com/tooru-furuyama/jupyter-container.git
   cp jupyter-container/jupyter .
   ```
3. Update domain name from example domain name (apps.example.local) to the appropriate domain name<br>
   Example
   ```
   sed -i -e "s/apps.example.local/{domain-name}/g" docker-compose.yml
   sed -i -e "s/apps.example.local/{domain-name}/g" gitea/data/gitea/conf/app.ini
   ```
4. Launch Docker Compose
   ```
   docker compose up -d
   ```
