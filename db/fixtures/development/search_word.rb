SearchWord.seed do |s|
  # id がわからない場合の UPSERT だが……ハードコーディングが頂けない
  target_word = '検索語なし'
  target_id   = SearchWord.where(word: target_word).first.id

  s.id    = target_id
  s.word  = '検索語なし'
end
