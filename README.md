# Inception
>Containers and Dockers

</p>
<p align="center">
	<a href="#about">About</a> •
  <a href="#implementation">Implementation</a>
</p>

## About

The goal of Inception is to provide an introduction to the world of system administration. By creating and virtualizing three Docker images for three essential and interconnected services: a Wordpress CMS, a MariaDB database, and a NGINX web-server, we effectively simulate a real-world web application environment by leveraging containerization, service orchestration, and network management. This project effectively introduces the concept of containerization and Docker and docker-compose.

## Implementation

The project had the following requirements:

 - NGINX with TLSv1.2 or TLSv1.3.
 - WordPress (installed and configured) using php-fpm, without NGINX.
 - MariaDB as the database server.
 - Volumes to store the WordPress database and website files.
 - A Docker network to connect the containers.
 - Containers must restart automatically in case of failure.
 - Configure a local domain (e.g., yourlogin.42.fr) pointing to your virtual machine's IP.
 -  Use environment variables and .env files for sensitive information like passwords, avoiding hard-coded secrets.
 - The project enforces best practices like avoiding infinite loops, improper use of PID 1, and using proper daemons in Docker.
 - No "hacky patches" like using tail -f or sleep infinity.
 - NGINX must be the sole entry point into the infrastructure, only accessible via port 443.
