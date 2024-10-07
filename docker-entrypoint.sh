#!/bin/bash

# Check if Magento is already installed
if [ ! -f /var/www/html/app/etc/env.php ]; then
    # Run the Magento setup install command
    bin/magento setup:install \
    --base-url=http://localhost/magento2ee \
    --db-host=db-hostname \
    --db-name=magento \
    --db-user=magento \
    --db-password=magento \
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
    --opensearch-host=os-host.example.com \
    --opensearch-port=9200 \
    --opensearch-index-prefix=magento2 \
    --opensearch-timeout=15
fi

# Start Apache in the foreground
apache2-foreground
