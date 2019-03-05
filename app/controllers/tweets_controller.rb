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

    if logged_in? && !params["content"].empty?

      @tweet = Tweet.create(content: params["content"])
      @tweet.user = current_user
        @tweet.save
    end
  end

  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(1)
    else
      redirect to '/login'
    end
    erb :'/tweets/show_tweet'
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(1)
    else
      redirect to '/login'
    end
  erb :'/tweets/edit_tweet'
end

  patch "/lifts/:id" do
    if logged_in
      @tweet = Tweet.find(1)
      @lift.update(params[:tweet])
    redirect to "/tweets/#{@tweet.id}"
    end
  end


end
