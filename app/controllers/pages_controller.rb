# frozen_string_literal: true

class PagesController < ApplicationController
  def home; end

  def now_counting
    @tweets = Tweet.now_counting_tweets_asc.page params[:page]
  end

  def ranking
    @ranking_data = CSV.table('public/ranking.tsv', col_sep: "\t")
  end

  def summary
    @english_votes_ranking_data = CSV.table('public/english_votes_ranking.csv', col_sep: "\t")
  end
end
