# Signature Generator

[![Build Status](https://travis-ci.org/lbriais/signature_generator.svg)](https://travis-ci.org/lbriais/signature_generator)
[![Gem Version](https://badge.fury.io/rb/signature_generator.svg)](http://badge.fury.io/rb/signature_generator)


This gem provides the `sg` executable to generate signature files from templates.
Variables used in the template, can be provided at run-time either by:

* Providing values on command line
* Providing values in config file
* Interactively

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'signature_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install signature_generator

## Usage

By default, the template is taken from STDIN and the result is produced on STDOUT. Of course both template and
result files can be specified on command line (see `sg --help` to see all options).

### Template

The template is actually an [ERB](http://www.stuartellis.name/articles/erb/) template.

### Resulting file

By default the result is _minified_ using the [kangax minifier](https://github.com/kangax/html-minifier/). You can disable
this behaviour by specifying `--no-minify` on the command line.

### Substituting variables

You can specify variables on the command line using the following syntax: `--var varname1=value1 --var varname2=value2 ...`

Here is a real-life usage example:

    $ sg -f ./my_template.html.erb -o my_signature_file.html --force --var varname1=value1 --var varname2=value2 

As this gem is using [easy_app_helper], it means that anything you can provide on the command line can 
be actually provided by a config file. Read [easy_app_helper] documentation for further info.

__Any variable value not provided by the command line or a config file will actually be requested interactively at run time.__

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, 
which will create a git tag for the version, push git commits and tags, and push the `.gem` file 
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lbriais/signature_generator. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected 
to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[easy_app_helper]: https://github.com/lbriais/easy_app_helper "easy_app_helper Gem'