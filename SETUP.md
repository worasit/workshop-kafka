# Setup Guide

### Prerequisite

- Java 8 `brew cask install java8`
- Kafka Binaries : [kafka_2.13-3.0.0](./kafka_2.13-3.0.0)

### Install Kafka Locally using Homebrew

```shell
#(Optional) Download Kafka binaries or use the existing one in repo (The current stable version is 3.0.0.)
https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz

# Install Kafka's CLI and Services
brew install kafka

# Stop all kafka background services from Homebrew
brew services stop kafka
brew services stop zookeeper

# Start Zookeeper (new terminal)
zookeeper-server-start kafka_2.13-3.0.0/config/zookeeper.properties

# Start Kafka's broker (new terminal)
kafka-server-start kafka_2.13-3.0.0/config/server.properties 
```

