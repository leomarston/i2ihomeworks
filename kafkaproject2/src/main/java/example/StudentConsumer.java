package example;

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.serialization.Deserializer;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.Duration;
import java.util.Collections;
import java.util.Map;
import java.util.Properties;


public class StudentConsumer {
    public static void main(String[] args) {
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9092");
        props.put("group.id", "student-group");
        props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        props.put("value.deserializer", "example.StudentDeserializer");
        props.put("auto.offset.reset", "earliest");

        KafkaConsumer<String, Student> consumer = new KafkaConsumer<>(props);
        consumer.subscribe(Collections.singletonList("students-topic"));

        System.out.println("Waiting for messages...");
        while (true) {
            ConsumerRecords<String, Student> records = consumer.poll(Duration.ofMillis(100));
            for (ConsumerRecord<String, Student> record : records) {
                System.out.printf("Consumed: key = %s, value = %s%n", record.key(), record.value());
            }
        }
    }
}
