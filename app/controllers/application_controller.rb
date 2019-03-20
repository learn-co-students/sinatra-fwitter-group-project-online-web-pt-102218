require './config/environment'
require 'sinatra/base'


class ApplicationController < Sinatra::Base
  configure do
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    erb :index
  end

  def logged_in?
      !!current_user
  end
  
  def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def redirect_if_not_logged_in
    if !logged_in?
      redirect '/'
    end
  end

  def authorized_to_edit?(a_tweet)
    a_tweet.user == current_user
  end


end