# frozen_string_literal: true

# rubocop:disable Lint/UselessAssignment
# TODO: クラス名が抽象的過ぎてなにやるのかわからない
class InsertTweet
  def user_id_list
    max_users_per_request = 100
    # Rate Limits に注意……
    user_ids_str = User.order(user_number: :desc).pluck(:user_number)
    user_ids_int_array = user_ids_str.map(&:to_i)

    divided_array = user_ids_int_array.each_slice(max_users_per_request).to_a
  end
end
# rubocop:enable Lint/UselessAssignment
