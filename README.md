# Docker Symfony

This project uses Docker to create a local development environment for a Symfony application. It includes Docker services such as Nginx, PHP-FPM, MySQL, and phpMyAdmin.

## Prerequisites

Make sure you have the following software installed on your machine:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Project Contents

This project uses Docker Compose to manage multiple services necessary for running your Symfony application. Here are the included services:

- **Nginx**: Web server to serve the Symfony application.
- **PHP-FPM**: PHP interpreter configured to work with Symfony.
- **MySQL**: Database server to store application data.
- **phpMyAdmin**: Web interface to easily manage the MySQL database.

## Installation

Follow these steps to set up your local development environment:

### Step 1: Clone the Project Repository

Clone this Git repository to your local machine:

```bash
git clone git@github.com:lrxgregory/docker-symfony.git
cd docker-symfony
```

### Step 2 : Create a `.env` file

Create a .env file at the root of the project with the following information (replace as necessary):

```
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=appdb
MYSQL_USER=user
MYSQL_PASSWORD=password
```

### Step 3 : Build Docker Images

Build the necessary Docker images to run the services:

```bash
docker compose build
```

### Step 4: Start the Services

Start the Docker services in detached mode:

```bash
docker compose up -d
```

### Step 5 : Install Symfony

Access the PHP container shell to install Symfony:

```bash
docker exec -it <nom_du_container_php> bash
composer create-project symfony/skeleton:"7.1.*" my_project
cd my_project
composer require webapp
```

If you are creating an API or microservice, use this command:

```bash
composer create-project symfony/skeleton:"7.1.*" my_project
```

> **Note** : If you change the name of the folder `my_project`, don't forget to update the `nginx.conf` file at the following line :
> 
> ```
> root /var/www/html/my_project/public;
> ```

### Step 6 : Update the .env inside the Symfony application

Don't forget to update the `.env` file in your symfony folder to be able to use doctrine :

```
#Add variables at the beginning of the .env file:
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=appdb
MYSQL_USER=user
MYSQL_PASSWORD=password

#Change the DATABASE_URL as shown here:
# DATABASE_URL="mysql://app:!ChangeMe!@127.0.0.1:3306/app?serverVersion=8.0.32&charset=utf8mb4"
=> DATABASE_URL="mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@mysql:3306/${MYSQL_DATABASE}?serverVersion=8.4.2&charset=utf8mb4"
```

### Step 7 : Accessing  the Symfony Application

Your Symfony application will be available at the following address: [http://localhost:8080](http://localhost:8080).

### Step 8 : Stop the Services

To stop and delete Docker containers, use the following command:

```bash
docker compose down
```

## Accessing the Services

- **Symfony Application (via Nginx)**: [http://localhost:8080](http://localhost:8080)
- **phpMyAdmin**: [http://localhost:8081](http://localhost:8081)
  * MySQL Server: `mysql`
  * Username: `${MYSQL_USER}`
  * Password: `${MYSQL_ROOT_PASSWORD}`

## Database Management

### MySQL Connection via SQL Client

You can use a database client such as TablePlus, MySQL Workbench, or DBeaver to connect to the MySQL database using the following information:

- Host: `localhost`
- Port: `3306`
- Username: `${MYSQL_USER}`
- Password: `${MYSQL_PASSWORD}`
- Database Name: `${MYSQL_DATABASE}`

## Rebuilding Docker Images

If you modify the `Dockerfile` or `docker-compose.yml`, you will need to rebuild the Docker images to apply the changes:

```bash
docker compose build --no-cache
```

## Viewing Logs

To monitor container logs and debug potential errors:

```bash
docker compose logs -f
```

## Persistent Volumes

To ensure that MySQL data is persistent between container stops, a Docker volume is used for the database. If you need to delete the data, you can do so by removing this volume:

```bash
docker volume rm docker-symfony_data
```

