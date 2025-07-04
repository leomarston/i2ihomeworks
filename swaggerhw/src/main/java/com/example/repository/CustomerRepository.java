package com.example.repository;

import com.example.model.Customer;
import java.util.List;
import java.util.Optional;

public interface CustomerRepository {

    List<Customer> findAll();

    Optional<Customer> findById(Long id);

    Customer save(Customer customer);

    void deleteById(Long id);

    boolean existsById(Long id);

    boolean existsByEmail(String email);

    long count();
}