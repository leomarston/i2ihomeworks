package com.i2ihomework;

import org.voltdb.client.Client;
import org.voltdb.client.ClientFactory;
import org.voltdb.client.ProcCallException;
import org.voltdb.client.ClientResponse;
import org.voltdb.VoltTable;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;
import java.io.IOException;

public class VoltDbApp {

    public static void main(String[] args) throws Exception {
        System.out.println("Starting VoltDB homework application...");

        Client client = null;
        try {
            // Create a VoltDB client
            client = ClientFactory.createClient();
            // Connect to VoltDB server. Default port is 21212.
            // Assumes VoltDB is running on localhost.
            client.createConnection("localhost");
            System.out.println("Successfully connected to VoltDB.");

            // Read and execute SQL script
            System.out.println("Reading schema.sql to create and populate table...");
            String sqlScript = readResourceFile("schema.sql");
            String[] sqlStatements = sqlScript.split(";");

            for (String statement : sqlStatements) {
                statement = statement.trim();
                if (!statement.isEmpty() && !statement.startsWith("--")) {
                    System.out.println("Executing: " + statement);
                    ClientResponse response = client.callProcedure("@AdHoc", statement);
                    if (response.getStatus() != ClientResponse.SUCCESS) {
                        System.err.println("Error executing statement: " + statement);
                        System.err.println(response.getStatusString());
                        // Decide if we should stop on error
                    }
                }
            }
            System.out.println("SQL script executed successfully.");

            // Verify insertion with a SELECT query
            System.out.println("\nVerifying data with 'select * from mth3902':");
            ClientResponse response = client.callProcedure("@AdHoc", "select * from mth3902 order by id");
            if (response.getStatus() == ClientResponse.SUCCESS) {
                VoltTable resultTable = response.getResults()[0];
                System.out.println("Query result:");
                System.out.println(resultTable.toFormattedString());
            } else {
                System.err.println("Failed to execute select query.");
                System.err.println(response.getStatusString());
            }

        } catch (IOException | ProcCallException e) {
            System.err.println("An error occurred:");
            e.printStackTrace();
        } finally {
            if (client != null) {
                System.out.println("Closing VoltDB connection.");
                client.close();
            }
        }
    }

    private static String readResourceFile(String fileName) throws IOException {
        InputStream is = VoltDbApp.class.getClassLoader().getResourceAsStream(fileName);
        if (is == null) {
            throw new IOException("Cannot find resource file: " + fileName);
        }
        try (InputStreamReader isr = new InputStreamReader(is, StandardCharsets.UTF_8);
             BufferedReader reader = new BufferedReader(isr)) {
            return reader.lines().collect(Collectors.joining("\n"));
        }
    }
}
