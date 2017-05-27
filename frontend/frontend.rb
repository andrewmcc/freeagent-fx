class Frontend < Sinatra::Base

  set :public_folder => "public", :static => true

  get "/" do
    erb :index
  end
end
