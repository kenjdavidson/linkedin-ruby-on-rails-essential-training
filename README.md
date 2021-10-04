# Ruby on Rails 6 - Essential Training

Working directory for the **[Ruby on Rails 6 Essential Training](https://www.linkedin.com/learning/ruby-on-rails-6-essential-training)** training course on [Linked In](https://www.linkedin.com/learning/ruby-on-rails-6-essential-training)

## Introduction

Faster, better, less painful website development.

- Handle web requests
- Manage data in database

## Using the Exercies Files

Each chapter has exercise files accompanying them, each of them will be copied and extracted into the folder `<chapter#>/course` which can then be used as the application directory of the sample docker application.

Example files are not included in the Git repository, they must be downloaded to their applicable folder and extracted.

## Running Examples

### Image

A crudly built **Docker** image is used for running exercise files:

```
$> docker build -t rails-essential-training .
[+] Building 37.0s (7/7) FINISHED
$>
```

### Container

Once the image is built it can be run using:

```
$> docker run -v ${pwd}:/course -it --rm rails-essential-training /bin/bash
```

For example:

```
$> cd 2-get-started-with-ruby-on-rails/Ex_Files_Ruby_Rails_6_Esst_Ch_2/Exercise Files/Chapter_02/02_02/simple_cms
$> docker run -v ${pwd}:/course -it --rm rails-essential-training /bin/bash
```

### Docker Compose

