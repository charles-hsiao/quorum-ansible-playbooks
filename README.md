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

### Network Connectivity - netem

#### netem common variables
Variables | Description | Optional values | Default values | Required
--------- | ----------- | --------------- | -------------- | --------
Action | Action for netem command | add <br> delete <br> change | add | False
NetworkInterface | Network interface to set-up | - | eth0 | False
DelayTime | Delay time, input with time unit, ex: 100ms | - | - | True
MarginTime | Delay time with margin, Delay=${DelayTime} ± ${MarginTime}, input with time unit, ex: 100ms | - | - | True
Probability | (1)Delay time with margin/(2)Packet corrupt/(3)Packet loss/(4)Packet misorder base on the given probability, input probability with %, ex: 25% | - | - | True 
DistributionType | Delay time with margin distribution | uniform <br> normal <br> pareto <br> paretonormal | - | True
CorrelationProbability | The correlation probability (If correlation_probability=25%, Probn=0.25*Probn-1 + 0.75*Random) | - | - | True
NoDelayIndexModBase | No delay for packet index % ${NoDelayIndexModBase}=0, others delay with ${DelayTime} and misorder with certain probability | - | - | True
NetworkRateLimit | Network rate limit, input in speed unit, ex: 256kbit | - | - | True

#### netem - Delay with specific time
```
- include_tasks: tasks/netem-delay.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    delay_time: ${DelayTime}
```

#### netem - Delay with margin
```
- include_tasks: tasks/netem-delay-margin.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    delay_time: ${DelayTime}
    margin_time: ${MarginTime}
```

#### netem - Delay with margin probability
```
- include_tasks: tasks/netem-delay-margin-probability.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    delay_time: ${DelayTime}
    margin_time: ${MarginTime}
    probability: ${Probability}
```

#### netem - Delay with margin distrubution
```
- include_tasks: tasks/netem-delay-margin-distribution.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    delay_time: ${DelayTime}
    margin_time: ${MarginTime}
    distribution_type: ${DistributionType}
```

#### netem - Packet corrupt
```
- include_tasks: tasks/netem-packet-corrupt.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    probability: ${Probability}
```

#### netem - Packet loss
```
- include_tasks: tasks/netem-packet-loss.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    probability: ${Probability}
```

#### netem - Packet loss with burst
```
- include_tasks: tasks/netem-packet-loss-burst.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    probability: ${Probability}
    correlation_probability: ${CorrelationProbability}
```

#### netem - Packet misorder with specific gap
```
- include_tasks: tasks/netem-packet-misorder-gap.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    packet_nodelay_index_mod_base: ${NoDelayIndexModBase}
    delay_time: ${DelayTime}
    probability: ${Probability}
    correlation_probability: ${CorrelationProbability}
```

#### netem - Packet misorder with probability
```
- include_tasks: tasks/netem-packet-misorder-probability.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    probability: ${Probability}
    correlation_probability: ${CorrelationProbability}
```

#### netem - Network rate limit control
```
- include_tasks: tasks/netem-network-rate-control.yml
  vars:
    action: ${Action}
    network_interface: ${NetworkInterface}
    delay_time: ${DelayTime}
    network_rate_limit: ${NetworkRateLimit}
```

#### netem - Clear all
```
- include_tasks: tasks/netem-clear-all.yml
  vars:
    network_interface: ${NetworkInterface}
```


