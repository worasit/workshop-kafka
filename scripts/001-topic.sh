https://kafka.apache.org/documentation/#topicconfigs

# Create a topic
kafka-topics --bootstrap-server localhost:9092 --create \
             --topic learning.helloworld \
             --partitions 3 \
             --replication-factor 1

# List topics
kafka-topics --bootstrap-server localhost:9092 --list

# Describe a topic
kafka-topics --bootstrap-server localhost:9092 --describe \
             --topic learning.helloworld

# Delete a topic
kafka-topics --bootstrap-server localhost:9092 --delete \
             --topic learning.helloworld