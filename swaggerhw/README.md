Here’s a concise README for your project, suitable for GitHub:

---

# Customer Management API

A Spring Boot RESTful API for managing customer data, featuring OpenAPI (Swagger) documentation.

## Features

- CRUD operations for customers
- In-memory data storage (no database required)
- OpenAPI 3.0 documentation with Swagger UI
- Input validation and error handling

## Tech Stack

- Java 21
- Spring Boot 3.2.0
- SpringDoc OpenAPI
- Maven

## Getting Started

1. **Build and Run:**
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```
2. **Access the API:**
   - API Base URL: `http://localhost:8081/api/customers`
   - Swagger UI: `http://localhost:8081/swagger-ui.html`

## API Endpoints

| Method | Endpoint                | Description           |
|--------|-------------------------|-----------------------|
| GET    | `/api/customers`        | List all customers    |
| GET    | `/api/customers/{id}`   | Get customer by ID    |
| POST   | `/api/customers`        | Create new customer   |
| PUT    | `/api/customers/{id}`   | Update customer       |
| DELETE | `/api/customers/{id}`   | Delete customer       |

## Sample Request

```json
{
  "name": "Ahmet Murat",
  "email": "ahmet.murat@gmail.com"
}
```
