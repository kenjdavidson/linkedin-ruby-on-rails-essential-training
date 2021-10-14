# Ruby on Rails 6 - Essential Training

Working directory for the 

- **[Ruby on Rails 6 Essential Training](https://www.linkedin.com/learning/ruby-on-rails-6-essential-training)** 
- **[Ruby on Rails 6 Essential Training - Controllers and Views](https://www.linkedin.com/learning/ruby-on-rails-6-controllers-and-views)** 
- **[Ruby on Rails 6 Essential Training - Models and Associations](https://www.linkedin.com/learning/ruby-on-rails-6-essential-training-models-and-associations)** 

## Introduction

Getting to use Ruby on Rails!
### Essential Training 

Faster, better, less painful website development.

- Handle web requests
- Manage data in database

Project notes can be found under `1-essential-training`
### Controllers and Views

Project notes can be found under `2-controllers-and-views`
### Models and Associations

Project notes can be found under `3-Models and Associations`

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

### Tailwind CSS

I've also included playing around with Tailwind CSS (actually just getting it working was a task in and of itself).

## Models and Associations

This course continues on within this same project, with chapter notes continuing from the end (7-controllers-and-crud) using the same **Simple CMS** project.

