# Models and ActiveRecord

## Understanding ActiveRecord and ActiveRelation

Active record is a design pattern for relational database.  This design pattern is implemented with `ActiveRecord`.

### ActiveRecord

- Understand structure
- Contain data
- Contain interactions 

```
# Creates a new object referencing the `users` table
user = User.new
user.first_name = "Ken"
user.save   # Inserted

user.last_name = "Davidson"
user.save   # Updated

user.destroy # Deleted
```

### ActiveRelation

Also called `Arel` is an object oriented interpretation of relational algebra.

- Small queries can be chained together
- Complex joins and aggregations that use efficient SQL

```
# Active relation query
users = User.where(first_name: "Ken")
users = users.order("last_name ASC").limit(5)
```

> This query doesn't go to the database right away, only a subset of methods will force the query to occur.

```
# Now the query(ies) are made
users.each { |user| ... }
```

## Using the Rails Console 

Rails console lets you interact with the rails environment in isolation.

```
# Development is the default -e
root@1af1da1d7487:/simple-cms# rails console -e development
Running via Spring preloader in process 1376
Loading development environment (Rails 6.1.4.1)
irb(main):001:0>
```

## Create Record using ActiveRecord

There are two ways to go about this:

- `new` and `save` 
- `create` all in one

## Update Record using ActiveRecord

Another two techniques for going about this:

- `find`, set values and `save`
- `update` which is passed updated fields and then performs sql 

## Delete Record using ActiveRecord

There is one process for this:

- `find` and `destroy`

> Method name is `destroy` even though the action is `delete`.  There is also a method `delete` which does the same thing, but bypasses Rails features and could cause some issues.

> Once the ActiveRecord is deleted, the object remains available using a frozen hash so that the content is still available for display.

## Find Record(s) using ActiveRecord

There are a number of tools available for finding record(s):

- `Subject.find(id)` perform a lookup on the subject table using the `id` primary key
- `Subject.where(condition: hash)` accepts multiple key/value pairs to lookup column details
- `Subject.where(['visible = 1 and position < ?'], @positionQuery)` accepts an SQL fragment

> Never interpolate into the String (SQL injection)

- `Subject.limit(20).offset(100)` would get the items 100 to 120

## Define One-to-Many Associations

There are a number of relations.  Once 

- one to one
- one to many
-  many to many

The relationships must be defined in the Model:

```
class Subject < ActiveRecord
  # Lower snake plural of type
  has_many :pages
end

class Page < ActiveRecord
  belongs_to :subject
end
```