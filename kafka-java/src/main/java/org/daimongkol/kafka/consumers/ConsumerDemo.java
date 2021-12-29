package org.daimongkol.kafka.consumers;

import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.serialization.StringDeserializer;

import java.time.Duration;
import java.util.Collections;
import java.util.Properties;

@Slf4j
public class ConsumerDemo {

    public static final String TOPIC = "learning.helloworld";
    public static final String CONSUMER_GROUP_ID = "java-consumer-group-1";

    public static void main(String[] args) {
        // https://kafka.apache.org/documentation/#consumerconfigs
        Properties consumerProps = new Properties();
        consumerProps.setProperty(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, "127.0.0.1:9092");
        consumerProps.setProperty(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        consumerProps.setProperty(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        consumerProps.setProperty(ConsumerConfig.GROUP_ID_CONFIG, CONSUMER_GROUP_ID);
        consumerProps.setProperty(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");

        // Create a consumer
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(consumerProps);

        // Subscribe consumer to our topic
        consumer.subscribe(Collections.singletonList(TOPIC));

        while (true) {
            ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(500));
            records.forEach(record -> {
                log.info("topic: " + record.topic());
                log.info("partition: " + String.valueOf(record.partition()));
                log.info("key: " + record.key());
                log.info("value: " + record.value());
            });
        }
    }
}
