enable :sessions

get '/' do

  erb :index
end

post "/users" do
  user = User.create(params[:user])
  # user = User.where(:email => params[:email]).first_or_create()
  session[:user_id] = user.id
  redirect "/users/#{user.id}"
end

get '/users/:id' do |id|
  @user = User.find(id)
  erb :"users/show"
end

get '/sessions/new' do
  erb :"sessions/new"
end

post '/sessions' do
  user = User.find_by_email(params[:email])
  if user.password == params[:password]
    session[:user_id] = user.id
    redirect "/"
  else
    erb :"sessions/new"
  end
end

get '/sessions/end' do 
  session.clear
  redirect '/'
end

post "/posts" do 
  Post.create(title: params[:title], body: params[:body], user_id: "#{session[:user_id]}")
  redirect "/users/#{session[:user_id]}"
end

get "/posts/:id" do |id|
  @post = Post.find(id)
  @user = User.find(@post.user_id)
  erb :"posts/show"
end

post "/comments" do
  Comment.create(content: params[:content], user_id: "#{session[:user_id]}", post_id: params[:post_id])
  redirect "/posts/#{params[:post_id]}"
end


