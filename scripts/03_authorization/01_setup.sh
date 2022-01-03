# 1.) configure Kafka's brokers to support ACLs
# apply server01.properties to your Kafka's brokers

# 2.) Create a topic
kafka-topics --bootstrap-server ec2-54-158-166-68.compute-1.amazonaws.com:8092 --create \
  --topic acl-test \
  --partitions 1 \
  --replication-factor 1

# 3.) create ACLs

# 4.) ACLs validation
