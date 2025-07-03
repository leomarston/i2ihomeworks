# Hazelcast Person Example

This is a simple Java project that demonstrates how to use Hazelcast to store and retrieve `Person` objects in a distributed map.

## Exercise: HAZELCAST-EX-03

**Goal:**  
- Connect to the Hazelcast server running on your remote machine.
- Insert 10,000 dummy `Person` objects into a Hazelcast map.
- Retrieve and print a few of them to verify.

## Project Structure

hazelcast-person/
├── pom.xml
├── src/
│ └── main/
│ └── java/
│ └── com/
│ └── example/
│ └── hazelcast/
│ ├── Person.java
│ └── HazelcastPersonExample.java
└── README.md

## Prerequisites

- Java 11+ installed
- Maven installed
- Hazelcast server running on your EC2 instance (port 5701)

## How to Run

1. **Edit your `HazelcastPersonExample` to match your Hazelcast server IP:**
   ```java
   clientConfig.getNetworkConfig().addAddress("YOUR_SERVER_IP:5701");
   
Build and run the project:
mvn clean compile exec:java -U


Expected output:

Inserts 10,000 Person objects

Prints a few retrieved Person entries from the map


![image](https://github.com/user-attachments/assets/c251f1e7-1fa8-4222-83cf-5fe95da7e6b0)

