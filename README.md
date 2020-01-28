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

#### Start mining
```
- include_tasks: tasks/consensus-mining-start.yml
```

#### Stop mining
```
- include_tasks: tasks/consensus-mining-stop.yml
```

#### Stop all consensus
```
- include_tasks: tasks/consensus-stop-all.yml
```

### Moitoring - epirus

#### epirus common variables
Variables | Description | Optional values | Default values | Required
--------- | ----------- | --------------- | -------------- | --------
server_ip | IP of quorum/geth nodes to monitor | - | - | True
server_port | Port of geth json rpc | - | 22000 | False

#### Start epirus
```
- include_tasks: tasks/eprius-start.yml
  vars:
    server_ip: ${server_ip}
    server_port: ${server_port}
```

#### Stop epirus
```
- include_tasks: tasks/eprius-stop.yml
```

### Network Connectivity - iptables

#### iptables common variables
Variables | Description | Optional values | Default values | Required
--------- | ----------- | --------------- | -------------- | --------
block_ip | IP to block or clear block rule | - | - | True 

#### iptables - Block source IP
```
- include_tasks: tasks/iptables-block-source.yml
  vars:
    block_ip: ${block_ip}
``` 

#### iptables - Clear block source IP
```
- include_tasks: tasks/iptables-clear-block-source.yml
  vars:
    block_ip: ${block_ip}
```

#### iptables - Clear all rules
```
- include_tasks: tasks/iptables-clear-all.yml
```

### Network Connectivity - netem

#### netem common variables
Variables | Description | Optional values | Default values | Required
--------- | ----------- | --------------- | -------------- | --------
action | action for netem command | add <br> delete <br> change | add | False
network_interface | Network interface to set-up | - | eth0 | False
delay_time | Delay time, input with time unit, ex: 100ms | - | - | True
margin_time | Delay time with margin, Delay=${delay_time} ± ${margin_time}, input with time unit, ex: 100ms | - | - | True
probability | (1)Delay time with margin/(2)Packet corrupt/(3)Packet loss/(4)Packet misorder base on the given probability, input probability with %, ex: 25% | - | - | True 
distribution_type | Delay time with margin distribution | uniform <br> normal <br> pareto <br> paretonormal | - | True
correlation_probability | The correlation probability (If correlation_probability=25%, Probn=0.25*Probn-1 + 0.75*Random) | - | - | True
no_delay_index_mod_base | No delay for packet index % ${no_delay_index_mod_base}=0, others delay with ${delay_time} and misorder with certain probability | - | - | True
network_rate_limit | Network rate limit, input in speed unit, ex: 256kbit | - | - | True

#### netem - Delay with specific time
```
- include_tasks: tasks/netem-delay.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    delay_time: ${delay_time}
```

#### netem - Delay with margin
```
- include_tasks: tasks/netem-delay-margin.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    delay_time: ${delay_time}
    margin_time: ${margin_time}
```

#### netem - Delay with margin probability
```
- include_tasks: tasks/netem-delay-margin-probability.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    delay_time: ${delay_time}
    margin_time: ${margin_time}
    probability: ${probability}
```

#### netem - Delay with margin distribution
```
- include_tasks: tasks/netem-delay-margin-distribution.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    delay_time: ${delay_time}
    margin_time: ${margin_time}
    distribution_type: ${distribution_type}
```

#### netem - Packet corrupt
```
- include_tasks: tasks/netem-packet-corrupt.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    probability: ${probability}
```

#### netem - Packet loss
```
- include_tasks: tasks/netem-packet-loss.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    probability: ${probability}
```

#### netem - Packet loss with burst
```
- include_tasks: tasks/netem-packet-loss-burst.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    probability: ${probability}
    correlation_probability: ${correlation_probability}
```

#### netem - Packet misorder with specific gap
```
- include_tasks: tasks/netem-packet-misorder-gap.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    packet_nodelay_index_mod_base: ${no_delay_index_mod_base}
    delay_time: ${delay_time}
    probability: ${probability}
    correlation_probability: ${correlation_probability}
```

#### netem - Packet misorder with probability
```
- include_tasks: tasks/netem-packet-misorder-probability.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    probability: ${probability}
    correlation_probability: ${correlation_probability}
```

#### netem - Packet duplicate
```
- include_tasks: tasks/netem-packet-duplicate.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    probability: ${probability}
```

#### netem - Network rate limit control
```
- include_tasks: tasks/netem-network-rate-control.yml
  vars:
    action: ${action}
    network_interface: ${network_interface}
    delay_time: ${delay_time}
    network_rate_limit: ${network_rate_limit}
```

#### netem - Clear all
```
- include_tasks: tasks/netem-clear-all.yml
  vars:
    network_interface: ${network_interface}
```

### Network Connectivity - wondershaper

#### wondershaper common variables
Variables | Description | Optional values | Default values | Required
--------- | ----------- | --------------- | -------------- | --------
network_interface | Network interface to set-up | - | eth0 | False
network_download_limit | Network download limit in kbps | - | 4096 | False
network_upload_limit | Network upload limit in kbps | - | 4096 | False

#### wondershaper - Network rate limit control
```
- include_tasks: tasks/wondershaper-rate-control.yml
  vars:
    network_interface: ${network_interface}
    network_download_limit: ${network_download_limit}
    network_upload_limit: ${network_upload_limit}
```

#### wondershaper - Clear all
```
- include_tasks: tasks/wondershaper-clear-all.yml
  vars:
    network_interface: ${network_interface}
```

### Benchmarking - sysbench

#### Common variables
Variables | Description | Optional values | Default values | Required
--------- | ----------- | --------------- | -------------- | --------
max_prime | Max prime to calculate while CPU load test | - | - | True
time_sec | Max time in seconds for CPU load test | - | 0 | False
threads | Threads to do load test | - | 1 | False
block_size | Memory/File block size | - | 1K/16K | False
total_size | Memory/File total size | - | 100G/2G | False
operation | Memory test mechanism | read <br> write | write | False
access_mode | Memory access with sequence(seq) or random(rnd) | seq <br> rnd | seq | False
scope | Scope to execute memory load test | global <br> local | global | False
file_num | File volume to generate | - | 128 | False
test_mode | File I/O test mode | - | seqwr <br> seqrewr <br> seqrd <br> rndrd <br> rndwr <br> rndrw | False
rw_ratio | File I/O ratio(Read/Write) | - | 1.5 | False

#### CPU
```
- include_tasks: tasks/sysbench-cpu.yml
  vars:
    max_prime: ${max_prime}
    time_sec: ${time_sec}
    threads: ${threads}
```

#### Memory
```
- include_tasks: tasks/sysbench-memory.yml
  vars:
    block_size: ${block_size}
    total_size: ${total_size}
    operation: ${operation}
    access_mode: ${access_mod}
    scope: ${scope}
    threads: ${threads}
```

#### File I/O
```
- include_tasks: tasks/sysbench-fileio.yml
  vars:
    file_num: ${file_num}
    block_size: ${block_size}
    total_size: ${total_size}
    test_mode: ${test_mode}
    rw_ratio: ${rw_ratio}
    threads: ${threads}
```

