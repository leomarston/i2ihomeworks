package com.baeldung.spring_boot_intro.repository;

import com.baeldung.spring_boot_intro.model.Book;
import org.springframework.data.repository.CrudRepository;
import java.util.List;

public interface BookRepository extends CrudRepository<Book, Long> {
    List<Book> findByTitle(String title);
}
