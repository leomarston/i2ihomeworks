# Oracle XE 21.3.0 Docker - Troubleshooting Guide

## Overview

This troubleshooting guide provides solutions for common issues encountered when setting up and running Oracle Database Express Edition 21.3.0 in Docker containers.

## Quick Diagnostic Commands

### Container Status Check
```bash
# Check if container is running
docker ps

# Check all containers (including stopped)
docker ps -a

# View container logs
docker logs oraclexe

# Check container resource usage
docker stats oraclexe
```

### Database Status Check
```bash
# Enter container
docker exec -it oraclexe bash

# Check database status
sqlplus sys/ORACLE@//localhost:1521/XE as sysdba
SQL> SELECT name, open_mode FROM v$database;
SQL> SELECT instance_name, status FROM v$instance;
```

## Common Issues and Solutions

### 1. Container Build Issues

#### Problem: Build Script Not Found
```
bash: ./buildContainerImage.sh: No such file or directory
```

**Solution:**
```bash
# Ensure you're in the correct directory
cd docker-images/OracleDatabase/SingleInstance/dockerfiles

# For Windows, use direct Docker command instead
cd 21.3.0
docker build --force-rm=true --no-cache=true --build-arg DB_EDITION=xe -t oracle/database:21.3.0-xe -f Dockerfile.xe .
```

#### Problem: Build Timeout or Memory Issues
```
ERROR: failed to solve: process "/bin/sh -c mkdir -p /opt/oracle" did not complete successfully
```

**Solutions:**
- Increase Docker memory allocation to at least 8GB
- Increase Docker disk space allocation
- Close other resource-intensive applications
- Use alternative pre-built image:
```bash
docker pull container-registry.oracle.com/database/express:21.3.0-xe
```

#### Problem: Architecture Compatibility
```
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform
```

**Solution:**
```bash
# For ARM-based systems (Apple M1/M2)
docker build --platform linux/amd64 --force-rm=true --no-cache=true --build-arg DB_EDITION=xe -t oracle/database:21.3.0-xe -f Dockerfile.xe .
```

### 2. Container Runtime Issues

#### Problem: Port Already in Use
```
Error starting userland proxy: listen tcp4 0.0.0.0:1521: bind: address already in use
```

**Solutions:**
```bash
# Check what's using the port
netstat -ano | findstr :1521  # Windows
lsof -i :1521                 # macOS/Linux

# Use different ports
docker run --name oraclexe -p 1522:1521 -p 5501:5500 -e ORACLE_PWD=ORACLE oracle/database:21.3.0-xe

# Stop conflicting services
# If Oracle is already installed locally, stop the service
```

#### Problem: Container Exits Immediately
```
docker: Error response from daemon: container exited
```

**Diagnostic Steps:**
```bash
# Check exit code and logs
docker logs oraclexe

# Check container configuration
docker inspect oraclexe

# Run in interactive mode for debugging
docker run -it --name oraclexe-debug -p 1521:1521 -p 5500:5500 -e ORACLE_PWD=ORACLE oracle/database:21.3.0-xe bash
```

#### Problem: Insufficient Memory
```
ORA-00845: MEMORY_TARGET not supported on this system
```

**Solutions:**
```bash
# Increase Docker memory allocation (Docker Desktop settings)
# Add shared memory size parameter
docker run --name oraclexe --shm-size=2g -p 1521:1521 -p 5500:5500 -e ORACLE_PWD=ORACLE oracle/database:21.3.0-xe

# For Linux systems, mount /dev/shm
docker run --name oraclexe -v /dev/shm:/dev/shm -p 1521:1521 -p 5500:5500 -e ORACLE_PWD=ORACLE oracle/database:21.3.0-xe
```

### 3. Database Connection Issues

#### Problem: Cannot Connect to Database
```
ORA-12541: TNS:no listener
```

**Solutions:**
```bash
# Wait for database initialization (can take 5-10 minutes)
docker logs -f oraclexe

# Check if database is ready
docker exec -it oraclexe bash -c "echo 'SELECT 1 FROM DUAL;' | sqlplus -s sys/ORACLE@//localhost:1521/XE as sysdba"

# Verify listener status
docker exec -it oraclexe lsnrctl status
```

