enable :sessions

get '/' do
  if session[:user_id]
    redirect "/users/#{session[:user_id]}"
  end
  erb :index
end

post "/users" do
  user = User.create(params[:user])
  # user = User.where(:email => params[:email]).first_or_create()
  session[:user_id] = user.id
  redirect "/users/#{user.id}"
end

post '/sessions' do
  user = User.find_by_email(params[:email])
  if user.password == params[:password]
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    erb :index
  end
end

get '/users/:id' do |id|
  @user = User.find(id)
  erb :"users/show"
end

get '/sessions/end' do 
  session.clear
  redirect '/'
end

