# ActiveRecord Callbacks

## Overview of Callbacks

Provide a way to intervene in an objects life cycle:

- before saving
- after saving
- etc

which can be used to run code automatically.

| Create | Update | Destroy | 
| --- | --- | --- |
| before_validation | before_validation | |
| after_validation | after_validation | |
| before_save | before_save | |
| before_create | before_update | before_destroy |
| after_create | after_update | after_destroy |
| after_save | after_save | after_destroy |
| after_commit | after_commit | after_commit |

> `after_create`, `after_update` and `after_save` provide the option to rollback the transaction.

Some things you'd like to do:

- Logging
- Set values
- Send email or API call regarding change
- Housekeeping of other models

## Use Calbacks to Automate Actions

Some hook examples that might want to be done:

1. `before_validation` you might want to run a `format_phone` that cleans up the phone number
2. `before_save` we want to lookup the lon/lat values of the users address.  We only care about this after we know the data is valid
3. `after_commit` we might want to fire a notification (microservice communication)

## Execute Callbacks Conditionally

Execute callbacks only when conditions are met - this is cleaner than executing the contition within the method.

```
# Only notify after save, if it matches :should_notify?
after_save :notify_new_thing, if: :should_notify?
```

Can also be used with a code bock:

```
# `c` is the actual customer instance
after_commit :send_welcome, if: Proc.new {|c| c.email.present? }
```

> Generally use a codeblock if the test is simple (single line)

## How to Skip Callbacks

Useful, at some points, to skip callbacks:

- `instance.update_column(name, value)`
- `instance.update_columns(name: value, name: value)`
- `instance.delete`

> These three methods construct SQL to update the database directly.  Pretty much any methods acting directly on the `Relation`

Maybe for some things like?

- User passwords being updated, we wouldn't want to notify of a User change across the environment.  While updating a user name we probably do.

## Challenge: Callbacks

- [x] Add a callback to the Subject and Page to set the name attribute to `name.titleize` (essentially caps)
- [x] Modify the subject callback :log_save so that it only logs if the subject has visible pages
- [x] Find the subject record with position 1 and change visibility without callbacks.