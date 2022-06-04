# Jupyter-Cluster
## Warning
This project is Work-in-Progress status and not all features are functional

## Procedures
Pre-requisite: Docker Compose
1. Clone this repository
2. Clone [Jupyter Container](../../../jupyter-container) repository as jupyter<br>
   Example
   ```
   git clone https://github.com/tooru-furuyama/jupyter-container.git jupyter
   ```
3. Launch Docker Compose
   ```
   docker compose up -d
   ```

# To Do
* HTTPS Support
* LDAP integration
  Note: Currently Jupyter, Gitea and OpenLDAP are just running in the same network and LDAP authentication is NOT integrated yet.
