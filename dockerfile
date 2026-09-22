# Imagen base para GitHub Codespaces / Dev Containers
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Evita preguntas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar Ubuntu e instalar Apache y MySQL
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    mysql-server \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Crear carpeta necesaria para que MySQL pueda iniciar
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld

# Configuración básica de Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Crear una página de prueba para Apache
RUN echo '<!DOCTYPE html> \
<html lang="es"> \
<head> \
    <meta charset="UTF-8"> \
    <title>Apache + MySQL</title> \
</head> \
<body> \
    <h1>Apache funcionando correctamente</h1> \
    <p>Servidor ejecutándose desde GitHub Codespaces.</p> \
</body> \
</html>' > /var/www/html/index.html

# Puerto de Apache
EXPOSE 80

# Puerto de MySQL
EXPOSE 3306
