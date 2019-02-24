class UsersController < ApplicationController

    get "/" do 
        erb :"/welcome"
    end 

    get "/login" do 
        if !session.key?(:user_id)
            erb :"users/login"
        else 
            redirect "/tweets"
        end 
    end 

    post "/login" do 
        if !session.key?(:user_id)
            user = User.find_by(username: params[:username])
            if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/<%=user.slug%>"
            else
            redirect "/login"
            end
        else 
            redirect "/tweets"
        end 
    end 

    get "/signup" do 
        erb :"users/create_user"
    end 

    post "/signup" do 
        if !session.key?(:user_id)
            if params[:username] != "" && params[:password] != "" && params[:email] != ""
                if User.find_by(username: params[:username]) && User.find_by(email: params[:email])

                else 
                    user = User.create(username: params[:username], email: params[:email], password: params[:password])
                    session[:user_id] = user.id
                end 
                redirect "/tweets"
            else
                redirect "/signup"
            end
        else 
            redirect "/tweets"
        end
    
    end 

    get "/logout" do 
        if !session.key?(:user_id)
            redirect "/"
        else 
            session.clear
            redirect "/login"
        end 
    end 

    get "/users/:slug" do 
        @user = User.find_by_slug(params[:slug])
        erb :"users/show"
    end 

end
