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

Run StudentProducer.java

