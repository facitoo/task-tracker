# README


* Ruby version ~> 3.1.3

* Rails ~> 7.0.8

Steps to set up the service
> `git clone`

> `bundle install`

Database creation
> `rails db:migrate`

Database initialization
> For manual testing you need to create your own user with the following attributes 'first_name', 'last_name','email' and for Rspecs the user will be created automatically.

How to run the test suite
> `rails db:migrate RAILS_ENV=test` for creating test DB


API endpoint details 
> `api/v1/tasks` will be used before each endpoint defined in routes.rb

Features / Functionalities : 
> A user can create a task with a title and description. Given the user has a valid JWT token `(token secret = 'test')`. A task can be retrieved by Task ID or created by or assigned to the logged-in user. For updating a task user just needs to send the field and the value that needs to be updated.
> Deletion can be done via the delete API which will require a task ID.


