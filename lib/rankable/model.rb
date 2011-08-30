# Includable module, for ActiveRecord::Base. By default, the "rank"
# column is used to store the sort order. To override:
#
#     class Article < ActiveRecord::Base
#       include Rankable::Model
#       self.rankable_column_name = "position"
#     end
#
module Rankable::Model
  extend ActiveSupport::Concern

  included do
    class_attribute :rankable_column_name
    self.rankable_column_name = "rank"
  end

  module ClassMethods

    # Ranks all records by given IDs. Example:
    #
    #   Article.rank_all([7,5,3])
    #   Article.find(7).rank # => 1
    #   Article.find(5).rank # => 2
    #   Article.find(3).rank # => 3
    #
    # Works with scopes too. Example:
    #
    #   Article.unread.rank_all([2,4,3])
    #
    def rank_all(ids)
      pk_col = columns_hash[primary_key]
      rk_col = columns_hash[rankable_column_name.to_s]

      raise "Ranking only works with integer primary keys" unless pk_col && pk_col.type == :integer
      raise "Ranking is missing the '#{rankable_column_name}' column. Please add a '#{rankable_column_name}' to your database table or specify a custom column name via self.rankable_column_name = '...'" unless rk_col

      ranked = Array.wrap(ids).map do |value|
        Integer(value) rescue nil
      end.compact
      return 0 if ranked.empty?

      clause = ranked.each_with_index.map do |id, index|
        "WHEN #{connection.quote(id, pk_col)} THEN #{connection.quote(index + 1, rk_col)}"
      end.join(' ')

      where(primary_key.to_sym => ranked).update_all "#{connection.quote_column_name rankable_column_name} = CASE #{quoted_primary_key} #{clause} END"
    end

  end
end