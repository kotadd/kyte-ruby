# JqueryMousewheelRails

A ruby gem that uses the Rails asset pipeline to include the jQuery MouseWheel plugin by Brandon Aaron
(http://brandon.aaron.sh).

## Installation

Add this line to your application's Gemfile:

    gem "jquery-mousewheel-rails"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jquery-mousewheel-rails

NOTE: this is a jQuery plugin so you will also need the `jquery-rails` gem:

* https://github.com/rails/jquery-rails

## Usage

In your `application.js` you will need to add this line:

    //= require jquery.mousewheel