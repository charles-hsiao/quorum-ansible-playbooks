- hosts: quorum-nodes
  tasks:
      - name: Init tessera
        shell: cd /home/ubuntu/quorum-experiment/7nodes && bash tessera-init.sh
      - name: Start tessera
        shell: cd /home/ubuntu/quorum-experiment/7nodes && bash tessera-start.sh
