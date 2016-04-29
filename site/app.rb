class App < Sinatra::Base
  enable :sessions

  get '/' do
  	erb :index
  end


  post '/post/create' do
  title = params['title']
  content = params['content']
  post = Post.create(title: title, content: content)


  end


end