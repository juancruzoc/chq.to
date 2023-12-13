# CHQ.TO

## Table of Contents

- [Technical information](#technical-information)
	- [Ruby version](#ruby-version)
	- [Ruby on Rails version](#ruby-on-rails-version)
	- [DataBase specification](#database-specification)
 - [Functionalities](#functionalities)
	- [Users management](#users-management)
	- [Links management](#links-management)
	- [Links types](#links-types)
 	- [Links access](#links-access)
 	- [Links reports](#links-reports)
  - [UI/Frontend](#uifrontend)
 	- [Technical specification](#technical-specification)
    	

## Technical information
### Ruby version
ruby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-linux]
### Ruby on Rails version
Rails 7.1.2
### DataBase specification
Rails default SQLite db.

## Functionalities
### Users management
Used [Devise](https://github.com/heartcombo/devise/tree/main), a flexible authentication solution for Rails based on Warden, to create, edit and destroy the users records and sessions.
### Links management
Created a scaffold with the "Rails generate" command using the default functionality and modifying only the views.
### Links types
I treated all the links as the same, only evaluating if they have password, expiry date or a usage limit to provide the expected functionality.
### Links access
Generated a new action in the Short Link controller providing the access to the shortened links created.
### Links reports
To do

## UI/Frontend
### Technical specification
Used the default js provided by Rails, [Tailwind](https://tailwindcss.com/) was incorporated for the css views.

## Setup
### Prerequires
Have ruby, rails and npm installed.

### Steps
Run bundle install
rails db:migrate
npm install

