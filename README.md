# quorum-ansible-playbooks

## Usage

### Example: Run IBFT with Terrera Quorum nodes playbook
```
~$ ansible-playbook -i quorum-consensus/inventories/aws_ec2.yml quorum-consensus/ibft-tessera-5.yml
```

### Clear aws\_ec2 cache if add/remove EC2 quorum nodes
```
~$ rm -r /tmp/aws\_ec2*
```

