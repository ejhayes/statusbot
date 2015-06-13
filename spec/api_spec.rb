require 'spec_helper.rb'

describe 'API' do

  before(:each) do
    User.destroy_all
    @user = User.create(:name => 'test')
  end

  describe '/api - basic' do
    it '/api returns 400 if user not specifed' do
      get '/api/test'
      last_response.status.should eq 400
    end

    it '/api returns 400 if empty user provided' do
      get '/api/test?user=' + '    '

      last_response.status.should eq 400
    end

    it '/api returns 400 if invalid user specifed' do
      User.destroy_all

      get '/api/test?user=' + 'I_DO_NOT_EXIST'
      last_response.status.should eq 400
    end    

    it '/api returns 200 if valid user specified' do
      get '/api/test?user=' + @user.name
      last_response.should be_ok
    end

    it '/api/version returns correct version info' do
      get '/api/version?user=' + @user.name
      last_response.should be_ok
      last_response.body.should eq('1.0')
    end
  end

  describe '/api/doing' do

    it 'calls API.add_activity with the correct parameters' do
      data = "Sample activity description."

      Api.should_receive(:add_activity).with(@user.name, data)

      post '/api/doing?user=' + @user.name, data

      last_response.should be_ok
    end

    it 'removes whitespace from doing item' do
      data = "     I have too much whitespace       "

      Api.should_receive(:add_activity).with(@user.name, data.strip)

      post '/api/doing?user=' + @user.name, data
    end

    it 'returns a 400 if data is empty' do
      post '/api/doing?user=' + @user.name, '       '

      last_response.status.should eq 400
    end


  end

  describe '/api/stop' do

    it 'calls API.stop_activity with the correct parameters' do
      Api.should_receive(:stop_activity).with(@user.name)

      get '/api/stop?user=' + @user.name

      last_response.should be_ok
    end

  end

  describe '/api/wait' do

    it 'calls API.add_wait with the correct parameters' do
      data = 'waiting for something'

      Api.should_receive(:add_wait).with(@user.name, data)

      post '/api/wait?user=' + @user.name, data

      last_response.should be_ok
    end

    it 'removes whitespace from wait item' do
      data = '    I have whitespace here     '

      Api.should_receive(:add_wait).with(@user.name, data.strip)

      post '/api/wait?user=' + @user.name, data

      last_response.should be_ok
    end

    it 'returns a 400 if no wait item specified' do
      post '/api/wait?user=' + @user.name

      last_response.status.should eq 400
    end

    it 'returns a 400 if wait item is empty' do
      post '/api/wait?user=' + @user.name, '       '

      last_response.status.should eq 400
    end

  end

  describe '/api/wait/ping' do

    it 'calls API.wait_ping with the correct parameters' do
      data = 'some ping note'
      wait_id = '1'

      Api.should_receive(:wait_ping).with(@user.name, Integer(wait_id), data)

      post '/api/wait/ping?user=' + @user.name + '&waitId=' + wait_id, data

      last_response.should be_ok
    end

    it 'returns 400 if waitId not specified' do
      data = 'some ping note'

      post '/api/wait/ping?user=' + @user.name, data

      last_response.status.should eq 400
    end

    it 'returns 400 if waitId not an integer' do
      data = 'some ping note'

      post '/api/wait/ping?user=' + @user.name + '&waitId=' + 'NOT_INTEGER', data

      last_response.status.should eq 400
    end

    it 'returns 400 if waitId is negative' do
      data = 'some ping note'

      post '/api/wait/ping?user=' + @user.name + '&waitId=' + '-1', data

      last_response.status.should eq 400
    end

    it 'returns 400 if no ping note specified' do
      wait_id = '1'

      post '/api/wait/ping?user=' + @user.name + '&waitId=' + wait_id

      last_response.status.should eq 400
    end

    it 'returns 400 if ping note is empty' do
      data = '      '
      wait_id = '1'

      post '/api/wait/ping?user=' + @user.name + '&waitId=' + wait_id, '      '

      last_response.status.should eq 400
    end

  end

  describe '/api/wait/done' do

    it 'calls API.wait_done with the correct parameters' do
      wait_id = '1'

      Api.should_receive(:wait_done).with(@user.name, Integer(wait_id))

      get '/api/wait/done?user=' + @user.name + '&waitId=' + wait_id

      last_response.should be_ok
    end

    it 'returns 400 if waitId not specified' do
      data = 'some ping note'

      get '/api/wait/done?user=' + @user.name, data

      last_response.status.should eq 400
    end

    it 'returns 400 if waitId not an integer' do
      data = 'some ping note'

      get '/api/wait/done?user=' + @user.name + '&waitId=' + 'NOT_INTEGER', data

      last_response.status.should eq 400
    end

    it 'returns 400 if waitId is negative' do
      data = 'some ping note'

      get '/api/wait/done?user=' + @user.name + '&waitId=' + '-1', data

      last_response.status.should eq 400
    end

  end

  describe '/api/wait/cancel' do

    it 'calls API.wait_cancel with the correct parameters' do
      wait_id = '1'

      Api.should_receive(:wait_cancel).with(@user.name, Integer(wait_id))

      get '/api/wait/cancel?user=' + @user.name + '&waitId=' + wait_id

      last_response.should be_ok
    end

    it 'returns 400 if waitId not specified' do
      data = 'some ping note'

      get '/api/wait/cancel?user=' + @user.name, data

      last_response.status.should eq 400
    end

    it 'returns 400 if waitId not an integer' do
      data = 'some ping note'

      get '/api/wait/cancel?user=' + @user.name + '&waitId=' + 'NOT_INTEGER', data

      last_response.status.should eq 400
    end

    it 'returns 400 if waitId is negative' do
      data = 'some ping note'

      get '/api/wait/cancel?user=' + @user.name + '&waitId=' + '-1', data

      last_response.status.should eq 400
    end

  end

  describe '/api/goals' do

    it 'calls API.goals with the correct parameters' do
      Api.should_receive(:goals).with(@user.name)

      get '/api/goals?user=' + @user.name

      last_response.should be_ok   
    end

    it 'returns correctly formatted json response if goals exist for user' do
      data = {:a => 'nothing to see', :b => 'also nothing'}
      Api.should_receive(:goals).and_return(data)

      get '/api/goals?user=' + @user.name

      last_response.body.should eq data.to_json
      last_response.should be_ok
    end

    it 'returns empty json response if no goals exist for the user' do
      Api.should_receive(:goals).and_return(nil)

      get '/api/goals?user=' + @user.name

      last_response.body.should eq "{}"
      last_response.should be_ok
    end

  end

  describe '/api/waits' do

    it 'calls API.waits with the correct parameters' do
      Api.should_receive(:waits).with(@user.name)

      get '/api/waits?user=' + @user.name

      last_response.should be_ok
    end

    it 'returns correctly formatted response if waits exist for user' do
      data = {:a => 'nothing to see', :b => 'also nothing'}

      Api.should_receive(:waits).and_return(data)

      get '/api/waits?user=' + @user.name

      last_response.body.should eq data.to_json
    end

    it 'returns correctly formatted response if no waits exist for user' do
      Api.should_receive(:waits).and_return(nil)

      get '/api/waits?user=' + @user.name

      last_response.body.should eq "{}"
    end

  end
  
end