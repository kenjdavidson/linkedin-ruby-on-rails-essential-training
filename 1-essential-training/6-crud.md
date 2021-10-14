# CRUD

_Standardize_ the functionality for working with data:

## Learning about CRUD 

| CRUD | Action | Description | Example URL |
|---|---|---|---|
| create | `new` or `create` | Display or process a new record form | `POST /subjects/new` or `/subjects/create` |
| read | `index` or `show` | List records or display single | `GET /subjects/` or `/subjects/:id` |
| update | `edit` or `update` | Display edit form | `PATCH /subject/edit/:id` |
| delete | `delete` or `destroy` | Delete a record | `DELETE /subject/:id` |

Assumes that there is a separate controller per Model.
- Plural `SubjectsController` manages the model `Subject`
- Resource oriented approach to managing data

## REST and Resourceful Routes

**REpresentational State Transfer**

Instead of performing procedures, perform state transformations upon resources.  

### HTTP Verbs

GET - for retreiving data from a resource
POST - when creating a new item on resource
PATCH (PUT) - when updating an existing item
DELETE - for deleting items on resource

### Resourceful Routes

Is the Rails default and used by most Rails developers. 

The routes are defined not only with a string; but with the HTTP verb.

```
# routes.rb
resources :subjects
resources : pages
```

These can be configured:

```
resources :users, :except => [:show]
resources :users, :only => [:show,:edit]
```

Or nested:

```
# Delete is not provided by default when using resources :subjects
# the member is imporant to work with one item (expect an id)
# otherwise use `collection do; end`
resources :subjects do
  member do
    get :delete
  end
end
```

## Using Resourceful URL Helpers

When using resourceful routes, the same routes are required in the forms and views in order to get there.  Rails takes advantage of the resourceful helpers:

```
# General way of adding to paths
{ controller: 'subjects', action: 'show', id: 5 }

# resourceful way
subject_path(5)
```

| HTTP Verb | URL | Action | Description | Example |
| --- | --- | --- | --- | --_ |
| GET | `/subjects` | index | `subjects_path` | <%= link_to('All Subjects', subjects_path) %> |
| GET | `/subjects/:id` | show | `subjects_path(5)` | |
| GET | `/subjects/new` | new | `new_subjects_path` | |
| POST | `/subjects` | create | `subjects_path` | |
| GET | `/subjects/:id/edit` | edit | `edit_subjects_path(5)` | |
| PATCH | `/subjects/:id` | update | `subjects_path(5)` | |
| GET | `/subjects/:id/delete` | edit | `delete_subjects_path(5)` | |
| DELETE | `/subjects/:id` | edit | `subjects_path(5)` | |
