# Databases and Migrations

## Create a Database fo Ruby on Rails

In the getting starter the database was created:

```
show databases;
create database <name>;
```

In order to test the database is working, we can run:

```
rails db:schema:dump
```

which is a general command to dump the database.

> We don't generally care about the contents, just the fact that it creates the file.

Rails convention is to have three database:

- <name>_development
- <name>_test
- <name>_production

## Write Migrations to Define Database Changes

There are a number of requirements for defining database tables:

### Legacy

There may already be a database available which will be used with new software.

### Manually

Manually running on the `sql` cli.

### Migrations

**migrate** the database from one state to another (both forward and backwards).

- `up`
- `down` is required to perform the opposite steps as `up`

Migrations couple the schema with the application code.
Migrations are executable and repeatable.
Allow sharing schema changes with other developers.
Allow writing of Ruby code, instead of SQL.
Have access to all the access code - incase we need to pre-populate a table with data from another table.

## Use the Command Line to Generate Migrations

There are two methods for generating migrations:

1. `rails generate migration MigrationName` 
- for example something like `reails generate migration AddUserTable`

2. `rails generate model ModelName` 
- which both creates Model and Migration

Migrations are stored within `db/migrate` and are created with:

- A timestamp to keep migration unique
- Camel cased name converted to snake case

There are three main options for the migration:

```
class DoNothingYet < ActiveRecord::Migration[6.0]
  
  # Default that Rails attempts to intuit
  def change
  end

  # Long form version of going forward
  def up
  end 

  # Long form version of going back
  def down
  end
end
```

The main migration methods are:

- `create_table`
- `drop_table`
- `rename_table`
- `add_column`
- `remove_column`
- `rename_column`

Others include options for:

- Creating keys
- Creating indexes

### Models

To create a Model with migrations we can use:

```
root@1af1da1d7487:/simple-cms# rails generate model User first_name:string last_name:string email:string
Running via Spring preloader in process 1270
      invoke  active_record
      create    db/migrate/20211009223832_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
```

which will:

- scaffold the model
- scaffold the migration
- scaffold the tests

> Default table names are snake cased, lower case and plural.

### ID Column

Rails automatically generates an auto increment `:id` field.  There are some options available for modifying the id to different types.

## Run Migrations 

Now that the migrations have been created we need to tell rails to run them so that the database is brought up to that state:

```
root@1af1da1d7487:/simple-cms# rails db:migrate
== 20211009223832 CreateUsers: migrating ======================================
-- create_table(:users)
   -> 0.0292s
== 20211009223832 CreateUsers: migrated (0.0292s) =============================
```

> Ruby `puts` commands can be used to perform logging during the processing.

### schema_migrations

The table used to manage the current migration state of the database.  There is one column `version` that store the timestamp(s) of the migrations that have already been run.

### Status

The current status can be requested using: 

```
root@1af1da1d7487:/simple-cms# rails db:migrate:status

database: simple_cms_development

 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20211009223832  Create users
```

## Challenge: Migrations for the CMS

Create the migrations we need for the CMS.  To get an idea of requirements:

- Navigation showing `subjects`
- Each subject has a number of `pages`

Generate the following models:

1. Subjects
- name (string)
- position (integer)
- visible (boolean)

2. Pages
- subject_id (integer)
- name (string)
- permalink (string)
- position (integer)
- visible (boolean)
- content (text) 

> Text (compared to String) will provide substantially more space for content

### Foriegn Keys

Foreign keys can be created in a number of ways:

- t.integer :subject_id, index:true
- t.references :subject
- t.belongs_to :subject

### Solution

The `belongs_to :subject` was added manually, originally when attempting to add this to the `generate` command things went bad.