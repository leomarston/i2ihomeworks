package com.baeldung.spring_boot_intro.exception;

public class BookNotFoundException extends RuntimeException {
    public BookNotFoundException(String s) {
        super("Book not found");
    }
}
