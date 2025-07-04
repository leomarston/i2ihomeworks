# Swagger-ex-04 - Customer Management API

Spring Boot RESTful API with Swagger documentation for managing customer data.

## 🚀 Quick Start

```bash
mvn clean install
mvn spring-boot:run
```

**Access:**
- API: http://localhost:8081
- Swagger UI: http://localhost:8081/swagger-ui.html

## 📋 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/customers` | Get all customers |
| GET | `/api/customers/{id}` | Get customer by ID |
| POST | `/api/customers` | Create customer |
| PUT | `/api/customers/{id}` | Update customer |
| DELETE | `/api/customers/{id}` | Delete customer |
| GET | `/api/customers/count` | Get customer count |

## 🛠️ Tech Stack

- Java 21
- Spring Boot 3.2.0
- SpringDoc OpenAPI
- Maven

## 📝 Sample Request

```json
{
  "name": "John Doe",
  "email": "john.doe@example.com"
}
```

## 🏗️ Architecture

The application follows a layered architecture:

- **Controller Layer**: REST endpoints with Swagger documentation
- **Service Layer**: Business logic and validation
- **Repository Layer**: Data access (in-memory HashMap)
- **DTO Layer**: Data transfer objects with validation

## 🔧 Configuration

- Server Port: 8081
- Swagger UI: `/swagger-ui.html`
- OpenAPI JSON: `/api-docs`

## 📊 Sample Data

The application comes pre-loaded with sample customers:
1. John Doe - john.doe@example.com
2. Jane Smith - jane.smith@example.com  
3. Bob Johnson - bob.johnson@example.com

## 🔍 Features

- ✅ Full CRUD operations
- ✅ Email validation
- ✅ Duplicate email prevention
- ✅ Comprehensive Swagger documentation
- ✅ Request/Response validation
- ✅ In-memory data storage
- ✅ Timestamps for created/updated dates
- ✅ Proper HTTP status codes 