https://kafka.apache.org/documentation/#topicconfigs
#ec2-34-198-46-219.compute-1.amazonaws.com

# Create a topic
kafka-topics --bootstrap-server localhost:9092 --create \
             --topic workshop.kafka.basic \
             --partitions 1 \
             --replication-factor 1

# List topics
kafka-topics --bootstrap-server localhost:9092 --list

# Describe a topic
kafka-topics --bootstrap-server localhost:9092 --describe \
             --topic learning.helloworld

# Delete a topic
kafka-topics --bootstrap-server localhost:9092 --delete \
             --topic learning.helloworld