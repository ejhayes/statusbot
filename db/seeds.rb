User.create(:name => 'Eric', :email => 'test@example.com')

Activity.create(:description => 'this is an activity', :last_started => DateTime.now, :user => User.first)