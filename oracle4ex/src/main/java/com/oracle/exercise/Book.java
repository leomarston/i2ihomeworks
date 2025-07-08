package com.oracle.exercise;

/**
 * Book entity class representing a book with name and ISBN
 */
public class Book {
    
    private int id;
    private String name;
    private String isbn;
    
    /**
     * Default constructor
     */
    public Book() {
    }
    
    /**
     * Constructor with name and ISBN
     * @param name Book name
     * @param isbn Book ISBN
     */
    public Book(String name, String isbn) {
        this.name = name;
        this.isbn = isbn;
    }
    
    /**
     * Constructor with all fields
     * @param id Book ID
     * @param name Book name
     * @param isbn Book ISBN
     */
    public Book(int id, String name, String isbn) {
        this.id = id;
        this.name = name;
        this.isbn = isbn;
    }
    
    // Getters and Setters
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getIsbn() {
        return isbn;
    }
    
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", isbn='" + isbn + '\'' +
                '}';
    }
}