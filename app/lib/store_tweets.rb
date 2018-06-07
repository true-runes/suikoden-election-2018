class StoreTweets
  attr_reader :store_tweets

  def initialize
    @store_tweets = 'Hello, StoreTweets class!'
  end

  def insert_to_search_words(search_word)
    # search_word = SearchWord.new(
    #   word: search_word,
    # )

    # if search_word.save
    #   @ret_message = 'save successful'
    # else
    #   @ret_message = 'save failed'
    # end

    insert_words = [
      '幻水',
      '#幻水',
      '#幻水総選挙',
      '#幻想水滸伝',
    ]

    begin
      ActiveRecord::Base.connection_pool.with_connection do |c| # 決まり文句
        Upsert.batch(c, :search_words) do |upsert| # 決まり文句で、2つめの引数にテーブル名を指定する
          insert_words.each do |insert_word| # ここから自由記述だがたいていループで回すことになるはず
            upsert.row( # 決まり文句で、これ以降にINSERT文を書く
              { word: insert_word }, # INSERTをする際にここで指定されたカラムがすでに存在するならUPSERT扱いになる
              {
                created_at: Time.now.utc, # created_at は UPDATE されないようだ（うまくできてるが、ちゃんとドキュメントを読んで確信を得る）
                updated_at: Time.now.utc, # updated_at は UPSERT の datetime に更新される
              },
            )
          end
        end
      end
    rescue e
      # Duplicate entry '刀剣乱舞' for key 'index_search_words_on_word' は begin rescue じゃ捕まえられない？（あとで調べたい）
      @error_message = e
    end
  end
end