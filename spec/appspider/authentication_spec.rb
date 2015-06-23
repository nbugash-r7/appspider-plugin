require 'rspec'
require 'appspider/lib/authentication'

RSpec.describe Appspider::Api::Authentication do
  before(:each) do
    @params ={
      nto_ent_rest_url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
      name: 'wstclient',
      password: 'wstclient'
    }
  end
  describe '#Authentication' do
    context 'invalid parameters' do
      it 'should not throw an error for nil Appspider URL' do
        expect{
          @params[:nto_ent_rest_url] = nil
          Appspider::Api::Authentication.login(@params)
        }.to raise_error StandardError, "NTO URL was not set"
      end
      it 'should not throw an error for nil name' do
        expect{
          @params[:name] = nil
          Appspider::Api::Authentication.login(@params)
        }.to raise_error StandardError, "Name parameter was not set"
      end
      it 'should not throw an error for nil password' do
        expect{
          @params[:password] = nil
          Appspider::Api::Authentication.login(@params)
        }.to raise_error StandardError, "Password parameter was not set"
      end

    end
    context 'valid parameters' do
      it 'should return an authentication token' do
        expect(
            Appspider::Api::Authentication.login(@params)
        ).not_to be_nil
      end
    end
  end
end