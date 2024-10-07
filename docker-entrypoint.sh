#!/bin/bash

# Check if Magento is already installed
if [ ! -f /var/www/html/app/etc/env.php ]; then
    # Run the Magento setup install command
    php -d memory_limit=2G bin/magento setup:install \
    --base-url=https://rooc0cg8coo0s4c8scgko4ss.65.21.12.12.sslip.io \
    --db-host=mysql \
    --db-name=magento \
    --db-user=magento_user \
    --db-password=magento_password \
    --admin-firstname=admin \
    --admin-lastname=admin \
    --admin-email=admin@admin.com \
    --admin-user=admin \
    --admin-password=admin123 \
    --language=en_US \
    --currency=USD \
    --timezone=America/Chicago \
    --use-rewrites=1 \
    --search-engine=opensearch \
    --opensearch-host=http://opensearch \
    --opensearch-port=9200 \
    --opensearch-username=admin \
    --opensearch-password=cyb86*hmWP6Hx7 \
    --opensearch-index-prefix=magento2 \
    --opensearch-timeout=15
fi

# Start Apache in the foreground
apache2-foreground
