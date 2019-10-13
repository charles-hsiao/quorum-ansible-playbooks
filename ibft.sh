- hosts: quorum-nodes
  tasks:
      - name: Init IBFT
        shell: cd /home/ubuntu/quorum-experiment/7nodes && bash istanbul-init.sh
      - name: Start IBFT
        shell: cd /home/ubuntu/quorum-experiment/7nodes && bash istanbul-start.sh
