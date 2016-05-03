class App < Sinatra::Base
  enable :sessions

  get '/' do
  	erb :index
  end

  get '/admin' do
    @admins = Admin.all
    erb :login
  end

  post 'admin/register' do
    username = params['username']
    password = params['password']
    login = Admin.create(username: username, password: password)
  end


  post '/post/create' do
  title = params['title']
  content = params['content']
  post = Post.create(title: title, content: content)


  end


end