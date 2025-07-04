package com.example.service;

import com.example.dto.CustomerDTO;
import java.util.List;
import java.util.Optional;

public interface CustomerService {

    List<CustomerDTO> getAllCustomers();

    Optional<CustomerDTO> getCustomerById(Long id);

    CustomerDTO createCustomer(CustomerDTO customerDTO);

    Optional<CustomerDTO> updateCustomer(Long id, CustomerDTO customerDTO);

    boolean deleteCustomer(Long id);

    boolean existsById(Long id);

    boolean existsByEmail(String email);

    long getCustomerCount();
}