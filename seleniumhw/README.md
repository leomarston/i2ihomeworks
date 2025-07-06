# Selenium E-commerce Login Test

This project contains a simple test automation framework to demonstrate logging into an e-commerce website using Selenium and TestNG.

## Description

The primary goal of this project is to provide a clear and concise example of a Selenium test automation setup in a Java environment. It automates the login process for the website `https://www.saucedemo.com`.

## Technologies Used

*   **Java 11**: The core programming language.
*   **Selenium WebDriver 4**: For browser automation.
*   **TestNG**: As the testing framework for running tests and assertions.
*   **Maven**: For project build and dependency management.

## Project Structure

```
seleniumhw/
├── pom.xml
├── src/
│   └── test/
│       └── java/
│           └── com/
│               └── testautomation/
│                   ├── BaseTest.java
│                   └── LoginTest.java
├── testng.xml
└── README.md
```

*   `pom.xml`: Defines project dependencies (Selenium, TestNG) and build configurations.
*   `BaseTest.java`: Contains the base setup (`@BeforeMethod`) and teardown (`@AfterMethod`) for the WebDriver, ensuring each test runs in a clean browser session.
*   `LoginTest.java`: Includes the actual test case (`@Test`) for the login functionality.
*   `testng.xml`: The TestNG suite file that defines which tests to run.
*   `README.md`: This file.

## How to Run the Tests

### Prerequisites

1.  **Java JDK 11** or higher must be installed.
2.  **Apache Maven** must be installed and configured in your system's PATH.
3.  **Google Chrome** browser must be installed.

### Execution

1.  Open your terminal or command prompt.
2.  Navigate to the `seleniumhw` directory within this repository.
3.  Run the following Maven command:

    ```shell
    mvn clean test
    ```

Maven will handle downloading dependencies, compiling the code, and executing the tests defined in `testng.xml`. You will see a Chrome browser window launch and perform the automated login steps.