# Rankable

Super-simple ActiveRecord extension module, to quickly an efficiently sort
records. Sorts/ranks records in a single SQL query.

## Installation

Add this line to your Gemfile:

    gem "rankable"

Then, bundle:

    $ bundle install

## Usage Examples:

In the model:

    # app/models/article.rb
    class Article < ActiveRecord::Base
      # Include module
      include Rankable::Model

      # You default column is "rank", change it e.g. via:
      # self.rankable_column_name = :position
    end

In your controllers:

    # config/routes.rb
    MyApp::Application.routes.draw do
      resources :articles do
        put :sort, :on => :collection
      end
    end

    # app/controllers/articles_controllers.rb
    class ArticlesController < ApplicationController
      respond_to :html

      def sort
        Articles.rank_all(params[:article_ids])
        head(:ok)
      end
    end

In your views:

  <script>
  $(function() {
    $( "#sortable" ).sortable({
      stop: function() {
        $.post('<%= sort_articles_path %>', '_method=put&' + $(this).sortable('serialize'));
      }
    });
  });
  </script>

  <ul id="sortable">
    <li id="article_ids_1">Article 1</li>
    <li id="article_ids_2">Article 2</li>
    <li id="article_ids_3">Article 3</li>
    <li id="article_ids_4">Article 4</li>
    <li id="article_ids_5">Article 5</li>
  </ul>


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

