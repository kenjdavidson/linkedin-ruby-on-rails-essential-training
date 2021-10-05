#!/bin/bash

# Attempting to bypass some best practices due to the original examples files and not wanting to
# modify them all whenever they are downloaded we're going against the grain.
# The Docker image contains both Ruby (app) and MariaDB (database) which isn't the best, but in
# order to get this working we need to:

set -e

# Start the Database on load
service mysql start
mysql -e "create database simple_cms_development"
mysql -e "create user 'rails_user'@'localhost' identified by 'rails_user'"
mysql -e "grant all privileges on simple_cms_development.* to 'rails_user'@'localhost'"

# Run bundle install
bundle install

# Run node install
yarn install

# Run the arguments provided
exec "$@"