package org.daimongkol.kafka;

import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;

import java.util.Date;
import java.util.Properties;

@Slf4j
public class ProducerDemo {

    public static final String TOPIC = "learning.helloworld";
    public static final String MESSAGE = "this is from java producer " + new Date();

    public static void main(String[] args) {
        // Create producer producerProps
        // https://kafka.apache.org/documentation/#producerconfigs
        Properties producerProps = new Properties();
        producerProps.setProperty(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "127.0.0.1:9092");
        producerProps.setProperty(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        producerProps.setProperty(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());

        // Create producer
        KafkaProducer<String, String> producer = new KafkaProducer<String, String>(producerProps);

        // Build a record
        ProducerRecord<String, String> record = new ProducerRecord<String, String>(TOPIC, MESSAGE);

        // Send data
        producer.send(record);

        producer.flush();
        producer.close();
    }
}
