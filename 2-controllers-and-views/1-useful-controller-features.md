# Useful Controller Features

Create smarter and more useful controllers that:
- remember data across requests
- inherit behaviors
- perform tasks automatically

Also to build:
- dynamic templates
- assets (Javascript/CSS)

## Store Data in Cookies

HTTP is stateless, meaning that by default each request is unique.  Cookies allow us to preserve state across interactions.  Cookies are saved by the web browser and are sent back with every request (matching the cookie configuration) to the server.

```
# Cookies are accessed as a hash
cookies[:username] = 'kdavidson'

# Can have other options
cookies[:username] = {
    value: 'kdavidson',
    expires: 1.week.from_now
}
```

Which can be accessed with future requests:

```
@user = Users.find_by_username(cookies[:username])
```

### Limitations

- Max 4kb size
- Reside on the users computer (are available for viewing)

### Advice

> Use cookies for small peices of data. 

> Never store sensitive data and never trust cookie data (as it could have been modified).

## Store Data in Sessions

Classic way that sessions work is that the server sends a `session_id` in a `cookie`.  Except the server uses this session id to lookup a session file on the server, so that it's data cannot be read or altered.

```
session[:language] = 'en'
```

then pull it back:

```
@language = session[:language]
```

### Behind the Scenes

There are number of way to store sessions:
- File storage
- Database storage
- Cache storage (rails)
- Cookie storage

Some common limitations:
- Requires time to retreive
- Session files continue to accumulate
- Session cookies store on users computer

### Super Cookies

- Fast; no lookup needed
- Little setup require
- No file or database bloat
- Encrypted and Signed to prevent reading and tampering (respectively)

### Setup

Files created for sessions:
- `config/credentials.yml.enc` contains a string used to encrypt
- `config/master.key` is the file used to encrypt the credentials file

> Never want to commit master.key to git

Credentials can be edited by using

```
EDITOR="atom --wait" rails credentials:edit
```

which will take time to decrypt prior than adding it.

## Messaging with Flash

It stores a message in the `session` data and the message will be available for them to view.  The special thing is that the messages are cleared after a single request/response cycle (redirect).

- Handling single serve messages
- Validations
- Errors
- Successes
- Etc.

```
flash[:info] = "The subject was created successfully"
flash[:error] = "Sorry, that didn't work"
```

## Log Information to File

Web Server logs information regarding data coming in and sending back.
Application logs can perform substantially more logging to allow for debugging and lookups.

- log/development.log
- log/test.log
- log/production.log

each environment can have different log levels, they are configured using:

- config/environments/development.rb `config.log_level = :debug`
- config/environments/production.rb `config.log_level = :info`


### Log Levels

| | :debug | :info | :warn | :error | :fatal |
| --- | :---: | :---: | :---: | :---: | :---: |
| database queries | X | | | | |
| request/render details | X | X | | | |
| deprecations | X | X | X | | |
| standard errors | X | X | X | X | |
| fatal errors | X | X | X | X | X | X |

Log files can be cleared with:

```
$> rails log:clear
```

for production it's suggested to setup log rotation.

### Logger 

In order to log from the application directly we can use the `logger` object.

```
logger.info("#{self.class} >> Processing login attempt with user: #{params[:username]}")
```

## Inherit Common Behaviors

The most common patterns that should be inherited from the `ApplicationController` are:

- Authentication or authorization
- Common lookups

## Use Filters to Call Methods Automatically

Filters can be configured on an `ActionController::Base` to be run:
- Before
- After

a Controller action.

- Confirm a user is logged in
- Setup variables and default 
- Hit the database for request wide objects

The available filters are:

- `before_action`
- `after_action`
- `around_action`

Filters can be skipped in child Controllers:

- `skip_before_action`
- `skip_after_action`

### Around Action

Around action performs business logic before and after:

```
# Yield is used to call 
def buildup_teardown
    logger.debug("Running before")
    yield
    logger.debug("Running after")
end 
```

## Render or Redirect

Will cause the rest of the action from not completing.
## Understanding CSRF

Exploits user's currently logged-in state to perform actions which require authentication, like

```
<img src="https://bank.com/transfer?amt=10000&to=hacker" />
```

There are a number of ways:
- Require logged in user
- Regularly log out inactive users
- **Use POST Requests**

Rails will automatically generated a token that is:
- Attached to form
- Inserted into Session

then requests the two are then compared.  This requires:

```
protect`_from_forgery with: :exception
```

> There are other options for `protect_from_forgery` (https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html)[https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html]

### Ajax

Ajax will not use those tokens - there are a number of rails libraries that will automatically add the token.

## Challenge: Controllers

[x] Record a note in the log file when users log out

- Added `logger.info("logged user out")`

[x] set @username automatically for every controller action

- Moved @username to the ApplicationController with a `before_action`

[x] After any login, store a language preference

- Added `cookies[:language] = 'en'` to the AccessController

[x] Set @language automatically for every controller

- Renamed `ApplicationController#set_username` to `ApplicationController#set_user_preference` and now set `@username` and `@language`
- Changed `before_action :set_user_preference`

[x] Subjects/Pages stop them from uses any action

- Wrapped Subject and Pages in `before_action :confirm_logged_in`

[x] Store the flash has a message about logging in

- Stored the logging in, out and errors to the flash