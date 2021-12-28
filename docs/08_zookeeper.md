# Zookeeper

- Manages brokers (keeps a list of them)
- Help in performing leader election for partitions
- Sends notification to Kafka in case of changes (e.g. new topic, broker dies, broker comes up, delete topics,etc.)
- Kafka `can't work without Zookeeper`
- Zookeeper by design operates with an odd number of servers (3,5,7)
- Zookeeper has a leader (handle writes) the rest of the servers are followers(handle reads)