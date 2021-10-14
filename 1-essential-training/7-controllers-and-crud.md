# Controllers and CRUD

## Read Action

| CRUD | Action | Description | REST Route |
| --- | --- | --- | --- | --- |
| Read | `index` | List records | GET /subjects |
| Read | `show` | Display a single record | GET /subjects/:id |

### Index

Show a list of all Subjects.
Display links to show/edit/delete subjects.

```
<%= link_to("Show", "/subjects/#{subject.id}", :class => 'action show') %>
<%= link_to("Show", { action: 'show', id: subject.id }, :class => 'action show') %>
<%= link_to("Show", subject_path(subject), :class => 'action show') %>
```

### Show

Show the indivdiual Subject details.

## Adding Basic Forms

- Any template code that can be written with Rails/ERB can also be written with simple HTML.
- Writing code using the helpers is usually always easier and more beneficial

Basic HTML Form:

```
<form action="/subjects" method="post">
    <input type="text" name="name" />
    <input type="number" name="position" />
    <input type="checkbox" name="visible" />    
</form>
```

are accessed by:

```
params[:name]
params[:position]
params[:visible]
```


### Form Arrays

Standard with HTML

```
<form action="/subjects" method="post">
    <input type="text" name="subject[name]" />
    <input type="number" name="subject[position]" />
    <input type="checkbox" name="subject[visible]" />    
</form>
```

are accessed by:

```
params[:subject][:name]
params[:subject][:position]
params[:subject][:visible]
```

### Rails Helpers: Form For

```
<%= form_for(@subject) do |f| %>
    <%= f.text_field(:name) %>
    <%= f.number_field(:position) %> ??
    <%= f.checkbox(:visible) %> ??

    <%= f.submit("Create Subject") %>
<% end %>
```

## Create Action

| CRUD | Action | Description | REST Route |
| --- | --- | --- | --- | --- |
| Create | `new` | Display a form for new entry | GET /subjects/new |
| Create | `create` | Create and Save the function | POST /subjects/:id |

### New

```
# Initialize a new object to allow for 
# Database defaults and/or manual defaults
def new 
    @subject = Subject.new
end 
```

### Create

Process input from `new` form:

- Instantiate a new object with params
- Save
- If success redirect to index
- If fail redisplay the form

> `ActiveModel::ForbiddenAttributesError in SubjectsController#create` is what you get when you just try to pass in `params[:subject]` and a reason why for this **strong parameters** thing.

## Using Strong Parameters

When mass assigning the an object:

```
Subject.new(params[:subject])
Subject.create(params[:subject])
@subject.update(params[:subject])
```

By default Rails will not allow this.  We need to tell `params` what are available with:

```
params.permit(:first_name, :last_name)
params.require(:subject)
```

and are usually used together:

```
params.require(:subject).permit(:name, :position, :visible)
```

At this point from what I've seen of limited examples the purpose of this is so that:
- Ids cannot get overwritten
- Emails (and other key fields) cannot get overwritten unless explicitly done

> Something along the lines of `controller#set_email` or `controller#set_address` would only accept limited field updates.  I may be wrong, but this seems like the best case.


## Update 

### Edit 

Rails uses a make shift hidden `<input value="_method">` (so don't be alarmed).  When the `POST` is found with a secret `_method` it's switcharood for `PATCH`.
 
### Update

## Using Partials and Helpers

Better code organization by not repeating template content (for example NEW and EDIT use the same template, possibly).   Templates are templates which are prepended with an underscore:

```
_form.html.erb
```

### Helpers

Helpers are another way to clean up code.  

Helpers are located in the `helpers` folder.  As an example:

```
module SubjectsHelper
# Can be called anywhere within the application to run this code
  # This will render the partial in views/application/_error_messages file
  # be aware of the missing _ 
  def error_messages_for(object)
    render(partial: 'application/error_messages', locals: {object: object})    
  end
end
```

Which becomes available to our subject templates (I guess, maybe more of them but I assume there is a wall)

```
// views/subject/_form.html.erb
<%= error_messages_for(f.object) %>
```

> Note the syntax/magic for `f.object` where `f` is the passed in form from the caller `locals` and `f.object` which references the `@subject` that is associated with it.

## Delete Actions

### Delete 

Generally displays a form asking `are you sure` although this can probably be skipped if the confirmation is done in Javascript.

### Destroy

Although there is a `Subject.delete` and `Subject.destroy` but **ALWAYS** use the `destroy` version.

## Challenge: Pages CRUD

1. Create the CRUD for Pages
- ensure routes
- controller actions

2. Try writing without looking at SubjectsController

3. Try writing Pages within namespace of a subject.  For example, pages are added to subject so the route should be something like:

```
GET /subjects/:subject_id/pages
GET /subjects/:subject_id/pages/:id
GET /subjects/:subject_id/pages/new
POST /subjects/:subject_id/pages
PATCH /subjects/:subject_id/pages/:id
DELETE /subjects/:subject_id/pages/:id
```