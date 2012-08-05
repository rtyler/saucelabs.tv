require 'spec_helper'


describe SauceTV::API do
  subject { SauceTV::API.new('rspec', 'rspec') }

  describe :format do
    it 'should always be :json' do
      subject.format.should be :json
    end
  end

end


