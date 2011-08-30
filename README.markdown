# Rankable

Super-simple ActiveRecord extension module, to quickly an efficiently sort
records. Sorts/ranks records in a single SQL query.

## Installation

Add this line to your Gemfile:

    gem "rankable"

Then, bundle:

    $ bundle install

## Usage Examples:

Specify simple preferences, with defaults:

    class Article < ActiveRecord::Base
      include Rankable::Model
    end

Read and write preferences:

    user = User.find(1)
    user.preferences[:newsletter] # => false

    # Set single preferences (with type casting)
    user.preferences[:newsletter] = '1'
    user.preferences[:newsletter] # => true

    # or, bulk-set (e.g. from forms)
    user.preferences = { :newsletter => '1' }

    # Makes preferences persistent
    user.save

Specify conditions (if/unless):

    class User < ActiveRecord::Base

      preferable do
        string  :font_color, :default => "444444", :if => lambda {|v| v =~ /^[A-F0-9]{6}$/ }
      end

    end

    user = User.find(1)
    user.preferences[:font_color] = 'INVALID'
    user.preferences[:font_color] # => '444444'

Store even arrays (with internal casting):

    class User < ActiveRecord::Base

      preferable do
        array  :popular_words, :cast => :string
      end

    end

    user = User.find(1)
    user.preferences[:popular_words] = 'hello'
    user.preferences[:popular_words] # => ['hello']

## License

    Copyright (C) 2011 Dimitrij Denissenko

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  "Software"), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

