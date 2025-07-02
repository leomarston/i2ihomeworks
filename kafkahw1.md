
1: Sets up a ZooKeeper container with confluentinc/cp-zookeeper:7.2.15, named 'zookeeper', port 2181, and ZOOKEEPER_TICK_TIME=2000.

2: Configures a Kafka container with confluentinc/cp-kafka:7.2.15, named 'kafka', ports 9092 and 9093, broker ID 1, ZooKeeper connection zookeeper:2181, and replication factor 1.

![1](https://github.com/user-attachments/assets/069cd633-6c09-4a8f-943c-274b369460b6)

3: Runs 'docker compose up -d' to start ZooKeeper and Kafka in detached mode.

4: Lists running containers with 'docker ps', showing ZooKeeper and Kafka with IDs, images, statuses, and ports.

![3](https://github.com/user-attachments/assets/f0147148-fe1e-4ffd-95ce-8e7e421dd0a5)
