class App < Sinatra::Base
  enable :sessions

  get '/' do
  	erb :index
  end

  get '/admin' do
    @admins = Admin.all
    erb :login
  end

  post '/admin/login' do
    admin = Admin.first(username: params['username'])
    if admin && admin.password == params['password']
      session[:admin_id] = admin.id
      redirect '/'
    end

    redirect back

  end

  post '/post/create' do
  title = params['title']
  content = params['content']
  post = Post.create(title: title, content: content)


  end


end