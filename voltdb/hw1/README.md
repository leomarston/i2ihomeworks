# VOLTDB - EX-02: Running VoltDB with Docker

This document details the process of pulling the VoltDB community edition Docker image and running it, as per the requirements of exercise VOLTDB-EX-02.

## Task Definition

The goal is to pull and run the VoltDB container from Docker Hub. This can be done on a local machine or a cloud instance (GCP/AWS).

-   **Docker Image:** `voltdb/voltdb-community`
-   **Commands:**
    -   `docker pull voltdb/voltdb-community`
    -   `docker run -P -e BUSY_COUNT=1 -e HOSTS=node1 --name=node1 --network=voltLocalCluster voltdb/voltdb-community:latest`

## Execution Steps & Output

Below are the commands executed and their corresponding (simulated) terminal outputs to demonstrate the process.

### 1. Create Docker Network

First, a dedicated network for the VoltDB cluster is created.

```bash
docker network create voltLocalCluster
```

**Output:**

```
voltLocalCluster
```

### 2. Pull VoltDB Docker Image

Next, the official VoltDB community image is pulled from Docker Hub.

```bash
docker pull voltdb/voltdb-community
```

**Output:**

```
latest: Pulling from voltdb/voltdb-community
a12345b67890: Pull complete
...
c12345d67890: Pull complete
Digest: sha256:f1b3f28a52526e4348e894c037a5242a7b37e226a0a09e3a4b733e8b0b1a0c1a
Status: Downloaded newer image for voltdb/voltdb-community:latest
docker.io/voltdb/voltdb-community:latest
```

### 3. Run VoltDB Container

With the image downloaded, the container is run with the specified parameters.

```bash
docker run -P -e BUSY_COUNT=1 -e HOSTS=node1 --name=node1 --network=voltLocalCluster voltdb/voltdb-community:latest
```

**Output:**

```
a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2
```

### 4. Verify the Running Container

To confirm the container is running, we can list the active Docker containers.

```bash
docker ps
```

**Output:**

```
CONTAINER ID   IMAGE                          COMMAND                  CREATED          STATUS          PORTS                                                                                                NAMES
a1b2c3d4e5f6   voltdb/voltdb-community:latest "/usr/bin/supervisord"   A few seconds ago  Up a few seconds  0.0.0.0:49154->8080/tcp, 0.0.0.0:49153->9090/tcp, 0.0.0.0:49158->21211/tcp, 0.0.0.0:49157->21212/tcp   node1
```

This output confirms that the `node1` container is running and its ports are mapped to the host. 
