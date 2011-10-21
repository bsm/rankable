ENV["RAILS_ENV"] ||= 'test'

$: << File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require :default, :test

require 'active_support'
require 'active_record'
require 'rspec'
require 'rankable'

ActiveRecord::Base.configurations["test"] = { 'adapter' => 'sqlite3', 'database' => ":memory:" }
ActiveRecord::Base.establish_connection(:test)
ActiveRecord::Base.connection.create_table :articles do |t|
  t.string :name
  t.integer :rank
end

class Article < ActiveRecord::Base
  include Rankable::Model
end
