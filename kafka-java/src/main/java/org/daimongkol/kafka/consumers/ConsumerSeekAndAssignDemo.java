package org.daimongkol.kafka.consumers;

import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.TopicPartition;
import org.apache.kafka.common.serialization.StringDeserializer;

import java.time.Duration;
import java.util.Arrays;
import java.util.Collections;
import java.util.Properties;

// Replay messages purpose
@Slf4j
public class ConsumerSeekAndAssignDemo {

    public static final String TOPIC = "learning.helloworld";
    public static final int PARTITION = 0;
    //    public static final String CONSUMER_GROUP_ID = "java-consumer-group-2";

    public static void main(String[] args) {
        // https://kafka.apache.org/documentation/#consumerconfigs
        Properties consumerProps = new Properties();
        consumerProps.setProperty(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, "127.0.0.1:9092");
        consumerProps.setProperty(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        consumerProps.setProperty(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());

        // Don't need this
        // consumerProps.setProperty(ConsumerConfig.GROUP_ID_CONFIG, CONSUMER_GROUP_ID);

        consumerProps.setProperty(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");

        // Create a consumer
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(consumerProps);


        // Assign and Seek
        TopicPartition topicPartition = new TopicPartition(TOPIC, PARTITION);
        consumer.assign(Arrays.asList(topicPartition));

        int offsetToStartReading = 100;
        consumer.seek(topicPartition, offsetToStartReading);

        // Polling records
        while (true) {
            ConsumerRecords<String, String> consumerRecords = consumer.poll(Duration.ofMillis(500));
            consumerRecords.forEach(consumerRecord -> {
                log.info("topic: " + consumerRecord.topic());
                log.info("offset: " + consumerRecord.offset());
                log.info("partition: " + consumerRecord.partition());
                log.info("key: " + consumerRecord.key());
                log.info("value: " + consumerRecord.value());
            });
        }
    }
}
