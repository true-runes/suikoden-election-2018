class User < ApplicationRecord
  acts_as_paranoid

  has_many :tweets
  after_create :user_model_done

  validates :screen_name, presence: true
  validates :user_number, uniqueness: true, presence: true

  private
  def user_model_done
    @done_message = "UPSERT IS OK!"
  end
end
