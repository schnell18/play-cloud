#cloud-config

groups:
  - opsbot

# opsbot is required to run ansible
users:
  - name: opsbot
    gecos: devops robot
    shell: /bin/bash
    primary_group: opsbot
    groups: wheel
    expiredate: '2032-09-01'
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock_passwd: true
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIFpaQ95wDzJoNeHaiwAXzS3M4GP6efFwYkBLZwH646R Cloud OPS
