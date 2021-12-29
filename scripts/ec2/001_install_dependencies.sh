# Install machine dependencies
sudo apt-get install -y wget net-tools netcat tar openjdk-8-jdk

# Install kafka package
wget http://mirror.softaculous.com/apache/kafka/3.0.0/kafka_2.13-3.0.0.tgz
tar -xzf kafka_2.13-3.0.0.tgz
ln -s kafka_2.13-3.0.0 kafka

# Start Zookeeper
kafka/bin/zookeeper-server-start.sh -daemon kafka/config/zookeeper.properties
tail -n 20 ~/kafka/logs/zookeeper.out

# Validate connection
telnet localhost 2181

# Start Kafka's broker
kafka/bin/kafka-server-start.sh -daemon kafka/config/server.properties
tail -n 20 ~/kafka/logs/kafkaServer.out