#### Problem: Wrong Connection String
```
ORA-12154: TNS:could not resolve the connect identifier specified
```

**Correct Connection Formats:**
```bash
# From within container
sqlplus sys/ORACLE@//localhost:1521/XE as sysdba
sqlplus system/ORACLE@//localhost:1521/XE

# From host (if using different port)
sqlplus sys/ORACLE@//localhost:1522/XE as sysdba  # if using port 1522
```

#### Problem: Authentication Failed
```
ORA-01017: invalid username/password; logon denied
```

**Solutions:**
```bash
# Use correct default credentials
Username: sys
Password: ORACLE (or value set in ORACLE_PWD)
Connect as: SYSDBA

# Reset password if needed
docker exec -it oraclexe bash
./setPassword.sh NEWPASSWORD
```

### 4. Database Startup Issues

#### Problem: Database Won't Start
```
ORA-00845: MEMORY_TARGET not supported on this system
ORA-01034: ORACLE not available
```

**Solutions:**
```bash
# Check database status
docker exec -it oraclexe sqlplus / as sysdba
SQL> SELECT status FROM v$instance;

# If status is MOUNTED, start the database
SQL> ALTER DATABASE OPEN;

# If instance is down, start it
SQL> STARTUP;

# Check alert log for errors
docker exec -it oraclexe tail -f /opt/oracle/diag/rdbms/xe/XE/trace/alert_XE.log
```

#### Problem: Slow Database Startup
```
Database startup taking more than 10 minutes
```

**Normal Behavior:**
- First-time startup can take 5-15 minutes
- Subsequent startups are faster (2-5 minutes)

**Troubleshooting:**
```bash
# Monitor startup progress
docker logs -f oraclexe

# Check system resources
docker stats oraclexe

# Look for specific errors
docker exec -it oraclexe grep -i error /opt/oracle/diag/rdbms/xe/XE/trace/alert_XE.log
```

### 5. Performance Issues

#### Problem: Slow Query Performance
**Solutions:**
```sql
-- Check system statistics
SELECT * FROM v$sysstat WHERE name LIKE '%CPU%';

-- Check memory usage
SELECT * FROM v$memory_target_advice;

-- Check for blocking sessions
SELECT blocking_session, wait_class, event FROM v$session WHERE blocking_session IS NOT NULL;

-- Update table statistics
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('APPUSER');
```

#### Problem: High Memory Usage
**Solutions:**
```bash
# Monitor memory usage
docker stats oraclexe

# Adjust SGA size (if needed)
SQL> ALTER SYSTEM SET memory_target=1G SCOPE=SPFILE;
SQL> SHUTDOWN IMMEDIATE;
SQL> STARTUP;
```

### 6. Web Interface Issues

#### Problem: Cannot Access EM Express
```
This site can't be reached - localhost:5500
```

**Solutions:**
```bash
# Check if port is mapped correctly
docker port oraclexe

# Verify EM Express is configured
docker exec -it oraclexe sqlplus sys/ORACLE@//localhost:1521/XE as sysdba
SQL> SELECT dbms_xdb_config.gethttpsport() FROM dual;
SQL> SELECT dbms_xdb_config.gethttpport() FROM dual;

# Enable HTTPS port if needed
SQL> EXEC DBMS_XDB_CONFIG.SETHTTPSPORT(5500);
```

#### Problem: Certificate Warnings
**Solution:**
- Accept the self-signed certificate warning in your browser
- Use `https://localhost:5500/em` (not http)

### 7. Volume and Data Persistence Issues

#### Problem: Data Lost After Container Restart
**Solution:**
```bash
# Use volume mounting for persistence
docker run --name oraclexe \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PWD=ORACLE \
  -v oracle-data:/opt/oracle/oradata \
  oracle/database:21.3.0-xe

# Create named volume first
docker volume create oracle-data
```

#### Problem: Permission Issues with Volumes
```
Permission denied when accessing mounted volumes
```

