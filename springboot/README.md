
# Spring Boot Books API

A simple Spring Boot REST API for managing books.

## Features

* CRUD operations for books
* In-memory H2 database
* Spring Data JPA
* Spring Security (all endpoints open)
* Custom exception handling

## Getting Started

### Run the app

```bash
mvn spring-boot:run
```

### Access

* API: `http://localhost:8080/api/books`
* H2 Console: `http://localhost:8080/h2-console`

## Example Endpoints

| Method | Endpoint          | Description    |
| ------ | ----------------- | -------------- |
| GET    | `/api/books`      | Get all books  |
| POST   | `/api/books`      | Create a book  |
| GET    | `/api/books/{id}` | Get book by ID |
| PUT    | `/api/books/{id}` | Update book    |
| DELETE | `/api/books/{id}` | Delete book    |

## Example Book JSON

```json
{
  "title": "Spring in Action",
  "author": "Craig Walls"
}
```

## H2 DB Config (in `application.properties`)

```properties
spring.datasource.url=jdbc:h2:mem:bootapp
spring.h2.console.enabled=true
```

## Security Config

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests(auth -> auth.anyRequest().permitAll())
            .csrf(AbstractHttpConfigurer::disable);
        return http.build();
    }
}
```
