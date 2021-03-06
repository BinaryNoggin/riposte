# Riposte
[![Version
](https://img.shields.io/gem/v/riposte.svg?style=flat)](https://rubygems.org/gems/riposte)
[![Build
Status](https://travis-ci.org/BinaryNoggin/riposte.svg?branch=master)](https://travis-ci.org/BinaryNoggin/riposte)
[![Code
Climate](https://codeclimate.com/github/BinaryNoggin/riposte/badges/gpa.svg)](https://codeclimate.com/github/BinaryNoggin/riposte)
[![Test
Coverage](https://codeclimate.com/github/BinaryNoggin/riposte/badges/coverage.svg)](https://codeclimate.com/github/BinaryNoggin/riposte)

Riposte was put together to scratch an itch that I had when working with
multiple outcomes of telling an object what to do and then responding
differently depending on the results of the action. This happens all the
time in the software that I write. I want to save an object to the
database and I can't because of the object not meeting the database
requirements, or the database is down. I might have a whole host of
different responses for the user. This is where Riposte is geared. It is
a very small gem, and I hope to keep it that way. Finally after years of
using similar ideas I've finally made a gem out of it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'riposte'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install riposte

## Usage

I'm going to show an example usage within a basic Rails application
because that is where I've found this to be used the most.

```ruby
class MyController < ApplicationController
  def create
    @article = Article.new

    @article.publish { |on|
      on.published { send_email_to_subscribers }
      on.invalid { handle_invalid }
      on.exception { |e| database_down_handler(e) }
    }

    respond_with @artcile
  end
end

class Article < ActiveRecord::Base
  include Riposte::Helper

   def publish(&block)
     if valid?
       #publish logic
       react_to :published, &block
     else
       #failure logic
       react_to :invalid, &block
     end
   rescue SomeError => e
     react_to :exception, e, &block #passing an argument for reactions
   end
end
```

You may prefer not to use blocks. This is powerful as you can pass the
response object around. You can also use the object multiple times in
different places and with different blocks.


```ruby
class MyController < ApplicationController
  def create
    @article = Article.new

    on = @article.publish
    on.published { send_email_to_subscribers }
    on.invalid { handle_invalid }
    on.exception { |e| database_down_handler(e) }

    respond_with @artcile
  end
end

class Article < ActiveRecord::Base
  include Riposte::Helper

   def publish
     if valid?
       #publish logic
       react_to :published
     else
       #failure logic
       react_to :invalid
     end
   rescue SomeError => e
     react_to :exception, e, &block #passing an argument for reactions
   end
end
```


## Contributing

1. Fork it ( https://github.com/adkron/riposte/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
  Licensed under the MIT license. See the LICENSE.txt file for more
  details.
