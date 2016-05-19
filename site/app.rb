class App < Sinatra::Base
  enable :sessions

  get '/' do
    @posts = Post.all
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

  get '/post' do
    if session[:admin_id]
    @posts = Post.all
    erb :post
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

  post '/post/post' do
    if session[:admin_id]
      redirect '/post'
    end
  end

  post '/post/create' do
    if session[:admin_id]
      title = params['title']
      content = params['content']
      Post.create(title: title, content: content, admin_id: session[:admin_id])
      redirect "/"
    else
      redirect "/login"
    end
  end


end