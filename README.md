# README

## versions

ruby 2.7.6
Rails 7.0.4

## How to run the project

First, install the dependencies running `bundle install`

After that, take a look at the .env.sample file and copy it to a .env file `cp .env.sample .env`

And finally, run the project with  `bin/rails s`

The project should be running now!

The endpoint, just as an example:

`http://localhost:3000/closest_satellites?latitude=-27.158150&logitude=-48.553669&number_of_satellites=20`
