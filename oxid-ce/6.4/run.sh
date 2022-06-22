#!/bin/bash

SCRIPT_PATH=$(dirname ${BASH_SOURCE[0]})

cd $SCRIPT_PATH/../../../../ || exit

git clone https://github.com/OXID-eSales/oxideshop_ce.git --branch=b-6.4.x source

# Prepare services configuration
make setup
make addbasicservices
make file=services/selenium-chrome.yml addservice

# Configure containers
perl -pi\
  -e 's#PHP_VERSION=.*#PHP_VERSION=7.4#g;'\
  .env

perl -pi\
  -e 's#/var/www/#/var/www/source/#g;'\
  containers/httpd/project.conf

# Configure shop
cp source/source/config.inc.php.dist source/source/config.inc.php

perl -pi\
  -e 's#<dbHost>#mysql#g;'\
  -e 's#<dbUser>#root#g;'\
  -e 's#<dbName>#example#g;'\
  -e 's#<dbPwd>#root#g;'\
  -e 's#<dbPort>#3306#g;'\
  -e 's#<sShopURL>#http://localhost.local/#g;'\
  -e 's#<sShopDir>#/var/www/source/#g;'\
  -e 's#<sCompileDir>#/var/www/source/tmp/#g;'\
  source/source/config.inc.php

# Start all containers
make up

# Run dependencies installation and reset the shop to development state
docker-compose exec -T php composer update --no-interaction
docker-compose exec -T php php vendor/bin/reset-shop

mkdir -p ./source/var/configuration/environment
cp $SCRIPT_PATH/environment/1.yaml ./source/var/configuration/environment/1.yaml
docker-compose exec -T php php bin/oe-console oe:module:apply-configuration

echo "Recipe done!"