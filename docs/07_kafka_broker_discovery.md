# Kafka Broker Discovery

- Every Kafka broker is also called a `bootstrap server`
- That means that `you only need to cnnect to one broker` and you will be connected to the entire cluster.
- Each broker knows about all brokers, topics and partitions (metadata)