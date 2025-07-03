package example;

import org.apache.kafka.common.serialization.Serializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Map;

public class StudentSerializer implements Serializer<Student> {

    private final ObjectMapper objectMapper = new ObjectMapper();

    // public no-argument constructor
    public StudentSerializer() {}

    @Override
    public void configure(Map<String, ?> configs, boolean isKey) {
        // no configuration needed
    }

    @Override
    public byte[] serialize(String topic, Student data) {
        try {
            if (data == null)
                return null;
            return objectMapper.writeValueAsBytes(data);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void close() {
        // no resources to close
    }
}
