# 🎯 Docker Learning Exercises

## Exercise 1: Basic Docker Commands

### Task: Build and run your app manually

```bash
# 1. Build the image
docker build -t my-php-app .

# 2. Run the container
docker run -d -p 8080:80 --name my-php-container my-php-app

# 3. Check if it's running
docker ps

# 4. View logs
docker logs my-php-container

# 5. Stop the container
docker stop my-php-container

# 6. Remove the container
docker rm my-php-container
```

**What you learned:**
- How to build Docker images
- How to run containers
- Basic container management

---

## Exercise 2: Environment Variables

### Task: Make your app configurable

1. **Create a `.env` file:**
```env
MYSQL_HOST=mysql
MYSQL_DATABASE=phpapp
MYSQL_USER=phpuser
MYSQL_PASSWORD=phppass
APACHE_DOCUMENT_ROOT=/var/www/html
```

2. **Update `config.php` to use environment variables:**
```php
<?php
$host = $_ENV['MYSQL_HOST'] ?? 'mysql';
$dbname = $_ENV['MYSQL_DATABASE'] ?? 'phpapp';
$username = $_ENV['MYSQL_USER'] ?? 'phpuser';
$password = $_ENV['MYSQL_PASSWORD'] ?? 'phppass';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    // ... rest of your code
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?>
```

3. **Update `docker-compose.yml` to use .env:**
```yaml
services:
  web:
    build: .
    environment:
      - MYSQL_HOST=${MYSQL_HOST}
      - MYSQL_DATABASE=${MYSQL_DATABASE}
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
```

**What you learned:**
- Environment variables in Docker
- Configuration management
- Security best practices

---

## Exercise 3: Multi-Container Setup

### Task: Add Redis for caching

1. **Add Redis service to `docker-compose.yml`:**
```yaml
services:
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    networks:
      - phpapp-network

volumes:
  redis_data:
```

2. **Install Redis PHP extension in Dockerfile:**
```dockerfile
RUN pecl install redis && docker-php-ext-enable redis
```

3. **Test Redis connection in PHP:**
```php
<?php
try {
    $redis = new Redis();
    $redis->connect('redis', 6379);
    $redis->set('test', 'Hello Redis!');
    echo "Redis connected: " . $redis->get('test');
} catch (Exception $e) {
    echo "Redis connection failed: " . $e->getMessage();
}
?>
```

**What you learned:**
- Multi-service architecture
- Service communication
- Data persistence

---

## Exercise 4: Custom Networks

### Task: Create isolated network

1. **Create custom network:**
```bash
docker network create phpapp-network
```

2. **Run containers on custom network:**
```bash
# Run MySQL
docker run -d --name mysql --network phpapp-network \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  -e MYSQL_DATABASE=phpapp \
  mysql:8.0

# Run PHP app
docker run -d --name php-app --network phpapp-network \
  -p 8080:80 my-php-app
```

3. **Test network connectivity:**
```bash
# From PHP container, ping MySQL
docker exec php-app ping mysql
```

**What you learned:**
- Docker networking
- Container communication
- Network isolation

---

## Exercise 5: Volume Management

### Task: Persistent data storage

1. **Create named volume:**
```bash
docker volume create mysql-data
```

2. **Run MySQL with persistent volume:**
```bash
docker run -d --name mysql \
  -v mysql-data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  mysql:8.0
```

3. **Backup and restore data:**
```bash
# Backup
docker run --rm -v mysql-data:/data -v $(pwd):/backup alpine \
  tar czf /backup/mysql-backup.tar.gz -C /data .

# Restore
docker run --rm -v mysql-data:/data -v $(pwd):/backup alpine \
  tar xzf /backup/mysql-backup.tar.gz -C /data
```

**What you learned:**
- Data persistence
- Volume management
- Backup strategies

---

## Exercise 6: Health Checks

### Task: Add health monitoring

1. **Add health check to Dockerfile:**
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
```

2. **Add health check to docker-compose.yml:**
```yaml
services:
  web:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
```

3. **Monitor health status:**
```bash
docker ps
docker inspect <container_id> | grep Health
```

**What you learned:**
- Container health monitoring
- Automated health checks
- Service reliability

---

## Exercise 7: Multi-stage Build

### Task: Optimize image size

1. **Create multi-stage Dockerfile:**
```dockerfile
# Build stage
FROM node:16 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM php:8.2-apache
COPY --from=build /app/dist /var/www/html
# ... rest of your configuration
```

2. **Compare image sizes:**
```bash
docker images
```

**What you learned:**
- Multi-stage builds
- Image optimization
- Build efficiency

---

## Exercise 8: Docker Registry

### Task: Push to Docker Hub

1. **Create Docker Hub account** at https://hub.docker.com

2. **Login to Docker Hub:**
```bash
docker login
```

3. **Tag your image:**
```bash
docker tag my-php-app yourusername/php-app:latest
```

4. **Push to Docker Hub:**
```bash
docker push yourusername/php-app:latest
```

5. **Pull and run from anywhere:**
```bash
docker pull yourusername/php-app:latest
docker run -p 8080:80 yourusername/php-app:latest
```

**What you learned:**
- Docker registries
- Image sharing
- Cloud deployment

---

## Exercise 9: Docker Swarm (Advanced)

### Task: Container orchestration

1. **Initialize Docker Swarm:**
```bash
docker swarm init
```

2. **Create a stack file:**
```yaml
version: '3.8'
services:
  web:
    image: yourusername/php-app:latest
    ports:
      - "8080:80"
    deploy:
      replicas: 3
      update_config:
        parallelism: 1
        delay: 10s
      restart_policy:
        condition: on-failure
```

3. **Deploy the stack:**
```bash
docker stack deploy -c stack.yml phpapp
```

**What you learned:**
- Container orchestration
- High availability
- Load balancing

---

## Exercise 10: Monitoring and Logging

### Task: Add monitoring

1. **Add Prometheus service:**
```yaml
services:
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
```

2. **Add Grafana for visualization:**
```yaml
services:
  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
```

3. **View metrics:**
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

**What you learned:**
- Container monitoring
- Metrics collection
- Performance analysis

---

## 🏆 Mastery Checklist

- [ ] Can build Docker images
- [ ] Can run containers with proper networking
- [ ] Understand Docker Compose
- [ ] Can manage volumes and data persistence
- [ ] Can use environment variables
- [ ] Can create custom networks
- [ ] Can implement health checks
- [ ] Can optimize image sizes
- [ ] Can push/pull from registries
- [ ] Can troubleshoot common issues

**Keep practicing! The more you experiment, the better you'll understand Docker! 🚀**
