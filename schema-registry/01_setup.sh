# https://confluent.cloud/environments/env-3zjzo/clusters/lkc-z2nkd/topics/orders/schema/value

# Producer : https://docs.confluent.io/5.4.1/schema-registry/schema_registry_tutorial.html#java-producers
confluent kafka topic produce orders --value-format protobuf --schema /Users/worasit.daimongkol/Repositories/learning/workshop-kafka/schema-registry/schema-orders-value-v1.proto

# {"orderId":2122453,"orderTime":1607641868,"orderAddress":"899 W Evelyn Ave, Mountain View, CA 94041"}

confluent kafka topic produce orders --value-format protobuf --schema /Users/worasit.daimongkol/Repositories/learning/workshop-kafka/schema-registry/schema-orders-value-v2.proto
# {"orderId":2122453,"orderTime":1607641868,"orderAddress":"899 W Evelyn Ave, Mountain View, CA 94041","orderStatus":"COMPLETED"}

# Consumer : https://docs.confluent.io/5.4.1/schema-registry/schema_registry_tutorial.html#java-consumers
confluent kafka topic consume orders --value-format protobuf --from-beginning

# Update compatibility rules to validate forward
