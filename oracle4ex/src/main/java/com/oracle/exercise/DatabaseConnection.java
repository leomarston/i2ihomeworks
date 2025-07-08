package com.oracle.exercise;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;
import java.io.IOException;

/**
 * Database connection utility class for Oracle database
 */
public class DatabaseConnection {
    
    private static final String PROPERTIES_FILE = "/database.properties";
    private static Properties dbProperties;
    
    static {
        loadDatabaseProperties();
    }
    
    /**
     * Load database connection properties from configuration file
     */
    private static void loadDatabaseProperties() {
        dbProperties = new Properties();
        try (InputStream input = DatabaseConnection.class.getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                System.out.println("Database properties file not found, using default values");
                setDefaultProperties();
            } else {
                dbProperties.load(input);
            }
        } catch (IOException e) {
            System.err.println("Error loading database properties: " + e.getMessage());
            setDefaultProperties();
        }
    }
    
    /**
     * Set default database connection properties
     */
    private static void setDefaultProperties() {
        dbProperties.setProperty("db.url", "jdbc:oracle:thin:@localhost:1521:XE");
        dbProperties.setProperty("db.username", "hr");
        dbProperties.setProperty("db.password", "hr");
    }
    
    /**
     * Get database connection
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            String url = dbProperties.getProperty("db.url");
            String username = dbProperties.getProperty("db.username");
            String password = dbProperties.getProperty("db.password");
            
            System.out.println("Connecting to database: " + url);
            
            return DriverManager.getConnection(url, username, password);
            
        } catch (ClassNotFoundException e) {
            throw new SQLException("Oracle JDBC driver not found", e);
        }
    }
    
    /**
     * Close database connection safely
     * @param connection Connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed successfully");
            } catch (SQLException e) {
                System.err.println("Error closing database connection: " + e.getMessage());
            }
        }
    }
}