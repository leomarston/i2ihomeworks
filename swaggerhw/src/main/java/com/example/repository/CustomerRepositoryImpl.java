package com.example.repository;

import com.example.model.Customer;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@Repository
public class CustomerRepositoryImpl implements CustomerRepository {
    
    private final Map<Long, Customer> customers = new ConcurrentHashMap<>();
    private final AtomicLong idGenerator = new AtomicLong(1);
    
    public CustomerRepositoryImpl() {
        // Initialize with some sample data
        Customer customer1 = new Customer(1L, "John Doe", "john.doe@example.com");
        Customer customer2 = new Customer(2L, "Jane Smith", "jane.smith@example.com");
        Customer customer3 = new Customer(3L, "Bob Johnson", "bob.johnson@example.com");
        
        customers.put(1L, customer1);
        customers.put(2L, customer2);
        customers.put(3L, customer3);
        
        idGenerator.set(4L); // Set next ID to 4
    }
    
    @Override
    public List<Customer> findAll() {
        return new ArrayList<>(customers.values());
    }
    
    @Override
    public Optional<Customer> findById(Long id) {
        return Optional.ofNullable(customers.get(id));
    }
    
    @Override
    public Customer save(Customer customer) {
        if (customer.getId() == null) {
            // Create new customer
            customer.setId(idGenerator.getAndIncrement());
            customer.setCreatedAt(LocalDateTime.now());
            customer.setUpdatedAt(LocalDateTime.now());
        } else {
            // Update existing customer
            customer.setUpdatedAt(LocalDateTime.now());
        }
        customers.put(customer.getId(), customer);
        return customer;
    }
    
    @Override
    public void deleteById(Long id) {
        customers.remove(id);
    }
    
    @Override
    public boolean existsById(Long id) {
        return customers.containsKey(id);
    }
    
    @Override
    public boolean existsByEmail(String email) {
        return customers.values().stream()
                .anyMatch(customer -> customer.getEmail().equalsIgnoreCase(email));
    }
    
    @Override
    public long count() {
        return customers.size();
    }
} 