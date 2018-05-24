# User.create(
#   [
#         {
#           screen_name: 'taro',
#           user_number: 12345,
#         },
#         {
#           screen_name: 'kenji',
#           user_number: 54321,
#         },
#       ]
# )

Tweet.create(
  [
    {
      tweet_number: Faker::Number.number(18),
      user_id: 27,
      text: Faker::StarWars.quote,
    },
    {
      tweet_number: Faker::Number.number(18),
      user_id: 27,
      text: Faker::StarWars.quote,
    },
    {
      tweet_number: Faker::Number.number(18),
      user_id: 27,
      text: Faker::StarWars.quote,
    },
    {
      tweet_number: Faker::Number.number(18),
      user_id: 28,
      text: Faker::StarWars.quote,
    },
    {
      tweet_number: Faker::Number.number(18),
      user_id: 28,
      text: Faker::StarWars.quote,
    },
  ]
)
