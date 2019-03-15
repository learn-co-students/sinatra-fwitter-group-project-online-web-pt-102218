require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  #INDEX PAGE
  get '/' do
    erb :index
  end
  
  #SIGN UP PAGE
  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
  end
end



end
