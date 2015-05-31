def current_user
  session[:uid]
end

def provider
  if Sinatra::Application.production?
    return 'github'
  else
    return 'developer'
  end
end