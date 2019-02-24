class UsersController < ApplicationController


  get '/signup' do

    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end
  post '/signup' do

    if !params["username"].empty? && !params["password"].empty? && !params["email"].empty?
      user = User.create(username: params["username"], password: params["password"], email: params["email"])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
end
    get '/login' do

      if logged_in?
        redirect to "/tweets"
      end
      erb :'/users/login'
    end

    post '/login' do

      @user = User.find_by({username: params["username"]})
      if @user && @user.authenticate(params["password"])
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect to '/login'

    end

    end

    get '/logout' do
      if logged_in?
        session.clear
      end
    redirect to '/login'
  end

end
