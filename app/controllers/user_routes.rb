get '/' do
  erb :home
end

get '/dashboard' do
  erb :dashboard
end

get %r{^/daily/?(?<date>\d{4}\-\d{2}\-\d{2})?$} do
  date = get_date

  erb :daily

#  "Daily update: #{date}".to_json
end

get %r{^/weekly/?(?<date>\d{4}\-\d{2}\-\d{2})?$} do
  date = get_date

  erb :weekly
#  "Weekly update: #{date}".to_json
end

get %r{^/view/daily/?(?<date>\d{4}\-\d{2}\-\d{2})?$} do
  date = get_date

  "View daily: #{date}".to_json
end

get %r{^/view/weekly/?(?<date>\d{4}\-\d{2}\-\d{2})?$} do
  date = get_date

  "View weekly: #{date}".to_json
end

get '/profile' do

end

get '/history' do

end
