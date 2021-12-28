package org.daimongkol.kafka;

import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.producer.*;
import org.apache.kafka.common.serialization.StringSerializer;

import java.util.Date;
import java.util.Properties;

@Slf4j
public class ProducerCallbackWithKeyDemo {

    public static final String TOPIC = "learning.helloworld";


    public static void main(String[] args) throws InterruptedException {
        // Create producer producerProps
        // https://kafka.apache.org/documentation/#producerconfigs
        Properties producerProps = new Properties();
        producerProps.setProperty(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "127.0.0.1:9092");
        producerProps.setProperty(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        producerProps.setProperty(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());

        // Create producer
        KafkaProducer<String, String> producer = new KafkaProducer<String, String>(producerProps);

        // Send data
        for (int key = 0; key < 10; key++) {
            // Build a record
            // id_1 => partition 0
            // id_8 => partition 1
            // id_2 => partition 2
            String KEY = String.format("id_%d", 8);
            final String MESSAGE = "this is from java producer " + new Date();
            ProducerRecord<String, String> record = new ProducerRecord<String, String>(TOPIC, KEY, MESSAGE);
            producer.send(record, new Callback() {
                public void onCompletion(RecordMetadata recordMetadata, Exception e) {
                    if (e == null) {
                        log.info("topic: " + recordMetadata.topic());
                        log.info("partition: " + recordMetadata.partition());
                        log.info("offset: " + recordMetadata.offset());
                        log.info("timestamp: " + recordMetadata.timestamp());
                    } else {
                        log.error("Error while producing", e);
                    }
                }
            });

            Thread.sleep(1000);
        }

        producer.flush();
        producer.close();

    }
}
