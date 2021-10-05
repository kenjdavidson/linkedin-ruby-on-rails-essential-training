# Getting Started with Ruby on Rails

## Create a new Ruby on Rails project

First start up the container

> This is using the original contain which expects a `simple-cms` folder, but that's out of laziness it could have been anything really:

Once the container is started up, the new project is created in the current working directory:

```
$> docker run -v ${pwd}:/simple-cms -it --rm rails-essential-training /bin/bash
$ /simple-cms# rails new . -d mysql
```

## Examine the Structure of a Ruby on Rails Project

### App

Most of the code.  Three main subdirectories:

- `models`
- `controllers`
- `views`

Other items are:

- `helpers` which should be thought of as _view helpers_
- `assets` 
- `javascript` which was pulled out of `assets` in Rails 6

### Config

All the configuration is found in this folder

### DB

Database related files:

- `migrations`
- `schema`
- `seeds` initial data

### Public

Contains a number of the static files that a regular website should contain:

- `404.html`
- `500.html`

> From looking around it seems like one of the main complains is that the error files are not handled through views.  Although based on the Rack middleware this should be possible.

### Vendor

- Ruby gems for 3rd party libraries

## Configure a Ruby on Rails Project

### Application.rb

Although there are settings here, it's unlikely that it will be edited.  The two better places are:

- `initializers` are run during boot
- `environments`

### Database.yml

Previous versions of Rails didn't require a database to be setup, this is changed and now this is required.

1. Create the database in mysql

```
show databases;
create simple_cms_development
```

2. Create a new user for accessing the database

```
select host, user from mysql.user;
create user 'rails_user'@'localhost' identified by 'rails_user';
```

3. Grant privileges on the databs

```
show grants for 'username'@'localhost'
grant all privileges on simple_cms_development.* to 'username'@'localhost'
```

## Access a Ruby on Rails Project from Browser

Start up the project

```
$ /simple-cms# rails server
=> Booting Puma
=> Rails 6.1.4.1 application starting in development
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.5.0 (ruby 2.6.5-p114) ("Zawgyi")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 1296
* Listening on http://127.0.0.1:3000
Use Ctrl-C to stop
```

> or `rails s` for short

During startup may get an error regarding `webpack` asking you to run:

```
$ /simple-cms# rails webpacker:install
```

which will install the:

- `webpacker.yml` configuration
- `node_modules`
- other good things
