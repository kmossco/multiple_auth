# MultiAuth

1. Install Ruby 3.2.2 preferably using a version manager like chruby
2. Setup [Homebrew](https://brew.sh/) in your Mac OS
3. Install `postgresql@14` using Homebrew and run it with user & pass as `postgres`
    - If you need to use the default no user or pass, remove them in `config/database.yml`
4. Run `$ bundle install` to install the gems
5. Run `$ rails db:setup` to setup the database and migrations
6. Run `$ rails s` to serve the app on port HTTP 3000
