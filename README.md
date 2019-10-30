# quorum-ansible-playbooks

## Usage

### Init node config
```
ansible-playbook -i aws_ec2.yml quorum-consensus/init_node_config.yml
```

### Run IBFT consensus
```
ansible-playbook -i aws_ec2.yml quorum-consensus/ibft.yml
```