**Solutions:**
```bash
# For Linux/macOS - fix permissions
sudo chown -R 54321:54321 /path/to/host/directory

# Use proper volume mounting
docker run --name oraclexe \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PWD=ORACLE \
  -v /host/path:/opt/oracle/oradata \
  --user 54321:54321 \
  oracle/database:21.3.0-xe
```

### 8. Windows-Specific Issues

#### Problem: PowerShell Command Issues
```
The token '&&' is not a valid statement separator
```

**Solution:**
```powershell
# Use separate commands instead of &&
cd docker-images/OracleDatabase/SingleInstance/dockerfiles
Get-ChildItem

# Or use cmd
cmd /c "cd docker-images\OracleDatabase\SingleInstance\dockerfiles && dir"
```

#### Problem: Path Issues
```
Cannot find path '/c/Users/...'
```

**Solution:**
```powershell
# Use Windows-style paths
cd C:\Users\Admin\Desktop\hwi2i\oracle2ex

# Or use forward slashes with proper drive
cd /c/Users/Admin/Desktop/hwi2i/oracle2ex
```

## Diagnostic SQL Queries

### System Health Check
```sql
-- Database status
SELECT name, open_mode, log_mode FROM v$database;

-- Instance status
SELECT instance_name, status, startup_time FROM v$instance;

-- Tablespace usage
SELECT tablespace_name, 
       ROUND(bytes/1024/1024, 2) AS size_mb,
       ROUND(free_bytes/1024/1024, 2) AS free_mb,
       ROUND((bytes-free_bytes)/bytes*100, 2) AS used_pct
FROM (SELECT tablespace_name, SUM(bytes) AS bytes FROM dba_data_files GROUP BY tablespace_name) df
JOIN (SELECT tablespace_name, SUM(bytes) AS free_bytes FROM dba_free_space GROUP BY tablespace_name) fs
USING (tablespace_name);

-- Session information
SELECT username, count(*) AS session_count
FROM v$session 
WHERE username IS NOT NULL 
GROUP BY username;
```

### Performance Diagnostics
```sql
-- Top wait events
SELECT event, total_waits, time_waited, avg_wait
FROM v$system_event
WHERE event NOT LIKE 'SQL*Net%'
ORDER BY time_waited DESC
FETCH FIRST 10 ROWS ONLY;

-- Memory usage
SELECT component, current_size/1024/1024 AS size_mb
FROM v$memory_dynamic_components
WHERE current_size > 0
ORDER BY current_size DESC;
```

## Recovery Procedures

### Complete Container Reset
```bash
# Stop and remove container
docker stop oraclexe
docker rm oraclexe

# Remove volumes (if needed)
docker volume rm oracle-data

# Rebuild and restart
docker run --name oraclexe -p 1521:1521 -p 5500:5500 -e ORACLE_PWD=ORACLE oracle/database:21.3.0-xe
```

### Database Recovery
```sql
-- Check database status
SELECT name, open_mode FROM v$database;

-- Startup database if needed
STARTUP;

-- Check for corruptions
SELECT * FROM v$database_block_corruption;

-- Validate datafiles
SELECT name, status FROM v$datafile;
```

## Prevention Best Practices

1. **Resource Allocation**
   - Allocate at least 8GB RAM to Docker
   - Ensure 20GB+ free disk space
   - Monitor system resources regularly

2. **Container Management**
   - Use health checks
   - Implement proper logging
   - Regular container updates

3. **Database Maintenance**
   - Regular statistics gathering
   - Monitor tablespace usage
   - Backup important data

4. **Security**
   - Change default passwords
   - Limit network exposure
   - Regular security updates

## Getting Help

### Oracle Resources
- [Oracle Database Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/21/)
- [Oracle Docker GitHub](https://github.com/oracle/docker-images)
- [Oracle Community Forums](https://community.oracle.com/)

### Container Resources
- [Docker Documentation](https://docs.docker.com/)
- [Docker Desktop Troubleshooting](https://docs.docker.com/desktop/troubleshoot/)

### Log Locations
```bash
# Container logs
docker logs oraclexe

# Oracle alert log
/opt/oracle/diag/rdbms/xe/XE/trace/alert_XE.log

# Listener log
/opt/oracle/diag/tnslsnr/*/listener/trace/listener.log
```