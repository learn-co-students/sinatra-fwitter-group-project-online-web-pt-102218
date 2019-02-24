class UsersController < ApplicationController

  get '/signup' do

    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end
  post '/signup' do

    redirect to "/tweets"
  end
end
