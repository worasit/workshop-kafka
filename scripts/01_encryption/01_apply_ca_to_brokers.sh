#1.) Configure keystore & truststore for brokers

#================== keystore ===========================#
## Generate keystore
keytool -genkey -keystore kafka.server.keystore.jks \
  -validity 365 \
  -storepass brokersecret \
  -keypass brokersecret \
  -dname "CN=ec2-34-198-46-219.compute-1.amazonaws.com" \
  -storetype pkcs12

## View keystore
keytool -list -v -keystore kafka.server.keystore.jks

## generate cert-req (request a cert)
keytool -keystore kafka.server.keystore.jks \
  -certreq \
  -file cert-file \
  -storepass brokersecret \
  -keypass brokersecret

## sign a cert
openssl x509 -req -CA ca-cert \
  -CAkey ca-key \
  -in cert-file \
  -out cert-signed \
  -days 365 \
  -CAcreateserial \
  -passin pass:brokersecret

## view a signed cert
keytool -printcert -v -file cert-signed

#====================== truststore ==============================#
## create a truststore
keytool -keystore kafka.server.truststore.jks \
  -alias CARoot \
  -import -file ca-cert \
  -storepass brokersecret \
  -keypass brokersecret \
  -noprompt

## import a ca-cert to keystore
keytool -keystore kafka.server.keystore.jks \
  -alias CARoot \
  -import -file ca-cert \
  -storepass brokersecret \
  -keypass brokersecret \
  -noprompt

keytool -list -v -keystore kafka.server.keystore.jks

## import a signed-cert to keystore
keytool -keystore kafka.server.keystore.jks \
  -import -file cert-signed \
  -storepass brokersecret \
  -keypass brokersecret \
  -noprompt

## View keystore (expected to see 2 certificates)
keytool -list -v -keystore kafka.server.keystore.jks

#2.) Configure brokers to use SSL on the specific ports
sudo grep "EndPoint" /home/ubuntu/kafka/logs/server.log

#3.) Test SSL encryption
openssl s_client -connect ec2-34-205-162-147.compute-1.amazonaws.com:8092
