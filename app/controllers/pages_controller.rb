# frozen_string_literal: true

require 'csv'

class PagesController < ApplicationController
  def home; end

  def now_counting
    @tweets = Tweet.now_counting_tweets_asc.page params[:page]
  end

  def ranking
    ranking_tsv_filepath = Rails.public_path.join('ranking.tsv')
    @ranking_data = CSV.table(ranking_tsv_filepath, col_sep: "\t")
  end

  def summary
    ranking_csv_filepath = Rails.public_path.join('english_votes_ranking.csv')
    @english_votes_ranking_data = CSV.table(ranking_csv_filepath, col_sep: "\t")
  end
end
