# students.gschool.it

This site is the one stop shop for gSchool students to get information about the course.

## Tech details

* Ruby 2.0.0
* Rails 4.0
  * Omniauth-github for authentication
  * Minitest::Spec
* Deployed to Heroku (see below)


## Development Environment

1. Copy config/database.yml.example to config/database.yml. Configure for your local database settings.
1. Run `rake db:create:all` to create the databases.
1. Copy the envVariables.sh.example to envVariables.sh and fill in the values you need from the localhost Development Environment application registered under the Galvanize-IT Github organization.
1. Make sure the envVariables.sh is sourced into the shell where you are running your server.

## Review Environment
[http://students-gschool-review.herokuapp.com/](http://students-gschool-review.herokuapp.com/)