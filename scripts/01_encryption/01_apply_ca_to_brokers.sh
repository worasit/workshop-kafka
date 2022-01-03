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
# use the server01.properties as an example

#3.) Test SSL encryption
openssl s_client -connect ec2-54-158-166-68.compute-1.amazonaws.com:8092

# if a connect is failed to establish, please make sure the in-bound rules has been configured properly.

# Expected result
#CONNECTED(00000005)
#4435783340:error:1400410B:SSL routines:CONNECT_CR_SRVR_HELLO:wrong version number:/System/Volumes/Data/SWE/macOS/BuildRoots/2288acc43c/Library/Caches/com.apple.xbs/Sources/libressl/libressl-56.60.2/libressl-2.8/ssl/ssl_pkt.c:386:
#---
#no peer certificate available
#---
#No client certificate CA names sent
#---
#SSL handshake has read 5 bytes and written 0 bytes
#---
#New, (NONE), Cipher is (NONE)
#Secure Renegotiation IS NOT supported
#Compression: NONE
#Expansion: NONE
#No ALPN negotiated
#SSL-Session:
#    Protocol  : TLSv1.2
#    Cipher    : 0000
#    Session-ID:
#    Session-ID-ctx:
#    Master-Key:
#    Start Time: 1641193340
#    Timeout   : 7200 (sec)
#    Verify return code: 0 (ok)
#---
