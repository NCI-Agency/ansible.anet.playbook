![CI Playbook Syntax Check](https://github.com/NCI-Agency/ansible.anet.playbook/workflows/CI%20Playbook%20Syntax%20Check/badge.svg)

# ANET Ansible installation scripts

Aims to install [ANET](https://github.com/NCI-Agency/anet) and dependencies using [Ansible](https://www.ansible.com/).

Supported target systems:
* [RedHat Enterprise Linux 7.x](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/)
* [CentOS](https://www.centos.org/) 7.x

## Dependencies:
Depends on:
* [community.general](https://galaxy.ansible.com/community/general) for [Keycloak](https://docs.ansible.com/ansible/latest/collections/community/general/keycloak_client_module.html)

Which can be installed using:
```shell script
ansible-galaxy collection install community.general
```

## Inventory

`anet_fqhn` should bet set to ANET's [fully qualified hostname](https://de.wikipedia.org/wiki/Fully-Qualified_Host_Name) corresponding with the way user shall access anet via their web browser.

## Artifacts (dependencies)
Artifacts should be installed on the Ansible controller in:
- `{{ local_rpm_repo_folder }}` All non-RPM artifacts (currently only Keycloak distribution)
- `{{ local_rpm_repo_folder }}/repo` All required RPMs

Default value for `local_rpm_repo_folder` = `/opt/ansible/anet`

For example:
```yml
all:
  vars:
    keycloak_anet_realm: ANET-Realm
    anet_db_password: 'Test-P@ssw0rd'
    anet_keycloak_key_server: NvHfQdPMRgJbUMYFiSmeYbRwlIFigEcV

anet-redhat-servers:
  hosts:
    anet.example.nato.int:
      ansible_host: 10.7.41.144
      anet_fqhn: anet.example.nato.int # Ansible will accessed via https://anet.example.nato.int/
```

## Run the playbook
```shell script
ansible-playbook -i hosts.yml -v install-anet.yml
```
