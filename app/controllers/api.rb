
## api for adding activity

# all api calls require a user to be specified
before '/api/*' do
  halt 400, "Invalid request" unless params[:user]
end

post '/api/doing' do
  
  # request body will have the doing activity
  "#{request.body.read}"

end

get '/api/stop' do

end

get '/api/wait' do

end

get '/api/wait/ping' do

end

get '/api/wait/done' do

end

get '/api/wait/cancel' do

end

## api for getting information back

get '/api/goals' do

end

get '/api/waits' do

end
