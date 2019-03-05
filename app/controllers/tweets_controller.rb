class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :"/tweets/index"
  end

  get '/tweets/new' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    erb :"/tweets/new"
  end

  post '/tweets' do
    user = Helpers.current_user(session)
    if params["content"].empty?
      
      redirect to '/tweets/new'
    end
    tweet = Tweet.create(:content => params["content"], :user_id => user.id)

    redirect to '/tweets'
  end

  get '/tweets/:id' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      flash[:wrong_user] = "you can only edit your own tweets"
      redirect to '/tweets'
    end
    erb :"tweets/edit_tweet"
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params["content"].empty?
      flash[:empty_tweet] = " tweet cannot be blank"
      redirect to "/tweets/#{params[:id]}/edit"
    end
    tweet.update(:content => params["content"])
    tweet.save

    redirect to "/tweets/#{tweet.id}"
  end

  post '/tweets/:id/delete' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      flash[:wrong_user] = "you can only delete your own tweets"
      redirect to '/tweets'
    end
    @tweet.delete
    redirect to '/tweets'
  end

  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"users/show"
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
