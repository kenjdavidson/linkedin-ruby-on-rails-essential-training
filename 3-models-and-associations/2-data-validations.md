# Data Validations

- Ensure that data meets requirements before saving to the database
- Validation code resides in models

> User standards provide validation (early) in JavaSript and also in the Model prior to saving

## Overview of Validation Methods

Most common validation methods:

- `validates_presence_of` - most common and ensures the attribute must not be blank (nil, false, "", " ", [] or {})
- `validates_length_of` - attribute meets length requirement (characters); used with `:is`, `:within` and `:minimum/:maximum`
- `validates_numericality_of` - whether attribute is a number; used with `:greater_than`, `:equal_to`, etc.
- `validates_inclusion_of :status, in: []` - attribute must be within a list of choices
- `validates_exclusion_of :status, in: []`
- `validates_format_of` - uses a regular expression to validate attribute
- `validates_uniqueness_of` - ensures an attribute is not already in the database; for example `:username` or `:email`
- `validates_acceptance_of` - Work with an "accepted" flag when working with `:terms`
- `validates_confirmation_of` - Ensures the user types data correctly by validating a virtual attribute `:password` and `:password_confirmation`
- `validates_associated` Ensures that associated objects must be valid.  Calls `#valid?` on the object or array of objects (does not fail on missing object)

> Watch out for chains of models that may depend on each other, as to not create infinte loops!

Most of items contain:

- `:allow_nil` or `:allow_blank`
- `:if` or `:unless`
- `:message` to supply a custom message

## Write Validations

First start off with considering what needs to be validated - probably the most annoying things.

- What does good data look like?
- What data does bad data look like?
- What would stop the application from working?

> You don't need to validate low level things like `ids` or `foreign_keys`

## Use the Multipurpose Validates Method

Here is an example of validations:

```
validates_presences_of :email
validates_length_of :email, maxiumum: 50
...
```

which can also be written as:

```
validates :email, presence: true,
    length: { maximum: 50 },
    ...
```

where the hash of validations is passed in:

## Write Custom Validations

It's possible to build your own!

```
validate :custom_method

private

def custom_method
  if test_case 
    errors.add(:attribute, "message")
  end 
end
```

> Custom validations can hit the DB, hit an API, pretty much anything that needs to validate an attribute

## How to Skip Validations

> Can be dangerous and only done when absolutely required!

- `record.save(validate: false)`
- `record.update_columns(:name => value)`
- `record.update_column(:name, value)`
- `relation.update_all(:name => value)` - is used to mass update tables using a `Relation`

## Challenge: Validations

- [x] Attempt to write 5 validations (subject: name, position; page: name, permalink, content; user: first, last, email)
- [x] Attempt to trigger in rails console

