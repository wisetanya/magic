class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  include TweetsHelper

  def index
    @tweets = Tweet.order(created_at: :desc)
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    @tweet = Tweet.create(tweet_params)
    @tweet = get_tagged(@tweet)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweets_url, notice: 'New Tweet added.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to tweets_url, notice: 'Tweet was updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was deleted.' }
    end
  end

  private

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:message, :user_id, :link)
    end
end
