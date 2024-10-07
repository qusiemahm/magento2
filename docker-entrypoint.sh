#!/bin/bash

# Check if Magento is already installed
if [ ! -f /var/www/html/app/etc/env.php ]; then
    # Run the Magento setup install command
    bin/magento setup:install \
    --base-url=http://y4g8og40wwowgc8ks4gc0g0k.65.21.12.12.sslip.io \
    --db-host=65.21.12.12:5557 \
    --db-name=postgres \
    --db-user=postgres \
    --db-password=OiioNv0zo0KMM7GKfhjiR9PM1A7QDX8m3wc0sf5jigXlnjhFD3B95KkjYrcvK5ld \
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
