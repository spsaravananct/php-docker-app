#!/bin/bash

echo "========================================"
echo "   PHP Docker App Setup Script"
echo "========================================"
echo

echo "Checking if Docker is running..."
if ! docker version >/dev/null 2>&1; then
    echo "ERROR: Docker is not running!"
    echo "Please start Docker Desktop and try again."
    exit 1
fi

echo "Docker is running ✓"
echo

echo "Starting PHP Docker Application..."
echo "This will download and start the following services:"
echo "- PHP/Apache web server (port 8080)"
echo "- MySQL database (port 3307)"
echo "- phpMyAdmin (port 8081)"
echo

docker-compose up -d

if [ $? -eq 0 ]; then
    echo
    echo "========================================"
    echo "   Setup Complete! ✓"
    echo "========================================"
    echo
    echo "Your PHP application is now running:"
    echo
    echo "🌐 Main App:    http://localhost:8080"
    echo "🗄️  phpMyAdmin:  http://localhost:8081"
    echo
    echo "Database credentials:"
    echo "- Username: phpuser"
    echo "- Password: phppass"
    echo "- Database: phpapp"
    echo
    echo "To stop the application, run: docker-compose down"
    echo
else
    echo
    echo "ERROR: Failed to start the application!"
    echo "Please check the error messages above."
    exit 1
fi

