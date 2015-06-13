# all api calls require a user to be specified
# can call locally like this: curl --data 'my update to you' "localhost:9393/api/doing?user=bob@gmail.com"
before '/api/*' do
  halt 400, "Invalid request" unless User.exists?(:name => params[:user])
end

get '/api/test' do
  # do nothing here
end

get '/api/version' do
  API_VERSION
end

post '/api/doing' do
  update = request.body.read.strip

  halt 400 if update.empty?

  Api.add_activity(params[:user], update)
end

get '/api/stop' do
 Api.stop_activity(params[:user])
end

post '/api/wait' do
  data = request.body.read.strip

  halt 400 if data.empty?
  Api.add_wait(params[:user], data)
end

post '/api/wait/ping' do
  data = request.body.read.strip

  halt 400 if data.empty?

  begin
    wait_id = Integer(params[:waitId])
  rescue
    halt 400
  end

  halt 400 if wait_id <= 0

  Api.wait_ping(params[:user], wait_id, data)
end

get '/api/wait/done' do
  
  begin
    wait_id = Integer(params[:waitId])
  rescue
    halt 400
  end

  halt 400 if wait_id <= 0
  
  Api.wait_done(params[:user], wait_id)
end

get '/api/wait/cancel' do

  begin
    wait_id = Integer(params[:waitId])
  rescue
    halt 400
  end

  halt 400 if wait_id <= 0

  Api.wait_cancel(params[:user], wait_id)

end

## api for getting information back

get '/api/goals' do
  goals = Api.goals(params[:user])

  if goals.nil?
    return "{}"
  else
    return goals.to_json
  end
end

get '/api/waits' do
  waits = Api.waits(params[:user])

  if waits.nil?
    return "{}"
  else
    return waits.to_json
  end
end