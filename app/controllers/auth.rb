before do
  # no authentication for these routes
  pass if request.path_info =~ Regexp.union([/^\/auth\//, /^\/api\//, /^\/$/, /^\/login/, /^\/logout/])

  unless current_user
    session[:redirect_to] = request.path_info
    redirect to("/auth/#{provider}")
  end
end

post '/auth/:provider/callback' do
  session[:uid] = env['omniauth.auth']['uid']
  redirect to(session.delete(:redirect_to) || '/')
end

get '/login' do
  redirect to "/auth/#{provider}"
end

get '/logout' do
  session[:uid] = nil
  redirect to '/'
end
