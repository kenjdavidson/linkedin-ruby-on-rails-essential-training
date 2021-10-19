# Rendering Views

An action may only call `render` or `redirect` once, but neither `render` nor `redirect` end the action.

```
def about
    if @language == 'fr'
        render('about_us-fr')
    end    
    render('about_us')
end
```

If this were to call with `@language == 'fr'` then the `render` would be called twice - which would result in an error.

## Avoid Double Render Errors

1. Adding a `and return` after the first request.  This requires `and` (not `&&`) due to operator precedence.

```
def about
    if @language == 'fr'
        render('about_us-fr') and return
    end    
    render('about_us')
end
```

2. Allow implicit render to take over if we were using `_us` template, matching the action:


```
def about_us
    if @language == 'fr'
        render('about_us-fr') and return
    end    
end
```

## More Options for Rendering Content

- `render(template: :template)`
- `render(plain: "just render text")`
- `render(html: "<html></html>")`
- `render(json: @subject)`
- `render(xml: @subject)`
- `render(plain: 'OK', status: 200)` using any of the HTTP status.  Always use a specific type of render when using status.
- `render(file: "/path/to/file")` will take the file and write to output (not download)
- `send_file("/path/to/file")` will download the file
- `render_to_string()` will allow the rendered content to be saved

## Use Layouts for Shared Templates

Layouts are just ERB files which contain:

- Template portion before
- `yield`
- Template portion after

The layout can be set at the Controller level:

```
class SomeController < ApplicationController
    layout 'public' # views/layout/public.html.erb
end

class AdminController < ApplicationController
    layout 'admin' # views/layout/admin.html.erb
end
```

The default layout is `application.html.erb`.  This can be overwritten in a number of ways:

- Per controller
- Per action

## Capture Content for Later Use

This is done using two methods:

- `content_for` (with a block will store, without a block will retreive)
- `content_for`? just checks to see if anything captured

```
<% content_for(:footer) do %>
    <p>This content is available for content later</p>
    <p>It can be used to place this content on the footer section of the template</p>
<% end %>
```

then in

```
# application.html.erb
<footer>
    <%= content_for?(:footer) ? yeild(:footer) : render(partial: 'default_footer')> %>
</footer>
```

> `content_for()` and `yield` both retreive, but `content_for` can be used within helper methods, while `yield` cannote.

## Challenge: Views

1. Show @username and logout link in the header of every page

- Remember that `cookies.delete :username` is used instead of the same for `session[:user_id] = nil`.

2. Show a flash hash notice below the header of every page (if one is present)

- Flash noticed added, but to the bottom and absolute, eventually should remove itself or manually.

3. Set the HTML page title using `content_for`

- Updated `content_for(:html_title) { "Subjects List" }`
- Unsure if this is good for single line items with no HTML (Apparently it's cool 3:15)

4. Define the method `render_404` which should render the `404.html` page in the public directory.

