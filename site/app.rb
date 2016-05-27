class App < Sinatra::Base
  enable :sessions

  get '/' do
    @posts = Post.all
  	erb :index
  end

  get '/about' do
    erb :about
  end

  get '/admin' do
    erb :login
  end

  get '/adminrights' do
      if session[:admin_id]
        @posts = Post.all
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

  get '/post/:id/edit' do |post_id|
    @post = Post.get(post_id)
    if @post && session[:admin_id]
      @posts = Post.all
      erb :postedit
    end
  end

  get '/home' do
    if session[:admin_id]
      redirect '/adminrights'
    else
      redirect '/'
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

  post '/post/:id/edit' do |post_id|
    @post = Post.get(post_id)
    if @post && session[:admin_id]
      @post.update(title: params['title'], category: params['category'], content: params['content'])
      redirect '/adminrights'
    end

  end


  post '/post/:id/delete' do |post_id|
    post = Post.get(post_id)
    if post && session[:admin_id]
      post.destroy
      redirect '/adminrights'
    else
      status 404
    end
  end

  post '/post/create' do
    if session[:admin_id]
      title = params['title']
      category = params['category']
      content = params['content']
      Post.create(title: title, category: category, content: content, admin_id: session[:admin_id])
      redirect '/adminrights'
    else
      redirect '/admin'
    end
  end

  # post '/issue/create' do
  #   p params
  #   if params['notification'] == "set"
  #     notification = true
  #   else
  #     notification = false
  #   end
  #
  #   created_issue = Issue.create(title:"#{params['title']}", email:"#{@user.email}", notification:notification, category_id:"#{params['category']}", regular_user_id:"#{@user.id}")
  #   created_update = Update.create(text:"#{params['issue_text']}", issue_id:created_issue.id)
  #
  #   if params[:attachments] != nil
  #     files = params[:attachments]
  #     files.each do |file|
  #       p file
  #       original_name = file[:filename]
  #       tmpfile = file[:tempfile]
  #
  #       filetype = file[:type].split('/')[1] #file[:type] always looks like image/*type*
  #
  #
  #       new_name = (0...30).map { ('a'..'z').to_a[rand(26)] }.join #Creates a random string with 30 letters
  #
  #       File.open("public/uploads/#{new_name}.#{filetype}", "w") do |f|
  #         f.write(tmpfile.read)
  #       end
  #
  #       CaseAttachment.create(path:"/uploads/#{new_name}.#{filetype}", name:original_name, update_id:created_update.id, article_id:1)
  #     end
  #   end

end