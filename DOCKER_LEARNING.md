# 🐳 Docker Learning Guide - PHP App Containerization

## 📚 Table of Contents
1. [Docker Fundamentals](#docker-fundamentals)
2. [Understanding Our Dockerfile](#understanding-our-dockerfile)
3. [Docker Compose Explained](#docker-compose-explained)
4. [Hands-on Docker Commands](#hands-on-docker-commands)
5. [Docker Best Practices](#docker-best-practices)
6. [Advanced Containerization](#advanced-containerization)

---

## 🎯 Docker Fundamentals

### What is Docker?
Think of Docker like this:
- **Traditional way**: Install PHP, Apache, MySQL on your computer
- **Docker way**: Package everything in containers that run anywhere

### Key Concepts:

#### 1. **Image** 📦
- A **read-only template** with instructions
- Like a "recipe" for your application
- Contains: OS, runtime, libraries, code, dependencies

#### 2. **Container** 🚀
- A **running instance** of an image
- Like a "running application" based on the recipe
- Isolated, portable, and consistent

#### 3. **Dockerfile** 📝
- **Text file** with instructions to build an image
- Step-by-step commands
- Like a "recipe card" for your application

#### 4. **Docker Compose** 🎼
- Tool to **orchestrate multiple containers**
- Define services, networks, volumes
- Like a "conductor" for an orchestra of containers

---

## 🔍 Understanding Our Dockerfile

Let's break down our `Dockerfile` line by line:

```dockerfile
# Use official PHP with Apache
FROM php:8.2-apache
```
**What this does:**
- `FROM` = Start with a base image
- `php:8.2-apache` = Official PHP 8.2 with Apache pre-installed
- This gives us a Linux system with PHP and Apache ready

```dockerfile
# Install MySQL PDO extension
RUN docker-php-ext-install pdo pdo_mysql
```
**What this does:**
- `RUN` = Execute a command during image build
- `docker-php-ext-install` = Install PHP extensions
- `pdo pdo_mysql` = Database connection extensions

```dockerfile
# Enable Apache mod_rewrite
RUN a2enmod rewrite
```
**What this does:**
- `a2enmod` = Apache command to enable modules
- `rewrite` = URL rewriting module (for clean URLs)

```dockerfile
# Set working directory
WORKDIR /var/www/html
```
**What this does:**
- `WORKDIR` = Set the current directory
- `/var/www/html` = Apache's web root directory

```dockerfile
# Copy application files
COPY . /var/www/html/
```
**What this does:**
- `COPY` = Copy files from host to container
- `.` = Current directory (our PHP files)
- `/var/www/html/` = Destination in container

```dockerfile
# Set proper permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
```
**What this does:**
- `chown` = Change file ownership to Apache user
- `chmod` = Set file permissions (read/write/execute)

```dockerfile
# Expose port 80
EXPOSE 80
```
**What this does:**
- `EXPOSE` = Document which port the container uses
- `80` = Standard HTTP port

```dockerfile
# Start Apache
CMD ["apache2-foreground"]
```
**What this does:**
- `CMD` = Default command to run when container starts
- `apache2-foreground` = Start Apache in foreground mode

---

## 🎼 Docker Compose Explained

Our `docker-compose.yml` orchestrates 3 services:

### 1. **Web Service (PHP/Apache)**
```yaml
web:
  build: .                    # Build from Dockerfile in current directory
  ports:
    - "8080:80"              # Map host port 8080 to container port 80
  volumes:
    - .:/var/www/html        # Mount current directory to container
  depends_on:
    - mysql                  # Wait for MySQL to start first
  environment:
    - APACHE_DOCUMENT_ROOT=/var/www/html
  networks:
    - phpapp-network         # Connect to custom network
```

### 2. **MySQL Service**
```yaml
mysql:
  image: mysql:8.0           # Use official MySQL 8.0 image
  ports:
    - "3307:3306"           # Map host port 3307 to container port 3306
  environment:
    MYSQL_ROOT_PASSWORD: rootpass
    MYSQL_DATABASE: phpapp
    MYSQL_USER: phpuser
    MYSQL_PASSWORD: phppass
  volumes:
    - mysql_data:/var/lib/mysql    # Persistent data storage
    - ./init.sql:/docker-entrypoint-initdb.d/init.sql
  networks:
    - phpapp-network
```

### 3. **phpMyAdmin Service**
```yaml
phpmyadmin:
  image: phpmyadmin/phpmyadmin
  ports:
    - "8081:80"
  environment:
    PMA_HOST: mysql          # Connect to MySQL service
    PMA_USER: phpuser
    PMA_PASSWORD: phppass
  depends_on:
    - mysql
  networks:
    - phpapp-network
```

---

## 🛠️ Hands-on Docker Commands

### Basic Commands:

#### **Build the Image:**
```bash
docker build -t my-php-app .
```
- `-t my-php-app` = Tag/name the image
- `.` = Build context (current directory)

#### **Run a Container:**
```bash
docker run -p 8080:80 my-php-app
```
- `-p 8080:80` = Port mapping (host:container)
- `my-php-app` = Image name

#### **List Images:**
```bash
docker images
```

#### **List Containers:**
```bash
docker ps                    # Running containers
docker ps -a                 # All containers
```

#### **Stop Container:**
```bash
docker stop <container_id>
```

#### **Remove Container:**
```bash
docker rm <container_id>
```

#### **Remove Image:**
```bash
docker rmi my-php-app
```

### Docker Compose Commands:

#### **Start All Services:**
```bash
docker-compose up -d
```
- `-d` = Run in background (detached)

#### **Stop All Services:**
```bash
docker-compose down
```

#### **View Logs:**
```bash
docker-compose logs
docker-compose logs web      # Specific service
```

#### **Restart Services:**
```bash
docker-compose restart
```

#### **Rebuild and Start:**
```bash
docker-compose up --build
```

---

## 🏆 Docker Best Practices

### 1. **Use .dockerignore**
```dockerignore
# Exclude unnecessary files
.git
README.md
*.log
.env
```

### 2. **Multi-stage Builds** (Advanced)
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
```

### 3. **Health Checks**
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
```

### 4. **Non-root User**
```dockerfile
RUN adduser --disabled-password --gecos '' appuser
USER appuser
```

### 5. **Environment Variables**
```dockerfile
ENV APACHE_DOCUMENT_ROOT=/var/www/html
ENV PHP_MEMORY_LIMIT=256M
```

---

## 🚀 Advanced Containerization

### 1. **Custom Network**
```yaml
networks:
  phpapp-network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
```

### 2. **Volume Management**
```yaml
volumes:
  mysql_data:
    driver: local
  app_data:
    driver: local
```

### 3. **Environment Files**
```yaml
env_file:
  - .env
environment:
  - MYSQL_HOST=mysql
  - MYSQL_DATABASE=phpapp
```

### 4. **Resource Limits**
```yaml
deploy:
  resources:
    limits:
      memory: 512M
      cpus: '0.5'
    reservations:
      memory: 256M
      cpus: '0.25'
```

---

## 🎯 Learning Exercises

### Exercise 1: Modify the Dockerfile
1. Change PHP version to 8.1
2. Add a custom PHP configuration
3. Install additional PHP extensions

### Exercise 2: Create a New Service
1. Add Redis to docker-compose.yml
2. Connect PHP app to Redis
3. Test the connection

### Exercise 3: Environment Variables
1. Create a .env file
2. Move all passwords to environment variables
3. Update docker-compose.yml to use .env

### Exercise 4: Multi-stage Build
1. Create a build stage for assets
2. Create a production stage
3. Optimize image size

---

## 🔧 Troubleshooting Common Issues

### 1. **Port Already in Use**
```bash
# Check what's using the port
netstat -an | findstr :8080
# Change port in docker-compose.yml
```

### 2. **Permission Denied**
```bash
# Fix file permissions
docker exec -it <container> chown -R www-data:www-data /var/www/html
```

### 3. **Database Connection Failed**
```bash
# Check if MySQL is ready
docker-compose logs mysql
# Wait for "ready for connections" message
```

### 4. **Container Won't Start**
```bash
# Check logs
docker-compose logs
# Check if ports are available
docker ps
```

---

## 📚 Next Steps in Your Docker Journey

1. **Practice with this app** - Modify and experiment
2. **Learn Docker volumes** - Persistent data storage
3. **Explore Docker networks** - Container communication
4. **Study Docker security** - Best practices
5. **Learn Kubernetes** - Container orchestration
6. **Explore Docker Hub** - Share your images

**Remember: The best way to learn Docker is by doing! 🚀**
