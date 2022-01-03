openssl req -new -newkey rsa:4096 \
  -days 365 \
  -x509 \
  -subj "/CN=Kafka.Security-CA" \
  -keyout ca-key \
  -out ca-cert \
  -nodes
