class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @tweets = Tweet.all
  erb :'tweets/tweets'
    end
end
end
