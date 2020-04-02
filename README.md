# Lost minions
[![Build Status](https://vadim-kurnatovskiy.semaphoreci.com/badges/lost-minions.svg)](https://vadim-kurnatovskiy.semaphoreci.com/projects/lost-minions)

Lost minions is a web application that helps people find their pets. The main idea is to centralize information about lost and found pets.

#### Requirements
- Ruby 2.6.3
- Rails 5.2.3
- PostgreSQL 9.5+

## Scripts

* `bin/setup` - setup required gems and migrate db if needed
* `bin/quality` - runs rubocop, brakeman, rails_best_practices and bundle-audit for the app
* `bin/ci` - should be used in the CI or locally
* `bin/server` - to run server locally

#### Setup
To get the application running, follow the steps below:

```bash
# clone repo
git clone git@github.com:Vadim-Kurnatovskiy/lost-minions.git
cd lost-minions

# configure ENV variables in .env
vim .env

# run setup script
bin/setup

# Run test and quality suits to make sure all dependencies are satisfied and applications works correctly before making changes.
bin/ci

# run server on 5000 port
rails s
```

## Test users

  - User: "test@test.com / 123456"
