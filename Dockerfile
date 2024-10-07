# Set the base image to PHP 8.2 with Apache
FROM php:8.2-apache

# Install required packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libxslt-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libicu-dev \
    libxslt1-dev \
    libmagickwand-dev --no-install-recommends \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-install soap xsl intl bcmath opcache sockets zip \
    && pecl install xdebug && docker-php-ext-enable xdebug

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set document root to Magento's public directory
ENV APACHE_DOCUMENT_ROOT /var/www/html/pub

# Update the default apache configuration to point to Magento's public directory
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

# Install Node.js and npm for frontend dependencies
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g grunt-cli

# Set up Magento application directory
WORKDIR /var/www/html

# Copy the existing app codebase into the container (if you have your code in the same directory as Dockerfile)
COPY . .

# Set permissions for the Magento installation
RUN chown -R www-data:www-data /var/www/html \
    && find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} + \
    && find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} + \
    && chmod u+x bin/magento

# Database environment variables (use public database)
ENV DB_HOST=65.21.12.12:5557
ENV DB_NAME=postgres
ENV DB_USER=postgres
ENV DB_PASSWORD=OiioNv0zo0KMM7GKfhjiR9PM1A7QDX8m3wc0sf5jigXlnjhFD3B95KkjYrcvK5ld

# Expose the Apache port
EXPOSE 80

# Copy the entrypoint script into the container
COPY docker-entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["docker-entrypoint.sh"]
