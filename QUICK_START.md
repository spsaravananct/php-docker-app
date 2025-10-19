# 🚀 Quick Start Guide

## For Your Other Laptop (Testing)

### Step 1: Copy Files
Copy this entire folder to your other laptop:
- All PHP files
- `docker-compose.yml`
- `setup.bat` (Windows) or `setup.sh` (Linux/Mac)
- `php-docker-app.tar` (Docker image)

### Step 2: Install Docker Desktop
1. Download from: https://www.docker.com/products/docker-desktop
2. Install and start Docker Desktop
3. Wait for it to fully load (green icon in system tray)

### Step 3: Run the App
**Windows:**
```cmd
# Double-click setup.bat
# OR run in Command Prompt:
setup.bat
```

**Linux/Mac:**
```bash
chmod +x setup.sh
./setup.sh
```

### Step 4: Access the App
- Open browser: http://localhost:8080
- Database admin: http://localhost:8081

---

## Alternative: Load Docker Image

If you have the `php-docker-app.tar` file:

```bash
# Load the Docker image
docker load -i php-docker-app.tar

# Start the application
docker-compose up -d
```

---

## What You'll See

✅ **Beautiful PHP application** with user management
✅ **Working database** with sample data
✅ **phpMyAdmin** for database management
✅ **No conflicts** with existing services

---

## Troubleshooting

**Port already in use?**
- Change ports in `docker-compose.yml`
- Or stop conflicting services

**Docker not starting?**
- Restart Docker Desktop
- Check if virtualization is enabled

**Database connection failed?**
- Wait 30 seconds for MySQL to start
- Check logs: `docker-compose logs`

---

## Stop the App
```bash
docker-compose down
```

**That's it! Your PHP app is now running on any computer with Docker Desktop! 🎉**
