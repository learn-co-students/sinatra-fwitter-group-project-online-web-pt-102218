require './config/environment'
require './app/models/user'
require './app/models/tweet'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end
  
  get '/' do
    erb :index
  end
  
  helpers do 
    def logged_in?
      #binding.pry
      !!current_user
    end
    
    def current_user 
      if session[:user_id]
        User.find(session[:user_id])
      end
    end
  end

end
