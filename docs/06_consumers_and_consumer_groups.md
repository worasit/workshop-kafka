# Consumer & Consumer Groups

## Consumers

- Consumers read data from a topic (identified by name)
- Consumers know which broker to read from
- In case of broker failures, consumers know how to recover
- Data is read in order `within each partitions`

## Consumer Groups

- Consumers read data in consumer groups
- Each consumer within a group reads from exclusive partitions
- If you have more consumers than partitions, some consumers will be inactive
    - Normal: `Consumers <= Partitions`
    - Best : `Consumers == Partitions`

## Consumer Offsets

- Kafka stores the offsets at which consumer group has been reading
- The offsets committed live in a Kafka topic named `__consumer__offsets`
- When a consumers in a group has processed data received from Kafka, it should be committing the offsets
- If a consumer dies, it will be able to read back from where it left off

## Delivery Semantics for Consumers

- _**At most once**_:
    - offset are committed as soon as the `message is received.`
    - If the processing goes wrong, the message will be lost (it won't be read again).
- **_At least once (usually preferred)_**
    - offsets are committed after the `message is processed.`
    - If the processing goes wrong, the message will be read again.
    - This can result in duplicate processing of message. Make sure your processing is `idempotent` (i.e. processing
      again the messages won't impact your systems)
- **_Exactly once:_**
    - Can be achieved for Kafka => Kafka workflows using Kafka Streams API
    - For Kafka => External System workflows, use an `idempotent` consumer.