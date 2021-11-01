# ActiveRecord Associations

## Working with Associations

### One to One 

One object is related to one and only one object.

In our example we have `Page:Subject` where page can only have a single Subject.

- `has_one` <- `belongs_to`

### One to Many

One object has many other objects.

In our exmaple we have `Subject:Page` where a subject has many Pages

- `has_many` <- `belongs_to`

### Many to Many

An object can have multiple other objects and vice versa.  

For example `SchoolSubject` might have multiple `Students` and a `Student` has multiple `SchoolSubjects`.

This is created using a join table containing the IDs of each objects which are related.

- `has_many` <-> ``

## Validate Presence with Belongs_to

`belongs_to` the other object is not optional, a Page that belongs to a Subject will not allow save to occur.

> This means that the manual validation I added in the previous section was not required.  (Ruby on Rails 5)

This validation can be disbabled using `{ optional: true }`

## Destroy Dependent-Related Records

Automatically cascades removal of dependent objects.

> I would have thought this would have been setup as cascade on the database (but I guess that's not database independent).

Automatically add the callback with

```
# Adds a callback after destroy that would delete all related
has_many :comments, dependent: destroy
```

> There is another option `delete_all` although delete_all skips callbacks within object being destroyed.  `destroy` allows for the hierarchy of callbacks.

## Has and Belongs To Many Relationships

Used when an object has many objects that belong to it, but not exclusively. 

This creates a Join Table with two foreign keys (which should be indexed).  For example we have:

- User
- Department

```
# departments_users table

# User
has_and_belongs_to_many :departments

# Department
has_and_belongs_to_many :users
```

> When creating a join table, the following is used: first_table_second_table but.... alphabetical order & plural names!!

To generate this use the command:

```
rails generate migration CreateJoinTableModelNames model1 model2
```

- `JoinTable` within the name
- `model1` and `model2` 

```
root@692b61a26441:/simple-cms# rails generate model Department name:string
Running via Spring preloader in process 455
      invoke  active_record
      create    db/migrate/20211021221124_create_departments.rb
      create    app/models/department.rb
      invoke    test_unit
      create      test/models/department_test.rb
      create      test/fixtures/departments.yml
root@692b61a26441:/simple-cms# rails generate migration CreateJoinTableDepartmentsUsers departments users
Running via Spring preloader in process 464
      invoke  active_record
      create    db/migrate/20211021221209_create_join_table_departments_users.rb
```

> Indexes must be created manually

### View Helpers

When working with views the helper

```
<%= f.collection_check_boxes(:department_ids, opts, :id, :name) %>
```

Which will display a list of check boxes to allow multiple selection.  When managing this in the controller, the `params` must be updated

```
# Department_ids must be added with a blank array to be populated
def user_params
      params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            {:department_ids => []}
      )
end
```

## Rich Join Associations

If we need to keep track of things like:

- the students seat number within a class
- the students grade within a class
- etc

when the content of the join has more state that needs to be maintained.  For example, instead of `courses_students` it would be something like `course_enrollments` which would maintain not only the `course_id` and `student_id` it will contain all the remaining items.

> Names than end in -ments or -ships work well for models with regards to Rich Joins

### Page Assignment

In order to assign a user to a page - with a specific role.

```
# migrations should be updated with more info
# index created on page_id and user_id together
create_table :page_assignments do |t|
      t.references :page, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
      t.index [:page_id, :user_id]
      t.index [:user_id, :page_id]
    end
```

## Traversing Rich Page Associations

Working with

```
user.departments # => [department1, department2]
```

With a rich join this isn't possible:

```
user.page_assignments[0].page
```

To get around this we use `has_many :through` which then allows a knew association:

```
# page.rb
has_many :users, :through => :page_assignments
```

## Joining Tables During Queries

It may be required to join tables during the query itself, this can be done using the `joins` method:

```
# Allow where to reference joined table
Product.joins(:category).where("categories.active = 1")

# Hash format
Product.joins(:category).where(categories: { active: true })
```

Will still return a list of `Product` objects.

> `joins` uses the association from the `Model` while `where` uses the table name (plural)