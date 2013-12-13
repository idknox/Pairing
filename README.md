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

If you get a 404 from Github when trying to authenticate, make sure you source the envVariables.sh file into the console
window that your server is running in. Not having the env variables is what causes the 404 error.

### Email in development
Development is set up to send all email to [Mailcatcher](http://mailcatcher.me/). Mailcatcher [can not be put into the Gemfile](http://mailcatcher.me/#bundler) so you will need to install it separately via `gem install mailcatcher`.

## Testing
Run `rake minitest` to run all of the tests.

You can also use [Guard](https://github.com/guard/guard) to automatically run your tests when a file changes using
`guard` at the command line. If you don't want the [Pry](https://github.com/pry/pry) prompt, use `guard --no-interaction`.

## Review Environment
[http://students-gschool-review.herokuapp.com/](http://students-gschool-review.herokuapp.com/)