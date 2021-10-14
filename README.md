# Ruby on Rails 6 - Essential Training

Working directory for the **[Ruby on Rails 6 Essential Training](https://www.linkedin.com/learning/ruby-on-rails-6-essential-training)** training course on [Linked In](https://www.linkedin.com/learning/ruby-on-rails-6-essential-training)

## Introduction

Faster, better, less painful website development.

- Handle web requests
- Manage data in database

## Challenge: Simple CMS

To get the challenge project Simple CMS up and running use the provided Docker image

> It's a super shady, non-standard, non-compose Docker image that was thrown together quickly.  I get it, no hate mail please!

### Build and Run

```
$> docker build -t rails-essential-training .
$> docker run -v ${pwd}/simple-cms:/simple-cms -p 3000:3000 -it rails-essential-training /bin/bash
```

You'll get a container with:

- Ruby 2.6
- Maria DB
- `bundle install` run
- `yarn install` run
- `rails db:migrate` run

and then provided the iteractive terminal.  Once there startup Rails with

```
$ /simple-cms > rails server -b 0.0.0.0
```

And you should be good to go.
