# Controllers, Views and Dynamic Content

## Render a View Template for a Browser

Three essential parts (we've seen):

- Route
- Controller Action
- View Template

The default to match up `controller#action` to the view:

`demo/hello` to `DemoController#hello` to `demo/hello.html.erb`

### Render

This can be overridden by using the `render` method providing the view name.

```
def hello
  render('index')
end
```

can be used to switch the `hello` and `index` views.

## Redirect Controller Actions

Instead of just rendering a different view from the same action it's possible to re-direct to another action.

- User requests an action
- Controller checks if they are logged in
- Redirect to the login page

The main result of this is that:

- the URL is changed
- the new request is actually made by the browser

> Unlike when render just uses the provided template for the current action.

```
# Redirect using argument Hash
redirect_to(:controller => controller_name, :action => action_name)
redirect_to(controller: controller_name, action: action_name)

# Redirect to the same controller action
redirect_to(action: action_name)

# Redirect to direct location
redirect_to('http://google.com')
```

## Define View Templates using HTML

Templates us Embedded Ruby (ERB) (covered in Ruby Essential Training 3).  

> There are other template engines: HAML, etc.  But ERB is the standard/default.

```
# Perform the ruby code
<% variable = 'hello there' %>

# Perform and write the ruby code
<%= variable %>
```

## Use Instance Variables to Set values in the Template

The controller uses the `binding` functionality (Ruby Essential Training 3) to provide it's instance variables to the ERB template.

## Create Links to Other Webpages

Links in HTML are

```
<a href="/demo/index">Go Demo</a>
```

which can be generated using the Rails helper method:

```
<%= link_to(text, target)%>
```

where the arguments are:

- text to be written as the link text
- target which can be a simple string or a Hash `link_to('Hello', {controller: 'demo', action: 'hello'})`

## Defining and Reading URL Parameters

URL parameters (query parameters) are after the `?=` in the URL.  This is done by adding more entries in the Hash used:

```
<%= link_to('page name', {action: 'hello', name: 'Kenneth Davidson' } %>
```

all parameters (Url, Query and Content) are found in the `params` controller method.

> All of the parameters are **Strings** which require manual casting based on requirements.

## Challenge: Dynamic Template

- DemoController actions: #about, #contact
- Route to those actions
- Templates: demo/about_us, contact_us respectively
- Add links between the pages

Add dynamic:

In #contact:
- Check for a country
- If it's `us` or `ca` then show 800 number
- If its `uk` then show 020 number
- otherwise +1 (987) number

