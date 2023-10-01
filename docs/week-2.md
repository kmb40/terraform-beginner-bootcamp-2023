# Terraform Beginner Bootcamp 2023 - Week 2

**Objective:** 

## Working with Ruby
### Bundler
The primary way to install ruby packages (aka Gems) is using the Bundler package manager for ruby.

#### Install Gems
1. Create a Gemfile and define the gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```
2. Run the `bundle install` command to install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)
A Gemfile.lock should be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler
Run the `bundle exec` command to tell future ruby scripts to use the gems that you installed.  

### Sinatra
Sinatra is a micro web-framework for ruby to build web-apps. Its great for mock or development servers or for very simple projects.
It can be used to create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server
### Running the web server
1. Run the web server by executing the following commands:
```rb
bundle install
bundle exec ruby server.rb
```

**Note:** All of the code for the server is stored in the `server.rb` file.
