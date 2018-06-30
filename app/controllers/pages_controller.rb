class PagesController < ApplicationController
  def now_counting
    @all_tweets_count = Tweet.now_counting_tweets.size
    @tweets = Tweet.now_counting_tweets.page params[:page]
  end

  def home
    # @vote_number = Tweet.where(is_retweet: 0).where(tweeted_at: '2018-06-22 21:00:00'.in_time_zone('Tokyo')..'2018-06-24 09:00:00'.in_time_zone('Tokyo')).size
  end

  def ranking
    @ranking_data = CSV.table('public/ranking.tsv', col_sep: "\t")

    @vote_1_chars = temporary_ranking_vote_1_chars
    @vote_2_chars = temporary_ranking_vote_2_chars
    @vote_3_chars = temporary_ranking_vote_3_chars
    @vote_4_chars = temporary_ranking_vote_4_chars
    @vote_5_chars = temporary_ranking_vote_5_chars
    @vote_6_chars = temporary_ranking_vote_6_chars
    @vote_7_chars = temporary_ranking_vote_7_chars
    @vote_8_chars = temporary_ranking_vote_8_chars
    @vote_9_chars = temporary_ranking_vote_9_chars
    @vote_10_chars = temporary_ranking_vote_10_chars
    @vote_11_chars = temporary_ranking_vote_11_chars
    @vote_12_chars = temporary_ranking_vote_12_chars
    @vote_13_chars = temporary_ranking_vote_13_chars
    @vote_14_chars = temporary_ranking_vote_14_chars
    @vote_15_chars = temporary_ranking_vote_15_chars
    @vote_16_chars = temporary_ranking_vote_16_chars
    @vote_18_chars = temporary_ranking_vote_18_chars
    @vote_19_chars = temporary_ranking_vote_19_chars
    @vote_20_chars = temporary_ranking_vote_20_chars
    @vote_21_chars = temporary_ranking_vote_21_chars
    @vote_22_chars = temporary_ranking_vote_22_chars
  end

  def temporary_ranking_vote_22_chars
    [
      "ジャック",
    ]
  end

  def temporary_ranking_vote_21_chars
    [
      "カスミ",
      "ヒューゴ",
      "ロイ",
    ]
  end

  def temporary_ranking_vote_20_chars
    [
      "ユーバー",
    ]
  end

  def temporary_ranking_vote_19_chars
    [
      "ザムザ",
    ]
  end

  def temporary_ranking_vote_18_chars
    [
      "ティアクライス主人公【団長】",
      "リウ・シエン",
    ]
  end

  def temporary_ranking_vote_16_chars
    [
      "アルベルト・シルバーバーグ",
      "ムクムク",
      "リヒャルト",
    ]
  end

  def temporary_ranking_vote_15_chars
    [
      "クルガン",
      "炎の英雄",
    ]
  end

  def temporary_ranking_vote_14_chars
    [
      "ミアキス",
      "ロベルト",
    ]
  end

  def temporary_ranking_vote_13_chars
    [
      "サスケ",
      "ジョー軍曹",
      "タイ・ホー",
      "テンガアール",
      "ボルス・レッドラム",
      "リッチモンド",
    ]
  end

  def temporary_ranking_vote_12_chars
    [
      "アルド",
      "カミーユ",
      "ルビィ",
      "ワカバ",
      "紡がれし百年の時主人公【紡主】",
    ]
  end

  def temporary_ranking_vote_11_chars
    [
      "エルザ",
      "クレオ",
    ]
  end

  def temporary_ranking_vote_10_chars
    [
      "キカ",
      "シドニア",
      "セシル",
      "ハーヴェイ",
      "パーシヴァル・フロイライン",
    ]
  end

  def temporary_ranking_vote_9_chars
    [
      "ケネス",
      "ゼフォン",
      "ハンナ",
      "ハンフリー",
      "レイチェル",
    ]
  end

  def temporary_ranking_vote_8_chars
    [
      "シド",
      "シロ",
      "トリスタン",
      "ペシュメルガ",
      "リムスレーア・ファレナス",
    ]
  end

  def temporary_ranking_vote_7_chars
    [
      "カーン・マリィ",
      "グレンシール",
      "シグレ",
      "テンプルトン",
      "パーン",
      "ラミン",
    ]
  end

  def temporary_ranking_vote_6_chars
    [
      "アスアド",
      "ギゼル・ゴドウィン",
      "クインシー",
      "サロメ・ハラス",
      "トラヴィス",
      "ミルイヒ・オッペンハイマー",
      "ユウ",
      "リオン",
      "ルセリナ・バロウズ",
    ]
  end


  def temporary_ranking_vote_5_chars
    [
      "オロク",
      "ザヴィド",
      "ジェレミー",
      "トルワド・アルブレク",
      "トロイ",
      "ビュクセ",
      "ベルクート",
      "ポーラ",
      "ミレイ",
      "ヤール",
      "ヨベル",
      "リヒャルトのお父さん",
      "レギウス",
      "ワイアット・ライトフェロー（ジンバ）",
    ]
  end

  def temporary_ranking_vote_4_chars
    [
      "アイン・ジード",
      "エース",
      "カマンドール",
      "キルケ",
      "グランマイヤー",
      "クリン",
      "サイアリーズ",
      "シグルド",
      "ツァウベルン",
      "ヒックス",
      "フィッチャー",
      "フェリド",
      "フレア",
      "ボブ",
      "ミューラー",
      "ミリー",
      "ムバル",
      "リドリー",
    ]
  end

  def temporary_ranking_vote_3_chars
    [
      "アイリ",
      "アップル",
      "アレニア",
      "アレン",
      "イク",
      "ヴィルヘルム",
      "エリン",
      "エレノア・シルバーバーグ",
      "オウラン",
      "ガボチャ",
      "ギジェリガー",
      "キバ・ウィンダミア",
      "コノン",
      "ジーン",
      "ジェス",
      "ししのはた",
      "シャバック",
      "シュラ・ヴァルヤ",
      "ソロン・ジー",
      "タカム",
      "タル",
      "チャコ",
      "テオ・マクドール",
      "バーツ",
      "ハヅキ",
      "バレリア",
      "ひいらぎこぞう",
      "フリード・Y",
      "ヘルムート",
      "マクシミリアン",
      "ムーア",
      "メグ",
      "ユージン",
      "ヨシュア・レーベンハイト",
      "リキマル",
      "リリィ",
      "ロディ",
    ]
  end

  def temporary_ranking_vote_2_chars
    [
      "アイラ",
      "アトリ",
      "アンダルク",
      "アンネリー",
      "エミリー",
      "オボロ",
      "カイ",
      "キリィ",
      "クロデキルド",
      "クロン",
      "ゲッシュ",
      "ケリィ",
      "コーネル",
      "ジーノ",
      "ジェイル",
      "シュン",
      "ジル・ブライト",
      "セイラ",
      "ディオス",
      "ニナ",
      "ヒクサク",
      "フェザー",
      "フレッド・マクシミリアン",
      "フレデグンド",
      "ホウアン",
      "ミツバ",
      "メース",
      "リィナ",
      "リノ・エン・クルデス",
      "レーヴン",
      "レックナート",
      "レレイ",
    ]
  end

  def temporary_ranking_vote_1_chars
    [
      "アイリーン",
      "アカギ",
      "アグネス",
      "アストリッド",
      "イザベル",
      "ヴァンサン・ド・プール",
      "エッジ",
      "エルンスト",
      "からくり丸",
      "キルキス",
      "クープ",
      "グリフィス",
      "グントラム",
      "ゲン",
      "ケンジ",
      "ゲンシュウ",
      "ゴルヌイ",
      "コルネリオ",
      "コロク",
      "ザジ",
      "ザハーク",
      "ジークフリード",
      "シメオン",
      "シャロン",
      "シルビナ",
      "シンロウ",
      "スウ・ジン",
      "スノウの腕",
      "スバル",
      "ゼラセ",
      "ソニア・シューレン",
      "チープー",
      "ディーリーリ",
      "テレーズ・ワイズメル",
      "トモ",
      "ナボコフ",
      "ニコ",
      "ネクロード",
      "ハインズ",
      "ハスワール",
      "ビッチャム",
      "ビャクレン",
      "ファーガス",
      "フウマ",
      "フレデリカ",
      "ベル",
      "ポール",
      "マナリル",
      "マリカ",
      "ミーナ",
      "ミュラ",
      "ミュン・ツァン",
      "ムルーン",
      "モーガン",
      "モーリン",
      "ユーラム・バロウズ",
      "ラウド",
      "リュウカン",
      "リュセリ",
      "ルシア",
      "ルバイス",
      "ルル",
      "レオン・シルバーバーグ",
      "レネフェリアス13世",
      "レパント",
      "ローレライ",
    ]
  end
end
