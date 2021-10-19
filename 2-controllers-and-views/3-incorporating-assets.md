# Incorporating Assets

## Add Style Sheets to View Templates

There are two ways to work with styles with Rails:

- Add a `css` file to `/static` and reference that file from html
- Using the Asset Pipeline

### Asset Pipeline

- concats styles
- compresses
- precompiles css
- allows other languages
- asset fingerprinting (cache busting)

In order to use the asset pipline:

- asset precompile list must include a manifest
- manifest includes stylesheets
- stylesheets contain various styles

If using the pipline the stylesheets will be in

- Location: `/app/assets/stylesheets`
- Filename should end in `.css` or `.scss`

### Asset Initializer

The `/config/initializers/assets.rb` file needs to be updated to include the appropriate `Rails.application.config.assets.precompile += %w()` content.  By default this contains the current files `application.js` and `application.css`.

### Compiling

- `export RAILS_ENV=production`
- `bundle exec rails assets:precompile`

## Using Static Image Assets

Images that are stored with code in the repository and require deployment.  In contrast with dynamic images that are uploaded and stored somewhere to be displayed at a later time.  For information on this read up on `ActiveStorage`.

- Save an image to `public/images` and reference it
- Use the Rails asset pipeline

When using the asset pipeline we get the added:

- user helper methods
- image fingerprinting (cache busting)
- Location: `/app/assets/images`

### Helper Methods

For information on the `image_tag` arguments (https://apidock.com/rails/ActionView/Helpers/AssetTagHelper/image_tag)[https://apidock.com/rails/ActionView/Helpers/AssetTagHelper/image_tag]

`<%= image_tag('logo.png') %>`

Which works well with the `link_to`:

```
<%= link_to(logout_path, method: :delete) do %>
    <%= image_tag("icon_logoff.png", size: "16x16", title: "Logout", class: "inline m-2") %>
<% end %>
```

## Use Image as CSS Backgrounds

Within SCSS there is an `image-url` helper that will be processed:

```
- header {
-    backgorund-images: url('images/gradient.png')
- }
+ header {
+    backgorund-images: image-url('images/gradient.png')
+}
```

Within HTML requires using `image_path`

```
```

## About JavaScript in Ruby on Rails

- JavaScript directly to templates
- Javascript in public folders `/public/javascript`
- Webpack is used

> JavaScript is in transition as it allows both Webpacker and Asset Pipeline.  

### Kevin's Recommendations

**Use asset pipeline if**
- little JS or beginner
- working on legacy app already using pipeline
- do not need note.js npm packages

**Webpacker if**
- prefer to use default settings of rails (direction rails is headed)
- want to use node.js packages
- want to build _single page apps_
- a lot of control

## Manage JavaScript with Webpacker

Webpacker is the default for Rails.

Rails will install:
- node.js
- npm
- yarn
- babel
- webpack

and stored inside `app/javascript`

> I changed this to `app/frontend` as it made more sense since it included `css` as well.

### Packs

Webpacker is configured to pull in all entry files located at `app/frontend/packs`.

The default pack `app/frontend/packs/application.js` contains all the primary imports.  

## Configure Asset Pipeline for Javascript

In order to use JavaScript in asset pipeline it needs to be re-added again.

- create the original directory
- provide a compressor
- disable webpacker

> Ignored these as I felt it more important to use something that would happen in the real world.

## Manage JavaScript with Asset Pipeline

- Assed precompile list include manifest
- Manifest includes extra JS files
- JS contains various features

