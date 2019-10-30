# quorum-ansible-playbooks

## Usage

### Init node config
```
~$ ansible-playbook -i aws_ec2.yml quorum-consensus/init_node_config.yml
```

### Run consensus
```
# Modify "NodesNum" and "PrivacyImpl" if needed

# Run IBFT
~$ ansible-playbook -i aws_ec2.yml quorum-consensus/ibft.yml

# Run Clique
~$ ansible-playbook -i aws_ec2.yml quorum-consensus/clique.yml

# Run raft
~$ ansible-playbook -i aws_ec2.yml quorum-consensus/raft.yml

```

### Clear aws\_ec2 cache if add/remove EC2 quorum nodes
```
~$ rm -r /tmp/aws\_ec2*
```

