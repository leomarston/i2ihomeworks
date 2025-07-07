# Oracle Database Express Edition (XE) 21.3.0 - Docker Setup

## Project Overview

This project demonstrates how to set up and run Oracle Database Express Edition 21.3.0 using Docker containers. The setup includes building the Oracle XE container image and running it with proper configuration for database access.

## Prerequisites

- Docker Desktop installed and running
- Git for cloning repositories
- At least 8GB of RAM
- At least 20GB of free disk space

## Setup Instructions

### 1. Clone Oracle Docker Images Repository

```bash
git clone https://github.com/oracle/docker-images.git
```

### 2. Navigate to Oracle Database Dockerfiles

```bash
cd docker-images/OracleDatabase/SingleInstance/dockerfiles
```

### 3. Build Oracle XE 21.3.0 Container Image

```bash
# For Linux/macOS
./buildContainerImage.sh -v 21.3.0 -x

# For Windows (using Docker directly)
cd 21.3.0
docker build --force-rm=true --no-cache=true --build-arg DB_EDITION=xe -t oracle/database:21.3.0-xe -f Dockerfile.xe .
```

### 4. Run Oracle XE Container

```bash
docker run --name oraclexe \
  -p 1521:1521 \
  -p 5500:5500 \
  -e ORACLE_PWD=ORACLE \
  oracle/database:21.3.0-xe
```

### 5. Access Oracle SQL Plus

```bash
# Enter the container
docker exec -it oraclexe bash

# Connect to Oracle database
sqlplus sys/ORACLE@//localhost:1521/XE as sysdba
```

## Container Configuration

### Ports
- **1521**: Oracle Database listener port
- **5500**: Oracle Enterprise Manager Express port

### Environment Variables
- `ORACLE_PWD`: Sets the password for SYS, SYSTEM, and PDBADMIN users (default: ORACLE)

### Volume Mounting (Optional)
To persist data, you can mount volumes:

```bash
docker run --name oraclexe \
  -p 1521:1521 \
  -p 5500:5500 \
  -e ORACLE_PWD=ORACLE \
  -v oracle-data:/opt/oracle/oradata \
  oracle/database:21.3.0-xe
```

## Database Connection Details

- **Hostname**: localhost
- **Port**: 1521
- **Service Name**: XE
- **SYS Password**: ORACLE
- **SYSTEM Password**: ORACLE

## Sample SQL Commands

### Basic Database Information
```sql
-- Check database name
SELECT name FROM v$database;

-- Check instance status
SELECT instance_name, status FROM v$instance;

-- Show current user
SELECT user FROM dual;

-- List all users
SELECT username FROM dba_users ORDER BY username;
```

### Create Sample Schema
```sql
-- Create a new user
CREATE USER testuser IDENTIFIED BY testpass;

-- Grant permissions
GRANT CONNECT, RESOURCE TO testuser;
GRANT CREATE SESSION TO testuser;

-- Connect as new user
CONNECT testuser/testpass@//localhost:1521/XE
```

## Web Interface Access

Oracle Enterprise Manager Express is available at:
- URL: `https://localhost:5500/em`
- Username: SYS
- Password: ORACLE
- Connect as: SYSDBA

## Troubleshooting

### Common Issues

1. **Container fails to start**
   - Check if ports 1521 and 5500 are not already in use
   - Ensure Docker has sufficient memory allocated (8GB recommended)

2. **Cannot connect to database**
   - Wait for database initialization to complete (can take 5-10 minutes)
   - Check container logs: `docker logs oraclexe`

3. **Performance issues**
   - Increase Docker memory allocation
   - Use SSD storage for better performance

### Container Management Commands

```bash
# Start existing container
docker start oraclexe

# Stop container
docker stop oraclexe

# View container logs
docker logs oraclexe

# Remove container
docker rm oraclexe

# View running containers
docker ps
```

## Project Structure

```
oracle2ex/
├── README.md
├── docker-compose.yml            # Docker Compose configuration
├── scripts/
│   ├── setup.sql                 # Database setup scripts
│   └── sample-queries.sql        # Sample SQL queries
└── docs/
    ├── architecture.md           # System architecture
    └── troubleshooting.md        # Detailed troubleshooting guide
```

## Exercise Completion

This project successfully demonstrates:

✅ **Docker Installation**: Oracle Express Edition container from Docker Hub
✅ **Container Build**: Built Oracle XE 21.3.0 image from official repository
✅ **Container Execution**: Running Oracle container with proper port mapping
✅ **Database Access**: SQL Plus CLI access and database connectivity
✅ **Documentation**: Comprehensive setup and usage documentation

## References

- [Oracle Database 18c Express Edition in Containers](https://blogs.oracle.com/connect/post/deliver-oracle-database-18c-express-edition-in-containers)
- [Oracle Docker Images GitHub Repository](https://github.com/oracle/docker-images/tree/main/OracleDatabase/SingleInstance)
- [Oracle Database Docker Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/21/dxerd/)

## License

This project follows Oracle's licensing terms for Oracle Database Express Edition.

---

**Note**: This setup is intended for development and learning purposes. For production environments, please review Oracle's licensing requirements and security best practices.