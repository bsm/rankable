require 'spec_helper'
require 'logger'
describe Rankable::Model do

  before do
    @a = Article.create! :name => "A", :rank => 1
    @b = Article.create! :name => "B", :rank => 2
    @c = Article.create! :name => "C", :rank => 3
  end

  def ranks
    [@a, @b, @c].map(&:reload).map(&:rank)
  end

  it 'should not rank if nothing given' do
    Article.rank_all([]).should == 0
    Article.rank_all(nil).should == 0
  end

  it 'should convert inputs correctly' do
    Article.rank_all([@c.id, @a.id.to_s, @b.id, "", "..."]).should == 3
    ranks.should == [2, 3, 1]
  end

  it 'should be rank records' do
    Article.rank_all([@c.id, @a.id, @b.id]).should == 3
    ranks.should == [2, 3, 1]
  end

  it 'should work with scopes too' do
    Article.where(:id => @a.id).rank_all([@c.id, @a.id, @b.id]).should == 1
    ranks.should == [2, 2, 3]
  end

end
