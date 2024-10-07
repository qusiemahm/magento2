# Set the base image to use PHP and Apache
FROM php:8.1-apache

# Install required packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libxslt-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-install soap xsl intl bcmath opcache \
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

# Copy the existing app codebase into the container
COPY . .

# Set permissions for the Magento installation
RUN chown -R www-data:www-data /var/www/html \
    && find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} + \
    && find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} + \
    && chmod u+x bin/magento

# Expose ports
EXPOSE 80

# Start Apache in foreground
CMD ["apache2-foreground"]
