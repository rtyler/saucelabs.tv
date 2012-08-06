require 'spec_helper'


describe SauceTV::API do
  let(:username) { 'rspec' }
  let(:api_key) { 'rspec' }
  subject { SauceTV::API.new(username, api_key) }

  describe :format do
    it 'should always be :json' do
      subject.format.should be :json
    end
  end

  describe :recent_jobs do
    context 'when Sauce is timing out' do
      before :each do
        subject.class.should_receive(:get) do
          raise Timeout::Error
        end
      end

      it 'should return an empty Array' do
        jobs = subject.recent_jobs
        jobs.should_not be_nil
        jobs.should be_empty
      end
    end

    context 'when Sauce is serving HTML' do
      let(:response) do
        response = mock('HTTParty::Response')
        response.stub(:code).and_return(200)
        markup = "<html><body>Failboat</body></html>"
        response.stub(:parsed_response).and_return(markup)
        response
      end

      before :each do
        subject.class.should_receive(:get).and_return(response)
      end

      it "should return an empty Array if there's no JSON" do
        jobs = subject.recent_jobs
        jobs.should_not be_nil
        jobs.should be_empty
      end
    end
  end

  describe :info_for do
    it 'should raise if the `job_id` is bad' do
      expect {
        subject.info_for(nil)
      }.to raise_error(SauceTV::BadAPIParameters)
    end

    context 'when Sauce is timing out' do
      before :each do
        subject.class.should_receive(:get) do
          raise Timeout::Error
        end
      end

      it 'should return an empty Hash' do
        info = subject.info_for('foo')
        info.should_not be_nil
        info.should be_instance_of Hash
      end
    end
  end

  describe :auth_token_for do
    let(:job_id) { 'rspec_jobid' }

    it 'should generate the right token for the ID, username and API key' do
      subject.auth_token_for(job_id).should == 'eab6d962d96a9abf2b8e770f64a70e35'
    end
  end
end


