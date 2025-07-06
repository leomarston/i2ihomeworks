# VoltDB Homework 2

This project demonstrates how to connect to a VoltDB database from a Java application using JDBC, create a schema, and perform basic data manipulation operations.

## Description

The exercise involves:
1.  Connecting to a running VoltDB instance.
2.  Executing a SQL script to:
    *   Create a table named `mth3902`.
    *   Partition the table.
    *   Insert sample data into the table.
3.  Querying the table to verify the data insertion.

The project uses Maven for dependency management and building.

## Prerequisites

*   Java Development Kit (JDK) 8 or higher.
*   Apache Maven.
*   A running VoltDB instance. You can start one using Docker:
    ```sh
    docker run -d -p 21212:21212 -p 8080:8080 voltdb/voltdb-community:latest
    ```
    Note: The exercise description mentions port `55004` for the UI. `docker ps` can be used to find the mapped UI port (default is 8080 inside container). For example, if `docker ps` shows `0.0.0.0:55004->8080/tcp`, then the UI is at `http://localhost:55004`. The database connection port is 21212.

## How to Build and Run

1.  **Clone the repository and navigate to the project directory:**
    ```sh
    git clone https://github.com/leomarston/i2ihomeworks.git
    cd i2ihomeworks/voltdb/hw2
    ```

2.  **Build the project using Maven:**
    This will compile the code and package it into an executable JAR file with all dependencies included.
    ```sh
    mvn clean package
    ```

3.  **Run the application:**
    The application will connect to VoltDB, execute the SQL statements from `schema.sql`, and print the query results to the console.
    ```sh
    java -jar target/voltdb-hw2-1.0-SNAPSHOT-jar-with-dependencies.jar
    ```

## Expected Output

After running the application, you should see output indicating:
*   Successful connection to VoltDB.
*   Execution of `CREATE TABLE` and `INSERT` statements.
*   A formatted table showing the two rows inserted into the `mth3902` table.

## VoltDB UI

You can also verify the table and data through the VoltDB web interface, which is typically available on a mapped port (e.g., `http://localhost:8080` or `http://localhost:55004` as per exercise instructions). You can check the port mapping using `docker ps`. The UI provides a schema viewer to inspect tables.
