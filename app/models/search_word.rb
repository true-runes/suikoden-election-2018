# frozen_string_literal: true

# rubocop:disable Rails/HasManyOrHasOneDependent
class SearchWord < ApplicationRecord
  # validates :wordsemail, :uniqueness => {:scope => [:name, :age]}
  has_many :tweets
end
# rubocop:enable Rails/HasManyOrHasOneDependent
