https://kafka.apache.org/documentation/#producerconfigs

# Start producing messages to Kafka cluster
kafka-console-producer --bootstrap-server localhost:9092 \
                       --topic learning.helloworld \
                       --producer-property "acks=all"