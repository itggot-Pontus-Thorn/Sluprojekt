class App < Sinatra::Base
  enable :sessions

  get '/' do
  	erb :index
  end

  get '/admin' do
    erb :login
  end

  get '/adminrights' do
      if session[:admin_id]
        erb :admin
      else
        redirect '/admin'
      end
  end

  post '/admin/login' do
    admin = Admin.first(username: params['username'])
    if admin && admin.password == params['password']
      session[:admin_id] = admin.id
      redirect '/adminrights'
    end

    redirect back

  end

  post '/admin/logout' do
    session[:admin_id] = nil
    redirect '/'
  end

  post '/post/create' do
  title = params['title']
  content = params['content']
  post = Post.create(title: title, content: content)


  end


end