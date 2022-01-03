# 1.) generate keystore for clients
keytool -genkey -keystore kafka.client.keystore.jks \
  -validity 365 \
  -storepass clientsecret \
  -keypass clientsecret \
  -dname "CN=local-laptop" \
  -alias local-laptop \
  -storetype pkcs12

keytool -list -v -keystore kafka.client.keystore.jks

# generate client cert request for client.keystore
keytool -keystore kafka.client.keystore.jks \
  -certreq \
  -file client-cert-signed-request \
  -alias local-laptop \
  -storepass clientsecret \
  -keypass clientsecret

# sign a client's certificate (Basically do this on the CA server)
openssl x509 -req -CA ca-cert \
  -CAkey ca-key \
  -in client-cert-signed-request \
  -out client-cert-signed \
  -days 365 \
  -CAcreateserial \
  -passin pass:brokersecret

# import ca-cert
keytool -keystore kafka.client.keystore.jks \
  -alias CARoot \
  -import -file ca-cert \
  -storepass clientsecret \
  -keypass clientsecret \
  -noprompt

# import client-cert-signed
keytool -keystore kafka.client.keystore.jks \
  -alias local-laptop \
  -import -file client-cert-signed \
  -storepass clientsecret \
  -keypass clientsecret \
  -noprompt

keytool -list -v -keystore kafka.client.keystore.jks

# 2.) configure Kafka's brokers to requires SSL authentication
# https://kafka.apache.org/documentation/#brokerconfigs_ssl.client.auth
# ssl.client.auth=required

# 3.) SSL Authentication verification
kafka-console-consumer --bootstrap-server ec2-54-158-166-68.compute-1.amazonaws.com:8092 \
  --topic test \
  --consumer.config client.properties

# SslAuthenticationException: SSL handshake failed << Expected failed when make a connection
#[2022-01-03 16:14:02,067] ERROR [Consumer clientId=consumer-console-consumer-95684-1, groupId=console-consumer-95684] Connection to node -1 (ec2-54-158-166-68.compute-1.amazonaws.com/54.158.166.68:8092) failed authentication due to: SSL handshake failed (org.apache.kafka.clients.NetworkClient)
#[2022-01-03 16:14:02,067] WARN [Consumer clientId=consumer-console-consumer-95684-1, groupId=console-consumer-95684] Bootstrap broker ec2-54-158-166-68.compute-1.amazonaws.com:8092 (id: -1 rack: null) disconnected (org.apache.kafka.clients.NetworkClient)
#[2022-01-03 16:14:02,071] ERROR Error processing message, terminating consumer process:  (kafka.tools.ConsoleConsumer$)
#org.apache.kafka.common.errors.SslAuthenticationException: SSL handshake failed
#Caused by: javax.net.ssl.SSLProtocolException: Unexpected handshake message: server_hello
#	at java.base/sun.security.ssl.Alert.createSSLException(Alert.java:129)
#	at java.base/sun.security.ssl.Alert.createSSLException(Alert.java:117)
#	at java.base/sun.security.ssl.TransportContext.fatal(TransportContext.java:357)
#	at java.base/sun.security.ssl.TransportContext.fatal(TransportContext.java:313)
#	at java.base/sun.security.ssl.TransportContext.fatal(TransportContext.java:304)
#	at java.base/sun.security.ssl.HandshakeContext.dispatch(HandshakeContext.java:474)
#	at java.base/sun.security.ssl.SSLEngineImpl$DelegatedTask$DelegatedAction.run(SSLEngineImpl.java:1277)
#	at java.base/sun.security.ssl.SSLEngineImpl$DelegatedTask$DelegatedAction.run(SSLEngineImpl.java:1264)
#	at java.base/java.security.AccessController.doPrivileged(AccessController.java:712)
#	at java.base/sun.security.ssl.SSLEngineImpl$DelegatedTask.run(SSLEngineImpl.java:1209)
#	at org.apache.kafka.common.network.SslTransportLayer.runDelegatedTasks(SslTransportLayer.java:430)
#	at org.apache.kafka.common.network.SslTransportLayer.handshakeUnwrap(SslTransportLayer.java:514)
#	at org.apache.kafka.common.network.SslTransportLayer.doHandshake(SslTransportLayer.java:368)
#	at org.apache.kafka.common.network.SslTransportLayer.handshake(SslTransportLayer.java:291)
#	at org.apache.kafka.common.network.KafkaChannel.prepare(KafkaChannel.java:178)
#	at org.apache.kafka.common.network.Selector.pollSelectionKeys(Selector.java:543)
#	at org.apache.kafka.common.network.Selector.poll(Selector.java:481)
#	at org.apache.kafka.clients.NetworkClient.poll(NetworkClient.java:551)
#	at org.apache.kafka.clients.consumer.internals.ConsumerNetworkClient.poll(ConsumerNetworkClient.java:265)
#	at org.apache.kafka.clients.consumer.internals.ConsumerNetworkClient.poll(ConsumerNetworkClient.java:236)
#	at org.apache.kafka.clients.consumer.internals.ConsumerNetworkClient.poll(ConsumerNetworkClient.java:215)
#	at org.apache.kafka.clients.consumer.internals.AbstractCoordinator.ensureCoordinatorReady(AbstractCoordinator.java:246)
#	at org.apache.kafka.clients.consumer.internals.ConsumerCoordinator.poll(ConsumerCoordinator.java:480)
#	at org.apache.kafka.clients.consumer.KafkaConsumer.updateAssignmentMetadataIfNeeded(KafkaConsumer.java:1262)
#	at org.apache.kafka.clients.consumer.KafkaConsumer.poll(KafkaConsumer.java:1231)
#	at org.apache.kafka.clients.consumer.KafkaConsumer.poll(KafkaConsumer.java:1211)
#	at kafka.tools.ConsoleConsumer$ConsumerWrapper.receive(ConsoleConsumer.scala:454)
#	at kafka.tools.ConsoleConsumer$.process(ConsoleConsumer.scala:101)
#	at kafka.tools.ConsoleConsumer$.run(ConsoleConsumer.scala:75)
#	at kafka.tools.ConsoleConsumer$.main(ConsoleConsumer.scala:52)
#	at kafka.tools.ConsoleConsumer.main(ConsoleConsumer.scala)
#Processed a total of 0 messages
