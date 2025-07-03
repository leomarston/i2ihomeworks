# Kafka Java Producer & Consumer

Simple example: `StudentProducer` sends Student objects to a Kafka topic, `StudentConsumer` reads them and prints them.

## Requirements
- Java
- Maven
- Docker

## Run Kafka
```bash
docker-compose up -d
docker exec -it <kafka_container_id> bash
kafka-topics --create --topic students-topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

Run StudentConsumer.java

![image](https://github.com/user-attachments/assets/5acea99c-59f8-4110-b456-07b7438e79be)

Run StudentProducer.java

![image](https://github.com/user-attachments/assets/f0139628-6c39-47e0-9802-3ab88f95dba4)

![image](https://github.com/user-attachments/assets/07117f79-d53e-4770-9fec-421766fa1259)
