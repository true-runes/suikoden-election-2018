# frozen_string_literal: true

class SearchWord < ApplicationRecord
  # validates :wordsemail, :uniqueness => {:scope => [:name, :age]}
  has_many :tweets
end
