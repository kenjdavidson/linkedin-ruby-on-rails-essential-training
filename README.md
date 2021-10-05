# Ruby on Rails 6 - Essential Training

Working directory for the **[Ruby on Rails 6 Essential Training](https://www.linkedin.com/learning/ruby-on-rails-6-essential-training)** training course on [Linked In](https://www.linkedin.com/learning/ruby-on-rails-6-essential-training)

## Introduction

Faster, better, less painful website development.

- Handle web requests
- Manage data in database

## Using the Exercies Files

Each chapter has exercise files accompanying them, each of them will be copied and extracted into the folder `<chapter#>/course` which can then be used as the application directory of the sample docker application.

Example files are not included in the Git repository, they must be downloaded to their applicable folder and extracted.

### Image

A crudly built **Docker** image can be used for getting Rails and Mysql (MariaDB) up and running:

```
$> docker build -t rails-essential-training .
[+] Building 37.0s (7/7) FINISHED
$>
```

> The image will need updates based on the project configuration, but for the most part it leaves a lot of manual processing just to make things a little more dynamic and allow for accessing all the different example projects without modification.

### Container

Once built you can get into the working environment by running

```
$> cd 2-get-started-with-ruby-on-rails/Ex_Files_Ruby_Rails_6_Esst_Ch_2/Exercise Files/Chapter_02/02_02/simple_cms
$> docker run -v ${pwd}:/simple-cms -it --rm rails-essential-training /bin/bash
$ /simple-cms# service mysql start
[ ok ] Starting MariaDB database 
$ /simple-cms# 
```

> Mysql (MariaDB) needs to be started manually at this point.  It would be cooler if the project was setup to run
> Rails and Mysql separately, but that would involve a bunch of changes to the example files that I thought would
> be annoying when pulling them from the course site.

### Configuring the Project

At this point only the actual project/working files are being `volumized` (for lack of a better term). When starting up each environment the dependencies and database need to be brought up to the appropriate version.

```
$ /simple-cms# bundle install
$ /simple-cms# rails otl:import
```

> Which actually doesn't work as it's explained on the **Using the exercise files** section (hopefully just chapter 2).

> Look into adding `/usr/local/bundle/gems` as a `volume` to maintain the dependencies across restarts and projects.
