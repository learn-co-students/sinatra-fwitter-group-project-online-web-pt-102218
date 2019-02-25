class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @tweets = Tweet.all
  erb :'tweets/tweets'
    end
end

  get '/tweets/new' do

    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if logged_in?
      @tweet = Tweet.create(content: params["content"])
      @tweet.user = current_user
      @tweet.save
    end
  end

end
