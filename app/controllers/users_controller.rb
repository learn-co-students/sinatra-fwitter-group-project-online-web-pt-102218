class UsersController < ApplicationController
  
  get '/signup' do 
    if !Helpers.logged_in?(session)
      erb :"/users/new_user"
    else 
      redirect "/tweets"
      #if they are not logged in have them sign-up, otherwise display tweets page 
    end 
  end 
  
  post '/signup' do
    if !(params.has_value?(""))
      user = User.create(username: params[:username], password: params[:password], email: params[:email]
      )
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do 
    if !Helpers.logged_in?(session)
      erb :"users/login"
    else 
      redirect "/tweets"
    end 
    #if logged in direct to tweets, else login page 
  end 
   
  post '/login' do
    user = User.find_by(username: params[:username])
  	if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
	end
	
	get '/users/:slug' do 
	  @user= User.find_by(params[:slug])
	  erb :'/user_tweets'
	end 

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear 
      redirect to '/login'
    else
      redirect to '/'
    end
  end 

end

