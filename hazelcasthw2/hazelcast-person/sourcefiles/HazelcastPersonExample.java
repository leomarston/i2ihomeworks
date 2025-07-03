package com.example.hazelcast;
import com.hazelcast.client.HazelcastClient;
import com.hazelcast.client.config.ClientConfig;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.map.IMap;

public class HazelcastPersonExample {

    public static void main(String[] args) {
        ClientConfig clientConfig = new ClientConfig();
        clientConfig.getNetworkConfig().addAddress("172.31.44.131:5701"); // Use private IP inside cloud

        HazelcastInstance client = HazelcastClient.newHazelcastClient(clientConfig);

        IMap<Integer, Person> map = client.getMap("personsMap");

        for (int i = 0; i < 10000; i++) {
            map.put(i, new Person("Person_" + i));
        }
        System.out.println("Inserted 10,000 Person objects into Hazelcast map.");

        for (int i = 0; i < 10; i++) {
            Person p = map.get(i);
            System.out.println("Key " + i + " -> " + p);
        }

        client.shutdown();
    }
}
