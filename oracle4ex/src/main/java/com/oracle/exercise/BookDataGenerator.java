package com.oracle.exercise;

import java.util.Random;

/**
 * Utility class for generating random book data
 */
public class BookDataGenerator {
    
    private static final Random random = new Random();
    
    // Sample book titles parts for generating random names
    private static final String[] BOOK_PREFIXES = {
        "The", "A", "An", "Great", "Complete", "Advanced", "Modern", "Essential", 
        "Ultimate", "Professional", "Practical", "Comprehensive", "Introduction to"
    };
    
    private static final String[] BOOK_SUBJECTS = {
        "Java Programming", "Database Design", "Web Development", "Software Engineering",
        "Data Science", "Machine Learning", "Artificial Intelligence", "Computer Networks",
        "Operating Systems", "Algorithms", "Data Structures", "Software Architecture",
        "Cybersecurity", "Cloud Computing", "Mobile Development", "Game Development",
        "System Administration", "DevOps", "Project Management", "Business Analysis",
        "Digital Marketing", "Finance", "Economics", "Psychology", "Philosophy",
        "History", "Literature", "Science", "Mathematics", "Physics", "Chemistry",
        "Biology", "Medicine", "Engineering", "Art", "Music", "Photography"
    };
    
    private static final String[] BOOK_SUFFIXES = {
        "Handbook", "Guide", "Manual", "Reference", "Tutorial", "Cookbook",
        "Best Practices", "Patterns", "Principles", "Techniques", "Strategies",
        "Solutions", "Fundamentals", "Concepts", "Theory", "Practice"
    };
    
    /**
     * Generate a random book name
     * @return Random book name
     */
    public static String generateRandomBookName() {
        StringBuilder bookName = new StringBuilder();
        
        // Randomly decide whether to include a prefix
        if (random.nextBoolean()) {
            bookName.append(BOOK_PREFIXES[random.nextInt(BOOK_PREFIXES.length)]);
            bookName.append(" ");
        }
        
        // Add a subject
        bookName.append(BOOK_SUBJECTS[random.nextInt(BOOK_SUBJECTS.length)]);
        
        // Randomly decide whether to include a suffix
        if (random.nextBoolean()) {
            bookName.append(" ");
            bookName.append(BOOK_SUFFIXES[random.nextInt(BOOK_SUFFIXES.length)]);
        }
        
        return bookName.toString();
    }
    
    /**
     * Generate a random ISBN-13 number
     * @return Random ISBN-13 number in format XXX-X-XXX-XXXXX-X
     */
    public static String generateRandomISBN() {
        StringBuilder isbn = new StringBuilder();
        
        // ISBN-13 format: 978-X-XXX-XXXXX-X
        isbn.append("978-");
        isbn.append(random.nextInt(10));
        isbn.append("-");
        
        // Generate 3-digit group identifier
        isbn.append(String.format("%03d", random.nextInt(1000)));
        isbn.append("-");
        
        // Generate 5-digit publisher and title identifier
        isbn.append(String.format("%05d", random.nextInt(100000)));
        isbn.append("-");
        
        // Generate check digit (simplified - just a random digit)
        isbn.append(random.nextInt(10));
        
        return isbn.toString();
    }
    
    /**
     * Generate a random book with random name and ISBN
     * @return Random Book object
     */
    public static Book generateRandomBook() {
        return new Book(generateRandomBookName(), generateRandomISBN());
    }
}