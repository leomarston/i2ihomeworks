package example;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.Serializer;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.Map;
import java.util.Properties;


public class StudentProducer {
    public static void main(String[] args) {
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9092");
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "example.StudentSerializer");

        KafkaProducer<String, Student> producer = new KafkaProducer<>(props);

        Student student = new Student(1, "Alice");
        producer.send(new ProducerRecord<>("students-topic", "student1", student));

        System.out.println("Produced: " + student);

        producer.close();
    }
}
