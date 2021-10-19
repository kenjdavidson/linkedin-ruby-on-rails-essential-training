#!/bin/bash

# Attempting to bypass some best practices due to the original examples files and not wanting to
# modify them all whenever they are downloaded we're going against the grain.
# The Docker image contains both Ruby (app) and MariaDB (database) which isn't the best, but in
# order to get this working we need to:

set -e

# Start the Database on load
service mysql start
mysql -e "create database if not exists simple_cms_development"
mysql -e "create user if not exists 'rails_user'@'localhost' identified by 'rails_user'"
mysql -e "grant all privileges on simple_cms_development.* to 'rails_user'@'localhost'"

# Run bundle install
bundle install

# Run node install
yarn install

# Migrate railes
rails db:migrate

# Run the arguments provided
exec "$@"