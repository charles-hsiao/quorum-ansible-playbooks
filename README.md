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

#### Init node config (Must run before run consensus)
```
- include_tasks: tasks/consensus-node-config-init.yml
```

#### Consensus common variables

Variables | Description | Optional values | Default values | Required
--------- | ----------- | --------------- | -------------- | --------
NodeNum | Volume of Quorum nodes | 1~7 | - | True
PrivacyImpl | Privacy implementation | tessera <br> tessera-remote <br> constellation | - | True

#### Consensus - Clique
```
- include_tasks: tasks/consensus-clique-init.yml
  vars:
    NodesNum: ${NodeNum}
- include_tasks: tasks/consensus-clique-start.yml
  vars:
    PrivacyImpl: ${PrivacyImpl}
```

#### Consensus - IBFT
```
- include_tasks: tasks/consensus-ibft-init.yml
  vars:
    NodesNum: ${NodeNum}
- include_tasks: tasks/consensus-ibft-start.yml
  vars:
    PrivacyImpl: ${PrivacyImpl}
```

#### Consensus - Raft
```
- include_tasks: tasks/consensus-ibft-init.yml
  vars:
    NodesNum: ${NodeNum}
- include_tasks: tasks/consensus-ibft-start.yml
  vars:
    PrivacyImpl: ${PrivacyImpl}
```

#### Send 20 public events
```
- include_tasks: tasks/txn-send-public-events.yml
```

#### Send 20 private events
```
- include_tasks: tasks/txn-send-private-events.yml
```

#### Stop all consensus
```
- include_tasks: tasks/consensus-stop-all.yml
```

### Network Connectivity - iptables

#### iptables common variables
Variables | Description | Optional values | Default values | Required
--------- | ----------- | --------------- | -------------- | --------
TargetIP | IP to block or clear block rule | - | - | True 

#### iptables - Block source IP
```
- include_tasks: tasks/iptables-block-source.yml
  vars:
    block_ip: ${TargetIP}
``` 

#### iptables - Clear block source IP
```
- include_tasks: tasks/iptables-clear-block-source.yml
  vars:
    block_ip: ${TargetIP}
```

#### iptables - Clear all rules
```
- include_tasks: tasks/iptables-clear-all.yml
```
