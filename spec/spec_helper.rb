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

SPEC_DATABASE     = File.dirname(__FILE__) + '/tmp/test.sqlite3'
ActiveRecord::Base.configurations["test"] = { 'adapter' => 'sqlite3', 'database' => SPEC_DATABASE }

RSpec.configure do |c|
  c.before(:all) do
    FileUtils.mkdir_p File.dirname(SPEC_DATABASE)

    base = ActiveRecord::Base
    base.establish_connection(:test)
    base.connection.create_table :articles do |t|
      t.string :name
      t.integer :rank
    end
  end

  c.after(:all) do
    FileUtils.rm_f(SPEC_DATABASE)
  end
end

class Article < ActiveRecord::Base
  include Rankable::Model
end
