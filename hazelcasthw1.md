
1: Runs a Docker container named 'hazelcast' with the latest Hazelcast image, mapping port 5701 for a distributed data grid instance, using '--name' for identification and '-p' for port access.

![1](https://github.com/user-attachments/assets/1be6d8eb-9a62-46d9-baa9-1d2c5030d2c9)

2: Pulls the latest Hazelcast image from the registry, showing progress and a digest hash for integrity.

![2](https://github.com/user-attachments/assets/85f4d875-73e9-45da-a697-de6861be9d94)

3: Launches a 'management-center' container with the latest Hazelcast Management Center image, mapping port 8080 for cluster monitoring, using '--name' and '-p' for configuration.

![3](https://github.com/user-attachments/assets/40b2f656-09da-4c45-83ba-2db14090dd9f)

4: Pulls the latest Management Center image from the registry, displaying progress and a digest hash for verification.

![5](https://github.com/user-attachments/assets/8e4c75e1-a627-4ec9-8c60-7bc76cec9aa3)

5: Executes 'docker ps' to list active containers, showing IDs, images, commands, creation time, status, and port mappings to confirm Hazelcast and Management Center are running.

![6](https://github.com/user-attachments/assets/97f0c24b-3f7a-4ce7-a685-c029cf977276)
