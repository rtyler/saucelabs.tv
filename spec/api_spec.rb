require 'spec_helper'


describe SauceTV::API do
  subject { SauceTV::API.new('rspec', 'rspec') }

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

end


