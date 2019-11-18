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

## Usage - Quorum consensus tasks 

### Consensus

Init node config (Must run before run consensus)
```
- include_tasks: tasks/consensus-node-config-init.yml
```

Consensus common variable

Variables | Description | Optional values | Default values | Required
---------- | ----------- | --------------- | -------------- | --------
NodeNum | Volume of Quorum nodes | 1~7 | - | True
PrivacyImpl | Privacy implementation | tessera <br> tessera-remote <br> constellation | - | True

Consensus - Clique
```
- include_tasks: tasks/consensus-clique-init.yml
  vars:
    NodesNum: ${NodeNum}
- include_tasks: tasks/consensus-clique-start.yml
  vars:
    PrivacyImpl: ${PrivacyImpl}
```

Consensus - IBFT
```
- include_tasks: tasks/consensus-ibft-init.yml
  vars:
    NodesNum: ${NodeNum}
- include_tasks: tasks/consensus-ibft-start.yml
  vars:
    PrivacyImpl: ${PrivacyImpl}
```

Consensus - Raft
```
- include_tasks: tasks/consensus-ibft-init.yml
  vars:
    NodesNum: ${NodeNum}
- include_tasks: tasks/consensus-ibft-start.yml
  vars:
    PrivacyImpl: ${PrivacyImpl}
```

Stop all consensus
```
- include_tasks: tasks/consensus-stop-all.yml
```

### Tasks supported
