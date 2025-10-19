@echo off
echo 🐳 Docker Learning Commands
echo ==========================
echo.

REM 1. Basic Docker Information
echo 1. Docker Version and Info:
echo docker version
docker version
echo.

echo docker info
docker info
echo.

REM 2. List Images
echo 2. List Docker Images:
echo docker images
docker images
echo.

REM 3. List Containers
echo 3. List Running Containers:
echo docker ps
docker ps
echo.

echo 4. List All Containers:
echo docker ps -a
docker ps -a
echo.

REM 4. Build the Image
echo 5. Building PHP App Image:
echo docker build -t php-learning-app .
docker build -t php-learning-app .
echo.

REM 5. Run the Container
echo 6. Running PHP App Container:
echo docker run -d -p 8080:80 --name php-app-container php-learning-app
docker run -d -p 8080:80 --name php-app-container php-learning-app
echo.

REM 6. Check Container Status
echo 7. Container Status:
echo docker ps
docker ps
echo.

REM 7. View Container Logs
echo 8. Container Logs:
echo docker logs php-app-container
docker logs php-app-container
echo.

REM 8. Execute Commands in Container
echo 9. Execute Command in Container:
echo docker exec php-app-container php -v
docker exec php-app-container php -v
echo.

REM 9. Inspect Container
echo 10. Container Details:
echo docker inspect php-app-container
docker inspect php-app-container
echo.

REM 10. Container Stats
echo 11. Container Resource Usage:
echo docker stats php-app-container --no-stream
docker stats php-app-container --no-stream
echo.

echo 🌐 Your PHP app should now be running at: http://localhost:8080
echo.
echo To stop the container: docker stop php-app-container
echo To remove the container: docker rm php-app-container
echo To remove the image: docker rmi php-learning-app
pause
