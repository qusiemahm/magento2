#!/bin/bash

# Check if Magento is already installed
if [ ! -f /var/www/html/app/etc/env.php ]; then
    # Run the Magento setup install command
    php -d memory_limit=2G bin/magento setup:install \
    --base-url=https://y4g8og40wwowgc8ks4gc0g0k.65.21.12.12.sslip.io \
    --db-host=pk804wcwsssgk00ggkgg4gs4:3306 \
    --db-name=default \
    --db-user=root \
    --db-password=zOAITDJSs6cBmBFQxNDQnRi823TgpGmwpy77O2REWh2AKpOWUrhsFdiQiMZpHd6j \
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
    --opensearch-host=http://ig0so00g0k0cwkckwk848os4.65.21.12.12.sslip.io \
    --opensearch-port=9200 \
    --opensearch-username=admin \
    --opensearch-password=cyb86*hmWP6Hx7 \
    --opensearch-index-prefix=magento2 \
    --opensearch-timeout=15
fi

# Start Apache in the foreground
apache2-foreground
