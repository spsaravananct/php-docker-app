# 🚀 PHP Docker Application

A modern, containerized PHP application with Apache, MySQL, and phpMyAdmin. Perfect for development, testing, or learning Docker with PHP.

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

## ✨ Features

- 🐘 **PHP 8.2** with Apache web server
- 🗄️ **MySQL 8.0** database
- 🎨 **phpMyAdmin** for database management
- 📱 **Responsive design** with modern UI
- 🔧 **CRUD operations** for user management
- 🐳 **Docker containerized** for easy deployment
- 🚀 **One-click setup** with automated scripts

## 🚀 Quick Start

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop) installed and running

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/php-docker-app.git
   cd php-docker-app
   ```

2. **Run the setup script:**
   
   **Windows:**
   ```cmd
   setup.bat
   ```
   
   **Linux/Mac:**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. **Access the application:**
   - **Main App**: http://localhost:8080
   - **phpMyAdmin**: http://localhost:8081

## 🎯 What You Get

- **User Management System** - Add, view, and delete users
- **Sample Data** - Pre-loaded with example users
- **Database Admin** - Full phpMyAdmin interface
- **Modern UI** - Clean, responsive design
- **No Conflicts** - Uses different ports than WAMP/XAMPP

## 🛠️ Manual Setup

If you prefer manual setup:

```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# View logs
docker-compose logs

# Restart services
docker-compose restart
```

## 🌐 Access URLs

| Service | URL | Description |
|---------|-----|-------------|
| **Main App** | http://localhost:8080 | PHP application |
| **phpMyAdmin** | http://localhost:8081 | Database management |
| **MySQL** | localhost:3307 | Database server |

## 🔑 Database Credentials

- **Username**: `phpuser`
- **Password**: `phppass`
- **Database**: `phpapp`
- **Root Password**: `rootpass`

## 📁 Project Structure

```
php-docker-app/
├── index.php              # Main application file
├── config.php             # Database configuration
├── init.sql               # Database initialization
├── Dockerfile             # PHP/Apache container config
├── docker-compose.yml     # Multi-container setup
├── setup.bat              # Windows setup script
├── setup.sh               # Linux/Mac setup script
├── .gitignore             # Git ignore rules
└── README.md              # This file
```

## 🔧 Customization

### Change Ports
Edit `docker-compose.yml` to use different ports:
```yaml
ports:
  - "8080:80"    # Change 8080 to your preferred port
  - "3307:3306"  # Change 3307 to your preferred port
  - "8081:80"    # Change 8081 to your preferred port
```

### Add New Features
- Modify `index.php` for new functionality
- Update `init.sql` for database changes
- Add new PHP files as needed

## 🐛 Troubleshooting

### Common Issues

**Port already in use:**
```bash
# Check what's using the port
netstat -an | findstr :8080
# Change ports in docker-compose.yml
```

**Docker not running:**
- Start Docker Desktop
- Wait for it to fully load (green icon)

**Database connection failed:**
- Wait 30 seconds for MySQL to start
- Check logs: `docker-compose logs mysql`

**Permission denied (Linux/Mac):**
```bash
sudo chmod +x setup.sh
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -m 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🌟 Show Your Support

Give a ⭐️ if this project helped you!

## 📞 Support

If you have any questions or issues:
1. Check the [troubleshooting section](#-troubleshooting)
2. Open an [issue](https://github.com/YOUR_USERNAME/php-docker-app/issues)
3. Check the [Docker Desktop documentation](https://docs.docker.com/desktop/)

---

**Made with ❤️ using Docker and PHP**