class UsersController < ApplicationController
  
  get '/' do
    "Hello World"
    erb :index
  end
  
  get '/signup' do 
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end
  
  post '/signup' do 
    #logs user in and adds the sessions hash
    
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end
  
  get '/login' do 
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end
  
  post '/login' do 
    @user = User.find_by(username: params[:username])
    
    if @user && @user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      redirect '/tweets' # erb :'/users/show'
    else 
      redirect '/login'
    end
  end
  
  
  
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    if @user 
      @tweets = @user.tweets
      erb :'users/show'
    else
      redirect '/'
    end
  end
  
  get '/logout' do 
  
    session.clear
    if !logged_in?
      
      redirect '/login'
    end
  end
  
  

end
