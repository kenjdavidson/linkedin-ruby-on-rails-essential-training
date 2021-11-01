# Smarter Models

## Non-database attributes

In Ruby, attributes can be created on new instances:

- `attr_reader`
- `attr_writer`
- `attr_accessor`

In Ruby on Rails this doesn't happen as much, as they are generally created with `ActiveRecord` by looking at the database columns.  We can use values, not saved in the database, for:

- Setting temporary states

In this example we have the ability to store information in the `Payment` object, but will not be saved to the database:

```
class Payment < ApplicationRecord
    attr_writer :cc_number
    attr_reader :transaction_error

    def process!
        result = PaymentProcessor.charge(@cc_number)
        @transaction_error = result.error
    end
end

payment = Payment.new(payment_params)
payment.process!
@error = payment.transaction_error
```

## Smart Models by Design

It's important to configure which **interfaces** make sense - attempting to follow:

> Fat model, skinny controller

Moving business logic out of controllers and into the model.

> What kinds of things should an instance (object) know what to do?  

Things like:

- `full_name` concat the first and last name
- `recent` used to compare a created_at to a month ago?

### Not Too Fat

If you find yourself:

- Using XML, CSS, JSON, etc.
- Using view formatting helpers

you might be doing to much in the models.

## More ActiveRecord Query Methods

- `where(visible: true)` find all where visible is true
- `where(visible: true, sold_out: false)` used with a hash of attribute settings
- `where(visible: true).where("created_at < ?", Time.now)` to get around `<` issues in Hash format.  Multiple `where` clauses will be chained together with `AND`
- `where(visible: true).where.not("created_at < ?", Time.now)` applies a `NOT` to the and

Some other modifiers:

- `order("column ASC")`
- `limit(number:)`
- `offset(number: start)` 
- `all` 

Queries don't actually get fired until a certain set of methods are called (display-ish methods):

- `first` which takes the given order and adds `LIMIT 1` and fires the query right away
- `last` does the same as first but reverses order first
- `each`

## Query Data Selection

Specify the data to select:

### count

Returns the number of items that would be returned based on the query, where the following (although the same) is more effecient:

- `Product.where(sold_out: false).count  #-> 5`
- `Product.where(sold_out: flase).all.length #-> 5`

### select

Choose the columns that we wish to return - creating the same `Product` object but only populated.

> Kevin don't like!

```
product = Product.select(:id, :name).first
product.name 
product.id
product.description # ERROR
```

> This is where the annoyance is with Ruby, I would expect `product.description` to return nil or something else instead of throw an error.  This is where my preference of typed languages comes in.

### pluck

Instead of creating a full object, it returns an Array of data.

```
Product.where(active: true).pluck(:id, :name)
=> [[1, "Product Name"], ...]
```

### ids

Return an Array of `id` values matching the clause.

```
Product.where(active: true).ids
```

## Named Scopes

Provides standard, custom queries that are used repeatedly.  The following creates named clause/query that can be used and joined with others:

```
class Product < ApplicationRecord
    scope :active, lambda { where (active: true) }
    scope :sorted, lambda { order(:name) } 
    scope :recent, -> { where("created_at < ?", 1.week.ago) }
end 

Product.active.recent.sorted
```

> Scopes can be chained like all other queries.

Scopes can also take arguments:

```
scope :search, lambda { |keyword|
    where("LOWER(name) LIKE ?", "%#{kw.downcase}")
}

# When using the -> the brackets are required to accept arguments.
scope :search, -> (keyword) { |keyword| 
    where("LOWER(name) LIKE ?", "%#{kw.downcase}")
}
```

## Challenge: Named Scopes

- [x] Add scopes for :visible and invisible to Page
- [x] Add scope for :sorted to Subject, Page and User
- [x] Search subjects.name for a keyword

