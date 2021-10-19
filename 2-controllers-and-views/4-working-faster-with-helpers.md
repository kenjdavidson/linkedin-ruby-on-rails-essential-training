# Working Faster with Helpers

Wide variety of `helpers` that are available throughout Rails.

## Text Helpers

### Word_Wrap

Breaks text into line separated by `\n`; athough this doesn't help much with html.

`<%= word_wrap(text, :line_width => 30) %>`


### Simple_Format

Formats content as HTML

`<%=simple_format(text) %>`

- Wraps in `<p>` tags
- Breaks double `\n` into `<br/>` tags

### Truncate

Truncate a line of text to a specific size (ie. excerpt):

`<%= truncate(text, :length => 28) %>`

where this includes the `...`


### Pluralize

`<%= pluralize(n, 'product') %> found.`

When working on:

0 products found.
1 product found.
2 products found.

### Others

- truncate_word - given number of word
- highlight - finds a phrase and wraps it in string
- excerpt - finds a phrase

## Sanitization Helpers

Sanitization primary goal is to stop Cross-Site Scripting (XSS), it mainly occurs when code is parsed and executed when there is no santization:

- Run evil JavaScript from input into a form, the response could execute.
- HTML that could break the site if re-rendered

> Generally assume all input data is unsafe

### Html_Escape

which has the short form `h()` (which is generally how it's used).

In Rails 6 all HTML from ERB is escaped by default - using an allow list for when you'd like to overwrite.

- `<%= raw(msg) %>`
- `<%= msg.html_safe %>` can be marked for all content (will be unmarked automatically when string is modified)

### String_Links

Remove link tags `<a>` only, leaving the rest of the content

### String_Tags

Remove all html tags.

## Number Helpers

Large number of helpers to help format numbers:

- number_to_currency
- number_to_percentage
- number_with_precision
- number_with_delimiter
- number_to_human
- number_to_phone

They all take:

- A number as the first argument
- A hash of options

### Options

The most common options are:

- `:delimiter`
- `:separator`
- `:precision`

## Date and Time Helpers

`Integer` has a large number of date and time related features after importing/requiring:

- seconds
- minutes
- hours
- days
- weeks
- months
- years

Calculation can be done, for example:

```
Time.now + 30.days - 23.minutes
```

Which can be taken a little further

- `30.days.ago`
- `30.days.from_now`

And they get god damned crazy!!

```
# First day of December?
Time.now.last_year.end_of_Month.beginning_of_day
```

### Formatting

`strftime` which takes much the same formatting as Java.

> Which I can never remember anyhow and end up needing to google each option.

- :db
- :number
- :time
- :short
- :long

## Form Helpers

Probably the most important (and most annoying in my opinion):

- `form_tag(url, options) do; end` prints a form tag
- `form_for(active_record, options) do |f|; end` manages forms for a specific database object.  Where `f` is the FormBuilder to which items are appended

When working with:

### Text Fields

```
# Manually build form
text_field_tag('name', params[:name])

# Would use object and use attribute name
text_field(:object, :name)

# Using FormBuilder with the object used in the form_for
f.text_field(:name)
```

FormBuilder contains a large number of methods for building.  They call come in two flavours:

- `text_field`
- `text_field_tag` 

> Now for some of the GOTCHAS

- Checkbox `check_box` adds a hidden field to provide a `0` or `1` value.  This is because unchecked checkboxes don't submit their value.

- Select `select_tag` can be provided a number of options

```
opts = options_for_select(['text', 'HTML'], 'HTML)
select_tag(:content, opts)
```

when using the FormBuilder:

```
# Range
f.select(:position, 1...5)

# Array
f.select(:content_type, ['text', 'HTML'])

# Hash
f.select(:visible, { "Visible": 1, "Hidden: 2 })

# Array of Array (most widely used)
# Where array[0] is the title and array[1] is the value
f.select(:subject_id, Subject.all.map { |s| [s.name, s.id] })
```

## Custom Helpers

Helpers are Ruby modules with methods found in them.   They are created automatically when a `controller` is generated.  All helper methods are All view templates, unlike controller methods which are not.

- Frequently used code
- Storing complex sections of code that shouldn't clutter views
- If you're writing a large amount of Ruby code it might be better in a helper

## Challenge: Helpers

Attempt to complete some random ideas:

- [x] subjects/show use `pluralize` show the number of pages
- [x] subjects/show format the time for created/updated at
- [x] pages/show template use the status_tag we created 
- [ ] pages/show use text or sanitation helper on the content
- [ ] subjects/_form use a select tag for the position
- [x] subjects/_form use radio buttons for whether it should be visible
- [ ] pages/_form use a select tag for a subject_id
- [ ] pages/_form use a select tag for position
- [x] pages/_form use a checkbox for visible

### Bonus Points

- [ ] Use different options for the position.  If we're updating the position and we have 3 subjects, we should only be able to choose positions that aren't there.
- [ ] Write a custom helper.