package com.baeldung.spring_boot_intro.exception;

public class BookIdMismatchException extends RuntimeException {
    public BookIdMismatchException(String s) {
        super("Book ID mismatch");
    }
}
