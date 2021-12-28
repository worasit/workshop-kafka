https://kafka.apache.org/documentation/#consumerconfigs

# Messages would not show in order, since we have 3 partitions
kafka-console-consumer --bootstrap-server localhost:9092 \
                       --topic learning.helloworld \
                       --from-beginning # Optional

# NOTE: You 1 partition to guarantee this