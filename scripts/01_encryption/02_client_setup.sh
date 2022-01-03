# 1) Generate a truststore for clients
keytool -keystore kafka.client.truststore.jks \
  -alias CARoot \
  -import -file ca-cert \
  -storepass clientsecret \
  -keypass clientsecret \
  -noprompt

keytool -list -v -keystore kafka.client.truststore.jks

# 2) configure client properties

# 3) Verify connection between clients and brokers
kafka-console-producer --bootstrap-server ec2-54-158-166-68.compute-1.amazonaws.com:8092 \
  --topic test \
  --producer.config client.properties

kafka-console-consumer --bootstrap-server ec2-54-158-166-68.compute-1.amazonaws.com:8092 \
                       --topic test --consumer.config client.properties

# Result for failure connection SSL handshake
#[2022-01-03 07:53:44,095] INFO [Partition test-0 broker=1] Log loaded for partition test-0 with initial high watermark 0 (kafka.cluster.Partition)
#[2022-01-03 07:54:45,628] INFO [SocketServer listenerType=ZK_BROKER, nodeId=1] Failed authentication with /171.96.190.140 (SSL handshake failed) (org.apache.kafka.common.network.Selector)
