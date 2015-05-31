def get_date
  begin
    return params[:date] ? Date.parse(params[:date]) : DateTime.now.to_date
  rescue ArgumentError
    halt 500, 'Invalid date selected'
  end
end