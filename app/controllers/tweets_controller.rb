class TweetsController < ApplicationController
  
    get '/tweets' do 
      if logged_in?
        @tweets = Tweet.all
        erb :'users/show'
      else 
        redirect '/login'
      end
    end
    
    get '/tweets/new' do 
      if logged_in?
        erb :'tweets/new'
      else 
        redirect '/login'
      end
    end
    
    post '/tweets' do 
      if logged_in? && !params[:content].empty?
        @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
        redirect to "tweets/#{@tweet.id}"
      elsif logged_in? 
        redirect '/tweets/new'
      else
        redirect '/'
      end
    end
    
    get '/tweets/:id' do 
      @tweet = Tweet.find(params[:id])
      if logged_in?
        erb :'tweets/show_tweet'
      else
        redirect '/login'
      end
    end
    
    get '/tweets/:id/edit' do 
      if logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'tweets/edit_tweet'
      else 
        redirect '/login'
      end
    end
    
    patch '/tweets/:id' do
      if logged_in?
        if params[:content] != "" 
          @tweet = Tweet.find(params[:id])
          @tweet.update(content: params[:content])
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/#{params[:id]}/edit"
        end
      else 
        redirect '/login'
      end
    end
    
    delete '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if logged_in? && current_user.id == @tweet.user_id
          @tweet.destroy
          redirect '/tweets'
      else
          redirect "/login"
      end
  end
  end